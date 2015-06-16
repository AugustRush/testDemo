//
//  BR_BuyerInfoCell.m
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-6-9.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BR_BuyerInfoCell.h"
#import "BuyRyFitInfo.h"

@interface BR_BuyerInfoCell ()<UITextFieldDelegate>
{
    NSIndexPath *_ip;
    
    IBOutlet UIView *_line01;
    IBOutlet UIView *_line02;
    IBOutlet UIView *_line03;
    IBOutlet UIView *_line04;
    IBOutlet UIView *_splitLine;
    
    
    IBOutlet UITextField    *_txfBuyerName;
    IBOutlet UITextField    *_txfBuyerPhone;
    IBOutlet UITextField    *_txfBuyerAddress;
}

@end


@implementation BR_BuyerInfoCell

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
    BR_BuyerEntity *_buyer = info;
    if (_buyer) {
        _txfBuyerName.text          = _buyer.b_shipName ? _buyer.b_shipName : @"";
        _txfBuyerPhone.text         = _buyer.b_shipMobile ? _buyer.b_shipMobile : @"";
        _txfBuyerAddress.text       = _buyer.b_shipAddress ? _buyer.b_shipAddress : @"";
    }
}

-(void)initCell
{
    UIColor *_lineColor     = [UIColor colorWithRed:220 / 255.0
                                              green:220 / 255.0
                                               blue:220 / 255.0 alpha:1];
    _line01.backgroundColor     = _lineColor;
    _line02.backgroundColor     = _lineColor;
    _line03.backgroundColor     = _lineColor;
    _line04.backgroundColor     = _lineColor;
    _splitLine.backgroundColor  = _lineColor;
    
    
    _txfBuyerAddress.delegate   = self;
    _txfBuyerName.delegate      = self;
    _txfBuyerPhone.delegate     = self;
    
    _txfBuyerAddress.tag    = 3;
    _txfBuyerPhone.tag      = 2;
    _txfBuyerName.tag       = 1;
    

    
}
- (IBAction)provinceClick:(id)sender {

    [[NSNotificationCenter defaultCenter]postNotificationName:@"BRMain"
                                                       object:nil
                                                     userInfo:@{@"cell":@"bi",
                                                                @"ip":_ip,
                                                                @"tp":@"province"
                                                                }];
}
- (IBAction)cityClick:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BRMain"
                                                       object:nil
                                                     userInfo:@{@"cell":@"bi",
                                                                @"ip":_ip,
                                                                @"tp":@"city"
                                                                }];
}


#pragma mark - textFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSString *_tagStr = [NSString stringWithFormat:@"%d",textField.tag];
    
        [[NSNotificationCenter defaultCenter]postNotificationName:@"BRMain"
                                                           object:nil
                                                         userInfo:@{@"cell":@"bi",
                                                                    @"ip":_ip,
                                                                    @"tp":@"txf",
                                                                    @"txfTp":@"begin",
                                                                    @"tag":_tagStr
                                                                    }];
    
    
    
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!textField.text) {
        textField.text = @"";
    }
    textField.text = [textField.text
                      stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
                       
                       
                      // stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
    NSString *_tagStr = [NSString stringWithFormat:@"%d",textField.tag];
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BRMain"
                                                       object:nil
                                                     userInfo:@{@"cell":@"bi",
                                                                @"ip":_ip,
                                                                @"tp":@"txf",
                                                                @"txfTp":@"endEdit",
                                                                @"text":textField.text,
                                                                @"tag":_tagStr
                                                                }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}

@end
