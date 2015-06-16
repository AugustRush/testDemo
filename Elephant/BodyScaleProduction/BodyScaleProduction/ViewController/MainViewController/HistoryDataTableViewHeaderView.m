//
//  HistoryDataTableViewHeaderView.m
//  ViewDraw
//
//  Created by Go Salo on 14-5-14.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "HistoryDataTableViewHeaderView.h"

@implementation HistoryDataTableViewHeaderView {
    UILabel *_dateLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:241 / 255.0f green:246 / 255.0f blue:249 / 255.0f alpha:1];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (frame.size.height - 30) / 2, frame.size.width, 30)];
        _dateLabel.textColor = [UIColor colorWithWhite:177 / 255.0f alpha:1];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.backgroundColor = self.backgroundColor;
        [self addSubview:_dateLabel];
        
        // 文字Label
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, self.frame.size.width, self.frame.size.height - 4)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.text = @"      月      日";
        textLabel.textColor = _dateLabel.textColor;
        textLabel.font = [UIFont systemFontOfSize:11.0f];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:textLabel];
    }
    return self;
}

- (void)setDateString:(NSString *)dateString {
    if (dateString.length >= 10) {
        NSString *monthString = [dateString substringWithRange:NSMakeRange(5, 2)];
        NSString *dayString = [dateString substringWithRange:NSMakeRange(8, 2)];
        _dateLabel.text = [NSString stringWithFormat:@"      %@  %@  ", monthString, dayString];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 233 / 255.0f, 233 / 255.0f, 233 / 255.0f, 1);
    
    CGContextMoveToPoint(ctx, self.frame.size.width / 2, 0);
    CGContextAddLineToPoint(ctx, self.frame.size.width / 2, self.frame.size.height);
    
    CGContextStrokePath(ctx);
}

@end
