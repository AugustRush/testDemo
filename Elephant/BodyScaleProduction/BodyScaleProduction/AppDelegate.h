//
//  AppDelegate.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-14.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSMainViewController.h"


@class UserInfoEntity;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;


@property (nonatomic, strong) BSMainViewController* drawerController;

- (void)loginAndRegisterViewAppear;
- (void)mainViewAppearWithUserInfo:(UserInfoEntity *)userInfo;



@end
