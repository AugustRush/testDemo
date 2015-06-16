//
//  ARLineDot.m
//  lineChartTest
//
//  Created by 刘平伟 on 14-4-2.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "ARLineDot.h"

@implementation ARLineDot
{
    CALayer *_shadowLayer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.backgroundColor = [UIColor yellowColor];
        self.layer.cornerRadius = CGRectGetWidth(frame)/2;
        
        _shadowLayer = [CALayer layer];
        _shadowLayer.backgroundColor = [UIColor clearColor].CGColor;
        CGRect shadowFrame = CGRectMake(-3, -3, CGRectGetWidth(frame)+6, CGRectGetHeight(self.frame)+6);
        _shadowLayer.frame = shadowFrame;
        _shadowLayer.cornerRadius = CGRectGetWidth(shadowFrame)/2;
        _shadowLayer.opacity = .5;
        [self.layer addSublayer:_shadowLayer];
        
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
        _shadowLayer.backgroundColor = [UIColor whiteColor].CGColor;
    }else{
        _shadowLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
}

@end
