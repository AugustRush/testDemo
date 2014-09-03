//
//  ViewController.m
//  ARSegmentControl
//
//  Created by August on 14-9-2.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) ARActionSheet *actionSheet;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.actionSheet = [[ARActionSheet alloc] initWithTitles:@[@"sina",@"tencent",@"item"]];
    self.actionSheet.height = 300;
    self.actionSheet.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1];
    self.actionSheet.itemSize = CGSizeMake(160, 40);
    [self.actionSheet setItemImages:@[[UIImage imageNamed:@"copy"],[UIImage imageNamed:@"facebook"],[UIImage imageNamed:@"mail"],[UIImage imageNamed:@"copy"],[UIImage imageNamed:@"copy"]] highlightImages:@[[UIImage imageNamed:@"copy_actived"],[UIImage imageNamed:@"facebook_actived"],[UIImage imageNamed:@"mail_actived"],[UIImage imageNamed:@"copy_actived"]]];
    self.actionSheet.allowsMultipleSelection = YES;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.actionSheet.isShowing) {
         [self.actionSheet hide];
    }else{
    
        [self.actionSheet show];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"move");
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
