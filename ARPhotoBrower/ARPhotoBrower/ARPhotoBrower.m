//
//  ARPhotoBrower.m
//  ARPhotoBrower
//
//  Created by August on 15/7/12.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoBrower.h"
#import "ARPhotoBrowerPage.h"

@interface ARPhotoBrower ()

@end

@implementation ARPhotoBrower

#pragma mark - lifeCycle methods

-(instancetype)init
{
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@20}];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

-(void)_setUp
{
    self.dataSource = self;
    self.delegate = self;
    
    ARPhotoBrowerPage *currentPage = [[ARPhotoBrowerPage alloc] initWithNibName:@"ARPhotoBrowerPage" bundle:nil];
    [self setViewControllers:@[currentPage] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

#pragma mark - UIPageViewControllerDataSource method

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    ARPhotoBrowerPage *page = [[ARPhotoBrowerPage alloc] initWithNibName:@"ARPhotoBrowerPage" bundle:nil];
    return page;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    ARPhotoBrowerPage *page = [[ARPhotoBrowerPage alloc] initWithNibName:@"ARPhotoBrowerPage" bundle:nil];
    return page;
}

@end
