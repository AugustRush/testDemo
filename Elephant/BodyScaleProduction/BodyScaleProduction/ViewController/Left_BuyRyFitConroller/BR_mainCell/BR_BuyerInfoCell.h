//
//  BR_BuyerInfoCell.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-6-9.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BuyRyFitInfo.h"



@interface BR_BuyerInfoCell : UITableViewCell



@property(nonatomic,weak)IBOutlet UIButton *provinceBtn;
@property(nonatomic,weak)IBOutlet UIButton *cityBtn;

-(void)initCell;
-(void)updateCell:(id)info index:(NSIndexPath *)ip;

@end
