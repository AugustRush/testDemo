//
//  ARGradientView.m
//  GradientVIew
//
//  Created by August on 14-7-24.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ARGradientView.h"

@implementation ARGradientView
{
    CAGradientLayer *GLayer;
    CAShapeLayer *MLayer;
}

#pragma mark - init/config methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(void)initConfigs
{
    GLayer = (CAGradientLayer *)self.layer;
    
    MLayer = [CAShapeLayer layer];
    MLayer.frame = self.bounds;
    MLayer.strokeColor = [UIColor purpleColor].CGColor;
    MLayer.fillColor = [UIColor whiteColor].CGColor;
    MLayer.lineCap = kCALineCapRound;
    GLayer.mask = MLayer;
}

+(Class)layerClass
{
    return [CAGradientLayer class];
}

#pragma mark - custom methods

-(void)setColors:(NSArray *)colors
{
    _colors = colors;
    
    NSMutableArray *GColors = [NSMutableArray array];
    [_colors enumerateObjectsUsingBlock:^(UIColor *color, NSUInteger idx, BOOL *stop) {
        [GColors addObject:(id)color.CGColor];
    }];
    
    GLayer.colors = GColors;
}

-(void)setLocations:(NSArray *)locations
{
    _locations = locations;
    GLayer.locations = locations;
}

-(void)setStartPoint:(CGPoint)startPoint
{
    _startPoint = startPoint;
    GLayer.startPoint = startPoint;
}

-(void)setEndPoint:(CGPoint)endPoint
{
    _endPoint = endPoint;
    GLayer.endPoint = endPoint;
}

-(void)setColors:(NSArray *)colors withAnimationDescription:(ARGradientAnimateDescription)description
{
    self.colors = colors;
    [MLayer removeAllAnimations];
    ARGradientAnimateType animtionType = description.Type;
    switch (animtionType) {
        case ARGradientAnimateTypeLiner:
        {
            CGPathRef endPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
            MLayer.path = endPath;
            CABasicAnimation *pathA = [CABasicAnimation animationWithKeyPath:@"path"];
            pathA.duration = description.duration;
            pathA.removedOnCompletion = YES;
            
            ARGradientAnimateDirection animationDirection = description.direction;
            switch (animationDirection) {
                case ARGradientAnimateDirectionBottomToTop:
                {
                    pathA.fromValue = (id)[UIBezierPath bezierPathWithRect:CGRectMake(0, CGRectGetMaxY(self.bounds)-1, CGRectGetWidth(self.bounds), 1)].CGPath;
                    pathA.toValue = (__bridge id)endPath;
                    [MLayer addAnimation:pathA forKey:@"path"];
                }
                    break;
                case ARGradientAnimateDirectionTopToBottom:
                {
                    pathA.fromValue = (id)[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 1)].CGPath;
                    pathA.toValue = (__bridge id)endPath;
                    [MLayer addAnimation:pathA forKey:@"path"];
                }
                    break;
                case ARGradientAnimateDirectionLeftToRight:
                {
                    pathA.fromValue = (id)[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, CGRectGetHeight(self.bounds))].CGPath;
                    pathA.toValue = (__bridge id)endPath;
                    [MLayer addAnimation:pathA forKey:@"path"];
                }
                    break;
                case ARGradientAnimateDirectionRightToLeft:
                {
                    pathA.fromValue = (id)[UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMaxX(self.bounds)-1, 0, 1, CGRectGetHeight(self.bounds))].CGPath;
                    pathA.toValue = (__bridge id)endPath;
                    [MLayer addAnimation:pathA forKey:@"linerPath"];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case ARGradientAnimateTypeRadial:
        {
            CGPoint startP = description.startPoint;
            CGFloat radiusStd = hypotf(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds));
            CABasicAnimation *pathA = [CABasicAnimation animationWithKeyPath:@"path"];
            pathA.duration = description.duration;
            pathA.removedOnCompletion = YES;
            pathA.fromValue = (__bridge id)[UIBezierPath bezierPathWithOvalInRect:CGRectMake(startP.x-1, startP.y-1, 2, 2)].CGPath;
            CGPathRef endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(startP.x - radiusStd, startP.y- radiusStd, 2*radiusStd, 2*radiusStd)].CGPath;
            pathA.toValue = (__bridge id)endPath;
            [MLayer addAnimation:pathA forKey:@"radialPath"];
            MLayer.path = endPath;
            
        }
            break;
        case ARGradientAnimateTypeNone:
        {
            CGPathRef endPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
            MLayer.path = endPath;
        }
            break;
            
        default:
            break;
    }
}

@end
