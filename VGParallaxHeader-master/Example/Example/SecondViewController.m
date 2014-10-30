//
//  SecondViewController.m
//  Example
//
//  Created by Marek Serafin on 26/09/14.
//  Copyright (c) 2014 Marek Serafin. All rights reserved.
//

#import "SecondViewController.h"
#import "HeaderViewWithImage.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HeaderViewWithImage *headerView = [HeaderViewWithImage instantiateFromNib];
    
    
    [self.scrollView setParallaxHeaderView:headerView
                                      mode:VGParallaxHeaderModeCenter
                                    height:200];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, 3000)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self.scrollView shouldPositionParallaxHeader];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

@end
