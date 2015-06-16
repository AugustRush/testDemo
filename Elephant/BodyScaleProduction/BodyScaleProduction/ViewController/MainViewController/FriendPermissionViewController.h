//
//  FriendPermissionViewController.h
//  BodyScaleProduction
//
//  Created by Zhanghao on 4/21/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "AQBaseViewController.h"

@class FriendInfoEntity;

@interface FriendPermissionViewController : AQBaseViewController

- (instancetype)initWithEntity:(FriendInfoEntity *)entity;

@property (nonatomic, copy) void (^cancelFocusBlock)(void);

@end
