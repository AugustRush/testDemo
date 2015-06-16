//
//  BaseView.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 渐变
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0);
    CGMutablePathRef pathGradual = CGPathCreateMutable();
    CGPathAddRect(pathGradual, NULL, self.bounds);
    CGContextAddPath(ctx, pathGradual);
    CGContextFillPath(ctx);
    
    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, pathGradual);
    CGContextEOClip(ctx);
    
    // 绘制渐变
    CGFloat locs[2] = { 0.0, 1.0 };
    CGFloat colors[9] = {
        22 / 255.0f, 221 / 255.0f, 154 / 255.0f, 1,  // 开始颜色
        4 / 255.0f, 134 / 255.0f, 236 / 255.0f, 1    // 末尾颜色
    };
    CGColorSpaceRef sp = CGColorSpaceCreateDeviceRGB();
    CGGradientRef grad = CGGradientCreateWithColorComponents(sp, colors, locs, 2);
    CGContextDrawLinearGradient(ctx, grad, CGPointMake(0,SCREEN_HEIGHT), CGPointMake(SCREEN_WIDTH ,0), 0);
    CGColorSpaceRelease(sp);
    CGGradientRelease(grad);
    CGContextRestoreGState(ctx); // 完成裁剪
    
    CGPathRelease(pathGradual);
}

@end
