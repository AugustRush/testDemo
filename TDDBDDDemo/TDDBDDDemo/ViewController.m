//
//  ViewController.m
//  TDDBDDDemo
//
//  Created by August on 14-9-4.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushToTestController
{
    UIViewController *controller = [[UIViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
