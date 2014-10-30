//
//  ARMessageCollectionView.m
//  ARMessageViewController
//
//  Created by August on 14/10/30.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ARMessageCollectionView.h"

@implementation ARMessageCollectionView

+(instancetype)messageCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    ARMessageCollectionView *collectionView = [[ARMessageCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    return collectionView;
}

@end
