//
//  ValuePopView.m
//  ViewDraw
//
//  Created by Go Salo on 14-5-11.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "ValuePopView.h"

#define LEFT_RIGHT_ARC_RADIUS   8
#define VALUE_FONT_SIZE         14.0f

@implementation ValuePopView {
    UIColor *_popColor;
    NSString *_valueString;
    
    UILabel *_valueLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 5)];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.backgroundColor = [UIColor clearColor];
        _valueLabel.font = [UIFont systemFontOfSize:VALUE_FONT_SIZE];
        _valueLabel.textColor = [UIColor whiteColor];
        [self addSubview:_valueLabel];
        
        self.backgroundColor = [UIColor clearColor];
        _popColor = [UIColor grayColor];
    }
    return self;
}

#pragma mark - Setter
- (void)setValueString:(NSString *)valueString popColor:(UIColor *)popColor {
    if (popColor) {
        _popColor = popColor;
    } else {
        _popColor = [UIColor grayColor]; // default color
    }
    
    _valueLabel.text = valueString;
    
    CGSize popSize = [self calculatePopRectWithValueString:valueString];
    CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, popSize.width, popSize.height);
    [self setFrame:rect];
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [_valueLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 5)];
}

#pragma mark - Calculate
/*
- (CGSize)calculateRectWithValueString:(NSString *)valueString {
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:valueString attributes:@{kCIAttributeTypeColor: [UIColor whiteColor]}];
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(MAXFLOAT, 17) options:NSStringDrawingTruncatesLastVisibleLine context:nil];
    return CGSizeMake(rect.size.width + 10, 22);
}
 */

- (CGSize)calculatePopRectWithValueString:(NSString *)valueString {
    CGSize textSize = [valueString sizeWithFont:[UIFont systemFontOfSize:VALUE_FONT_SIZE] constrainedToSize:CGSizeMake(MAXFLOAT, 17) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat popWidth = textSize.width + 10;
    return CGSizeMake((popWidth >= 30 ? popWidth : 30) , 22); // POP 最小宽度为30
}

#pragma mark - Draw
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, _popColor.CGColor);
    
    {
        CGContextMoveToPoint(ctx, (self.frame.size.width - 1) / 2 - 1 - 9, LEFT_RIGHT_ARC_RADIUS * 2 +0.5);

        CGContextAddLineToPoint(ctx, LEFT_RIGHT_ARC_RADIUS, LEFT_RIGHT_ARC_RADIUS * 2+0.5);
        
        CGContextAddArc(ctx, LEFT_RIGHT_ARC_RADIUS, (self.frame.size.height - 5) / 2, LEFT_RIGHT_ARC_RADIUS, M_PI / 2, M_PI / 2 * 3, NO);

        CGContextAddArc(ctx, (self.frame.size.width - 1) - LEFT_RIGHT_ARC_RADIUS + 0.5, (self.frame.size.height - 5) / 2, LEFT_RIGHT_ARC_RADIUS, M_PI / 2 * 3, M_PI / 2, NO);

        CGContextAddLineToPoint(ctx, (self.frame.size.width - 1) / 2 - 9 + 17 + 0.5, LEFT_RIGHT_ARC_RADIUS * 2 + 0.5);
        
        CGContextAddArc(ctx, (self.frame.size.width - 1) / 2 + 9.5, LEFT_RIGHT_ARC_RADIUS * 2 + 11 + 0.5, 11, - M_PI / 2, acosf(-8 / 11), YES);
        CGContextAddArc(ctx, (self.frame.size.width - 1) / 2 - 9.5, LEFT_RIGHT_ARC_RADIUS * 2 + 11 + 0.5, 11, acosf(8 / 11), - M_PI / 2, YES);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
    }
}

@end
