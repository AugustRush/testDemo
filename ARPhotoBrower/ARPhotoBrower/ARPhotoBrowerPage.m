//
//  ARPhotoBrowerPage.m
//  ARPhotoBrower
//
//  Created by August on 15/7/12.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoBrowerPage.h"

@interface ARPhotoBrowerPage ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ARPhotoBrowerPage

#pragma mark - lifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods

-(void)setUp
{
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 3;
    self.scrollView.minimumZoomScale = 1;
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 300)];
    [self.scrollView setNeedsLayout];
    [self.scrollView layoutIfNeeded];
}

#pragma mark - UIScrollViewDelegate methods

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
