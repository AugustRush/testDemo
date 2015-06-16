//
//  CircleFormView.h
//  BodyScale
//
//  Created by Go Salo on 14-3-4.
//  Copyright (c) 2014年 于菲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleFormView : UIView

/**
 *  设置图标数据
 *
 *  @param name       图表名称
 *  @param num        图表数值
 *  @param percentage 图标数值百分比(0 - 100之间的数)
 */
- (void)setItemName:(NSString *)name dataNum:(float)num percentage:(float)percentage;

@end
