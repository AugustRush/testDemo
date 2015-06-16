//
//  UIViewController+Helpers.m
//  BLEDemo
//
//  Created by Zhanghao on 3/21/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import "UIViewController+Helpers.h"
#import "MBProgressHUD.h"

static MBProgressHUD *_hud = nil;

@implementation UIViewController (Helpers)

#pragma mark - Show in window

- (void)showSuccessHudInWindowWithText:(NSString *)text dismissAfterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:KEY_WINDOW];
    [KEY_WINDOW addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.margin = 15.0f;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    if (text) {
        hud.labelText = text;
    }
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

- (void)showHudInWindowOnlyText:(NSString *)text dismissAfterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:KEY_WINDOW];
    [KEY_WINDOW addSubview:hud];
    
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 15.0f;
    if (text) {
        hud.labelText = text;
    }
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

- (void)showHudInWindowWithText:(NSString *)text {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithWindow:KEY_WINDOW];
    }
    
    if (!_hud.superview) {
        [KEY_WINDOW addSubview:_hud];
    }
    
    _hud.margin = 15.0f;
    _hud.square = YES;
    _hud.labelText = text;
    _hud.removeFromSuperViewOnHide = YES;
    [_hud show:YES];
}

#pragma mark - Show in view

- (void)showSuccessHudInView:(UIView *)view text:(NSString *)text dismissAfterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    if (text) {
        hud.labelText = text;
    }
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

- (void)showHudWithText:(NSString *)text inView:(UIView *)aView {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:aView];
    }
    
    if (!_hud.superview) {
        [aView addSubview:_hud];
    }
    
    _hud.margin = 15.0f;
    _hud.square = YES;
    _hud.labelText = text;
    _hud.removeFromSuperViewOnHide = YES;
    [_hud show:YES];
}

#pragma mark - Dismiss

- (void)dismissHud {
    if (_hud) {
        [_hud hide:YES];
    }
}

@end
