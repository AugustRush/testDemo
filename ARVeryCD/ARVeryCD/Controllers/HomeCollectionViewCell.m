//
//  HomeCollectionViewCell.m
//  ARVeryCD
//
//  Created by August on 14-7-30.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initConfigs];
}

-(void)initConfigs
{
    self.titleLabel.textColor = FlatBlack;
}

#pragma mark - private methods

-(void)prepareForReuse
{
    self.thumbImageView.image = nil;
    self.titleLabel.text = nil;
}

-(void)buildCellWithEntry:(VCHomeEntry *)entry
{
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:entry.thumbImageUrl]];
    self.titleLabel.text = entry.videoName;
}

@end
