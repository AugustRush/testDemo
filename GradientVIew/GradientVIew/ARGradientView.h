//
//  ARGradientView.h
//  GradientVIew
//
//  Created by August on 14-7-24.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ARGradientAnimateType) {
    ARGradientAnimateTypeLiner = 0,
    ARGradientAnimateTypeRadial,
    ARGradientAnimateTypeNone
};


typedef NS_ENUM(NSInteger, ARGradientAnimateDirection) {
    ARGradientAnimateDirectionLeftToRight,
    ARGradientAnimateDirectionRightToLeft,
    ARGradientAnimateDirectionTopToBottom,
    ARGradientAnimateDirectionBottomToTop
};

typedef struct{
    NSTimeInterval duration;
    ARGradientAnimateType Type;//if type is ARGradientAnimateTypeNone ,the bellow two paramaters is invalidate
    ARGradientAnimateDirection direction;//just apply to ARGradientAnimateTypeLiner type animation
    CGPoint startPoint;//just apply to ARGradientAnimateTypeRadial type, the point should inner this view 's bouds
    
} ARGradientAnimateDescription;


NS_INLINE ARGradientAnimateDescription ARGradientAnimateDescriptionMake(NSTimeInterval duration,ARGradientAnimateType type,ARGradientAnimateDirection direction, CGPoint startPoint){
    
    ARGradientAnimateDescription des = {duration,type,direction,startPoint};
    return des;
}

/**
 *  gradient View
 */

@interface ARGradientView : UIView

/* The array of CGColorRef objects defining the color of each gradient
 * stop. Defaults to nil. Animatable. */

@property(nonatomic, strong) NSArray *colors;

/* An optional array of NSNumber objects defining the location of each
 * gradient stop as a value in the range [0,1]. The values must be
 * monotonically increasing. If a nil array is given, the stops are
 * assumed to spread uniformly across the [0,1] range. When rendered,
 * the colors are mapped to the output colorspace before being
 * interpolated. Defaults to nil. Animatable. */

@property(nonatomic, strong) NSArray *locations;

/* The start and end points of the gradient when drawn into the layer's
 * coordinate space. The start point corresponds to the first gradient
 * stop, the end point to the last gradient stop. Both points are
 * defined in a unit coordinate space that is then mapped to the
 * layer's bounds rectangle when drawn. (I.e. [0,0] is the bottom-left
 * corner of the layer, [1,1] is the top-right corner.) The default values
 * are [.5,0] and [.5,1] respectively. Both are animatable. */

@property (nonatomic) CGPoint startPoint, endPoint;

/**
 *  set gradient colors with animation
 *
 *  @param colors      gradient colors array
 *  @param description gradient animation's description,it should be ARGradientAnimateDescription struct type
 */

-(void)setColors:(NSArray *)colors withAnimationDescription:(ARGradientAnimateDescription)description;

@end
