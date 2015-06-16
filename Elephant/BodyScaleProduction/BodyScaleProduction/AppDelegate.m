//
//  AppDelegate.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-14.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "AppDelegate.h"
#import "InputUserInfoViewController.h"

#import "BodyFatHistoryViewController.h"
#import "LeftSideViewController.h"
#import "RightSideViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "InterfaceModel.h"

#import "UserInfomationModel.h"
//#import "BSMainViewController.h"
#import "Helpers.h"
#import "BTModel.h"
#import "ViewUtilFactory.h"
#import "APService.h"
#import "GuidView.h"

#import "DataDetailViewController.h"
#import "BaseNavigationController.h"
#import "ShareEngine.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "ThemeManager.h"
#import "DatabaseService.h"



@implementation AppDelegate {

}

void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*  初始化并修正数据库  */
    [DatabaseService defaultDatabaseService];
    
    
    [Flurry setCrashReportingEnabled:YES];
    [Flurry setAppVersion:[Utility getAppVersion]];
    [Flurry startSession:RYFIT_FLURRY_APP_KEY];
    [Flurry logEvent:APP_SYSTEM_VERSION withParameters:@{ @"APP_SYSTEM_VERSION" : [Utility getSystemVersion]}];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
#if DEBUG

#endif
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    UIImage *image = nil;
    if (kIsiOS_7) {
        NSDictionary *titleAttribute = @{ UITextAttributeTextColor : [UIColor whiteColor] };
        [[UINavigationBar appearance] setTitleTextAttributes:titleAttribute];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
        image = ThemeImage(@"navigation_bar_background_image_iOS7");
        [[UINavigationBar appearance] setBackgroundImage:image
                                           forBarMetrics:UIBarMetricsDefault];
        
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];
    } else {
        image = ThemeImage(@"navigation_bar_background_image_iOS6");
        [[UINavigationBar appearance] setBackgroundImage:image
                                           forBarMetrics:UIBarMetricsDefault];
    }

    [self setupPushNotificationWithOption:launchOptions];

    NSString *_uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];

    UserInfoEntity *_user = [[InterfaceModel sharedInstance] getUserByUid:_uid];
    if (_user)
    {
        
        
        int _year = [Helpers getNowYear] - [_user.UI_age intValue];
        _user.UI_birthday = [NSString stringWithFormat:@"%04d-01-01",_year];
        
        [GloubleProperty sharedInstance].currentUserEntity = _user;
        [GloubleProperty sharedInstance].currentUserEntity.UI_lastUserData =
            [[InterfaceModel sharedInstance] getLastDataByUser:_user];

        
        [GloubleProperty sharedInstance].sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
         
        [self mainViewAppearWithUserInfo:_user];

        [self showHUDInWindowJustWithText:@"正在登录"];

        [[InterfaceModel sharedInstance] userLoginWithLoginName:_user.UI_loginName
                                                       loginPwd:_user.UI_loginPwd
                                                      isEncrypt:YES
                                                        userLoc:_user.UI_isLoc
                                                       callBack:^(int code, UserInfoEntity *userInfo, NSString *errorMsg) {
                                                           if (code == REQUEST_SUCCESS_CODE) {

                                                               [self disMissHUDWithText:@"登录成功" afterDelay:0.8];
                                                                                                                          } else {
                                                                                                                              
                                                                                                                              
                                                                                                                              [GloubleProperty sharedInstance].currentUserEntity.UI_deviceList = @[];
                                                               [self disMissHUDWithText:@"登录失败" afterDelay:0.8];
                                                           }
                                                       }];

    }
    else
    {

        [self loginAndRegisterViewAppear];

    }
    
    // 蓝牙流程装载
    [[FlowManager sharedInstance] setup];

    GuidView *guideView = [[GuidView alloc] initWithFrame:self.window.frame];
    [self.window addSubview:guideView];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[InterfaceModel sharedInstance] isOnLogIn];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[InterfaceModel sharedInstance] getLng_lat];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if ([[notification.userInfo objectForKey:@"key"] isEqualToString:@"name"]) {
        if (application.applicationState == UIApplicationStateActive){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"亲，该测量体重了"
                                                                message:notification.alertAction
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }

}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [[ShareEngine sharedInstance] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[ShareEngine sharedInstance] handleOpenURL:url];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[BTModel sharedInstance] breakConnectPeripheral];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [APService handleRemoteNotification:userInfo];

    // 收到关注通知刷新消息
    [[NSNotificationCenter defaultCenter] postNotificationName:AQHasNewMessageNotification object:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [APService handleRemoteNotification:userInfo];

    // 收到关注通知刷新消息
    [[NSNotificationCenter defaultCenter] postNotificationName:AQHasNewMessageNotification object:nil];
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {

}

#pragma mark - Push notification

- (void)setupPushNotificationWithOption:(NSDictionary *)launchOptions
{
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    [APService setupWithOption:launchOptions];
}

- (void)loginAndRegisterViewAppear {
    InputUserInfoViewController *inputUserInfoVC = [[InputUserInfoViewController alloc] initWithNibName:@"InputUserInfoViewController" bundle:nil type:FlowTypeRegister checkCode:nil];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:inputUserInfoVC];
    self.window.rootViewController = nav;
}

- (void)mainViewAppearWithUserInfo:(UserInfoEntity *)userInfo {
    DataDetailViewController *dataDetailVC = [[DataDetailViewController alloc] initWithNibName:@"DataDetailViewController" bundle:nil userInfoEntity:userInfo type:FlowTypeUser];
    BaseNavigationController * navigationController = [[BaseNavigationController alloc] initWithRootViewController:dataDetailVC];

    LeftSideViewController *leftVC = [[LeftSideViewController alloc] initWithNibName:@"LeftSideViewController" bundle:nil];
    RightSideViewController *rightVC = [[RightSideViewController alloc] initWithNibName:@"RightSideViewController" bundle:nil];

    self.drawerController = [[BSMainViewController alloc]
                                              initWithCenterViewController:navigationController
                                              leftDrawerViewController:leftVC
                                              rightDrawerViewController:rightVC];
    [self.drawerController setShouldStretchDrawer:NO];
    [self.drawerController setMaximumRightDrawerWidth:110.0];
    [self.drawerController setMaximumLeftDrawerWidth:225.0f];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];

    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {

         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];

         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    self.window.rootViewController = self.drawerController;

}



@end
