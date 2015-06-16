//
//  HeaderButton.m
//  BodyScale
//
//  Created by cxx on 14-11-13.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "HeaderButton.h"
#import "UIButton+WebCache.h"

@implementation HeaderButton


- (void)setWithHeaderView:(NSString*)imagePath
{
    [self sd_setImageWithURL:[NSURL URLWithString:imagePath] forState:UIControlStateNormal  placeholderImage:[UIImage imageNamed:@"DefaultHeader.png"]];
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:15];
    [self.layer setBorderWidth:2];
    [self.layer setBorderColor:[UIColor whiteColor].CGColor];
}

- (void)setWithBigHeaderView:(NSString*)imagePath
{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:30];
    [self.layer setBorderWidth:1];
    [self.layer setBorderColor:[UIColor clearColor].CGColor];
    [self sd_setImageWithURL:[NSURL URLWithString:imagePath] forState:UIControlStateNormal  placeholderImage:[UIImage imageNamed:@"DefaultHeader.png"]];
}
@end
