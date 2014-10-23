//
//  CustomLayout.m
//  CustomCollectionLayoutDemo
//
//  Created by August on 14/10/22.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "CustomLayout.h"

@interface CustomLayout ()

@property (nonatomic, strong) NSMutableArray *layoutAttributes;

@end

@implementation CustomLayout

-(instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)prepareLayout
{
        NSLog(@"%s",__PRETTY_FUNCTION__);
    [super prepareLayout];
//    if (self.layoutAttributes == nil) {
        self.layoutAttributes = [NSMutableArray array];
//    }
    self.itemSize = CGSizeMake(15, CGRectGetHeight(self.collectionView.bounds));
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds)*3, CGRectGetHeight(self.collectionView.bounds));
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    if (_layoutAttributes.count > 0) {
        return _layoutAttributes;
    }
    
//    _layoutAttributes = [NSMutableArray array];

    NSArray *indexPaths = [self indexPathsInRect:rect];
    
    for (int i = 0; i < indexPaths.count; i++) {
        NSIndexPath *indexPath = indexPaths[i];
        
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        attributes.frame = [self itemFrameAtIndexPath:indexPath];
        attributes.zIndex = indexPath.row;
        [_layoutAttributes addObject:attributes];
    }
    return _layoutAttributes;
}

-(NSArray *)indexPathsInRect:(CGRect)rect
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int section = 0; section < sectionCount; section++) {
        NSInteger sectionItemsCount = [self.collectionView numberOfItemsInSection:section];
        CGRect visibleRect = [self visibleRect];
        for (int item; item < sectionItemsCount; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CGRect itemFrame = [self itemFrameAtIndexPath:indexPath];
//            if (CGRectIntersectsRect(visibleRect, itemFrame)) {
                [indexPaths addObject:indexPath];
//            }

        }
    }
    
    return indexPaths;
}

-(CGRect)itemFrameAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect itemFrame = CGRectMake(indexPath.item*self.itemSize.width, 0, self.itemSize.width,self.itemSize.height);
    return itemFrame;
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        NSLog(@"layout index");
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    layoutAttributes.zIndex = layoutAttributes.indexPath.row;
    layoutAttributes.frame = [self itemFrameAtIndexPath:indexPath];
//    layoutAttributes.size = self.itemSize;
    return layoutAttributes;
}

-(CGRect)visibleRect
{
    CGPoint offset = self.collectionView.contentOffset;
    return CGRectMake(offset.x, offset.y, CGRectGetWidth(self.collectionView.bounds)+offset.x, CGRectGetHeight(self.collectionView.bounds)+offset.y);
}

@end
