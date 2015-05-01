//
//  UIView+autolayout.m
//  ARMessage
//
//  Created by August on 15/4/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "UIView+autolayout.h"

@implementation UIView (autolayout)

-(void)pinchToSuperViewAllEdges
{
    [self pinchToSuperViewAllEdgesWithInsets:UIEdgeInsetsZero];
}

-(NSLayoutConstraint *)pinchToSuperViewEdgeWithEdgeType:(NSLayoutAttribute)edgeType inset:(CGFloat)inset
{
    NSAssert(self.superview != nil, @"%@ superView should not be nil !",self);
    UIView *superView = self.superview;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:edgeType
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:superView
                                                                  attribute:edgeType
                                                                 multiplier:1
                                                                   constant:inset];
    
    [superView addConstraint:constraint];
    
    return constraint;
}

-(void)pinchToSuperViewAllEdgesWithInsets:(UIEdgeInsets)insets
{
    [self pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeLeft inset:insets.left];
    [self pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeRight inset:insets.right];
    [self pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeTop inset:insets.top];
    [self pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeBottom inset:insets.bottom];
}

@end
