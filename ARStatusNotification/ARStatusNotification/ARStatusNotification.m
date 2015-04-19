//
//  ARStatusNotification.m
//  ARStatusNotification
//
//  Created by August on 15/4/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARStatusNotification.h"

@interface ARStatusNotification ()

@property (nonatomic, strong) UIWindow *overlayView;

@end

@implementation ARStatusNotification

#pragma mark - init methods

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _baseConfigs];
    }
    return self;
}

+(instancetype)shareOverlay
{
    static ARStatusNotification *statusOverlay = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        statusOverlay = [[ARStatusNotification alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    });
    return statusOverlay;
}

#pragma mark - private methods

-(void)_baseConfigs
{
    
    self.windowLevel = UIWindowLevelAlert;
    self.backgroundColor = [UIColor redColor];
}

#pragma mark - public methods

+(void)show
{
    ARStatusNotification *statusView = [ARStatusNotification shareOverlay];
    [statusView makeKeyAndVisible];
}

@end
