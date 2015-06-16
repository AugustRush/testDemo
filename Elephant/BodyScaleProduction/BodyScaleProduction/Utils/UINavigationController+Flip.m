//
//  UINavigationController+Flip.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 5/29/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "UINavigationController+Flip.h"

#define ANIMATION_DURATION      0.5

@implementation UINavigationController (Flip)

- (void)pushViewController:(UIViewController *)viewController transition:(UIViewAnimationTransition)transition {
    [self pushViewController:viewController animated:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (void)popWithTransition:(UIViewAnimationTransition)transition {
    [self popViewControllerAnimated:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

@end
