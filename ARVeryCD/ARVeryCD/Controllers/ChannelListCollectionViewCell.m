//
//  ChannelListCollectionViewCell.m
//  ARVeryCD
//
//  Created by August on 14-8-5.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ChannelListCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation ChannelListCollectionViewCell

#pragma mark - init methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)awakeFromNib
{

}

#pragma mark - public methods

-(void)buildCellWithChannelListEntry:(VCChanelListEntry *)enrty
{
    if (enrty.thumbImageUrl) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:enrty.thumbImageUrl]];
    }
}

@end
