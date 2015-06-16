//
//  ChatListViewController.m
//  BodyScale
//
//  Created by 两元鱼 on 15/3/17.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ChatListViewController.h"

@interface ChatListViewController ()

@end

@implementation ChatListViewController

#pragma mark
#pragma mark - Init & Dealloc
- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}
- (void)dealloc
{
}
#pragma mark
#pragma mark - Init & Add


#pragma mark
#pragma mark - System Action
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initViewControllerBaseInfo];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark
#pragma mark - Other Action
- (void)initViewControllerBaseInfo
{
    [self buildControllers];
    [self buildOtherLogic];
}
- (void)buildControllers
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
}
- (void)buildOtherLogic
{
    
}
- (void)backAction
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark
#pragma mark - System Delegate & Datasource

#pragma mark
#pragma mark - Other Delegate & Datasource


@end
