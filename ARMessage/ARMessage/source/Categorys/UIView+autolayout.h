//
//  UIView+autolayout.h
//  ARMessage
//
//  Created by August on 15/4/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EdgeType) {
    EdgeTypeLeft,
    EdgeTypeRight,
    EdgeTypeTop,
    EdgeTypeBottom
};

@interface UIView (autolayout)

-(void)pinchToSuperViewAllEdges;
-(void)pinchToSuperViewAllEdgesWithInsets:(UIEdgeInsets)insets;
-(NSLayoutConstraint *)pinchToSuperViewEdgeWithEdgeType:(NSLayoutAttribute)edgeType inset:(CGFloat)inset;

@end
