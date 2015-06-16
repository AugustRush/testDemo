//
//  LeftTableViewCell.m
//  BodyScale
//
//  Created by cxx on 14-11-14.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateWithImg:(UIImage *)img WithText:(NSString *)text
{
    [self.imgView setImage:img];
    self.textLb.text = text;
}
@end
