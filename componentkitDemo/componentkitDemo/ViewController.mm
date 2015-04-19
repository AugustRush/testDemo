//
//  ViewController.m
//  componentkitDemo
//
//  Created by August on 15/4/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import <CKComponentHostingView.h>
#import <CKComponentFlexibleSizeRangeProvider.h>
#import <CKCollectionViewDataSource.h>

@interface ViewController ()<CKComponentProvider>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    

}

@end
