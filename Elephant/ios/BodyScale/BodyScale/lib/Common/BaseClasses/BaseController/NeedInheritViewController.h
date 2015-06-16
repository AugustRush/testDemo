//
//  NeedInheritViewController.h
//  FFLtd
//
//  Created by lyywhg on 10-10-11.
//  Copyright 2010 FFLtd. All rights reserved.
//

#import "UIView+ActivityIndicator.h"
#import "CommonViewController.h"
#import "CommonTitleView.h"

@interface NeedInheritViewController : CommonViewController

<UITableViewDelegate, UITableViewDataSource, BBAlertViewDelegate, TitleViewDelegate>
{

}

@property (nonatomic, strong) NSTimerHelper     *dlgTimer;
@property (nonatomic, strong) NSString          *pageInTime;
/*
 by Sun
 */
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *topTitleLabel;
@property (nonatomic, strong) UIImageView *topTitleView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIScrollView *hdScrollView;
/*
 设置TopView
 默认 没有右边按钮
 背景色统一 DefaultColor
 */
- (void)setTopViewWithTitle:(NSString*)title;
/*
 设置TopView
 WithRightImage :右侧按钮图片(默认显示)
 */
- (void)setTopViewWithTitle:(NSString*)title
             WithRightImage:(NSString*)imgName;
/*
 设置TopView
 WithLeftImage :左侧按钮图片
 */
- (void)setTopViewWithTitle:(NSString*)title
             WithLeftImage:(NSString*)imgName;
/*
 设置TopView
 WithLeftImage :左侧按钮图片
  WithRightImage :右侧按钮图片(默认显示)
 */
- (void)setTopViewWithTitle:(NSString*)title
              WithLeftImage:(NSString*)leftimgName
             WithRightImage:(NSString*)rightimgName;
/*
 设置TopView
 WithRightText :右侧文字
 */
- (void)setTopViewWithTitle:(NSString*)title
              WithRightText:(NSString*)text;
/*
 设置TopView
 WithLeftText :左侧文字
 WithRightText :右侧文字
 */
- (void)setTopViewWithTitle:(NSString*)title
               WithLeftText:(NSString *)leftText
              WithRightText:(NSString*)rightText;
/*
 设置TopView
 color : TopView背景色
 */
- (void)setTopViewWithTitle:(NSString*)title
                  WithColor:(UIColor*)bgColor;
/*
 设置TopView
 WithRightImage :右侧按钮图片
 bgColor : TopView背景色
 */
- (void)setTopViewWithTitle:(NSString*)title
             WithRightImage:(NSString*)imgName
                  WithColor:(UIColor*)bgColor;

- (void)setTopViewWithTitle:(NSString*)title
              WithLeftImage:(NSString*)leftimgName
              WithRightText:(NSString*)rightimgName;

+ (id)controller;

- (void)leftBtnAction;
- (void)rightBtnAction;

@end