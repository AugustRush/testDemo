//
//  ViewController.m
//  ARPhotoBrower
//
//  Created by August on 15/7/2.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import "ARPhotoBrower.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)presentBrower:(id)sender {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.view.bounds.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    ARPhotoBrower *brower = [[ARPhotoBrower alloc] init];
    
    [self presentViewController:brower animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
