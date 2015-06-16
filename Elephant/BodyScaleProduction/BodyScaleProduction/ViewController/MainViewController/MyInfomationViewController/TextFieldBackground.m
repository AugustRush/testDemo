//
//  TextFieldBackground.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-24.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "TextFieldBackground.h"

@implementation TextFieldBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 0.5);
    CGContextSetRGBStrokeColor(ctx, 121 / 255.0f, 121 / 255.0f, 121 / 255.0f, 1);
    
    CGContextMoveToPoint(ctx, 0, self.height * 4 / 5);
    CGContextAddLineToPoint(ctx, 0, self.height);
    CGContextAddLineToPoint(ctx, self.width, self.height);
    CGContextAddLineToPoint(ctx, self.width, self.height * 4 / 5);
    CGContextStrokePath(ctx);
}

@end
