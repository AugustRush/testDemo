//
//  ChannelCollcetionViewCell.m
//  ARVeryCD
//
//  Created by August on 14-8-1.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ChannelCollcetionViewCell.h"

@implementation ChannelCollcetionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)prepareForReuse
{
    self.imageView.image = nil;
}

-(void)awakeFromNib
{
    self.imageView.contentMode = UIViewContentModeCenter;
    self.channelLabel.backgroundColor = FlatRed;
    self.channelLabel.textColor = FlatWhite;
    self.descriptionlabel.backgroundColor = FlatTeal;
    self.descriptionlabel.textColor = FlatWhite;
}

#pragma mark - public methods

-(void)buildCellWithChannel:(VCChannel *)channel
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:channel.channelThumbnail]];
    self.descriptionlabel.text = channel.channelDescription;
    self.channelLabel.text = channel.channelName;
    NSLog(@"channel is %@",channel);
}

@end
