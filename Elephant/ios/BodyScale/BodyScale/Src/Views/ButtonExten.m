//
//  ButtonExten.m
//  BodyScale
//
//  Created by cxx on 14-11-16.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ButtonExten.h"
#import "GetStringWidthAndHeight.h"

@implementation ButtonExten

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setImage:(UIImage *)image WithText:(NSString *)text WithState:(UIControlState)state
{
    CGSize titleSize = [GetStringWidthAndHeight getStringWidth:text height:55 font:[UIFont systemFontOfSize:12]];
    DLog(@"msg_lyywhg: ~ %f %f %@", titleSize.width, titleSize.height, text);
    [self setTitle:text forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateNormal];
//    CGSize size = self.titleLabel.frame.size;
//    size.width = titleSize.width;
    if (titleSize.width < 36)
    {
        self.titleEdgeInsets = UIEdgeInsetsMake(20, -30, 0.0, 0);
    }
    else
    {
        self.titleEdgeInsets = UIEdgeInsetsMake(20, -20, 0.0, 0);
    }
    self.imageEdgeInsets = UIEdgeInsetsMake(-20, 15, 0.0, 0);
//    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.titleLabel setTextColor:[UIColor redColor]];
}

- (void)setImage:(UIImage *)image WithDownText:(NSString *)text
{
    CGSize titleSize = [GetStringWidthAndHeight getStringWidth:text height:self.frame.size.height font:[UIFont systemFontOfSize:12]];
    DLog(@"msg_lyywhg: ~ %f %f %@", titleSize.width, titleSize.height, text);
    [self setImage:image forState:UIControlStateNormal];
    [self setTitle:text forState:UIControlStateNormal];
    self.imageEdgeInsets = UIEdgeInsetsMake(-30, 0, 0.0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(30, -45, 0.0, 0);
//    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [self.titleLabel setTextColor:[UIColor redColor]];
}

@end
