//
//  SYAppDelegate.h
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-18.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYMainViewController.h"
#import "SYPeripheralsHandle.h"

@interface SYAppDelegate : UIResponder <UIApplicationDelegate,SYPeripheralsHandleDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) SYPeripheralsHandle *BLTPeriHandle;

@end
