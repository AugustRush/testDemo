//
//  AppDelegate.m
//  BodyScale
//
//  Created by August on 14-9-27.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "AppDelegate.h"
#import "UserBaseInfoViewController.h"
#import "CenterViewController.h"
#import "VisitorViewController.h"
#import "DocumentsManage.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"

#import "DAO.h"
#import "AFNetworking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - life cycle methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.deviceId = @"";
    _connectType = 0;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if ([[FFConfig currentConfig].needAutoLogin boolValue]== NO)
    {
        [self buildRootViewController];
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }
    else
    {
        [self autoLogin];
    }
    [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:HASALREADYCONNECTED];
    self.blueToothHelper = [BlueToothHelper shareInstance];
    [_blueToothHelper centralManagerChangedStateBlock:^(CBCentralManagerState state) {
        [_blueToothHelper centralManagerScanPeripheralsWithBlock:^(NSArray *peripherals) {
        }];
    }];
    
    [BodyScaleBTInterface instanceWeightDataWithHandler:^(NSError *error, NSNumber *weight) {
    }];
    

    
    [self appFolderNeedCreate];
    [self databaseInit];
    [self socialShare];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
}
- (void)applicationWillTerminate:(UIApplication *)application
{
}

#pragma mark - private methods

- (void)socialShare
{
    [ShareSDK registerApp:ShareSDK_APPKEY];//字符串api20为您的ShareSDK的AppKey
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:SINAWEIBOAPPKEY
                               appSecret:SINAWEIBOSECRECT
                             redirectUri:SINA_REDIRECT_URI];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:SINAWEIBOAPPKEY
                                appSecret:SINAWEIBOSECRECT
                              redirectUri:SINA_REDIRECT_URI
                              weiboSDKCls:[WeiboSDK class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:QQAPPID
                           appSecret:QQAPPKEY
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:QQAPPID
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:WECHATAPPID
                           wechatCls:[WXApi class]];
}

-(void)buildRootViewController
{
    if ([[FFConfig currentConfig].isLogined boolValue] == YES)
    {
        UserBaseInfoViewController *userBaseInfoViewController = [[UserBaseInfoViewController alloc] initWithNibName:@"UserBaseInfoViewController" bundle:nil];
        CenterViewController *centerViewController = [[CenterViewController alloc] initWithNibName:nil bundle:nil ishasTextFeild:NO];
        UINavigationController *centerNavigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
        self.sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:centerNavigationController leftMenuViewController:userBaseInfoViewController rightMenuViewController:nil];
        self.sideMenuViewController.panFromEdge = YES;
        self.sideMenuViewController.panGestureEnabled = YES;
        self.sideMenuViewController.scaleMenuView = NO;
        self.sideMenuViewController.contentViewShadowEnabled = YES;
        self.sideMenuViewController.delegate = self;
        self.window.rootViewController = self.sideMenuViewController;
    }
    else
    {
        VisitorViewController *wVC = [[VisitorViewController alloc] initWithNibName:@"VisitorViewController" bundle:nil];
        UINavigationController *mNav = [[UINavigationController alloc] initWithRootViewController:wVC];
        self.window.rootViewController = mNav;
    }
}
-  (void)appFolderNeedCreate
{
    [DocumentsManage initAllAppNeedFolders];
}

- (void)autoLogin
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"login"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"mobile":[FFConfig currentConfig].userName,@"password":[FFConfig currentConfig].password, @"udid":[OpenUDID value]};
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (!errorCode)
        {
            NSDictionary * codeDic = [resultDic objectForKey:@"data"];
            [FFConfig currentConfig].needAutoLogin = @YES;
            [FFConfig currentConfig].userId = [codeDic objectForKey:@"user_id"];
            [FFConfig currentConfig].userShowName = [codeDic objectForKey:@"username"];
            [FFConfig currentConfig].privateCode = [codeDic objectForKey:@"private_code"];
            [FFConfig currentConfig].userHeader = codeDic[@"avatar"];
            NSMutableArray *tList = [[NSMutableArray alloc] init];
            [tList addObjectsFromArray:codeDic[@"members"]];
            if (tList != nil)
            {
                UserInfoManager *tUser = [UserInfoManager sharedInstance];
                [tUser.userLoginArray addObjectsFromArray:tList];
                
                NSInteger iCount = tList.count;
                if (iCount > 0)
                {
                    [FFConfig currentConfig].nowUserId = [NSString stringWithFormat:@"%@", [tList[0] objectForKey:@"id"]];
                }
            }
            [FFConfig currentConfig].isLogined = @YES;
            
            [self buildRootViewController];
            self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
    }];
}
- (void)databaseInit
{
    [DAO createTablesNeeded];
}
+ (AppDelegate *)currentAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}
-(void) onReq:(BaseReq*)req
{}

-(void) onResp:(BaseResp*)resp
{}

@end