//
//  NetworkReach.h
//  Dtouching
//
//  Created by lyywhg on 12-5-12.
//  Copyright (c) 2012年 BH. All rights reserved.
//


#import <Foundation/Foundation.h>
@class Reachability;

/**
 @header   NetworkReach
 @abstract 获取网络状态，提示网络异常
 @author   lyywhg
 @version  1.0  2012/5/12 Creation
 */
@interface NetworkReach : NSObject


@property (nonatomic, readonly) BOOL isNetReachable;
@property (nonatomic, readonly) BOOL isHostReach;
@property (nonatomic, readonly) BOOL isInternetReach;
@property (nonatomic, readonly) BOOL isWifiReach;
@property (nonatomic, readonly) NSInteger reachableCount;

/*!
 @method
 @abstract NetworkReach 初始化方法
 @discussion 初始化
 */
- (void)initNetwork;
/*!
 @method
 @abstract    弹出框 提示网络异常信息
 @discussion  提示：NotReachable
 */
- (void)showNetworkAlertMessage;

@end
