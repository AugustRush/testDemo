//
//  UIView+ICConstraintsAutoLayout.h
//  AutoLayoutProgrammingDemo
//
//  Created by 刘平伟 on 14-5-14.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct{
    
    float ICA;
    float ICB;
    float ICC;
    float ICD;
    
} ICAutoLayoutMargin;

CG_INLINE ICAutoLayoutMargin ICAutoLayoutMarginMake(float a,float b,float c,float d){
    ICAutoLayoutMargin margin = {a,b,c,d};
    return margin;
};


typedef NS_ENUM(NSUInteger, ICAutoLayoutType) {
    ICAutoLayoutTypeAllUnFirm,//默认，abcd分别定义与左右上下的距离
    ICAutoLayoutTypeFirmHeightToTop,//高度确定，与顶部距离固定，ICD就成了高度的定义
    ICAutoLayoutTypeFirmHeightToBottom,
    ICAutoLayoutTypeFirmWidthToLeft,
    ICAutoLayoutTypeFirmWidthToRight,
    ICAutoLayoutTypeFirmHeightLocationCenterY,
    ICAutoLayoutTypeFirmWidthLocationCenterX,
    ICAutoLayoutMarginAllFirmToLeftTop,
    ICAutoLayoutMarginAllFirmToLeftBottom,
    ICAutoLayoutMarginAllFirmToRightTop,
    ICAutoLayoutMarginAllFirmToRightBottom,
    ICAutoLayoutTypeAllFirmLocationCenterXY
};

typedef NS_ENUM(NSUInteger, ICAutoLayoutRelativeType) {
    ICAutoLayoutRelativeTypeFirmHeightTop,
    ICAutoLayoutRelativeTypeFirmHeightBottom,
    ICAutoLayoutRelativeTypeFirmWidthLeft,
    ICAutoLayoutRelativeTypeFirmWidthRight,
    ICAutoLayoutRelativeTypeAllFirmLeftTop,
    ICAutoLayoutRelativeTypeAllFirmLeftBottom,
    ICAutoLayoutRelativeTypeAllFirmRightTop,
    ICAutoLayoutRelativeTypeAllFirmRightBottom,
    ICAutoLayoutRelativeTypeInnerAllUnfirm,
};


@interface UIView (ICConstraintsAutoLayout)

/**
 *  相对于父视图自动布局，默认ICAutoLayoutTypeAllUnFirm为布局类型
 *
 *  @param Margin {10,10,20,30} 相对于父视图左边10，右边10，顶部20，底部30
 */

-(void)ICAutoLayout_RelativeSuperViewMargin:(ICAutoLayoutMargin)Margin;

/**
 *  相对于父视图自动布局，提供ICAutoLayoutType参数来选择布局的方式
 *
 *  @param Margin  Margin {10,10,20,30} 各个参数会根据选择的布局方式有不同的含义
 *  @param type   布局的方式枚举
 */

-(void)ICAutoLayout_RelativeSuperViewMargin:(ICAutoLayoutMargin)Margin type:(ICAutoLayoutType)type;

/**
 *  以relativeView为参考对象进行布局,relativeView 不能为self的superView
 *
 *  @param relativeView 参考视图
 *  @param Margin       Margin {10,10,10,－20} 相对于relativeView的original.x 加 10，max x 加 10，original.y 加 10，max y 加 －20
 */

-(void)ICAutoLayout_RelativeView:(UIView *)relativeView Margin:(ICAutoLayoutMargin)Margin;

/**
 *  以relativeView为参考对象进行布局,relativeView 不能为self的superView
 *
 *  @param relativeView 当前视图布局的参考视图
 *  @param Margin       相对坐标结构体
 *  @param type         不同的type所对应的margin的每个数值的意义不一样
 */
-(void)ICAutoLayout_RelativeView:(UIView *)relativeView Margin:(ICAutoLayoutMargin)Margin Type:(ICAutoLayoutRelativeType)type;

@end
