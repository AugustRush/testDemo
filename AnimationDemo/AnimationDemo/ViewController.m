//
//  ViewController.m
//  AnimationDemo
//
//  Created by August on 15/6/5.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import "textView.h"

@interface ViewController ()
@property (strong, nonatomic) textView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from sea nib.
    
    self.testView = [[[NSBundle mainBundle] loadNibNamed:@"testView" owner:nil options:nil] lastObject];
    self.testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testView];
    
    self.testView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.testView addConstraint:[NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:400]];
    
    [self.testView addConstraint:[NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:300]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
     [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    
}

- (IBAction)startAnimation:(id)sender {
    [UIView animateWithDuration:.5
                     animations:^{
                         self.testView.backgroundColor = [UIColor blackColor];
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
