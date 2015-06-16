//
//  UserManagerViewController.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 5/16/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "UserManagerViewController.h"
#import "UserTableViewCell.h"
#import "UIAlertView+Blocks.h"
#import "BTModel.h"
#import "AppDelegate.h"
#import "APService.h"
#import "InputUserInfoViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface UserManagerViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserManagerViewController {
    NSMutableArray *allUsers;
}

#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self buildTableViewData];
}

#pragma mark - Private Methods

- (void)commonInit {
    allUsers = [NSMutableArray array];
}

- (void)setUpUI {
    self.navigationItem.title = @"用户管理";
    self.tableView.backgroundView = nil;
    [self.backgroundView removeFromSuperview];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addUser)];
}

- (void)buildTableViewData {
    // 本地用户
    [allUsers addObject:@[[GloubleProperty sharedInstance].currentUserEntity]];
    
    // 从数据库获取历史用户
    NSArray *userList = [[InterfaceModel sharedInstance] getLocalUserList];
    if (userList && userList.count > 0) {
        [allUsers addObject:[NSMutableArray arrayWithArray:userList]];
    }
}

- (void)switchUserByIndexPath:(NSIndexPath *)indexPath {
    [self showHUDInWindowWithText:@"切换中..."];
    
    UserInfoEntity *userInfo = allUsers[indexPath.section][indexPath.row];
    
    [[InterfaceModel sharedInstance] userLoginWithLoginName:userInfo.UI_loginName loginPwd:userInfo.UI_loginPwd isEncrypt:YES userLoc:userInfo.UI_isLoc callBack:^(int code, UserInfoEntity *userInfo, NSString *errorMsg) {

        if (code == REQUEST_SUCCESS_CODE) {
            [self disMissHUDWithText:nil afterDelay:0.1];
            [[BTModel sharedInstance] selectUserInScale:[[InterfaceModel sharedInstance] getHostUser] isTesting:NO];
            
            [APService setAlias:userInfo.UI_userId callbackSelector:nil object:nil];
            [(AppDelegate *)[UIApplication sharedApplication].delegate mainViewAppearWithUserInfo:userInfo];
            
        } else {
            [self disMissHUDWithText:errorMsg afterDelay:1];
        }
    }];
}

// 修复iOS7删除TableView最后一行的动画bug
- (void)hackDeletedCell:(UITableViewCell *)cell {
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7) {
        cell.alpha = 0;
    }
}

- (void)safelyRemoveIndexPath:(NSIndexPath *)indexPath dataSource:(NSMutableArray *)dataSource {
    if (!indexPath || !dataSource) {
        return;
    }
    
    if (indexPath.section < dataSource.count) {
        NSInteger rows = [dataSource[indexPath.section] count];
        NSMutableArray *sectionArray = dataSource[indexPath.section];
        
        if (rows == 0) {
            return;
        } else if (rows == 1) {
            // Table view cell animation bug fix for iOS 7
            if (kIsiOS_7) {
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                cell.alpha = 0;
            }
            
            [self.tableView beginUpdates];
            
            [sectionArray removeAllObjects];
            [dataSource removeObject:sectionArray];
            NSIndexSet *sections = [NSIndexSet indexSetWithIndex:indexPath.section];
            [self.tableView deleteSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self.tableView endUpdates];
            
        } else {
            [self.tableView beginUpdates];
            
            [sectionArray removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self.tableView endUpdates];
        }
    }
}

#pragma mark - Actions 

- (void)addUser {
    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil userInfoEntity:nil isForgetPassword:NO type:FlowTypeAddUser];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark - UITableViewDataSource and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return allUsers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [allUsers[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"userManagerCell";
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserTableViewCell" owner:self options:nil] lastObject];
    }

    if (indexPath.section < allUsers.count) {
        [cell fillCellWithUserInfoEntity:allUsers[indexPath.section][indexPath.row]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"当前用户";
            break;
        case 1:
            title = @"历史用户";
            break;
        default:
            break;
    }
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        [self switchUserByIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
        if (indexPath.row < [allUsers[indexPath.section] count]) {
            UserInfoEntity *historyUser = allUsers[indexPath.section][indexPath.row];
            
            BOOL deleteSuccess = [[InterfaceModel sharedInstance] deleteUserByUid:historyUser.UI_userId];
            if (deleteSuccess) {
                // 数据库删除用户成功
                [self safelyRemoveIndexPath:indexPath dataSource:allUsers];
            } else {
                // 数据库删除用户失败
                [self showHUDInWindowJustWithText:@"删除用户失败" disMissAfterDelay:1];
            }
        }
    }
}

@end
