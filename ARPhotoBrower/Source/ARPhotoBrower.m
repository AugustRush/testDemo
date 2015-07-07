//
//  ARPhotoBrower.m
//  ARPhotoBrower
//
//  Created by August on 15/7/2.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoBrower.h"
#import "ARPhotoBrowerCell.h"

@interface ARPhotoBrower ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation ARPhotoBrower

NSString *const reuseIdentifier = @"ARPhotoBrowerCell";

#pragma mark - life cycle methods

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _setUp];
}

#pragma mark - private methods

-(void)_setUp
{
    self.images = [NSMutableArray array];
    
    for (int i = 0; i < 50; i ++) {
        [self.images addObject:@"test"];
    }
    
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[ARPhotoBrowerCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - UICollectionViewDataSource methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ARPhotoBrowerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
