//
//  MyInfoModifyGenderCell.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-24.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "MyInfoModifyGenderCell.h"

@interface MyInfoModifyGenderCell()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation MyInfoModifyGenderCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(NSString *)content {
    self.label.text = content;
}

@end
