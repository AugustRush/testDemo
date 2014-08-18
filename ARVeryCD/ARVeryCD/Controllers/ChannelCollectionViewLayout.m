//
//  ChannelCollectionViewLayout.m
//  ARVeryCD
//
//  Created by August on 14-8-1.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ChannelCollectionViewLayout.h"
#import "ChannelCollcetionViewCell.h"

@implementation ChannelCollectionViewLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 5;
        self.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    }
    return self;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArr = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attr in attributesArr) {
        
        CGRect visibleRect = self.collectionView.bounds;
        visibleRect.origin = self.collectionView.contentOffset;
        
        CGFloat offset = (attr.center.y - CGRectGetMidY(visibleRect))/CGRectGetHeight(self.collectionView.bounds);
        CGFloat distance = fabsf(offset);
//        attr.transform = CGAffineTransformMakeScale(1-distance/3, 1-distance/3);
        attr.transform3D = CATransform3DScale(CATransform3DIdentity, 1-distance/3, 1-distance/3, 1-offset);
    
        ChannelCollcetionViewCell *cell = (ChannelCollcetionViewCell *)[self.collectionView cellForItemAtIndexPath:attr.indexPath];
        CGRect imageFrame = cell.imageView.frame;
        
        imageFrame.origin.y = 45*offset;
        cell.imageView.frame = imageFrame;
        
    }
    return attributesArr;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
