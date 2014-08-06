//
//  ChannelListCollctionView.m
//  ARVeryCD
//
//  Created by August on 14-8-5.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ChannelListCollctionView.h"
#import "ChannelListCollectionViewLayout.h"

@implementation ChannelListCollctionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(void)initConfigs
{
    ChannelListCollectionViewLayout *layout = [[ChannelListCollectionViewLayout alloc] init];
    self.collectionViewLayout = layout;
    self.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
