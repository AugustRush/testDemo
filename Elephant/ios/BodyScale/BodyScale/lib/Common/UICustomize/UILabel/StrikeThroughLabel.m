//
//  StrikeThroughLabel.m
//  FFLtd
//
//  Created by 两元鱼 on 12-2-9.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "StrikeThroughLabel.h"

@implementation StrikeThroughLabel
@synthesize isWithStrikeThrough = isWithStrikeThrough_;


- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.isWithStrikeThrough = YES;
        
        if (!line_)
        {
            line_ = [[UIImageView alloc] init];
            
            line_.frame = CGRectZero;
            
            [self addSubview:line_];
        }
    }
    return self;
}

- (void)dealloc
{
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (isWithStrikeThrough_)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //设置颜色
        UIColor *textColor = self.textColor;
        CGContextSetStrokeColorWithColor(context, textColor.CGColor);
        
        //设置线宽
        CGContextSetLineWidth(context, 1);
        CGContextSetLineCap(context, kCGLineCapRound);
        
        //画线
        CGContextMoveToPoint(context, 0, self.frame.size.height/2);
        CGSize wordSize = [self.text sizeWithFont:self.font
                                constrainedToSize:self.frame.size
                                    lineBreakMode:NSLineBreakByCharWrapping];
        CGContextAddLineToPoint(context, wordSize.width, self.frame.size.height/2);
        CGContextStrokePath(context);
    }
    
}

@end
