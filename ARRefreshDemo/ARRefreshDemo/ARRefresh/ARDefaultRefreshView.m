//
//  ARDefaultRefreshView.m
//  ARRefreshDemo
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARDefaultRefreshView.h"

@interface ARDefaultRefreshView ()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation ARDefaultRefreshView

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
//        self.alpha = 0;
        self.indicatorView = [[UIActivityIndicatorView alloc] init];
        [self.indicatorView startAnimating];
        [self addSubview:self.indicatorView];
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.indicatorView
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1
                                                          constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.indicatorView
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];

    }
    return self;
}

//-(void)scrollView:(UIScrollView *)scrollView didChangeProgress:(CGFloat)progress
//{
//    NSLog(@"progress is %f",progress);
//    self.alpha = progress;
//}
//
//-(void)scrollView:(UIScrollView *)scrollView didChangeState:(ARRefreshState)state
//{
//    if (state == ARRefreshStateEnd) {
//        self.alpha = 0;
//    }
//}

-(UIColor *)randomColor
{
    CGFloat r = (arc4random()%255)/255.0;
    CGFloat g = (arc4random()%255)/255.0;
    CGFloat b = (arc4random()%255)/255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


@end
