//
//  ARDisplayLink.m
//  ARAnimationDemo
//
//  Created by August on 15/6/17.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARDisplayLink.h"

@interface ARDisplayLink ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSUInteger times;

@end

@implementation ARDisplayLink

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTriggered:)];
//        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)displayLinkTriggered:(id)sender
{
    self.times ++;
    if (self.times == 255) {
        [self.displayLink invalidate];
        if (self.completion) {
            self.completion();
        }
    }

    if (self.writeBlock) {
        self.writeBlock(self.times);
    }
}

-(void)startRun
{
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

@end
