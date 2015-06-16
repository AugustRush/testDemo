//
//  HealthIndexView.m
//  BodyScale
//
//  Created by zhangweiwei on 15/1/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "HealthIndexView.h"
#import "LineView.h"
#import "RightLineView.h"
@interface HealthIndexView()

//textLB
@property(strong,nonatomic) LineView *lineView;
@property(strong,nonatomic) UILabel *normalTextLb;//TextLb1
@property(strong,nonatomic) UILabel *bodyAgeLb;//textLb11
@property(strong,nonatomic) RightLineView *rightLineView;
@property(nonatomic,strong) UILabel * bmiTextLb;    //textLb2

@end

@implementation HealthIndexView

- (HeaderButton *)headBt
{
    if (!_headBt)
    {
        _headBt = [HeaderButton buttonWithType:UIButtonTypeCustom];
        NSString * imgPath = [NSString stringWithFormat:@"%@/%@.%@", [CommanHelp getDocmentsDirectory],HEADERIMAGE,@"png"];
        [_headBt setWithHeaderView:imgPath];
        [self addSubview:_headBt];
    }
    return _headBt;
}
- (UIButton *)shareBt
{
    if (!_shareBt)
    {
        _shareBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBt setBackgroundImage:[UIImage imageNamed:@"shareIcon"] forState:UIControlStateNormal];
        [self addSubview:_shareBt];
    }
    return _shareBt;
}
- (UILabel * )userNameLb
{
    if (!_userNameLb)
    {
        _userNameLb = [[UILabel alloc] init];
        [_userNameLb setText:@"User name"];
        [_userNameLb setTextColor:[UIColor whiteColor]];
        [_userNameLb sizeToFit];
        [self addSubview:_userNameLb];
    }
    return _userNameLb;
}
- (UILabel *)weightLabel
{
    if (!_weightLabel)
    {
        _weightLabel = [[UILabel alloc]init];
        [_weightLabel setTextColor:[UIColor whiteColor]];
        [_weightLabel setTextAlignment:NSTextAlignmentCenter];
        //_weightLabel.text = @"您的体重已超标，请控制饮食，多运动";
        [self addSubview:_weightLabel];
    }
    return _weightLabel;
}
- (UILabel *)bmiNumLb
{
    if(!_bmiNumLb)
    {
        _bmiNumLb = [[UILabel alloc] init];
        [_bmiNumLb setTextColor:[UIColor whiteColor]];
        [_bmiNumLb setFont:[UIFont systemFontOfSize:40]];
        [_bmiNumLb setTextAlignment:NSTextAlignmentCenter];
        [_bmiNumLb setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_bmiNumLb];
    }
    return _bmiNumLb;
}
- (LineView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[LineView alloc] init];
        [_lineView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_lineView];
    }
    return _lineView;
}
- (UILabel *)normalTextLb
{
    if (!_normalTextLb)
    {
        _normalTextLb = [[UILabel alloc] init];
        [_normalTextLb setTextColor:[UIColor whiteColor]];
        [_normalTextLb setFont:[UIFont systemFontOfSize:14]];
        [_normalTextLb setTextAlignment:NSTextAlignmentCenter];
        [_normalTextLb setBackgroundColor:[UIColor clearColor]];
        [_normalTextLb setText:@"标准"];
        [self addSubview:_normalTextLb];
    }
    return _normalTextLb;
}
- (UILabel*)bmiTextLb
{
    if (!_bmiTextLb)
    {
        _bmiTextLb = [[UILabel alloc] init];
        [_bmiTextLb setTextColor:[UIColor whiteColor]];
        [_bmiTextLb setFont:[UIFont systemFontOfSize:14]];
        [_bmiTextLb setTextAlignment:NSTextAlignmentCenter];
        [_bmiTextLb setBackgroundColor:[UIColor clearColor]];
        [_bmiTextLb setText:@"BMI"];
        [self addSubview:_bmiTextLb];
    }
    return _bmiTextLb;
}
- (UILabel *)ageLb
{
    if (!_ageLb)
    {
        _ageLb = [[UILabel alloc] init];
        [_ageLb setTextColor:[UIColor whiteColor]];
        [_ageLb setFont:[UIFont systemFontOfSize:40]];
        [_ageLb setTextAlignment:NSTextAlignmentCenter];
        [_ageLb setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_ageLb];
    }
    return _ageLb;
}
- (UILabel * )bodyAgeLb
{
    if (!_bodyAgeLb)
    {
        _bodyAgeLb  = [[UILabel alloc] init];
        [_bodyAgeLb setTextColor:[UIColor whiteColor]];
        [_bodyAgeLb setFont:[UIFont systemFontOfSize:14]];
        [_bodyAgeLb setTextAlignment:NSTextAlignmentCenter];
        [_bodyAgeLb setBackgroundColor:[UIColor clearColor]];
        [_bodyAgeLb setText:@"身体年龄"];
        [self addSubview:_bodyAgeLb];
    }
    return _bodyAgeLb;
}

- (RightLineView *)rightLineView
{
    if (!_rightLineView)
    {
        _rightLineView =  [[RightLineView alloc] init];
        [_rightLineView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_rightLineView];
    }
    return _rightLineView;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        CGFloat insetTop =Screen_Height*3/4-12;
        int leftX = 43;
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"homePageBackground"]]];
        
        
        [self.headBt mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.left.equalTo(@10);
            maker.top.equalTo(@20);
            maker.height.equalTo(@36);
            maker.width.equalTo(@36);
        }];
        
        [self.shareBt mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.right.equalTo(@(-10));
            maker.top.equalTo(self.headBt);
            maker.height.equalTo(@36);
            maker.width.equalTo(@36);
        }];
        
        [self.userNameLb mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.centerX.equalTo(@0);
            maker.top.equalTo(@30);
        }];
        
        UIEdgeInsets padding1 = UIEdgeInsetsMake(insetTop-30, 0,0, 0);
        [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.top.equalTo(self.mas_top).with.offset(padding1.top); //with is an optional semantic filler
            maker.left.equalTo(self.mas_left).with.offset(padding1.left);
            maker.bottom.equalTo(self.mas_bottom).with.offset(-padding1.bottom);
            maker.right.equalTo(self.mas_right).with.offset(-padding1.right);
        }];
        
        [self.bmiNumLb mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.left.equalTo(self.mas_left).offset(-25);//.with.offset(padding2.left);
            maker.top.equalTo(self.mas_top).offset(GetWidth(280));
            maker.width.equalTo(@(50*3));
            maker.height.equalTo(@(40));
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(self.bmiNumLb.mas_top).with.offset(10);
            make.width.equalTo(@150);
            make.height.equalTo(@60);
        }];
        
        UIEdgeInsets padding3 = UIEdgeInsetsMake(0, 0,-leftX+47, 0);
        [self.normalTextLb mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.left.equalTo(self.bmiNumLb.mas_left).with.offset(padding3.left);
            maker.top.equalTo(self.bmiNumLb.mas_bottom).with.offset(padding3.bottom);
            maker.width.equalTo(@(50*3));
        }];
        
        UIEdgeInsets padding4 = UIEdgeInsetsMake(0, 0,-leftX+45, 0);
        [self.bmiTextLb mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.left.equalTo(self.bmiNumLb.mas_left).with.offset(padding4.left);
            maker.top.equalTo(self.normalTextLb.mas_bottom).with.offset(padding4.bottom);
            maker.width.equalTo(@(50*3));
        }];
        
        [self.ageLb mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.right.equalTo(self.mas_right).with.offset(-5);
            maker.top.equalTo(self.mas_top).with.offset(GetWidth(280));
            maker.width.equalTo(@(40*3));
            maker.height.equalTo(@(40));
        }];
        UIEdgeInsets padding6 = UIEdgeInsetsMake(0, -10,-leftX+45, 0);
        [self.bodyAgeLb mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.left.equalTo(self.ageLb.mas_left).with.offset(0);
            maker.top.equalTo(self.ageLb.mas_bottom).with.offset(padding6.bottom);
            maker.width.equalTo(@(50*3));
        }];
        
        [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bodyAgeLb.mas_right);
            make.top.equalTo(self.ageLb.mas_top).with.offset(10);
            make.width.equalTo(@150);
            make.height.equalTo(@60);
        }];
    }
    return self;
}

@end
