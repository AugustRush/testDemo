//
//  FriendPermissionViewController.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 4/21/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "FriendPermissionViewController.h"
#import "UIImageView+WebCache.h"
#import "UserInfoEntity.h"
#import "FriendInfoEntity.h"
#import "AQAlertView.h"
#import "InterfaceModel.h"
#import "FocusFriendTableViewCell.h"
#import "ICSwitchControl.h"

#define SET_PERMISSION      @"设置权限"
#define CANCEL_FOCUS        @"取消关注"

@interface FriendPermissionViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FriendPermissionViewController {
    NSArray *rowTitles;
    FriendInfoEntity *userInfoEntity;
}

#pragma mark - View Lifecycle

- (instancetype)initWithEntity:(FriendInfoEntity *)entity {
    self = [super init];
    if (self) {
        if (entity) {
            userInfoEntity = entity;
        }
        
        [self commonInit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

#pragma mark - Private Methods

- (void)commonInit {
    NSString *nickName = @"";
    
    if (userInfoEntity) {
        nickName = userInfoEntity.FI_nickName;
    }
    
    rowTitles = @[nickName, SET_PERMISSION, CANCEL_FOCUS];
}

- (void)setUpUI {
    self.title = @"朋友";
    
    [self.backgroundView removeFromSuperview];
    self.tableView.backgroundView = nil;
}

#pragma mark - Requests

- (void)issueModifyPermissionRequest:(BOOL)hasPermission {
    [[InterfaceModel sharedInstance] modifyFriendRightWithFriend:userInfoEntity mright:hasPermission callBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {

        if (result == WebCallBackResultFailure) {
            if (errorMsg) {
                [self showHUDInView:self.view justWithText:errorMsg disMissAfterDelay:1];
            }
        } else if (result == WebCallBackResultSuccess) {
            userInfoEntity.FI_mright_att = [NSString stringWithFormat:@"%d", hasPermission];
        }
    }];
}

- (void)issueCancelFocusRequest {
    [[InterfaceModel sharedInstance] deleteFriendWithFriend:userInfoEntity callBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
        if (result == WebCallBackResultSuccess) {
            if (self.cancelFocusBlock) {
                self.cancelFocusBlock();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            if (errorMsg) {
                [self showHUDInView:self.view justWithText:errorMsg disMissAfterDelay:1];
            }
        }
    }];
}

#pragma mark - Actions

- (void)setFriendPermission:(BOOL)hasPermission {
    [self issueModifyPermissionRequest:hasPermission];
}

#pragma mark - UITableViewDataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 头像
    if (indexPath.row == 0) {
        FocusFriendTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"FocusFriendTableViewCell" owner:self options:nil] lastObject];
        
        NSURL *headImageURL = [NSURL URLWithString:[SERVICE_URL stringByAppendingString:userInfoEntity.FI_photopath]];
        
        NSString *headImageName = ([userInfoEntity.FI_sex intValue] == 0) ?
        @"default_photo_females.png" : @"default_photo_males.png";
        UIImage *placeholderImage = [UIImage imageNamed:headImageName];
        
        [cell.headImageView setImageWithURL:headImageURL placeholderImage:placeholderImage];
        
        cell.titleLabel.text = rowTitles[indexPath.row];
        
        return cell;
        
    } else {
        static NSString *identifier = @"addUserIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1];
        
        if (indexPath.row < rowTitles.count) {
            NSString *title = rowTitles[indexPath.row];
            
            if ([title isEqualToString:SET_PERMISSION]) {
                ICSwitchControl *switchControl = [[ICSwitchControl alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
                switchControl.style = ICSwitchControlStyleRoundCorner;
                [switchControl setLeftTitle:@"On" RightTitle:@"Off"];
                switchControl.pannelColor = [UIColor whiteColor];
                [switchControl setBackgroundColor:[UIColor lightGrayColor] forState:ICSwitchControlStateHightlight];
                [switchControl setBackgroundColor:[UIColor blueColor] forState:ICSwitchControlStateOn];
                [switchControl setBackgroundColor:[UIColor redColor] forState:ICSwitchControlStateOff];
                switchControl.isOn = userInfoEntity.FI_mright_att.intValue;

                WEAK_SELF;
                void (^buttonAction)(ICSwitchControl *sender) = ^(ICSwitchControl *sender){

                    STRONG_WEAK_SELF;
                    if (sender.isOn) {
                        [sself setFriendPermission:sender.isOn];
                    } else {
                        AQAlertView *alertView = [[AQAlertView alloc] initWithTitle:nil
                                                                            message:@"关闭后对方将看不到你的数据信息"
                                                                 confirmButtonTitle:@"确定"
                                                                        cancelTitle:@"取消"
                                                                     confirmHandler:^(AQAlertView *alertView) {
                                                                         [sself setFriendPermission:NO];
                                                                     }
                                                                      cancelHandler:^(AQAlertView *alertView) {
                                                                          sender.isOn = YES;
                                                                      }];
                        alertView.canTapDismiss = NO;
                        
                        [alertView show];
                    }
                };
                [switchControl setCompleteSelectedBlock:buttonAction];
                
                cell.accessoryView = switchControl;
            }
            
            cell.textLabel.text = rowTitles[indexPath.row];
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    } else {
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < rowTitles.count) {
        NSString *title = rowTitles[indexPath.row];
        
        if ([title isEqualToString:CANCEL_FOCUS]) {
            AQAlertView *alertView = [[AQAlertView alloc] initWithTitle:@"确定取消关注？"
                                                                message:nil
                                                     confirmButtonTitle:@"确定"
                                                            cancelTitle:@"取消"
                                                         confirmHandler:^(AQAlertView *alertView) {
                                                             [self issueCancelFocusRequest];
                                                         }
                                                          cancelHandler:nil];
            
            [alertView show];
        }
    }
}

@end
