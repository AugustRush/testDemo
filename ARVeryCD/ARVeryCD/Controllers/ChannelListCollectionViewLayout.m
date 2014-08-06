//
//  ChannelListCollectionViewLayout.m
//  ARVeryCD
//
//  Created by August on 14-8-5.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ChannelListCollectionViewLayout.h"

@implementation ChannelListCollectionViewLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.minimumInteritemSpacing = 5;
        self.minimumLineSpacing = 10;
        self.itemSize = CGSizeMake(120, 170);
    }
    return self;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *atrrs = [super layoutAttributesForElementsInRect:rect];
    return atrrs;
}

-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    NSLog(@"aaaa");
    UICollectionViewLayoutAttributes *attr = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    attr.center = CGPointMake(1000, 1000);
    attr.alpha = 0;
    return attr;
}

-(UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    NSLog(@"bbbb");
    UICollectionViewLayoutAttributes *attr = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    attr.alpha = 1;
    attr.center = CGPointMake(100,100);
    return attr;
}

@end
