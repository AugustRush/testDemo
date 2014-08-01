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
    
}

#pragma mark - private methods

-(void)prepareForReuse
{

}

-(void)buildCellWithEntry:(VCHomeEntry *)entry
{
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:entry.thumbImageUrl]];
    self.titleLabel.text = entry.videoName;
}

@end
