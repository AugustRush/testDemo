//
//  ARSearchBar.h
//  MySearchBar
//
//  Created by August on 14-7-28.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARSearchBar : UISearchBar<UITextFieldDelegate>

//替代原生🔍图标
@property (nonatomic, strong) UIImage *leftImage;
//搜索字体的颜色及光标
@property (nonatomic, strong) UIColor *textColor;
//搜索框的背景色
@property (nonatomic, strong) UIColor *searchTextFieldBackgoudColor;
//右边清楚按钮的图标∫
@property (nonatomic, strong) UIImage *clearButtonImage;
//搜索字体的font
@property (nonatomic, strong) UIFont *font;

/**
 *  设置自定义颜色的placeholder
 *
 *  @param placeholder placeholder字符串
 *  @param color       颜色
 */
-(void)setPlaceholder:(NSString *)placeholder withColor:(UIColor *)color;

@end