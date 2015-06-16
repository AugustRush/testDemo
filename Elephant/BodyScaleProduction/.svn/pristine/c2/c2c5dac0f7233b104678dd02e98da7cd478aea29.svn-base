//
//  BRCityAreaControllerCell.m
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-6-9.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BRCityAreaControllerCell.h"
#import "BuyRyFitInfo.h"

@interface BRCityAreaControllerCell ()
{
    NSIndexPath *_ip;
    IBOutlet UILabel    *_nameLab;
    IBOutlet UIView     *_splitLine;
}

@end

@implementation BRCityAreaControllerCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)updateCell:(id)info
            index:(NSIndexPath *)ip
{
    _ip = ip;
    BR_Area *_area = info;
    if (_area) {
        _nameLab.text = _area.a_name;
    }
}

-(void)initCell
{
    _splitLine.backgroundColor = [UIColor colorWithRed:220 / 255.0
                                                 green:220 / 255.0
                                                  blue:220 / 255.0 alpha:1];
  
}

@end
