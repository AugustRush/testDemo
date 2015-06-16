//
//  RightLineView.m
//  BodyScale
//
//  Created by cxx on 14-11-20.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "RightLineView.h"

@implementation RightLineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.opaque = NO;
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,1, 1, 1,1);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context,rect.size.width*2/3+10,(rect.origin.y+rect.size.height-10) );
    CGContextAddLineToPoint(context, rect.size.width/3-10,(rect.origin.y+rect.size.height-10));
    CGContextAddLineToPoint(context, 0, 0);
    CGContextStrokePath(context);
}


@end
