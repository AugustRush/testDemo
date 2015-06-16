//
//  AQBaseViewController.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 4/19/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "AQBaseViewController.h"
#import "MMDrawerController.h"
#import "LeftSideViewController.h"
#import "UIImageView+WebCache.h"
#import "BaseView.h"

#define LeftViewController  (LeftSideViewController *)[(MMDrawerController *)[[UIApplication sharedApplication].delegate window].rootViewController leftDrawerViewController]
#define FLURRY_EVENT_KEY    NSStringFromClass([self class])

@implementation AQBaseViewController 

#pragma mark - View Lifecycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ThemeDidChangeNotification object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:ThemeDidChangeNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本背景
    UIImage *backgroundImage = [UIImage imageNamed:@"beijing.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)];
    [self.view insertSubview:imageView atIndex:0];
    self.backgroundView = imageView;

    if (kIsiOS_7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self buildBackButton];
    [self configureThemeAppearance];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 开始页面统计时间
    [Flurry logEvent:FLURRY_EVENT_KEY timed:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 结束页面统计时间
    [Flurry endTimedEvent:FLURRY_EVENT_KEY withParameters:nil];
}

#pragma mark - Public Methods

- (void)buildBackButton {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 16, 25);
    [backButton setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back_icon_press"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    if (kIsiOS_7) {
        // 只为presentViewController构建返回按钮，栈中的viewController使用系统原生返回按钮
        if (self.navigationController.viewControllers.count == 1) {
            [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -11, 0, 0)];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        }
    } else {
        // iOS6中为所有viewController构建返回按钮
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
}

- (void)buildBarButtonItemIn:(BaseViewControllerBarButtonItemPosition)position withTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 50, 30)];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (position == BaseViewControllerBarButtonItemPositionLeft) {
        [button addTarget:self action:@selector(leftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = barButton;
    } else {
        [button addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = barButton;
    }
}

- (void)buildBarButtonItemIn:(BaseViewControllerBarButtonItemPosition)position withImagePath:(NSString *)imagePath gender:(int)gender {
    id item = nil;
    if (position == BaseViewControllerBarButtonItemPositionLeft) {
        item = self.navigationItem.leftBarButtonItem;
    } else {
        item = self.navigationItem.rightBarButtonItem;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SERVICE_URL, imagePath]];
    UIImageView *imageView = nil;
    if (item && [item isKindOfClass:[UIImageView class]]) {
        imageView = (UIImageView *)item;
        imageView.layer.cornerRadius = 20;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 1.5f;
        imageView.layer.masksToBounds = YES;
    } else {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imageView.layer.cornerRadius = 20;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 1.5f;
        imageView.layer.masksToBounds = YES;
    }
    
    UIImage *placeholderImage = nil;
    if (gender == 0) {
        placeholderImage = [UIImage imageNamed:@"default_photo_females.png"];
    } else {
        placeholderImage = [UIImage imageNamed:@"default_photo_males.png"];
    }
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    UITapGestureRecognizer *tap = nil;
    if (position == BaseViewControllerBarButtonItemPositionLeft) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftBarButtonAction:)];
        self.navigationItem.leftBarButtonItem = barButton;
    } else {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightBarButtonAction:)];
        self.navigationItem.rightBarButtonItem = barButton;
    }
    [imageView addGestureRecognizer:tap];
    tap.numberOfTouchesRequired = 1;
    
    if (imagePath.length) {
        if (placeholderImage) {
            [imageView setImageWithURL:url placeholderImage:placeholderImage];
        } else {
            [imageView setImageWithURL:url];
        }
    } else {
        imageView.image = placeholderImage;
    }
}

- (void)buildBarButtonItemIn:(BaseViewControllerBarButtonItemPosition)position withImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (position == BaseViewControllerBarButtonItemPositionLeft) {
        [button addTarget:self action:@selector(leftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = barButton;
    } else {
        [button addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = barButton;
    }
}

- (void)dismiss {
    if (self.presentingViewController && self.navigationController.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:^ {
            if ([GloubleProperty sharedInstance].leftViewWillAppear) {
                [LeftViewController hackViewWillAppearAfterDismissViewController];
            }
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Notification

- (void)themeDidChange:(NSNotification *)notification {
    [self configureThemeAppearance];
}

- (void)configureThemeAppearance {
    self.backgroundView.image = ThemeImage(@"beijing.png");
    
    if (!self.navigationController) {
        return;
    }
    UIImage *image = nil;
    if (kIsiOS_7) {
        image = ThemeImage(@"navigation_bar_background_image_iOS7.png");
    } else {
        image = ThemeImage(@"navigation_bar_background_image_iOS6.png");
    }
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

}

#pragma mark - Actions

- (void)leftBarButtonAction:(id)sender {
    
}

- (void)rightBarButtonAction:(id)sender {
    
}

@end
