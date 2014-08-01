//
//  ChannelCollectionView.m
//  ARVeryCD
//
//  Created by August on 14-8-1.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ChannelCollectionView.h"
#import "ChannelCollectionViewLayout.h"

@implementation ChannelCollectionView

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
    ChannelCollectionViewLayout *layout = [[ChannelCollectionViewLayout alloc] init];
    self.collectionViewLayout = layout;
}

@end
