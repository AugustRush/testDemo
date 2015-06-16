//
//  NSTimerHelper.m
//  FFLtd
//
//  Created by 两元鱼 on 12-9-4.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "NSTimerHelper.h"

@interface NSTimerHelper()
{
    SEL action_;
}

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) SEL action;

@end

/*********************************************************************/

@implementation NSTimerHelper

@synthesize timer = timer_;
@synthesize delegate = delegate_;
@synthesize action = action_;

- (void)dealloc {
    [self invalidate];
    delegate_ = nil;
    action_ = nil;
    
}

+ (NSTimerHelper *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    NSTimerHelper *helper = [[NSTimerHelper alloc] init];
    
    [helper invalidate];
    
    helper.delegate = aTarget;
    helper.action = aSelector;
    
    helper.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:helper selector:@selector(doSomething) userInfo:userInfo repeats:yesOrNo];
    
    return helper;
}

- (void)invalidate
{
    [timer_ invalidate];
    timer_ = nil;
}

- (void)doSomething
{
    if (self.delegate && [self.delegate respondsToSelector:self.action]) {
        [self.delegate performSelector:self.action];
    }
}

@end
