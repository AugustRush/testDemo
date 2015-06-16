//
//  SNPopoverNavController.h
//  FFLtd
//
//  Created by 两元鱼 on 12-8-30.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//


@class SNPopoverController;

@interface SNPopoverNavController : UINavigationController


- (id)initWithRootViewController:(UIViewController *)rootViewController 
                  homeController:(SNPopoverController *)homeController;

@end
