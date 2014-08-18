//
//  ARViewController.m
//  UIDynamicsDemo
//
//  Created by August on 14-8-7.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ARViewController.h"

@interface ARViewController ()<UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIView *dynamicView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    dynamicView.backgroundColor = [UIColor purpleColor];
    dynamicView.transform = CGAffineTransformRotate(dynamicView.transform, 45);
    [self.view addSubview:dynamicView];
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[dynamicView]];
    [animator addBehavior:gravity];
    self.animator = animator;
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[dynamicView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collision];
    collision.collisionDelegate = self;
    
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:dynamicView snapToPoint:CGPointMake(200, 300)];
    [self.animator addBehavior:snap];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
