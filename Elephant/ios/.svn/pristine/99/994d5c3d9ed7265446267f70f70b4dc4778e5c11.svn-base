//
//  CenterTableViewCell.m
//  BodyScale
//
//  Created by cxx on 14-11-11.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "CenterTableViewCell.h"

@implementation CenterTableViewCell

- (void)awakeFromNib
{
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(WeightModel *)myModel
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initResourceWithmodel:myModel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)initResourceWithmodel:(WeightModel *)myModel
{
    float Y_top = 20;
    UIImage * test = [UIImage imageNamed:myModel.imagePath];
    imgView = [[UIImageView alloc] initWithImage:test];
    if(imgView.image)
    {
        DLog(@"image size%f",imgView.image.size.height);
    }
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(@20);
        maker.top.equalTo(@(Y_top));
        maker.width.equalTo(@24);
        maker.height.equalTo(@24);
    }];
    
    textLabel = [[UILabel alloc] init];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [textLabel setText:myModel.weightName];
    [textLabel setFont:[UIFont systemFontOfSize:18]];
    [self.contentView addSubview:textLabel];
    UIEdgeInsets padding = UIEdgeInsetsMake(3, 24+15, 0, 0);
    [textLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(imgView.mas_left).with.offset(padding.left);
        maker.top.equalTo(imgView.mas_top).with.offset(padding.top);
    }];
    
    numLabel = [[LabelExten alloc] init];
    [numLabel setTextStr:myModel.weightValue];
    [self.contentView addSubview:numLabel];
    UIEdgeInsets padding2 = UIEdgeInsetsMake(-10, 0, 0, 70);
    [numLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.equalTo(self.mas_right).with.offset(-10);
        maker.top.equalTo(imgView.mas_top).with.offset(padding2.top);
    }];
}

@end
