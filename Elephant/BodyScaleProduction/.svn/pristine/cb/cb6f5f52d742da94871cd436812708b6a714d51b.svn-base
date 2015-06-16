//
//  RightSideViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "RightSideViewController.h"
#import "AppDelegate.h"
#import "UIViewController+MMDrawerController.h"
#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "UserFeedbackViewViewController.h"
#import "BTModel.h"
#import "UserHelpViewController.h"
#import "BlockUI.h"
#import "BaseNavigationController.h"
#import "HistoryDataViewController.h"
#import "BodyFatHistoryViewController.h"
#import "NewShareViewViewController.h"
#import "AQTrendingViewController.h"
#import "ConnectingView.h"

@interface RightSideViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation RightSideViewController {
    NSArray *_itemNames;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _itemNames = @[@"获得设备", @"设置", @"关于我们", @"用户反馈", @"帮助"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareButtonAction:) name:@"yaoyiyao" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Override Methods

- (void)configureThemeAppearance {
    [super configureThemeAppearance];
    
    self.backgroundImageView.image = ThemeImage(@"beijing_you");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)chronoLineButtonAction:(id)sender {
    BodyFatHistoryViewController *cloudLineVC = [[BodyFatHistoryViewController alloc] initWithNibName:@"BodyFatHistoryViewController" bundle:nil];
    BaseNavigationController *cloudLineNavVC = [[BaseNavigationController alloc] initWithRootViewController:cloudLineVC];
//    cloudLineNavVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    MMDrawerController *mmd = self.mm_drawerController;
    [mmd presentViewController:cloudLineNavVC animated:YES completion:nil];

    [Flurry logEvent:@"右侧边栏" withParameters:@{@"时间线按钮":@"弹出时间线"} timed:YES];
}

- (IBAction)shareButtonAction:(id)sender {
    int times= [[InterfaceModel sharedInstance] getTotalDataCount];  //测量总次数
    if (times>1) {
        UserInfoEntity *userInfo ;
        userInfo = [[GloubleProperty sharedInstance] currentUserEntity];
        UserDataEntity *userData = userInfo.UI_lastUserData;
        CGFloat ryfit = [CalculateTool calculateRyFitWithUserInfo:userInfo data:userData];
        if (ryfit>0 && ryfit<100) {
            NewShareViewViewController *newShareVC = [[NewShareViewViewController alloc] initWithNibName:@"NewShareViewViewController" bundle:nil];
            BaseNavigationController *newShareNavVC = [[BaseNavigationController alloc] initWithRootViewController:newShareVC];
//            newShareNavVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            MMDrawerController *mmd = self.mm_drawerController;
            [mmd presentViewController:newShareNavVC animated:YES completion:nil];

            [Flurry logEvent:@"右侧边栏" withParameters:@{@"分享按钮":@"弹出分享"} timed:YES];
            
        }else{
            //[self showHUDInView:self.view justWithText:@"数据异常，不能分享哦。" disMissAfterDelay:1];
            [self showHUDInWindowJustWithText:@"数据异常，不能分享哦。" disMissAfterDelay:1];
        }
    }else{
        //[self showHUDInView:self.view justWithText:@"请再测量一次，才能对比分享哦。" disMissAfterDelay:1];
        [self showHUDInWindowJustWithText:@"请再测量一次，才能对比分享哦。" disMissAfterDelay:1];
    }

}

- (IBAction)historyButtonAction:(id)sender {
//    HistoryDataViewController *historyVC = [[HistoryDataViewController alloc] initWithNibName:@"HistoryDataViewController" bundle:nil];
    AQTrendingViewController *trendingVC = [[AQTrendingViewController alloc] initWithNibName:@"AQTrendingViewController" initialType:AQOptionTypeRyFitIndex dateType:AQDateTypeWeek initDate:[NSDate date]];
    BaseNavigationController *trendingNavVC = [[BaseNavigationController alloc] initWithRootViewController:trendingVC];
//    trendingNavVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    MMDrawerController *mmd = self.mm_drawerController;
    [mmd presentViewController:trendingNavVC animated:YES completion:nil];
    
    [Flurry logEvent:@"右侧边栏" withParameters:@{@"数据统计按钮":@"弹出数据统计"} timed:YES];
}

- (IBAction)settingButtonAction:(id)sender {
    SettingViewController *settingVC = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    BaseNavigationController *setingNavVC = [[BaseNavigationController alloc] initWithRootViewController:settingVC];
//    setingNavVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    MMDrawerController *mmd = self.mm_drawerController;
    [mmd presentViewController:setingNavVC animated:YES completion:nil];
    
    [Flurry logEvent:@"右侧边栏" withParameters:@{@"设置按钮":@"弹出设置"} timed:YES];
}

/*
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.text = [NSString stringWithFormat:@"   %@", _itemNames[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        NSLog(@"url is %@",[[GloubleProperty sharedInstance] url]);
        if (![[[GloubleProperty sharedInstance] url] isEqual:[NSNull null]] &&
            [[[GloubleProperty sharedInstance] url] length] > 3) {
             [[UIApplication sharedApplication]
              openURL:[NSURL URLWithString:[[GloubleProperty sharedInstance] url]]];
        }
        
    }else if (indexPath.row == 1) {
        SettingViewController *settingVC = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        BSNavigationController *setingNavVC = [[BSNavigationController alloc] initWithRootViewController:settingVC];
        setingNavVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        MMDrawerController *mmd = self.mm_drawerController;
        
        [mmd presentViewController:setingNavVC animated:YES completion:^{
        
        }];
    }else if (indexPath.row == 2){
        AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
        aboutUsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        MMDrawerController *mmd = self.mm_drawerController;
        [mmd presentViewController:aboutUsVC animated:YES completion:^{
            
        }];
    }else if (indexPath.row == 3){
        UserFeedbackViewViewController *userFeedback = [[UserFeedbackViewViewController alloc] initWithNibName:@"UserFeedbackViewViewController" bundle:nil];
        userFeedback.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        MMDrawerController *mmd = self.mm_drawerController;
        
        [mmd presentViewController:userFeedback animated:YES completion:^{
            
        }];
        
    }else if (indexPath.row == 4){
        UserHelpViewController *helpVC = [[UserHelpViewController alloc] initWithNibName:@"UserHelpViewController" bundle:nil];
        helpVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        MMDrawerController *mmd = self.mm_drawerController;
        
        [mmd presentViewController:helpVC animated:YES completion:^{
            
        }];
    }
}
 */

- (IBAction)CallCustomServiceNumber:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否拨打客服热线?"
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    
    [alert showWithCompletionHandler:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4000666800"]];
        }
    }];
}
@end
