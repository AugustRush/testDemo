//
//  LeftLineTableView.m
//  ViewDraw
//
//  Created by Go Salo on 14-5-14.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "LeftLineTableView.h"

@implementation LeftLineTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 219 / 255.0f, 228 / 255.0f, 235 / 255.0f, 1);
    CGContextSetLineWidth(ctx, 0.5);
    
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 0, self.frame.size.height);
    CGContextStrokePath(ctx);
}

@end
