//
//  EmojKeyboardLayout.m
//  CustomCollectionLayoutDemo
//
//  Created by August on 14/10/23.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "EmojKeyboardLayout.h"

@implementation EmojKeyboardLayout

#pragma mark - lifeCycle methods

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.perPageColumn = 6;
        self.perPageLine = 5;
        _layoutAttributes = [NSMutableArray array];
    }
    return self;
}

-(CGSize)collectionViewContentSize
{
    NSInteger pages = ceilf(_layoutAttributes.count*1.0/(self.perPageLine*self.perPageColumn));
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds)*pages, CGRectGetHeight(self.collectionView.bounds));;
}

#pragma mark - private methods

-(NSArray *)allLayoutAttributes
{
    NSMutableArray *layoutAttributesArray = [NSMutableArray array];
    
    NSInteger sections = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < sections; section++) {
        NSInteger items = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0; item < items; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attrbute = [self layoutAttributesForItemAtIndexPath:indexPath];
            [layoutAttributesArray addObject:attrbute];
        }
    }
    
    return layoutAttributesArray;
}

-(CGRect)itemFrameAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger column = indexPath.item%self.perPageColumn;
    NSInteger line = indexPath.item/self.perPageColumn%self.perPageLine;
    NSInteger page = indexPath.item/(_perPageLine*_perPageColumn);
    CGRect itemFrame = CGRectMake(column*_itemSize.width+CGRectGetWidth(self.collectionView.bounds)*page, line*_itemSize.height, _itemSize.width,_itemSize.height);
    return itemFrame;
}

#pragma mark - override layout methods

-(void)prepareLayout
{
    CGFloat width = CGRectGetWidth(self.collectionView.bounds)/self.perPageColumn;
    CGFloat height = CGRectGetHeight(self.collectionView.bounds)/self.perPageLine;
    _itemSize = CGSizeMake(width, height);
    [_layoutAttributes addObjectsFromArray:[self allLayoutAttributes]];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _layoutAttributes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrbute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrbute.frame = [self itemFrameAtIndexPath:indexPath];
    attrbute.zIndex = indexPath.item;
    return attrbute;
}

@end
