//
//  BodyFatHistoryViewCell.m
//  BodyScale
//
//  Created by Go Salo on 14-3-4.
//  Copyright (c) 2014年 于菲. All rights reserved.
//

#import "BodyFatHistoryViewCell.h"

@interface BodyFatHistoryViewCell()

@end

@implementation BodyFatHistoryViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
}

- (void)awakeFromNib {
    [self configView];
}

#pragma mark - Private Method
- (void)configView {
    self.backgroundColor = [UIColor clearColor];
    self.sliderImageView.image = [[UIImage imageNamed:@"round_slider.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:49];
}

@end
