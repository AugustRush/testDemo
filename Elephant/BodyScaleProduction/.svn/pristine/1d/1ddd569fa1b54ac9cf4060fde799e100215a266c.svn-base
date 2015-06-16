//
//  ARLineInfoView.m
//  lineChartTest
//
//  Created by 刘平伟 on 14-4-3.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "ARLineInfoView.h"


@implementation ARLineInfoView

-(id)init
{
    self = [super init];
    if (self) {
        [self initConfig];
    }
    return self;
}

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
    self.backgroundColor = [UIColor redColor];
    self.userInteractionEnabled = NO;
    self.clipsToBounds = NO;
    self.layer.cornerRadius = 3;
    CAShapeLayer *shape = (CAShapeLayer *)self.layer;
    shape.fillColor = [UIColor whiteColor].CGColor;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = 1;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];
}

+(Class)layerClass
{
    return [CAShapeLayer class];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.titleLabel.frame = CGRectInset(self.bounds, 2, 2);
    
}

-(void)setArrowDirection:(ARLineInfoViewArrowDirection)arrowDirection
{
    _arrowDirection = arrowDirection;
    
    
    switch (_arrowDirection) {
        case ARLineInfoViewArrowDirectionTop:
        {
            UIBezierPath *bPath = [UIBezierPath bezierPath];
            [bPath moveToPoint:CGPointMake(CGRectGetWidth(self.frame)/2-5, 1)];
            [bPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)/2, -kDefaultInfoViewArrowHeight)];
            [bPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)/2+5, 1)];
            //    [bPath closePath];
            ((CAShapeLayer *)self.layer).path = bPath.CGPath;
        }
            break;
        case ARLineInfoViewArrowDirectionBottom:
        {
            UIBezierPath *bPath = [UIBezierPath bezierPath];
            [bPath moveToPoint:CGPointMake(CGRectGetWidth(self.frame)/2-5, CGRectGetHeight(self.frame)-1)];
            [bPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)+kDefaultInfoViewArrowHeight)];
            [bPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)/2+5, CGRectGetHeight(self.frame)-1)];
            //    [bPath closePath];
            ((CAShapeLayer *)self.layer).path = bPath.CGPath;
        }
            break;
        case ARLineInfoViewArrowDirectionLeftTop:
        {
            UIBezierPath *bPath = [UIBezierPath bezierPath];
            [bPath moveToPoint:CGPointMake(0, 2)];
            [bPath addLineToPoint:CGPointMake(-2, -kDefaultInfoViewArrowHeight)];
            [bPath addLineToPoint:CGPointMake(5, 2)];
            //    [bPath closePath];
            ((CAShapeLayer *)self.layer).path = bPath.CGPath;
        }
            break;
        case ARLineInfoViewArrowDirectionLeftBottom:
        {
            UIBezierPath *bPath = [UIBezierPath bezierPath];
            [bPath moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame)-1)];
            [bPath addLineToPoint:CGPointMake(-2, CGRectGetHeight(self.frame)+ kDefaultInfoViewArrowHeight)];
            [bPath addLineToPoint:CGPointMake(5, CGRectGetHeight(self.frame)-1)];
            //    [bPath closePath];
            ((CAShapeLayer *)self.layer).path = bPath.CGPath;
        }
            break;
        case ARLineInfoViewArrowDirectionRightBottom:
        {
            UIBezierPath *bPath = [UIBezierPath bezierPath];
            [bPath moveToPoint:CGPointMake(CGRectGetWidth(self.frame)-5, CGRectGetHeight(self.frame)-1)];
            [bPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)+2, CGRectGetHeight(self.frame)+ kDefaultInfoViewArrowHeight)];
            [bPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-1)];
            //    [bPath closePath];
            ((CAShapeLayer *)self.layer).path = bPath.CGPath;
        }
            break;
        case ARLineInfoViewArrowDirectionRightTop:
        {
            UIBezierPath *bPath = [UIBezierPath bezierPath];
            [bPath moveToPoint:CGPointMake(CGRectGetWidth(self.frame)-5, 1)];
            [bPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)+2,  -kDefaultInfoViewArrowHeight)];
            [bPath addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 1)];
            //    [bPath closePath];
            ((CAShapeLayer *)self.layer).path = bPath.CGPath;

        }
            break;
            
        default:
            break;
    }
    
    
}

@end
