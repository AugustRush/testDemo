//
//  UIView+ICConstraintsAutoLayout.m
//  AutoLayoutProgrammingDemo
//
//  Created by 刘平伟 on 14-5-14.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "UIView+ICConstraintsAutoLayout.h"

@implementation UIView (ICConstraintsAutoLayout)

-(void)ICAutoLayout_RelativeSuperViewMargin:(ICAutoLayoutMargin)Margin
{
    [self ICAutoLayout_RelativeSuperViewMargin:Margin type:ICAutoLayoutTypeAllUnFirm];
}

-(void)ICAutoLayout_RelativeSuperViewMargin:(ICAutoLayoutMargin)Margin type:(ICAutoLayoutType)type
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSAssert1(self.superview != nil, @"%@ superView should not be nil", self);
    
    
    NSDictionary *viewsBinding = NSDictionaryOfVariableBindings(self);
    NSString *vflH = nil;
    NSString *vflV = nil;
    
    switch (type) {
        case ICAutoLayoutTypeAllFirmLocationCenterXY:
        {
            vflH = [NSString stringWithFormat:@"H:[self(%f)]",Margin.ICA];
            vflV = [NSString stringWithFormat:@"V:[self(%f)]",Margin.ICC];
            
            [self.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self
                                           attribute:NSLayoutAttributeCenterX
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.superview
                                           attribute:NSLayoutAttributeCenterX
                                           multiplier:1
                                           constant:Margin.ICB]];

            [self.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self
                                           attribute:NSLayoutAttributeCenterY
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.superview
                                           attribute:NSLayoutAttributeCenterY
                                           multiplier:1
                                           constant:Margin.ICD]];

        }
            break;
        case ICAutoLayoutMarginAllFirmToLeftTop:
        {
            vflH = [NSString stringWithFormat:@"H:|-(%f)-[self(%f)]",Margin.ICA,Margin.ICB];
            vflV = [NSString stringWithFormat:@"V:|-(%f)-[self(%f)]",Margin.ICC,Margin.ICD];
        }
            break;
        case ICAutoLayoutMarginAllFirmToLeftBottom:
        {
            vflH = [NSString stringWithFormat:@"H:|-(%f)-[self(%f)]",Margin.ICA,Margin.ICB];
            vflV = [NSString stringWithFormat:@"V:[self(%f)]-(%f)-|",Margin.ICC,Margin.ICD];
        }
            break;
        case ICAutoLayoutMarginAllFirmToRightTop:
        {
            vflH = [NSString stringWithFormat:@"H:[self(%f)]-(%f)-|",Margin.ICA,Margin.ICB];
            vflV = [NSString stringWithFormat:@"V:|-(%f)-[self(%f)]",Margin.ICC,Margin.ICD];
        }
            break;
        case ICAutoLayoutMarginAllFirmToRightBottom:
        {
            vflH = [NSString stringWithFormat:@"H:[self(%f)]-(%f)-|",Margin.ICA,Margin.ICB];
            vflV = [NSString stringWithFormat:@"V:[self(%f)]-(%f)-|",Margin.ICC,Margin.ICD];
        }
            break;
        case ICAutoLayoutTypeFirmHeightLocationCenterY:
        {
            vflH = [NSString stringWithFormat:@"H:|-(%f)-[self]-(%f)-|",Margin.ICA,Margin.ICB];
            vflV = [NSString stringWithFormat:@"V:[self(%f)]",Margin.ICC];
            
            [self.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self
                                           attribute:NSLayoutAttributeCenterY
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.superview
                                           attribute:NSLayoutAttributeCenterY
                                           multiplier:1
                                           constant:Margin.ICD]];
        }
            break;
        case ICAutoLayoutTypeFirmWidthLocationCenterX:
        {
            vflV = [NSString stringWithFormat:@"V:|-(%f)-[self]-(%f)-|",Margin.ICC,Margin.ICD];
            vflH = [NSString stringWithFormat:@"H:[self(%f)]",Margin.ICA];
            
            [self.superview addConstraint:[NSLayoutConstraint
                                           constraintWithItem:self
                                           attribute:NSLayoutAttributeCenterX
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.superview
                                           attribute:NSLayoutAttributeCenterX
                                           multiplier:1
                                           constant:Margin.ICB]];

        }
            break;
        case ICAutoLayoutTypeFirmHeightToTop:
        {
            vflH = [NSString stringWithFormat:@"H:|-(%f)-[self]-(%f)-|",Margin.ICA,Margin.ICB];
            vflV = [NSString stringWithFormat:@"V:|-(%f)-[self(%f)]",Margin.ICC,Margin.ICD];
        }
            break;
        case ICAutoLayoutTypeFirmHeightToBottom:
        {
            vflH = [NSString stringWithFormat:@"H:|-(%f)-[self]-(%f)-|",Margin.ICA,Margin.ICB];
            vflV = [NSString stringWithFormat:@"V:[self(%f)]-(%f)-|",Margin.ICC,Margin.ICD];
        }
            break;
        case ICAutoLayoutTypeFirmWidthToLeft:
        {
            vflH = [NSString stringWithFormat:@"H:|-(%f)-[self(%f)]",Margin.ICA,Margin.ICB];
            vflV = [NSString stringWithFormat:@"V:|-(%f)-[self]-(%f)-|",Margin.ICC,Margin.ICD];
        }
            break;
        case ICAutoLayoutTypeFirmWidthToRight:
        {
            vflH = [NSString stringWithFormat:@"H:[self(%f)]-(%f)-|",Margin.ICA,Margin.ICB];
            vflV = [NSString stringWithFormat:@"V:|-(%f)-[self]-(%f)-|",Margin.ICC,Margin.ICD];
        }
            break;
        case ICAutoLayoutTypeAllUnFirm:
        {
            vflH = [NSString stringWithFormat:@"H:|-(%f)-[self]-(%f)-|",Margin.ICA,Margin.ICB];
            vflV = [NSString stringWithFormat:@"V:|-(%f)-[self]-(%f)-|",Margin.ICC,Margin.ICD];
        }
            break;
            
        default:
            break;
    }
    
        
    NSArray *herizinalConstraints = [NSLayoutConstraint
                                     constraintsWithVisualFormat:vflH
                                     options:0
                                     metrics:nil
                                     views:viewsBinding];
    
    NSArray *verticalConstraints = [NSLayoutConstraint
                                    constraintsWithVisualFormat:vflV
                                    options:0
                                    metrics:nil
                                    views:viewsBinding];
    
    [self.superview addConstraints:herizinalConstraints];
    [self.superview addConstraints:verticalConstraints];

}

-(void)ICAutoLayout_RelativeView:(UIView *)relativeView Margin:(ICAutoLayoutMargin)Margin
{
    [self ICAutoLayout_RelativeView:relativeView Margin:Margin Type:ICAutoLayoutRelativeTypeInnerAllUnfirm];
}

-(void)ICAutoLayout_RelativeView:(UIView *)relativeView Margin:(ICAutoLayoutMargin)Margin Type:(ICAutoLayoutRelativeType)type
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSAssert1(self.superview, @"%@ superView should not be nil !",self);
    
    NSDictionary *viewsBinding = NSDictionaryOfVariableBindings(self);
    NSMutableArray *self_attrs = [NSMutableArray arrayWithArray:@[@0,@0,@0,@0]];
    NSMutableArray *relative_attrs = [NSMutableArray arrayWithArray:@[@0,@0,@0,@0]];
    
    switch (type) {
        case ICAutoLayoutRelativeTypeInnerAllUnfirm:
        {
            self_attrs[0] = @(NSLayoutAttributeLeft);
            self_attrs[1] = @(NSLayoutAttributeRight);
            self_attrs[2] = @(NSLayoutAttributeTop);
            self_attrs[3] = @(NSLayoutAttributeBottom);
            
            relative_attrs[0] = @(NSLayoutAttributeLeft);
            relative_attrs[1] = @(NSLayoutAttributeRight);
            relative_attrs[2] = @(NSLayoutAttributeTop);
            relative_attrs[3] = @(NSLayoutAttributeBottom);
        }
            break;
            
        case ICAutoLayoutRelativeTypeFirmHeightTop:
        {
            self_attrs[0] = @(NSLayoutAttributeLeft);
            self_attrs[1] = @(NSLayoutAttributeRight);
            self_attrs[2] = @(NSLayoutAttributeBottom);
            [self_attrs removeObjectAtIndex:3];
            
            relative_attrs[0] = @(NSLayoutAttributeLeft);
            relative_attrs[1] = @(NSLayoutAttributeRight);
            relative_attrs[2] = @(NSLayoutAttributeTop);
            [relative_attrs removeObjectAtIndex:3];
            
            NSString *vflV = [NSString stringWithFormat:@"V:[self(%f)]",Margin.ICD];
            
            [self.superview addConstraints:[NSLayoutConstraint
                                            constraintsWithVisualFormat:vflV
                                            options:0
                                            metrics:nil
                                            views:viewsBinding]];
        }
            break;
            
        case ICAutoLayoutRelativeTypeFirmHeightBottom:
        {
            self_attrs[0] = @(NSLayoutAttributeLeft);
            self_attrs[1] = @(NSLayoutAttributeRight);
            self_attrs[2] = @(NSLayoutAttributeTop);
            [self_attrs removeObjectAtIndex:3];
            
            relative_attrs[0] = @(NSLayoutAttributeLeft);
            relative_attrs[1] = @(NSLayoutAttributeRight);
            relative_attrs[2] = @(NSLayoutAttributeBottom);
            [relative_attrs removeObjectAtIndex:3];
            
            NSString *vflV = [NSString stringWithFormat:@"V:[self(%f)]",Margin.ICD];
            
            [self.superview addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:vflV
                                  options:0
                                  metrics:nil
                                  views:viewsBinding]];
        }
            break;
        case ICAutoLayoutRelativeTypeFirmWidthLeft:
        {
            self_attrs[0] = @(NSLayoutAttributeRight);
            self_attrs[1] = @(NSLayoutAttributeTop);
            self_attrs[2] = @(NSLayoutAttributeBottom);
            [self_attrs removeObjectAtIndex:3];
            
            relative_attrs[0] = @(NSLayoutAttributeLeft);
            relative_attrs[1] = @(NSLayoutAttributeTop);
            relative_attrs[2] = @(NSLayoutAttributeBottom);
            [relative_attrs removeObjectAtIndex:3];
            
            NSString *vflH = [NSString stringWithFormat:@"H:[self(%f)]",Margin.ICA];
            
            [self.superview addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:vflH
                                  options:0
                                  metrics:nil
                                  views:viewsBinding]];
            
            Margin = ICAutoLayoutMarginMake(Margin.ICB, Margin.ICC, Margin.ICD, 0);
            
        }
            break;
        case ICAutoLayoutRelativeTypeFirmWidthRight:
        {
            self_attrs[0] = @(NSLayoutAttributeLeft);
            self_attrs[1] = @(NSLayoutAttributeTop);
            self_attrs[2] = @(NSLayoutAttributeBottom);
            [self_attrs removeObjectAtIndex:3];
            
            relative_attrs[0] = @(NSLayoutAttributeRight);
            relative_attrs[1] = @(NSLayoutAttributeTop);
            relative_attrs[2] = @(NSLayoutAttributeBottom);
            [relative_attrs removeObjectAtIndex:3];
            
            NSString *vflH = [NSString stringWithFormat:@"H:[self(%f)]",Margin.ICB];
            
            [self.superview addConstraints:[NSLayoutConstraint
                                            constraintsWithVisualFormat:vflH
                                            options:0
                                            metrics:nil
                                            views:viewsBinding]];
            
            Margin = ICAutoLayoutMarginMake(Margin.ICA, Margin.ICC, Margin.ICD, 0);
            
        }
            break;
        case ICAutoLayoutRelativeTypeAllFirmLeftTop:
        {
            self_attrs[0] = @(NSLayoutAttributeRight);
            self_attrs[1] = @(NSLayoutAttributeBottom);
            [self_attrs removeLastObject];
            [self_attrs removeLastObject];
            
            relative_attrs[0] = @(NSLayoutAttributeLeft);
            relative_attrs[1] = @(NSLayoutAttributeTop);
            [relative_attrs removeLastObject];
            [relative_attrs removeLastObject];
            
            NSString *vflH = [NSString stringWithFormat:@"H:[self(%f)]",Margin.ICA];
            NSString *vflV = [NSString stringWithFormat:@"V:[self(%f)]",Margin.ICC];
            [self.superview addConstraints:[NSLayoutConstraint
                                            constraintsWithVisualFormat:vflH
                                            options:0
                                            metrics:nil
                                            views:viewsBinding]];
            
            [self.superview addConstraints:[NSLayoutConstraint
                                            constraintsWithVisualFormat:vflV
                                            options:0
                                            metrics:nil
                                            views:viewsBinding]];
            
            Margin = ICAutoLayoutMarginMake(Margin.ICB, Margin.ICD, 0, 0);
            
        }
            break;
        case ICAutoLayoutRelativeTypeAllFirmLeftBottom:
        {
            self_attrs[0] = @(NSLayoutAttributeRight);
            self_attrs[1] = @(NSLayoutAttributeTop);
            [self_attrs removeLastObject];
            [self_attrs removeLastObject];
            
            relative_attrs[0] = @(NSLayoutAttributeLeft);
            relative_attrs[1] = @(NSLayoutAttributeBottom);
            [relative_attrs removeLastObject];
            [relative_attrs removeLastObject];
            
            NSString *vflH = [NSString stringWithFormat:@"H:[self(%f)]",Margin.ICA];
            NSString *vflV = [NSString stringWithFormat:@"V:[self(%f)]",Margin.ICD];
            [self.superview addConstraints:[NSLayoutConstraint
                                            constraintsWithVisualFormat:vflH
                                            options:0
                                            metrics:nil
                                            views:viewsBinding]];
            
            [self.superview addConstraints:[NSLayoutConstraint
                                            constraintsWithVisualFormat:vflV
                                            options:0
                                            metrics:nil
                                            views:viewsBinding]];
            
            Margin = ICAutoLayoutMarginMake(Margin.ICB, Margin.ICC, 0, 0);
            
        }
            break;

        case ICAutoLayoutRelativeTypeAllFirmRightTop:
        {
            self_attrs[0] = @(NSLayoutAttributeLeft);
            self_attrs[1] = @(NSLayoutAttributeBottom);
            [self_attrs removeLastObject];
            [self_attrs removeLastObject];
            
            relative_attrs[0] = @(NSLayoutAttributeRight);
            relative_attrs[1] = @(NSLayoutAttributeTop);
            [relative_attrs removeLastObject];
            [relative_attrs removeLastObject];
            
            NSString *vflH = [NSString stringWithFormat:@"H:[self(%f)]",Margin.ICA];
            NSString *vflV = [NSString stringWithFormat:@"V:[self(%f)]",Margin.ICD];
            [self.superview addConstraints:[NSLayoutConstraint
                                            constraintsWithVisualFormat:vflH
                                            options:0
                                            metrics:nil
                                            views:viewsBinding]];
            
            [self.superview addConstraints:[NSLayoutConstraint
                                            constraintsWithVisualFormat:vflV
                                            options:0
                                            metrics:nil
                                            views:viewsBinding]];
            
            Margin = ICAutoLayoutMarginMake(Margin.ICB, Margin.ICC, 0, 0);
            
        }
            break;

        case ICAutoLayoutRelativeTypeAllFirmRightBottom:
        {
            self_attrs[0] = @(NSLayoutAttributeLeft);
            self_attrs[1] = @(NSLayoutAttributeTop);
            [self_attrs removeLastObject];
            [self_attrs removeLastObject];
            
            relative_attrs[0] = @(NSLayoutAttributeRight);
            relative_attrs[1] = @(NSLayoutAttributeBottom);
            [relative_attrs removeLastObject];
            [relative_attrs removeLastObject];
            
            NSString *vflH = [NSString stringWithFormat:@"H:[self(%f)]",Margin.ICB];
            NSString *vflV = [NSString stringWithFormat:@"V:[self(%f)]",Margin.ICD];
            [self.superview addConstraints:[NSLayoutConstraint
                                            constraintsWithVisualFormat:vflH
                                            options:0
                                            metrics:nil
                                            views:viewsBinding]];
            
            [self.superview addConstraints:[NSLayoutConstraint
                                            constraintsWithVisualFormat:vflV
                                            options:0
                                            metrics:nil
                                            views:viewsBinding]];
            
            Margin = ICAutoLayoutMarginMake(Margin.ICA, Margin.ICC, 0, 0);
            
        }
            break;

            
        default:
            break;
    }
    
    NSAssert2(self_attrs.count == relative_attrs.count, @"%@ should have equal count layout attributes to %@", self_attrs, relative_attrs);
    
    for (int i = 0; i < self_attrs.count; i++) {
        
        float constant = 0;
        switch (i) {
            case 0:
                constant = Margin.ICA;
                break;
            case 1:
                constant = Margin.ICB;
                break;
            case 2:
                constant = Margin.ICC;
                break;
            case 3:
                constant = Margin.ICD;
                break;
                
            default:
                break;
        }
        
        [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                                   attribute:[self_attrs[i] integerValue]
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:relativeView
                                                                   attribute:[relative_attrs[i] integerValue]
                                                                  multiplier:1
                                                                    constant:constant]];

    }
    
}

@end

