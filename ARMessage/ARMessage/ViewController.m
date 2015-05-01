//
//  ViewController.m
//  ARMessage
//
//  Created by August on 15/4/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import "MessageViewVController.h"
#import "Message.h"

@interface ViewController ()
- (IBAction)pushToMessage:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushToMessage:(id)sender {

    MessageViewVController *messageViewController = [[MessageViewVController alloc] init];

    [self.navigationController pushViewController:messageViewController animated:YES];
    
}
@end
