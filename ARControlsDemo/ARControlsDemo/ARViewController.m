//
//  ARViewController.m
//  ARControlsDemo
//
//  Created by August on 14-7-25.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ARViewController.h"

@interface ARViewController ()
@property (weak, nonatomic) IBOutlet ICSwitchControl *switchControl;

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //
    [self.switchControl setBackgroundColor:[UIColor greenColor] forState:ICSwitchControlStateOn];
    [self.switchControl setBackgroundColor:[UIColor redColor] forState:ICSwitchControlStateHightlight];
    [self.switchControl setBackgroundColor:[UIColor blueColor] forState:ICSwitchControlStateOff];
    [self.switchControl setCompleteSelectedBlock:^(ICSwitchControl *sender) {
        sender.style = ICSwitchControlStyleDefault;
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
