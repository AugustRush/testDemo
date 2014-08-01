//
//  ARAppDelegate.m
//  ARVeryCD
//
//  Created by August on 14-7-29.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ARAppDelegate.h"

@implementation ARAppDelegate

#pragma mark - lifeCycle methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    [self configApperence];
    [self buildMainTabbarController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
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

#pragma mark - Private methods

-(void)configApperence
{
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:FlatRed];
    [[UITabBar appearance] setBarTintColor:FlatLime];
    [[UINavigationBar appearance] setBarTintColor:FlatLime];
    [[UINavigationBar appearance] setTintColor:FlatWhite];
}

-(void)buildMainTabbarController
{
    HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:NSStringFromClass([HomeViewController class]) bundle:nil];
    homeViewController.title = kLocalizeString(@"Home");
    homeViewController.tabBarItem = [self buildTabbarItemWithSystermItem:UITabBarSystemItemMostViewed tag:0];
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    ChannelViewController *channelViewController = [[ChannelViewController alloc] initWithNibName:NSStringFromClass([ChannelViewController class]) bundle:nil];
    channelViewController.title = kLocalizeString(@"Channel");
    channelViewController.tabBarItem = [self buildTabbarItemWithSystermItem:UITabBarSystemItemTopRated tag:1];
    UINavigationController *channelNavigationController = [[UINavigationController alloc] initWithRootViewController:channelViewController];
    
    HistoryViewController *historyViewController = [[HistoryViewController alloc] initWithNibName:NSStringFromClass([HistoryViewController class]) bundle:nil];
    historyViewController.title = kLocalizeString(@"History");
    historyViewController.tabBarItem = [self buildTabbarItemWithSystermItem:UITabBarSystemItemHistory tag:2];
    UINavigationController *historyNavigationController = [[UINavigationController alloc] initWithRootViewController:historyViewController];
    
    SettingViewController *settingVIewController = [[SettingViewController alloc] initWithNibName:NSStringFromClass([SettingViewController class]) bundle:nil];
    settingVIewController.title = kLocalizeString(@"Setting");
    settingVIewController.tabBarItem = [self buildTabbarItemWithSystermItem:UITabBarSystemItemMore tag:3];
    UINavigationController *settingNavigationController = [[UINavigationController alloc] initWithRootViewController:settingVIewController];
    
    MainTabbarViewController *mainTabbarController = [[MainTabbarViewController alloc] initWithNibName:NSStringFromClass([MainTabbarViewController class]) bundle:nil];
    mainTabbarController.viewControllers = @[homeNavigationController,channelNavigationController,historyNavigationController,settingNavigationController];
    
    self.window.rootViewController = mainTabbarController;
}

-(UITabBarItem *)buildTabbarItemWithSystermItem:(UITabBarSystemItem)item tag:(NSInteger)tag
{
    return [[UITabBarItem alloc] initWithTabBarSystemItem:item tag:tag];
}

@end
