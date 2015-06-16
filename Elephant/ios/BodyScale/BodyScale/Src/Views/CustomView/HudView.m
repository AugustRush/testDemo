//
//  HudView.m
//  BodyScale
//
//  Created by cxx on 14-11-24.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "HudView.h"

@implementation HudView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame WithText:(NSString *)text
{
     self = [super init];
    if (self) {
        UIView *bgView = [[UIView alloc] initWithFrame:frame];
        [bgView setBackgroundColor:[UIColor blackColor]];
        [bgView.layer setCornerRadius:8];
        [bgView setAlpha:0.9];
        [self addSubview:bgView];
  
 
        
        
        UILabel *textLb = [[UILabel alloc] init];
        [textLb setBackgroundColor:[UIColor clearColor]];
        textLb.text = text;
        [textLb setTextColor:[UIColor whiteColor]];
        [self addSubview:textLb];
        [textLb setFont:[UIFont systemFontOfSize:11]];
        [textLb setFrame:CGRectMake(15, 75, (frame.size.width-30), 14)];
        [textLb setTextAlignment:NSTextAlignmentCenter];
    }
    return self;
}
@end
