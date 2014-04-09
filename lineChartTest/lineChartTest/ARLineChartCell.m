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
    ARLineDot *dot = [[ARLineDot alloc] initWithFrame:CGRectMake(0, 0, kDefaultLineDotSize, kDefaultLineDotSize)];
    [self.contentView addSubview:dot];
    _dot = dot;
    
    
    
    //title
    
    _titleLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(-CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)-20, CGRectGetWidth(self.frame), 20)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment   = 1;
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.font            = [UIFont systemFontOfSize:kLineCellDefaultFontSize];
    _titleLabel.textColor       = [UIColor grayColor];
    [_titleLabel setHighlightedTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:_titleLabel];
    
    
    ///back view
    
    _backView = [[ARLineChartCellBack alloc] init];
    _backView.backgroundColor = [UIColor clearColor];
    self.backgroundView = _backView;
}

-(void)drawRect:(CGRect)rect
{
    if (self.selected) {
        CGFloat lengths[] = {3,6};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, self.selectLineColor.CGColor);
        CGContextSetLineWidth(line, 2);
        CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
        CGContextMoveToPoint(line, _Point.x,  _Point.y);    //开始画线
        CGContextAddLineToPoint(line, 0, CGRectGetHeight(self.frame)-20);
        CGContextStrokePath(line);
    }
}

#pragma mark - custom methods

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setNeedsDisplay];
    if (selected) {
        _dot.highlighted = YES;
    }else{
        _dot.highlighted = NO;
    }

}

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
    
    [bPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-20)];
    [bPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-20)];
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
        gra.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor clearColor].CGColor];
        
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
