//
//  ARLineChartCell.m
//  lineChartTest
//
//  Created by 刘平伟 on 14-3-21.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "ARLineChartCell.h"


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
    self.backgroundColor = [UIColor clearColor];
    //line
    _shapeL = [CAShapeLayer layer];
    _shapeL.lineWidth = 1;
    _shapeL.fillColor = [UIColor yellowColor].CGColor;
    _shapeL.lineCap = kCALineCapRound;
    [self.layer addSublayer:_shapeL];
    
    //dot
    _dot = [[ARLineDot alloc] initWithFrame:CGRectMake(0, 0, kDefaultLineDotSize, kDefaultLineDotSize)];
    [self.contentView addSubview:_dot];
    
    
    
    //title
    
    _titleLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(-CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)-kDefaultXDialTitleHeight, CGRectGetWidth(self.frame), kDefaultXDialTitleHeight)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment   = 1;
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.font            = [UIFont systemFontOfSize:kLineCellDefaultFontSize];
    _titleLabel.textColor       = [UIColor whiteColor];
    [_titleLabel setHighlightedTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:_titleLabel];
    
    
    ///back view
    
    _backView = [[ARLineChartCellBack alloc] init];
    _backView.backgroundColor = [UIColor clearColor];
    self.backgroundView = _backView;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef border = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(border, .5);
    CGContextMoveToPoint(border, 0, 0);
    CGContextAddLineToPoint(border, 0, CGRectGetHeight(self.frame)-kDefaultXDialTitleHeight);
    CGContextSetStrokeColorWithColor(border, [UIColor whiteColor].CGColor);
    CGContextStrokePath(border);
    
    if (self.selected) {
        CGFloat lengths[] = {3,6};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, self.selectLineColor.CGColor);
        CGContextSetLineWidth(line, 2);
        CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
        CGContextMoveToPoint(line, _Point.x,  _Point.y);    //开始画线
        CGContextAddLineToPoint(line, 0, CGRectGetHeight(self.frame)-kDefaultXDialTitleHeight);
        CGContextStrokePath(line);
    }
}

#pragma mark - custom methods

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        _dot.highlighted = YES;
    }else{
        _dot.highlighted = NO;
    }
    [self setNeedsDisplay];
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
    self.clipsToBounds = NO;
    _shapeL.strokeColor = self.lineColor.CGColor;
    
    CGPoint startP = CGPointMake(0, startValue);
    _Point = startP;
    [UIView animateWithDuration:kLineCellDefaultAnimationTime animations:^{
       _dot.center = startP;
    }];
    
    CGPoint endP = CGPointMake(CGRectGetWidth(self.frame), endValue);
    
    CGPathRef prePath = _shapeL.path;
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:startP];
    [bPath addLineToPoint:endP];
    _shapeL.path = bPath.CGPath;
    
    [bPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-kDefaultXDialTitleHeight)];
    [bPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-kDefaultXDialTitleHeight)];
    [bPath closePath];
    
    
    [_backView setPath:bPath.CGPath];
    
    [_shapeL removeAllAnimations];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.removedOnCompletion = NO;
    animation.duration = kLineCellDefaultAnimationTime;
    animation.fromValue = (__bridge id)prePath;
    animation.toValue = (__bridge id)_shapeL.path;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [_shapeL addAnimation:animation forKey:@"animatePath"];
}

@end


@implementation ARLineChartCellBack
{
    CAShapeLayer *shapL;
}

-(id)init
{
    self = [super init];
    if (self) {
        CAGradientLayer *gra = (CAGradientLayer *)self.layer;
        gra.opacity = .5;
//        199 / 255.0f, 251 / 255.0f, 255 / 255.0f, 1,// 开始颜色
//        19 / 255.0f, 214 / 255.0f, 228 / 255.0f, 0  // 末
        
        UIColor *color1 = [UIColor colorWithRed:199 / 255.0f green:251 / 255.0f blue:255 / 255.0f alpha:1];
        UIColor *color2 = [UIColor colorWithRed:19 / 255.0f green:214 / 255.0f blue:228 / 255.0f alpha:0];
        gra.colors = @[(id)color1.CGColor,(id)color2.CGColor];
        
        shapL = [CAShapeLayer layer];
        [self.layer setMask:shapL];
    }
    return self;
}

+(Class)layerClass
{
    return [CAGradientLayer class];
}

-(void)setPath:(CGPathRef)path
{
    CGPathRef prePath = _path;
    _path = path;
    shapL.path = path;
    
    [shapL removeAllAnimations];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.removedOnCompletion = NO;
    animation.duration = kLineCellDefaultAnimationTime;
    animation.fromValue = (__bridge id)prePath;
    animation.toValue = (__bridge id)path;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [shapL addAnimation:animation forKey:@"animatePath"];
    

}

@end
