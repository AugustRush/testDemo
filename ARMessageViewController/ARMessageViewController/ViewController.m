//
//  ViewController.m
//  ARMessageViewController
//
//  Created by August on 14/10/30.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ViewController.h"
#import "ARMessageViewController.h"

@interface ViewController ()
- (IBAction)pushToMessageView:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (IBAction)pushToMessageView:(id)sender {
    ARMessageViewController *messageController = [[ARMessageViewController alloc] init];
    [self.navigationController pushViewController:messageController animated:YES];
}
@end
