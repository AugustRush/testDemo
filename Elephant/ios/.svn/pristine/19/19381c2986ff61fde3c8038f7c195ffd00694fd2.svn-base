//
//  CustomProgressView.m
//  BodyScale
//
//  Created by zhangweiwei on 15/1/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "CustomProgressView.h"

@interface CustomProgressView ()

@end

@implementation CustomProgressView

- (instancetype)initWithConnected:(BOOL)connectedDevice
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (UIImageView *)connectingImg
{
    if (!_connectingImg)
    {
        _connectingImg = [[UIImageView alloc] init];
        _connectingImg.backgroundColor = [UIColor clearColor];
        _connectingImg.image = [UIImage imageNamed:@"NowUserConnecting.png"];
        [self addSubview:_connectingImg];
        [_connectingImg mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.center.equalTo(self).with.offset(3);
            maker.width.equalTo(@160);
            maker.height.equalTo(@62);
        }];
    }
    return _connectingImg;
}
- (UILabel *)connectingLabel
{
    if (!_connectingLabel)
    {
        _connectingLabel = [[UILabel alloc] init];
        _connectingLabel.textAlignment = NSTextAlignmentCenter;
        [_connectingLabel setFont:[UIFont systemFontOfSize:12]];
        [_connectingLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:_connectingLabel];
        _connectingLabel.text = @"正在连接设备...";
        CGFloat leftX = 48;
        CGFloat width = Screen_Width-leftX*2;
        _connectingLabel.frame = CGRectMake(0, 160, width, 20);
    }
    return _connectingLabel;
}
- (UILabel *)scoreNumLb
{
    if (!_scoreNumLb)
    {
        CGFloat leftX = 48;
        CGFloat width = Screen_Width-leftX*2;
        _scoreNumLb = [[UILabel alloc] init];
        _scoreNumLb.textAlignment = NSTextAlignmentCenter;
        _scoreNumLb.text = @"88.6";
        _scoreNumLb.font = [UIFont boldSystemFontOfSize:18.0f];
        [_scoreNumLb setTextColor:[UIColor whiteColor]];
        [self addSubview: _scoreNumLb];
        _scoreNumLb.frame = CGRectMake(0, 30, width, 80);
    }
    return _scoreNumLb;
}
- (UILabel *)scoreLb
{
    if (!_scoreLb)
    {
        CGFloat leftX = 48;
        CGFloat width = Screen_Width-leftX*2;
        _scoreLb = [[UILabel alloc] init];
        _scoreLb.text = @"健康指数\n最高92分";
        _scoreLb.textAlignment = NSTextAlignmentCenter;
        [_scoreLb setFont:[UIFont systemFontOfSize:12]];
        [_scoreLb setTextColor:[UIColor whiteColor]];
        [self addSubview: _scoreLb];
        _scoreLb.numberOfLines = 2;
        _scoreLb.frame = CGRectMake(0, 140, width, 40);
    }
    return _scoreLb;
}
- (void)showHighestLabel
{
    self.scoreNumLb.alpha = 1.0f;
    self.scoreLb.alpha = 1.0f;
    self.connectingImg.alpha = 0.0;
    self.connectingLabel.alpha = 0.0f;
    self.scoreNumLb.font = [UIFont boldSystemFontOfSize:40.0f];
}

- (void)showConnectImg
{
    self.connectingImg.alpha = 1.0;
    self.connectingLabel.alpha = 1.0f;
    self.scoreNumLb.alpha = 0.0f;
    self.scoreLb.alpha = 0.0f;
}

@end
