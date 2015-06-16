//
//  BR_PayInfoCell.m
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-6-9.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BR_PayInfoCell.h"
@interface BR_PayInfoCell ()
{
    NSIndexPath *_ip;
    IBOutlet UILabel *_totalPriceLab;
}

@end

@implementation BR_PayInfoCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setPriceTxt:(NSString *)price
{
    _totalPriceLab.text = price;
}

-(void)updateCell:(id)info
            index:(NSIndexPath *)ip
{
    _ip = ip;
    if (info) {
        _totalPriceLab.text = info[@"p"];
    }
}

-(void)initCell
{
    self.contentView.backgroundColor = [UIColor colorWithRed:244 / 255.0
                                                       green:244 / 255.0
                                                        blue:244 / 255.0 alpha:1];
    _totalPriceLab.text = @"0.00";
}


- (IBAction)aliPayClick:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BRMain"
                                                       object:nil
                                                     userInfo:@{@"cell":@"pay",
                                                                @"ip":_ip,
                                                                @"tp":@"ali"
                                                                }];
}
- (IBAction)wxPayClick:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BRMain"
                                                       object:nil
                                                     userInfo:@{@"cell":@"pay",
                                                                @"ip":_ip,
                                                                @"tp":@"wx"
                                                                }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
