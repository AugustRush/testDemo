//
//  UIViewController+HUD.m
//  iChrono365
//
//  Created by 刘平伟 on 14-1-14.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "NSObject+HUD.h"

MBProgressHUD *__HUD = nil;

#define KeyWindow     [[UIApplication sharedApplication] keyWindow]

@implementation NSObject (HUD)

-(void)showHUDInWindowWithText:(NSString *)text
{
    [__HUD hide:YES afterDelay:0.3];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:KeyWindow];
    HUD.removeFromSuperViewOnHide = YES;
    [KeyWindow addSubview:HUD];
    __HUD = HUD;
    if (text) {
        HUD.labelText = text;
    }
    [HUD show:YES];
}

-(void)disMissHUDWithText:(NSString *)text afterDelay:(NSTimeInterval)inteval
{
    if (text) {
        __HUD.labelText = text;
    }
    [__HUD hide:YES afterDelay:inteval];
    
}

-(void)showHUDInWindowJustWithText:(NSString *)text
{
    [__HUD hide:YES afterDelay:0.3];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:KeyWindow];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.customView = [[UILabel alloc] init];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.margin = 10;
    [KeyWindow addSubview:HUD];
    __HUD = HUD;
    if (text) {
        HUD.labelText = text;
    }
    [HUD show:YES];
}

-(void)showHUDInWindowJustWithText:(NSString *)text disMissAfterDelay:(NSTimeInterval)interval
{
    [__HUD hide:YES afterDelay:0.3];
    [self showHUDInWindowJustWithText:text];
    [self disMissHUDWithText:nil afterDelay:interval];
}

-(void)showHUDInView:(UIView *)view WithText:(NSString *)text
{
    [__HUD hide:YES afterDelay:0.3];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.removeFromSuperViewOnHide = YES;
    [view addSubview:HUD];
    __HUD = HUD;
    if (text) {
        HUD.labelText = text;
    }
    [HUD show:YES];
}

-(void)showHUDInView:(UIView *)view WithText:(NSString *)text dismissAfterDelay:(NSTimeInterval)interval
{
    [__HUD hide:YES afterDelay:0.3];
    [self showHUDInView:view WithText:text];
    [self disMissHUDWithText:nil afterDelay:interval];
}

-(void)showHUDInView:(UIView *)view justWithText:(NSString *)text
{
    [__HUD hide:YES afterDelay:0.3];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.customView = [[UILabel alloc] init];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.margin = 10;
    HUD.removeFromSuperViewOnHide = YES;
    [view addSubview:HUD];
    __HUD = HUD;
    if (text) {
        HUD.labelText = text;
    }
    [HUD show:YES];
}

-(void)showHUDInView:(UIView *)view justWithText:(NSString *)text disMissAfterDelay:(NSTimeInterval)interval
{
    [__HUD hide:YES afterDelay:0.3];
    [self showHUDInView:view justWithText:text];
    [self disMissHUDWithText:nil afterDelay:interval];
}

-(void)showHUDWithCustomView:(UIView *)customView inView:(UIView *)view
{
    UIControl *overView = [[UIControl alloc] initWithFrame:view.bounds];
    overView.backgroundColor = [UIColor clearColor];
    [overView addTarget:self action:@selector(overViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect frame = view.bounds;
    customView.center = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
    [overView addSubview:customView];
    [view addSubview:overView];

    
    overView.alpha = 0;
    [UIView animateWithDuration:.3 animations:^{
        overView.alpha = 1.0;
    }];
}

-(void)overViewClicked:(id)sender
{
    
    UIControl *ct = (UIControl *)sender;
    [UIView animateWithDuration:.5
                     animations:^{
                         ct.alpha = 0.0;
    }
                     completion:^(BOOL finished) {
                         [ct removeFromSuperview];
    }];
}

@end
