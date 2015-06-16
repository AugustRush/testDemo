//
//  ARLineChartCell.h
//  lineChartTest
//
//  Created by 刘平伟 on 14-3-21.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLineDot.h"
#import "ARChartViewGlobal.h"

@class ARLineChartCellBack;

@interface ARLineChartCell : UICollectionViewCell
{
    @private
    CAShapeLayer *_shapeL;
    ARLineDot *_dot;
    UILabel *_titleLabel;
    ARLineChartCellBack *_backView;
}

@property (nonatomic, copy) NSString *infoTitle;
@property (nonatomic, assign,readonly) CGPoint Point;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *selectLineColor;

-(void)setStartValue:(CGFloat)startValue endValue:(CGFloat)endValue;

@end


@interface ARLineChartCellBack : UIView

@property (nonatomic, assign) CGPathRef path;

@property (nonatomic, strong) NSArray *gradientColors;


@end