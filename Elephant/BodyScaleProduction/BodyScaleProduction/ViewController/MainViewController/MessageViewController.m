//
//  MessageViewController.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 5/9/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "MessageViewController.h"
#import "LeftSideViewController.h"
#import "MessageViewTableViewCell.h"
#import "InterfaceModel.h"
#import "MSGFocusMeEntity.h"

@interface MessageViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MessageViewController {
    NSMutableArray *rowData;
}

#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
    [self issueFocusMeListReqeust];
}

- (void)viewDidLayoutSubviews {
    self.loadingView.frame = self.view.bounds;
}

#pragma mark - Private Methods

- (void)initData {
    rowData = [NSMutableArray array];
}

- (void)initViews {
    self.navigationItem.title = @"新消息";
    
    [self.backgroundView removeFromSuperview];
    
    self.tableView.backgroundView = nil;
    
    self.loadingView = [AQLoadingView new];
    [self.view addSubview:self.loadingView];
    
    [self.tableView addSubview:self.refreshControl];
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (void)refresh:(UIRefreshControl *)control {
    [[InterfaceModel sharedInstance] getFocusMeListWithCallBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.loadingView.superview) {
                [self.loadingView removeFromSuperview];
            }
            
            if (result == WebCallBackResultSuccess) {
                if ([successParam isKindOfClass:[NSArray class]]) {
                    
                    if (((NSArray *)successParam).count > 0) {
                        rowData = [NSMutableArray arrayWithArray:successParam];
                        
                        self.hintLabel.hidden = YES;
                        self.tableView.hidden = NO;
                        
                        [self.tableView reloadData];
                    } else {
                        self.hintLabel.hidden = NO;
                        self.tableView.hidden = YES;
                    }
                }
            } else {
                self.tableView.hidden = YES;
                
                if (errorMsg) {
                    self.hintLabel.hidden = NO;
                    self.hintLabel.text = errorMsg;
                }
            }
            
            [control endRefreshing];
        });
        
    }];
}

#pragma mark - Requests

- (void)issueFocusMeListReqeust {
    [[InterfaceModel sharedInstance] getFocusMeListWithCallBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
        
        [self.loadingView removeFromSuperview];
        
        if (result == WebCallBackResultSuccess) {
            if ([successParam isKindOfClass:[NSArray class]]) {
                
                if (((NSArray *)successParam).count > 0) {
                    rowData = [NSMutableArray arrayWithArray:successParam];
                    
                    self.hintLabel.hidden = YES;
                    self.tableView.hidden = NO;
                    
                    [self.tableView reloadData];
                } else {
                    self.hintLabel.hidden = NO;
                    self.tableView.hidden = YES;
                }
            }
        } else {
            self.tableView.hidden = YES;
            
            if (errorMsg) {
                self.hintLabel.hidden = NO;
                self.hintLabel.text = errorMsg;
            }
        }
    }];
}

#pragma mark - Private Methods

- (void)agreeAddingFriendByIndexPath:(NSIndexPath *)indexPath msgId:(NSString *)msgid {
    [Flurry logEvent:AGREE_ADD_FRIEND_EVENT];
    
    [[InterfaceModel sharedInstance] focusSetWithSetTp:FocusType_ageree mid:msgid callback:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
        if (result == WebCallBackResultSuccess) {
            // 数据源更改
            MSGFocusMeEntity *entity = rowData[indexPath.row];
            entity.msgFm_status = [NSString stringWithFormat:@"0"];
            
            // 界面更新
            MessageViewTableViewCell *cell = (MessageViewTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell.agreeButton setImage:[UIImage imageNamed:@"agreed"] forState:UIControlStateNormal];
            cell.agreeButton.enabled = NO;
        } else {
            if (errorMsg) {
                [self showHUDInView:self.view justWithText:errorMsg disMissAfterDelay:1];
            }
        }
    }];
}

#pragma mark - UITableViewDataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"messageCell";
    MessageViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageViewTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row < rowData.count) {
        [cell fillCellWithEntity:rowData[indexPath.row]];
    }
    
    WEAK_SELF;
    cell.agreeBlock = ^(NSString *msgId) {
        STRONG_WEAK_SELF;
        [sself agreeAddingFriendByIndexPath:indexPath msgId:msgId];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < rowData.count) {
        MSGFocusMeEntity *entity = rowData[indexPath.row];
        
        [Flurry logEvent:IGNORE_ADD_FRIEND_EVENT];
        
        [[InterfaceModel sharedInstance] delMsgWithMid:entity.msgFm_mId callBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
            
        }];
        
        [rowData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        if (rowData.count == 0) {
            self.tableView.hidden = YES;
            
            self.hintLabel.hidden = NO;
            self.hintLabel.text = @"暂时没有新消息哦！";
        }
    }
}

@end
