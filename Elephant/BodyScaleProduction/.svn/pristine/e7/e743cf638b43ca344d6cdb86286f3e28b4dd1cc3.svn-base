//
//  HistoryDetailDataTableViewCell.m
//  ViewDraw
//
//  Created by Go Salo on 14-5-14.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "HistoryDetailDataTableViewCell.h"

@implementation HistoryDetailDataTableViewCell {
    __weak IBOutlet UIImageView *typeImageView;
    __weak IBOutlet UILabel *attrLabel;
    __weak IBOutlet UILabel *valueLabel;
    
    NSArray *_attrs;
}

- (void)awakeFromNib
{
    _attrs = @[@"体重", @"BMI", @"体脂率", @"水含量", @"肌肉比例", @"骨骼重量", @"基础代谢率", @"基础代谢率", @"皮下脂肪", @"内脏脂肪", @"身体年龄"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setter
- (void)setType:(PCType)type valueString:(NSString *)valueString health:(BOOL)health {
    attrLabel.text = _attrs[type];
    
    typeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"historylisticon%d.png", type]];
    if (type == PCType_weight) {
        valueLabel.text = [NSString stringWithFormat:@"%.1fkg", [valueString floatValue]];
    } else if (type == PCType_fat || type == PCType_skin || type == PCType_boneWeight || type == PCType_muscle || type == PCType_water) {
        valueLabel.text = [NSString stringWithFormat:@"%.1f%%", [valueString floatValue]];
    } else if (type == PCType_bodyage || type == PCType_bmr || type == PCType_eBmr) {
        valueLabel.text = [NSString stringWithFormat:@"%.0f", [valueString floatValue]];
    } else {
        valueLabel.text = [NSString stringWithFormat:@"%.1f", [valueString floatValue]];
    }
    
    if (health) {
        valueLabel.textColor = [UIColor colorWithRed:67 / 255.0f green:157 / 255.0f blue:18 / 255.0f alpha:1];
    } else {
        valueLabel.textColor = [UIColor colorWithRed:252 / 255.0f green:70 / 255.0f blue:70 / 255.0f alpha:1];
    }
}

@end
