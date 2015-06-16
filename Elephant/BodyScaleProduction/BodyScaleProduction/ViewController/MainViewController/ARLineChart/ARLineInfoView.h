//
//  ARLineInfoView.h
//  lineChartTest
//
//  Created by 刘平伟 on 14-4-3.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARChartViewGlobal.h"

typedef NS_ENUM(NSInteger, ARLineInfoViewArrowDirection)
{
    ARLineInfoViewArrowDirectionTop,
    ARLineInfoViewArrowDirectionBottom,
    ARLineInfoViewArrowDirectionLeftTop,
    ARLineInfoViewArrowDirectionLeftBottom,
    ARLineInfoViewArrowDirectionRightBottom,
    ARLineInfoViewArrowDirectionRightTop
};

@interface ARLineInfoView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) ARLineInfoViewArrowDirection arrowDirection;

@end
