//
//  ARSegmentView.m
//  ARSegmentPager
//
//  Created by August on 15/3/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARSegmentView.h"

@implementation ARSegmentView

#pragma mark - init methods

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self _baseConfigs];
    }
    return self;
}

#pragma mark - private methods

-(void)_baseConfigs
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.5].CGColor;
    self.layer.borderWidth = 0.5;
    
    _segmentControl = [[UISegmentedControl alloc] init];
    _segmentControl.selectedSegmentIndex = 0;
    [self addSubview:self.segmentControl];

    self.segmentControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentControl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:-14]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentControl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:-2]];
}

@end
