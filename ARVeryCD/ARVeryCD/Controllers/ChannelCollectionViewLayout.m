//
//  ChannelCollectionViewLayout.m
//  ARVeryCD
//
//  Created by August on 14-8-1.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ChannelCollectionViewLayout.h"

@implementation ChannelCollectionViewLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    }
    return self;
}

//-(CGSize)collectionViewContentSize
//{
//    return self.collectionView.bounds.size;
//}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArr = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attr in attributesArr) {
        
        CGRect relativeRect = [self.collectionView convertRect:attr.frame toView:self.collectionView.superview];
        
        CGFloat distance = fabs(CGRectGetMidY(relativeRect)-CGRectGetMidY(self.collectionView.bounds));
        attr.transform = CGAffineTransformMakeScale(0.6+0.4*distance/CGRectGetMidY(self.collectionView.bounds), distance/CGRectGetMidY(self.collectionView.bounds));
    }
    return attributesArr;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
