//
//  ARMessageViewController.m
//  ARMessageViewController
//
//  Created by August on 14/10/30.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ARMessageViewController.h"
#import <Masonry.h>

@interface ARMessageViewController ()

@property (nonatomic, strong) ARMessageCollectionView *messageCollectionView;

@end

@implementation ARMessageViewController

#pragma mark - life cycle methods

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configSubViews];
}

#pragma mark - private methods

-(void)configSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.messageCollectionView = [ARMessageCollectionView messageCollectionView];
    [self.view addSubview:self.messageCollectionView];
    [self.messageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - manage memory methods

-(void)dealloc
{
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
