//
//  BaseViewController.m
//  ARVeryCD
//
//  Created by August on 14-7-29.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - lifeCycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self Configs];
}

#pragma mark - Private methods

-(void)Configs
{
    self.view.backgroundColor = FlatWhite;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - manage memory methods

-(void)dealloc
{}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
