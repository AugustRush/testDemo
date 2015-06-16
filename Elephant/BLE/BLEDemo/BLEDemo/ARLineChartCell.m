//
//  ARLineChartCell.m
//  lineChartTest
//
//  Created by 刘平伟 on 14-3-21.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "ARLineChartCell.h"

#define kLineCellDefaultFontSize      12
#define kLineCellDefaultAnimationTime .2

@implementation ARLineChartCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(void)initConfig
{
    
    _shapeL                     = (CAShapeLayer *)self.layer;
    _shapeL.lineDashPhase       = 5;
    _shapeL.lineWidth           = 1;
    _shapeL.fillColor           = [UIColor blackColor].CGColor;
    _shapeL.lineCap             = kCALineCapRound;

    ///
    _dot                        = [[ARLineChartDot alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
    [self.contentView addSubview:_dot];

    ///

    UIView *selectView          = [[UIView alloc] init];
    selectView.backgroundColor  = [UIColor colorWithPatternImage:[self sepImageFromColor:[UIColor whiteColor]]];
    self.selectedBackgroundView = selectView;
    _titleLabel                 = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment   = 0;
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.font            = [UIFont systemFontOfSize:kLineCellDefaultFontSize];
    _titleLabel.textColor       = [UIColor blackColor];
    [selectView addSubview:_titleLabel];
}

+(Class)layerClass
{
    return [CAShapeLayer class];
}

#pragma mark - custom methods

-(UIImage *)sepImageFromColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.frame)+1, 4);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [color CGColor]);
    
    CGContextFillRect(context, CGRectMake(0, 0, 1, 2));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    if (_title) {
        _titleLabel.text = _title;
    }
}

-(void)setStartValue:(CGFloat)startValue endValue:(CGFloat)endValue
{
    CGPoint startP = CGPointMake(0, startValue);
    
    [UIView animateWithDuration:kLineCellDefaultAnimationTime animations:^{
        _dot.center = startP;
    }];
    
    _titleLabel.frame = CGRectMake(0, startValue < CGRectGetHeight(self.frame)-20 ?startValue:CGRectGetHeight(self.frame)-20 , 100, 20);
    
    CGPathRef prePath = _shapeL.path;
    _shapeL.strokeColor = self.lineColor.CGColor;
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:startP];
    [bPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), endValue)];
    [_shapeL setPath:bPath.CGPath];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.removedOnCompletion = NO;
    animation.duration = kLineCellDefaultAnimationTime;
    animation.fromValue = (__bridge id)prePath;
    animation.toValue = (__bridge id)bPath.CGPath;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [_shapeL addAnimation:animation forKey:@"animatePath"];
    
}

@end
