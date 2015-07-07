//
//  UIView+CustomTimingFunction.m
//  Instants
//
//  Created by Christian Giordano on 16/10/2013.
//  Copyright (c) 2013 Christian Giordano. All rights reserved.
//

#import "UIView+CustomTimingFunction.h"

@implementation UIView (CustomTimingFunction)

+ (void)animateWithDuration:(NSTimeInterval)duration customTimingFunction:(CustomTimingFunction)customTimingFunction animation:(void (^)(void))animation competion:(void (^)(void))competion
{
    [UIView beginAnimations:nil context:NULL];
    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    [CATransaction setAnimationTimingFunction:[self functionWithType:customTimingFunction]];
    [CATransaction setCompletionBlock:competion];
    
    animation();
    
    [CATransaction commit];
    [UIView commitAnimations];
}

- (void)animateProperty:(NSString *)property from:(id)from to:(id)to withDuration:(NSTimeInterval)duration customTimingFunction:(CustomTimingFunction)customTimingFunction competion:(void (^)(void))competion
{
    [CATransaction begin]; {
        [CATransaction setCompletionBlock:competion];
        
        if([property isEqualToString:@"frame"]){
            CGRect fromRect = [from CGRectValue];
            CGPoint fromPosition = CGPointMake(CGRectGetMidX(fromRect), CGRectGetMidY(fromRect));
            CGRect toRect = [to CGRectValue];
            CGPoint toPosition = CGPointMake(CGRectGetMidX(toRect), CGRectGetMidY(toRect));
            
            CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
            positionAnimation.timingFunction = [[self class] functionWithType:customTimingFunction];
            positionAnimation.fromValue = [NSValue valueWithCGPoint:fromPosition];
            positionAnimation.toValue = [NSValue valueWithCGPoint:toPosition];
            
            CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
            boundsAnimation.timingFunction = [[self class] functionWithType:customTimingFunction];
            boundsAnimation.fromValue = from;
            boundsAnimation.toValue = to;
            
            CAAnimationGroup * group =[CAAnimationGroup animation];
            group.removedOnCompletion=NO;
            group.fillMode=kCAFillModeForwards;
            group.animations = @[positionAnimation,boundsAnimation];
            group.duration = duration;
            
            [self.layer addAnimation:group forKey:property];
        }else{
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:property];
            animation.duration = duration;
            animation.timingFunction = [[self class] functionWithType:customTimingFunction];
            animation.fillMode = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            animation.fromValue = from;
            animation.toValue = to;
            [self.layer addAnimation:animation forKey:animation.keyPath];
        }
    } [CATransaction commit];
    
}

+(CAMediaTimingFunction *)functionWithType:(CustomTimingFunction)type
{
    switch (type) {
        case CustomTimingFunctionDefault:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            break;
        case CustomTimingFunctionLinear:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            break;
            
        case CustomTimingFunctionEaseIn:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            break;
        case CustomTimingFunctionEaseOut:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case CustomTimingFunctionEaseInOut:
            return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            break;
            
        case CustomTimingFunctionSineIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.45 :0 :1 :1];
            break;
        case CustomTimingFunctionSineOut:
            return [CAMediaTimingFunction functionWithControlPoints:0 :0 :0.55 :1];
            break;
        case CustomTimingFunctionSineInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.45 :0 :0.55 :1];
            break;
            
        case CustomTimingFunctionQuadIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.43 :0 :0.82 :0.60];
            break;
        case CustomTimingFunctionQuadOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.18 :0.4 :0.57 :1];
            break;
        case CustomTimingFunctionQuadInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.43 :0 :0.57 :1];
            break;
            
        case CustomTimingFunctionCubicIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.67 :0 :0.84 :0.54];
            break;
        case CustomTimingFunctionCubicOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.16 :0.46 :0.33 :1];
            break;
        case CustomTimingFunctionCubicInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.65 :0 :0.35 :1];
            break;
            
        case CustomTimingFunctionQuartIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.81 :0 :0.77 :0.34];
            break;
        case CustomTimingFunctionQuartOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.23 :0.66 :0.19 :1];
            break;
        case CustomTimingFunctionQuartInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.81 :0 :0.19 :1];
            break;
            
        case CustomTimingFunctionQuintIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.89 :0 :0.81 :0.27];
            break;
        case CustomTimingFunctionQuintOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.19 :0.73 :0.11 :1];
            break;
        case CustomTimingFunctionQuintInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.9 :0 :0.1 :1];
            break;
            
        case CustomTimingFunctionExpoIn:
            return [CAMediaTimingFunction functionWithControlPoints:1.04 :0 :0.88 :0.49];
            break;
        case CustomTimingFunctionExpoOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.12 :0.51 :-0.4 :1];
            break;
        case CustomTimingFunctionExpoInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.95 :0 :0.05 :1];
            break;
            
        case CustomTimingFunctionCircIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.6 :0 :1 :0.45];
            break;
        case CustomTimingFunctionCircOut:
            return [CAMediaTimingFunction functionWithControlPoints:1 :0.55 :0.4 :1];
            break;
        case CustomTimingFunctionCircInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.82 :0 :0.18 :1];
            break;
            
        case CustomTimingFunctionBackIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.77 :-0.63 :1 :1];
            break;
        case CustomTimingFunctionBackOut:
            return [CAMediaTimingFunction functionWithControlPoints:0 :0 :0.23 :1.37];
            break;
        case CustomTimingFunctionBackInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.77 :-0.63 :0.23 :1.37];
            break;
        default:
            break;
    }
    
    NSLog(@"Couldn't find CustomTimingFunction, will return linear");
    return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
}

@end
