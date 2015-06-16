//
//  SettingCell.m
//  BodyScale
//
//  Created by cxx on 14-11-21.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "SettingCell.h"
#import "UIButton+WebCache.h"

@implementation SettingCell

- (HeaderButton *)headBt
{
    if (!_headBt)
    {
        _headBt = [HeaderButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.headBt];
        [_headBt addTarget:self action:@selector(selectHeadBt) forControlEvents:UIControlEventTouchUpInside];
        [_headBt mas_makeConstraints:^(MASConstraintMaker *maker){
            maker.left.equalTo(@(Screen_Width-102));
            maker.top.equalTo(@6);
            maker.height.equalTo(@72);
            maker.width.equalTo(@72);
        }];
    }
    return _headBt;
}

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (void)setText:(NSString *)text WithIndexNum:(NSInteger)num
{
    self.textLb.text = text;
    {
        self.versionLb.text = nil;
    }
    [self.imgView setImage:[UIImage imageNamed:@"nextstep"]];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Screen_Width-10));
        make.width.equalTo(@5.5);
        make.height.equalTo(@10);
    }];
}

- (void)setPersonalText:(NSString *)text  WithInfo:(NSString *)infoStr
{
    self.textLb.text = text;
    
    [self.imgView setImage:[UIImage imageNamed:@"nextstep"]];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Screen_Width-20));
        make.width.equalTo(@5.5);
        make.height.equalTo(@10);
    }];
    
    [self.versionLb setText:[NSString stringWithFormat:@"%@",infoStr]];
    [self.versionLb setTextAlignment:NSTextAlignmentRight];
}

- (void)selectHeadBt
{
}

- (void)addHeadButton:(NSString *)imagePath
{
    self.headBt.layer.masksToBounds = YES;
    self.headBt.layer.cornerRadius = 36;
    [self.headBt sd_setImageWithURL:[NSURL URLWithString:imagePath] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"DefaultHeader.png"]];
}

@end
