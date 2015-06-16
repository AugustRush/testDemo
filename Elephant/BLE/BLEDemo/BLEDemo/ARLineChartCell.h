//
//  ARLineChartCell.h
//  lineChartTest
//
//  Created by 刘平伟 on 14-3-21.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLineChartDot.h"

@interface ARLineChartCell : UICollectionViewCell
{
    CAShapeLayer *_shapeL;
    UILabel *_titleLabel;
    ARLineChartDot *_dot;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *lineColor;

-(void)setStartValue:(CGFloat)startValue endValue:(CGFloat)endValue;

@end
