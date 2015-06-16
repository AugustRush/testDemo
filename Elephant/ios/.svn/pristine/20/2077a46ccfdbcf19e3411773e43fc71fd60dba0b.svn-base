//
//  SNPopoverController.m
//  FFLtd
//
//  Created by 两元鱼 on 12-8-30.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "SNPopoverController.h"
#import "AuthNavigationBar.h"
#import <objc/runtime.h>
#import "SNPopoverNavController.h"
#import "SNPopoverCommonViewController.h"

#define kDefaultPopoverViewWidth   230
#define kDefaultPopoverViewHeight  294
#define kAnimationDuration  0.3f
#define kPopoverViewTop     94

/*********************************************************************/


@interface SNPopoverController()
{
    SNPopoverCommonViewController *contentViewController_;
    SNPopoverNavController *navController_;
}
@property (nonatomic, readonly, strong) CALayer *blackLayer;

@property (nonatomic, readonly, strong) UIControl *maskControl;

@property (nonatomic, strong) UIImageView *backGroundImageView;

@property (nonatomic, readonly, strong) SNPopoverNavController *navController;

- (void)setContentController:(SNPopoverCommonViewController *)controller;

@end

/******************************************************/

@implementation SNPopoverController
@synthesize blackLayer = _blackLayer;
@synthesize maskControl = _maskControl;
@synthesize backGroundImageView = _backGroundImageView;
@synthesize navController = navController_;

@synthesize isVisible = isVisible_;
@synthesize blackLayerFrame = _blackLayerFrame;
@synthesize popoverSize = _popoverSize;

- (void)dealloc
{    
}

- (void)commonSetUp
{
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(0, 20+44, appFrame.size.width, appFrame.size.height-64-49);
    self.blackLayerFrame = frame;
    //设置默认大小
    self.popoverSize = CGSizeMake(kDefaultPopoverViewWidth, kDefaultPopoverViewHeight);
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self commonSetUp];
    }
    return self;
}

- (id)initWithContentController:(SNPopoverCommonViewController *)controller
{
    self = [super init];
    if (self)
    {
        [self commonSetUp];
        [self setContentController:controller];
    }
    return self;
}

- (void)setContentController:(SNPopoverCommonViewController *)controller
{
    if (contentViewController_ != controller) {
        
        NSArray *oldControllers = [self.navController viewControllers];
        if (oldControllers && [oldControllers count]>0) {
            for (SNPopoverCommonViewController *oldController in oldControllers){
                if ([oldController isKindOfClass:[SNPopoverCommonViewController class]]) {
                    oldController.snpopoverController = nil;
                }
            }
        }
        
		[[contentViewController_ view] removeFromSuperview];
		contentViewController_ = controller;
        if ([contentViewController_ isKindOfClass:[SNPopoverCommonViewController class]]) {
            contentViewController_.snpopoverController = self;
        }
		NSArray *viewControllers = [NSArray arrayWithObject:contentViewController_];        
        
		[self.navController setViewControllers:viewControllers];
	}
}

- (SNPopoverCommonViewController *)contentController
{
    return contentViewController_;
}

- (BOOL)isVisible
{
    return isVisible_;
}

- (SNPopoverNavController *)navController
{
    if (!navController_)
    {
        SNPopoverCommonViewController *viewController = [[SNPopoverCommonViewController alloc] init];
        navController_ = [[SNPopoverNavController alloc] initWithRootViewController:viewController homeController:self];
    }
    return navController_;
}

- (UIControl *)maskControl {
	if (_maskControl == nil) {
		_maskControl = [[UIControl alloc] init];
		[_maskControl setBackgroundColor:[UIColor clearColor]];
		[_maskControl addTarget:self action:@selector(maskControlDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _maskControl;
}

- (CALayer *)blackLayer
{
    if (!_blackLayer) {
        _blackLayer = [[CALayer alloc] init];
        _blackLayer.backgroundColor = [UIColor blackColor].CGColor;
    }
    return _blackLayer;
}

- (UIImageView *)backGroundImageView
{
    if (!_backGroundImageView)
    {
        _backGroundImageView = [[UIImageView alloc] init];
        
        UIImage *image = [UIImage imageNamed:@"snpopover_bg_border.png"];
        
        UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        
        _backGroundImageView.image = streImage;
    }
    return _backGroundImageView;
}


#pragma mark -
#pragma mark life cycle

- (void)presentWithContentViewController:(SNPopoverCommonViewController *)viewController animated:(BOOL)animated
{
    [self setContentController:viewController];
    
    [self presentAnimated:animated];
}

- (void)presentAnimated:(BOOL)animated
{
    if (isVisible_) {
        return;
    }
    isVisible_ = YES;
    
    [self.navController.view setAlpha:0.0];
    [self.backGroundImageView setAlpha:0.0];
    [self.blackLayer setOpacity:0.0];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
	CGRect appFrame = [[UIScreen mainScreen] bounds];
    
    [self.blackLayer setFrame:[self blackLayerFrame]];
    [window.layer addSublayer:self.blackLayer];
    
    [self.maskControl setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
	[self.maskControl setFrame:CGRectMake(0, 0, appFrame.size.width, appFrame.size.height)];
	[window addSubview:self.maskControl];
    
    CGFloat posX = (appFrame.size.width-self.popoverSize.width)/2;
    CGFloat posY = self.blackLayerFrame.origin.y+(self.blackLayerFrame.size.height-self.popoverSize.height)/2;
    self.navController.view.frame = CGRectMake(posX, posY, self.popoverSize.width, self.popoverSize.height);
//    self.backGroundImageView.frame = CGRectMake(self.navController.view..left-5,
//                                                self.navController.view.top-5, 
//                                                self.navController.view.width+10, 
//                                                self.navController.view.height+11);
    [window addSubview:self.backGroundImageView];
    
    [window addSubview:self.navController.view];
    
    [UIView animateWithDuration:animated?kAnimationDuration:0
                     animations:^{
                         [self.blackLayer setOpacity:0.5];
                         [self.navController.view setAlpha:1.0];
                         [self.backGroundImageView setAlpha:1.0];
                     } 
                     completion:^(BOOL finished){
                         
                         
                     }];
}

- (void)dismissAnimated:(BOOL)animated
{
    [UIView animateWithDuration:animated?kAnimationDuration:0
                     animations:^{
                         [self.blackLayer setOpacity:0.0];
                         [self.navController.view setAlpha:0.0];
                         [self.backGroundImageView setAlpha:0.0];
                     } 
                     completion:^(BOOL finished){
                         [self.blackLayer removeFromSuperlayer];
                         [self.maskControl removeFromSuperview];
                         [self.backGroundImageView removeFromSuperview];
                         [self.navController.view removeFromSuperview];
                         
                         isVisible_ = NO;
                         
                     }];
}

- (void)maskControlDidTouchUpInside:(id)sender {
	[self dismissAnimated:YES];
    
}

- (void)popToRoot:(BOOL)animated
{
    [self.navController popViewControllerAnimated:animated];
}

@end

