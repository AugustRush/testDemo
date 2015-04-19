//
//  ViewController.m
//  ARStatusNotification
//
//  Created by August on 15/4/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import "ARStatusNotification.h"

@interface ViewController ()

@property (nonatomic, strong) UIWindow *testWindow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)show:(id)sender {
    
    [ARStatusNotification show];
}

- (IBAction)dismiss:(id)sender {
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.testWindow.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self.testWindow resignKeyWindow];
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
