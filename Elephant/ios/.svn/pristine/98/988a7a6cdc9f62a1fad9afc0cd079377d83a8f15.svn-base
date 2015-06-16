//
//  UIView+ActivityIndicator.m
//  FFLtd5
//
//  Created by Hubert Ryan on 11-6-10.
//  Copyright 2011 FFLtd. All rights reserved.
//

#import "UIView+ActivityIndicator.h"
#import "SNHUDIndicatorView.h"



@implementation UIView (UIViewUtils)


- (LoadingHUDView*)createActivityViewAtCenter:(UIActivityIndicatorViewStyle)style title:(NSString*)indiTitle
{
   
	LoadingHUDView *HUD = [[LoadingHUDView alloc] initWithTitle:L(indiTitle)];	
	
	HUD.tag = activityViewTag;
		
    [self addSubview:HUD];
		
//	HUD.frame.origin.y = (self.frame.size.height - HUD.frame.size.height)/2;
//	
//    HUD.left = (self.frame.size.width - HUD.frame.size.width)/2;
//    
    return HUD;
}


- (LoadingHUDView*)createActivityViewAtCenter:(UIActivityIndicatorViewStyle)style
{
	return [self createActivityViewAtCenter:style title:@"加载中..."];
}



- (LoadingHUDView*)getActivityViewAtCenter
{
    UIView* view = [self viewWithTag:activityViewTag];
    if (view != nil && [view isKindOfClass:[LoadingHUDView class]]){
        return (LoadingHUDView*)view;
    }
    else {
        return nil;
    }
}

- (void)showActivityViewAtCenter
{
    LoadingHUDView* activityView = [self getActivityViewAtCenter];
	
    if (activityView == nil){
		
        activityView = [self createActivityViewAtCenter:UIActivityIndicatorViewStyleWhiteLarge title:@"加载中..."];
    
	}
	
	[activityView startAnimating];
    
}

- (void)showActivityViewAtCenter:(NSString*)indiTitle
{
    LoadingHUDView* activityView = [self getActivityViewAtCenter];
	
    if (activityView == nil){
		
        activityView = [self createActivityViewAtCenter:UIActivityIndicatorViewStyleWhiteLarge title:indiTitle];
		
	}
	
	[activityView startAnimating];
    
}

- (void)hideActivityViewAtCenter
{
    LoadingHUDView* activityView = [self getActivityViewAtCenter];
	
	[activityView removeFromSuperview];  
	
           
}


- (void)showTipViewAtCenter:(NSString*)indiTitle posY:(CGFloat)y{
	
	BBTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
	activityView = [[BBTipView alloc] initWithView:self message:indiTitle posY:y];
    
    activityView.tag = toolViewTag;
    
    [activityView show];

	
}

- (void)showTipViewAtCenter:(NSString*)indiTitle{
	
	BBTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
	activityView = [[BBTipView alloc] initWithView:self message:indiTitle posY:140];
    
    activityView.tag = toolViewTag;
    
    [activityView show];
	
}

- (void)showSuccessTipViewAtCenter:(NSString*)indiTitle{
	
	BBTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
    UIImage *successLogo = [UIImage imageNamed:@"sncloud_disk_ic_pop_success.png"];
    
	activityView = [[BBTipView alloc] initWithView:self message:indiTitle logoView:successLogo posY:140];
    
    activityView.tag = toolViewTag;
    
    [activityView show];
	
}

- (void)showFailTipViewAtCenter:(NSString*)indiTitle{
	
	BBTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
    UIImage *failLogo = [UIImage imageNamed:@"sncloud_disk_ic_pop_fault.png"];
    
	activityView = [[BBTipView alloc] initWithView:self message:indiTitle logoView:failLogo posY:140];
    
    activityView.tag = toolViewTag;
    
    [activityView show];
	
}

- (void)hideTipView{
	
	
	BBTipView *activityView = [self getTipView];
	
	[activityView dismiss:YES];  
		
}


- (BBTipView *)getTipView
{
    UIView* view = [self viewWithTag:toolViewTag];
	
    if (view != nil && [view isKindOfClass:[BBTipView class]]){
		
        return (BBTipView *)view;
		
    }
    else {
        return nil;
    }
}


#pragma mark -
#pragma mark hud

- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
	
    if (hud == nil){
        hud = [self createHUDIndicatorViewAtCenter:indiTitle yOffset:0];
        SNHUDIndicatorView *indicator = (SNHUDIndicatorView *)hud.customView;
        if (indicator) {
            [indicator startAnimation];
        }
        [hud show:YES];
	}else{
        hud.labelText = indiTitle;
    }
}


- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
	
    if (hud == nil){
		
        hud = [self createHUDIndicatorViewAtCenter:indiTitle yOffset:y];
        SNHUDIndicatorView *indicator = (SNHUDIndicatorView *)hud.customView;
        if (indicator) {
            [indicator startAnimation];
        }
        [hud show:YES];
	}else{
        hud.labelText = indiTitle;
    }
	
	
}

- (void)hideHUDIndicatorViewAtCenter
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
	
    SNHUDIndicatorView *indicator = (SNHUDIndicatorView *)hud.customView;
    
    [indicator stopAnimation];
    
    [hud hide:YES];
}

- (MBProgressHUD *)createHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    SNHUDIndicatorView *indicator = [[SNHUDIndicatorView alloc] init];
    hud.customView = indicator;
    hud.yOffset = y;
    hud.margin = 40;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = indiTitle;
    hud.mode = MBProgressHUDModeCustomView;
    [self addSubview:hud];
    hud.tag = hudViewTag;
    return hud;
}

- (MBProgressHUD *)getHUDIndicatorViewAtCenter
{
    UIView *view = [self viewWithTag:hudViewTag];
    
    if (view != nil && [view isKindOfClass:[MBProgressHUD class]])
    {
        return (MBProgressHUD *)view;
    }
    else 
    {
        return nil;
    }
}

@end