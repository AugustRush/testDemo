//
//  ViewController.m
//  CustomCollectionLayoutDemo
//
//  Created by August on 14/10/22.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ViewController.h"
#import "CustomLayout.h"
#import "CustomCell.h"
#import "EmojKeyboardLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic)  UICollectionView *collectionView;
@property (strong, nonatomic) CustomLayout *custpmLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomLayout *customLayout = [[CustomLayout alloc] init];
    self.custpmLayout = customLayout;
    
    EmojKeyboardLayout *emojLayout = [[EmojKeyboardLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 300) collectionViewLayout:emojLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[CustomCell class] forCellWithReuseIdentifier:@"cell"];

    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 250;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CGFloat random = (arc4random()%200)/255.0;
    CGFloat random1 = (arc4random()%155)/255.0;
    CGFloat random2 = (arc4random()%255)/255.0;
    cell.backgroundColor = [UIColor colorWithRed:random green:random1 blue:random2 alpha:1];
    [cell setIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
