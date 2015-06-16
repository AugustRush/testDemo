//
//  AQBaseViewController.h
//  BodyScaleProduction
//
//  Created by Zhanghao on 4/19/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceModel.h"
#import "AQLoadingView.h"
#import "ThemeManager.h"

typedef NS_ENUM(NSInteger, BaseViewControllerBarButtonItemPosition) {
    BaseViewControllerBarButtonItemPositionLeft,
    BaseViewControllerBarButtonItemPositionRight
};

@interface AQBaseViewController : UIViewController

- (void)buildBarButtonItemIn:(BaseViewControllerBarButtonItemPosition)position withTitle:(NSString *)title;
- (void)buildBarButtonItemIn:(BaseViewControllerBarButtonItemPosition)position withImage:(UIImage *)image;
- (void)buildBarButtonItemIn:(BaseViewControllerBarButtonItemPosition)position withImagePath:(NSString *)imagePath gender:(int)gender;

- (void)buildBackButton;
- (void)dismiss;
- (void)configureThemeAppearance;

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIView *loadingView;

@end
