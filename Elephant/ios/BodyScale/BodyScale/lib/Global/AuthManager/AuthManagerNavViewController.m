//
//  AuthManagerNavViewController.m
//  
//
//  Created by 两元鱼 on 11-6-23.
//  Copyright 2011 FFLtd. All rights reserved.
//

#import <objc/runtime.h>
#import "AuthNavigationBar.h"
#import "AuthManagerNavViewController.h"


static NSArray *loginAuthClassArray = nil;
@interface AuthManagerNavViewController ()

//@property (nonatomic,strong) NSArray *loginAuthClassArray;

@end

@implementation AuthManagerNavViewController

+ (void)initialize
{
    if (self == [AuthManagerNavViewController class])
    {
        
        loginAuthClassArray = [[NSArray alloc]  initWithObjects:/*[GuidanceViewController class], [AfterGuidanceListViewController class], [CentreListViewController class], [HealthForecastingViewController class], [AppointmentListViewController class], [HealthEducationViewController class],
            [NewsViewController class],*/nil];
    }
}

- (void)dealloc
{
}

- (void)loadView
{
    [super loadView];
//    self.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 1);
//    self.navigationBar.layer.shadowOpacity = 0.6;
//    self.navigationBar.layer.shadowRadius = 1;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if (self){
        UIImage *image = [UIImage imageNamed:kNavigationBarBackgroundImage];
        if (IOS_7)
        {
           // UIImage *streImage = [UIImage imageNamed:@"nav_bar_bgimage.png"];
            UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:20];
            [self.navigationBar setBackgroundImage:streImage forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
            [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
        }
        else
        {
            UIImage *streImage = [UIImage imageNamed:@"nav_bar_ios6.png"];
            [self.navigationBar setBackgroundImage:streImage forBarMetrics:UIBarMetricsDefault];
        }
   }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}
#pragma mark -
#pragma mark logon auth
- (BOOL)needLogonAuth:(UIViewController *)viewController
{
	BOOL need = NO;
	for (id loginClass in loginAuthClassArray)
    {
		if ([[viewController class] isSubclassOfClass:loginClass])
        {
			need = YES;
			break;
		}
	}
	return need;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] >= 1)
    {
        //自定义返回按钮
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    }
	if ([self needLogonAuth:viewController])
    {
        // 判断用户是否已登录，如果未登录，则弹出登录框
        if ([[FFConfig currentConfig].needAutoLogin boolValue] == NO)
        {
//            LoginViewController *loginViewController = [[LoginViewController alloc] init];
//            loginViewController.nextController = viewController;
//            loginViewController.isMoreView = YES;
//            loginViewController.nextNavigationController = self;
//            [self presentViewController:loginViewController animated:NO completion:nil];
            return;
        }
        if ([self.viewControllers containsObject:viewController])
        {
            return;
        }
	}
    [super pushViewController:viewController animated:animated];

}

-(UIBarButtonItem*) createBackButton
{
    UIImage* image= [UIImage imageNamed:@"System_Nav_Back_btn.png"];
    CGRect backframe= CGRectMake(0, 0, 20, 20);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage :image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
}

-(void)popself
{
    [self popViewControllerAnimated:YES];
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated
{
	[self dismissViewControllerAnimated:animated completion:nil];
}

@end

