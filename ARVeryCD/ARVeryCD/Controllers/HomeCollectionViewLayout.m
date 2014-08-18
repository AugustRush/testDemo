//
//  HomeCollectionViewLayout.m
//  ARVeryCD
//
//  Created by August on 14-7-30.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "HomeCollectionViewLayout.h"

@interface HomeCollectionViewLayout ()

@end

@implementation HomeCollectionViewLayout

-(id)init
{
    self = [super init];
    if (self) {
//        self.itemSize = CGSizeMake(90,120);
        self.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
        self.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
    }
    return self;
}


@end
