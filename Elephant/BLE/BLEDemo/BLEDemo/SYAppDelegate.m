//
//  SYAppDelegate.m
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-18.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYAppDelegate.h"
#import "SYMeasureDataViewController.h"
#import "SYMeasureViewController.h"
#import "SYSettingViewController.h"

@implementation SYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.BLTPeriHandle = [SYPeripheralsHandle shareBlueToothHandle];
    self.BLTPeriHandle.delegate = self;
    
    [self buildMainView];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.BLTPeriHandle cancleConnectPeripheral:self.BLTPeriHandle.curConnectPeripheral];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.BLTPeriHandle refreshScanPeripherals];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

#pragma mark - custom methods

-(void)buildMainView
{
    SYMainViewController *mainViewController = [[SYMainViewController alloc] initWithNibName:@"SYMianViewController" bundle:nil];
    
    SYMeasureViewController *measureViewController = [[SYMeasureViewController alloc] initWithNibName:@"SYMeasureViewController" bundle:nil];
    measureViewController.title = @"测量";
    measureViewController.tabBarItem.title =  @"测量";
    measureViewController.tabBarItem.image = [UIImage imageNamed:@"one.png"];
    UINavigationController *measureNavController = [[UINavigationController alloc] initWithRootViewController:measureViewController];
    
//    SYContinuesViewController *contunusViewController = [[SYContinuesViewController alloc] initWithNibName:@"SYContinuesViewController" bundle:nil];
//    contunusViewController.title = @"连续测量";
//    contunusViewController.tabBarItem.title = @"连续测量";
//    UINavigationController *continusNavController = [[UINavigationController alloc] initWithRootViewController:contunusViewController];
    
    SYMeasureDataViewController *measureDataViewController = [[SYMeasureDataViewController alloc] initWithNibName:@"SYMeasureDataViewController" bundle:nil];
    measureDataViewController.title = @"测量数据";
    measureDataViewController.tabBarItem.title = @"测量数据";
    measureDataViewController.tabBarItem.image = [UIImage imageNamed:@"two.png"];
    UINavigationController *measureDataNavController = [[UINavigationController alloc] initWithRootViewController:measureDataViewController];
    
    SYSettingViewController *settingViewController = [[SYSettingViewController alloc] initWithNibName:@"SYSettingViewController" bundle:nil];
    settingViewController.title = @"节律仪设置";
    settingViewController.tabBarItem.title = @"节律仪设置";
    settingViewController.tabBarItem.image = [UIImage imageNamed:@"three.png"];
    UINavigationController *settingNavController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    
    mainViewController.viewControllers = @[measureNavController,measureDataNavController,settingNavController];
    self.window.rootViewController = mainViewController;
}

#pragma mark - SYPeripheralsHandleDelegate methods

-(void)updataHasFindPeripheralsWith:(NSArray *)peripherals
{
//    NSLog(@"peripherals is %@",peripherals);
    if (peripherals.count > 0) {
        [self.BLTPeriHandle connectToPeripheral:peripherals[0]];
    }
}

-(void)peripheralHandleDidConnectPeripheral
{
//    NSLog(@"did connct peripheral");
}

-(void)peripheralHandleDidDisConnectPeripheral
{
//    NSLog(@"peripheral did disconnect");
}

-(void)peripheralDidUpdataValue:(NSString *)string withUUID:(NSString *)UUID
{
//    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"peripherals updata string  is %@",str);
}

@end
