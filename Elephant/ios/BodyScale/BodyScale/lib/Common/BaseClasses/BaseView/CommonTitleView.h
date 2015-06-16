//
//  CommonTitleView.h
//  FFLtd
//
//  Created by 两元鱼 on 13-4-15.
//  Copyright (c) 2013年 FFLtd. All rights reserved.
//


@protocol TitleViewDelegate <NSObject>
@optional
- (void)leftBtnMethod;
- (void)rightBtnMethod;
@end

@interface CommonTitleView : UIView
{
}

@property (nonatomic, assign) id<TitleViewDelegate> titleDelegate;
@property (nonatomic, strong) UIView *backgroundV;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

- (void)setAllControllers;

@end
