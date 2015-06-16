//
//  CommonTitleView.m
//  FFLtd
//
//  Created by 两元鱼 on 13-4-15.
//  Copyright (c) 2013年 FFLtd. All rights reserved.
//

#import "CommonTitleView.h"

@implementation CommonTitleView
@synthesize titleDelegate;
#pragma mark-
#pragma mark Init & Dealloc
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}
- (void)dealloc
{
}
#pragma mark-
#pragma mark Init & Add
- (UILabel *)titleL
{
    if (!_titleL)
    {
        _titleL = [[UILabel alloc] init];
        _titleL.frame = CGRectMake(60, 0, 200, VIEW_HEIGHT);
        _titleL.backgroundColor = [UIColor clearColor];
        _titleL.textColor = [UIColor whiteColor];
        _titleL.font = FONT20;
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.shadowColor = RGBCOLOR(20, 120, 224);
        _titleL.shadowOffset = CGSizeMake(1.0, 1.0);
        [self addSubview:_titleL];
    }
    return _titleL;
}

- (UIView *)backgroundV
{
    if (!_backgroundV)
    {
        _backgroundV = [[UIView alloc] init];
        _backgroundV.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
        _backgroundV.backgroundColor = [UIColor clearColor];
        [self addSubview:_backgroundV];
    }
    return _backgroundV;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(5, 3, 80, 35);
        _leftBtn.backgroundColor = [UIColor clearColor];
        [_leftBtn addTarget:self action:@selector(tmpLeftBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(VIEW_WIDTH - 85, 3, 80, 35);
        _rightBtn.backgroundColor = [UIColor clearColor];
        [_rightBtn addTarget:self action:@selector(tmpRightBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
        
    }
    return _rightBtn;
}

- (void)setAllControllers
{
    self.backgroundV.backgroundColor = [UIColor clearColor];
    self.titleL.backgroundColor = [UIColor clearColor];
    self.leftBtn.backgroundColor = [UIColor clearColor];
    self.rightBtn.backgroundColor = [UIColor clearColor];
    
}

- (void)tmpLeftBtnMethod
{
    if ([self.titleDelegate conformsToProtocol:@protocol(TitleViewDelegate)])
    {
        if ([self.titleDelegate performSelector:@selector(leftBtnMethod)])
        {
            [self.titleDelegate leftBtnMethod];
        }
    }
}

- (void)tmpRightBtnMethod
{
    if ([self.titleDelegate conformsToProtocol:@protocol(TitleViewDelegate)])
    {
        if ([self.titleDelegate performSelector:@selector(rightBtnMethod)])
        {
            [self.titleDelegate rightBtnMethod];
        }
    }
}

@end
