//
//  ARRefreshProtocol.h
//  ARRefreshDemo
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ARRefreshState) {
    ARRefreshStateNone = 0,
    ARRefreshStateDoing,
    ARRefreshStateEnd
};

@protocol ARRefreshProtocol <NSObject>

@optional
-(void)scrollView:(UIScrollView *)scrollView didChangeState:(ARRefreshState)state;
-(void)scrollView:(UIScrollView *)scrollView didChangeProgress:(CGFloat)progress;

@end
