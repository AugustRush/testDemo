//
//  SNPopoverNavController.m
//  FFLtd
//
//  Created by 两元鱼 on 12-8-30.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "SNPopoverNavController.h"
#import "AuthNavigationBar.h"
#include <objc/runtime.h>
#import "SNPopoverController.h"
#import "SNPopoverCommonViewController.h"

@interface SNPopoverNavController()
{
    SNPopoverController *_homeController;
}


@end

/*********************************************************************/

@implementation SNPopoverNavController


- (id)initWithRootViewController:(UIViewController *)rootViewController 
                  homeController:(SNPopoverController *)homeController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        _homeController = homeController;
        if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
            UIImage *image = [UIImage imageNamed:@"system_nav_bg.png"];
            
            UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:0];
            [self.navigationBar setBackgroundImage:streImage forBarMetrics:UIBarMetricsDefault];
        }
        else
        {
            object_setClass(self.navigationBar, [AuthNavigationBar class]);
        }
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.view.layer.cornerRadius = 3.5;
        [self.view.layer setMasksToBounds:YES];
        self.navigationBar.tintColor = [UIColor redColor];
        
        self.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
        self.navigationBar.layer.shadowOffset = CGSizeMake(0, 1);
        self.navigationBar.layer.shadowOpacity = 0.6;
        self.navigationBar.layer.shadowRadius = 1;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[SNPopoverCommonViewController class]]) {
        [(SNPopoverCommonViewController *)viewController setSnpopoverController:_homeController];
    }
    [super pushViewController:viewController animated:animated];

}

@end
