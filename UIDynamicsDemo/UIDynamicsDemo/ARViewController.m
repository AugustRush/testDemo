//
//  ARViewController.m
//  UIDynamicsDemo
//
//  Created by August on 14-8-7.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ARViewController.h"

@interface ARViewController ()<UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIView *animationView;

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIView *dynamicView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    dynamicView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:dynamicView];
    
    self.animationView = dynamicView;
    
}

- (IBAction)test:(id)sender {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 200, 200)].CGPath;
    animation.duration = 2;
    animation.calculationMode = kCAAnimationCubic;
    [self.animationView.layer addAnimation:animation forKey:@"test"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
