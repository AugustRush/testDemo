//
//  UserManagerCell.m
//  BodyScale
//
//  Created by cxx on 14-11-29.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "UserManagerCell.h"

@implementation UserManagerCell
- (HeaderButton *)headBt
{
    if (!_headBt)
    {
        _headBt = [HeaderButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_headBt];
        _headBt.frame = CGRectMake(15, 10, 60, 60);
        _headBt.layer.masksToBounds = YES;
        _headBt.layer.cornerRadius = 30;
        [_headBt.layer setBorderWidth:1];
        [_headBt.layer setBorderColor:[UIColor clearColor].CGColor];
    }
    return _headBt;

}

- (void)awakeFromNib
{
    NSString * imgPath = [NSString stringWithFormat:@"%@/%@.%@",[CommanHelp getDocmentsDirectory],HEADERIMAGE,@"png"];
    [self.headBt setWithBigHeaderView:imgPath];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (void)updateInfo:(NSDictionary *)dic
{
    self.headBt.userInteractionEnabled = NO;
}
@end
