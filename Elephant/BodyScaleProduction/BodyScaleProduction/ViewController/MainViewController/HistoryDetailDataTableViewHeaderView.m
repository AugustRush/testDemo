//
//  HistoryDetailDataTableViewHeaderView.m
//  ViewDraw
//
//  Created by Go Salo on 14-5-14.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "HistoryDetailDataTableViewHeaderView.h"

@implementation HistoryDetailDataTableViewHeaderView {
    UILabel *_timeLabel;
    
    UILabel *_errorLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _timeLabel.textColor = [UIColor colorWithRed:5 / 255.0f green:139 / 255.0f blue:232 / 255.0f alpha:1];
        _timeLabel.font = [UIFont systemFontOfSize:15.0f];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLabel];
        
        _errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 67 - 38, self.frame.size.width, 38)];
        _errorLabel.textColor = [UIColor colorWithRed:252 / 255.0f green:70 / 255.0f blue:70 / 255.0f alpha:1];
        _errorLabel.text = @"异常数据";
        _errorLabel.font = [UIFont systemFontOfSize:15.0f];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_errorLabel];
    }
    return self;
}

- (void)setDataString:(NSString *)dateString isError:(BOOL)isError {
    if (isError) {
        _errorLabel.hidden = NO;
    } else {
        _errorLabel.hidden = YES;
    }
    if (dateString.length > 10) {
        NSString *timeString = [dateString substringWithRange:NSMakeRange(11, 5)];
        _timeLabel.text = [NSString stringWithFormat:@"测量时间：%@", timeString];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
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
