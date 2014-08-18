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

@end
