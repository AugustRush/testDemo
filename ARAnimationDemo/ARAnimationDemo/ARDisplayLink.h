//
//  ARDisplayLink.h
//  ARAnimationDemo
//
//  Created by August on 15/6/17.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ARDisplayLink : NSObject

@property (nonatomic, strong, readonly) CADisplayLink *displayLink;

@property (nonatomic, copy) void(^writeBlock)(CGFloat value);

@property (nonatomic, copy) void(^completion)(void);

-(void)startRun;

@end
