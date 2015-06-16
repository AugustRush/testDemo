//
//  PopupTipView.m
//  bangbang
//
//  Created by 嘟嘟的小毛驴 on 14-7-16.
//  Copyright (c) 2014年 njsk. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PopupTipView.h"

#define kTagTipsView   111
#define kTagBackView   112
// Size Manage
#define TEXT_SIZE(str, font, ms)  [str sizeWithFont:font constrainedToSize:ms lineBreakMode:UILineBreakModeWordWrap]

static UIActivityIndicatorView *activityIndicator = nil;
static UIView *backView = nil;
static UIView *containerView = nil;
static UIView *superview = nil;
static UIView *tipsView = nil;

@implementation PopupTipView

+ (BOOL)showInView:(UIView *)view withText:(NSString *)text
{
	if (view == nil) {
		return NO;
	}
	
	[PopupTipView hideWait];
    
    superview = view;
    
	CGRect rect = [superview bounds];
    
    backView = [[UIView alloc]initWithFrame:rect];
    backView.backgroundColor = [UIColor darkGrayColor];
    backView.alpha = 0.7f;
    [superview addSubview:backView];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setColor:[UIColor lightGrayColor]];
    if (text.length == 0)
    {
        containerView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-128)/2, (rect.size.height-64)/2-50, 128, 64)];
        activityIndicator.frame = CGRectMake(16.f, 16.f, 32.f, 32.f);
    }
    else 
    {
        
        
            CGSize size = [text sizeWithAttributes: @{NSFontAttributeName: BOLD_FONT_SIZE(16.f)}];
        
               int length = size.width + 120 > 120 ? size.width + 120 : 120;
        containerView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-length)/2, (rect.size.height-length)/2-30, length, 120)];
        activityIndicator.frame = CGRectMake((length-25)/2, 25, 25, 25);
        UILabel *pLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, length, 20)];
        [pLable setText:text];
        [pLable setFont:FONT_SIZE(16.f)];
        [pLable setBackgroundColor:[UIColor clearColor]];
        [pLable setTextAlignment:NSTextAlignmentCenter];
        [pLable setTextColor:[UIColor blackColor]];
        [containerView addSubview:pLable];
    }
	
    [containerView addSubview:activityIndicator];
    [containerView setAlpha:1.0];
    containerView.layer.masksToBounds = YES;
    containerView.layer.cornerRadius = 8.0;
    [containerView setBackgroundColor:[UIColor whiteColor]];
    
	[superview addSubview:containerView]; 
	[activityIndicator startAnimating];
    
	return YES;
}


+ (void)hideWait
{
	if (superview == nil) {
		return;
	}
    [backView removeFromSuperview];
	[activityIndicator stopAnimating];
    [containerView removeFromSuperview];
    superview = nil;
}

+ (BOOL)showTipsInView:(UIView *)view withText:(NSString *)text duration:(NSTimeInterval)duration
{
    return [PopupTipView showTipsInView:view withText:text afterDelay:duration];
}

+ (BOOL)showTipsInView:(UIView *)view withText:(NSString *)text afterDelay:(NSTimeInterval)delay
{
    if (text.length == 0) return NO;
    
    [PopupTipView hideWait];
    
    tipsView = [view viewWithTag:kTagTipsView];
    if (tipsView != nil)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:tipsView];
        [tipsView removeFromSuperview];
        tipsView = nil;
    }
    
    if (backView != nil)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:backView];
        [backView removeFromSuperview];
        backView = nil;
    }
    
    CGRect rect = [view bounds];
    
    
    
    CGRect superrect = [view bounds];

    backView = [[UIView alloc]initWithFrame:superrect];
    backView.tag = kTagBackView;
    backView.backgroundColor = [UIColor darkGrayColor];
    backView.alpha = 0.7f;
    [view addSubview:backView];

    
  
        CGSize size = [text sizeWithAttributes: @{NSFontAttributeName: BOLD_FONT_SIZE(16.f)}];
        
    int length = size.width + 120 > 120 ? size.width + 120 : 120;
    tipsView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width-length)/2, (rect.size.height-length)/2+30, length, 60)];
    tipsView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | 
                                UIViewAutoresizingFlexibleBottomMargin | 
                                UIViewAutoresizingFlexibleLeftMargin | 
                                UIViewAutoresizingFlexibleRightMargin;
    
    // Transparent background
    tipsView.opaque = NO;
    tipsView.backgroundColor = [UIColor clearColor];
    tipsView.tag = kTagTipsView;
    
    // Make invisible for now
    tipsView.alpha = 1.0f;
    size = tipsView.frame.size;
    UILabel *pLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, length, 20)];
    [pLable setText:text];
    [pLable setFont:FONT_SIZE(16.f)];
    [pLable setBackgroundColor:[UIColor clearColor]];
    [pLable setTextAlignment:NSTextAlignmentCenter];
    [pLable setTextColor:[UIColor blackColor]];
    pLable.lineBreakMode = NSLineBreakByWordWrapping| NSLineBreakByTruncatingTail;
    pLable.numberOfLines = 2;
    
    [tipsView addSubview:pLable];
    
    [tipsView setAlpha:0.8];
    tipsView.layer.masksToBounds = YES;
    tipsView.layer.cornerRadius = 8;
    [tipsView setBackgroundColor:[UIColor whiteColor]];

	[view addSubview:tipsView];
    
    [tipsView performSelector:@selector(removeFromSuperview) withObject:tipsView afterDelay:delay];
    
    [backView performSelector:@selector(removeFromSuperview) withObject:backView afterDelay:delay];
    
    return YES;
}

@end
