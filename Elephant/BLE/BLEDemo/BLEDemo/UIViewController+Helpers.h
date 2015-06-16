//
//  UIViewController+Helpers.h
//  BLEDemo
//
//  Created by Zhanghao on 3/21/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Helpers)

- (void)showHudInWindowWithText:(NSString *)text;
- (void)showHudInWindowOnlyText:(NSString *)text dismissAfterDelay:(NSTimeInterval)delay;
- (void)showSuccessHudInWindowWithText:(NSString *)text dismissAfterDelay:(NSTimeInterval)delay;


- (void)showHudWithText:(NSString *)text inView:(UIView *)aView;
- (void)showSuccessHudInView:(UIView *)view text:(NSString *)text dismissAfterDelay:(NSTimeInterval)delay;


- (void)dismissHud;

@end
