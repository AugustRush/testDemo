//
//  LineView.m
//  BodyScale
//
//  Created by cxx on 14-11-11.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "LineView.h"

@implementation LineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.opaque = NO;
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,1, 1, 1,1);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, rect.origin.x,(rect.origin.y+rect.size.height-10));
    CGContextAddLineToPoint(context, (rect.origin.x+rect.size.width/2),(rect.origin.y+rect.size.height-10));
    CGContextAddLineToPoint(context, (rect.origin.x+rect.size.width*2/3), 0);
    CGContextStrokePath(context);
}


@end
