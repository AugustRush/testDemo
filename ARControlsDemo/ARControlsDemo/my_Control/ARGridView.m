//
//  ARGridView.m
//  ARControlsDemo
//
//  Created by August on 15/8/7.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARGridView.h"

static CGFloat ARGridViewAbsentValue = -1;
NSString *const kWraperViewWidthConstraintIdentifier = @"kWraperViewWidthConstraintIdentifier";
NSString *const kWraperViewheightConstraintIdentifier = @"kWraperViewheightConstraintIdentifier";

@interface ARGridView ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIView *wraperView;
@property (nonatomic, strong) NSLayoutConstraint *wraperHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *wraperWidthConstraint;

@end

@implementation ARGridView

#pragma mark - init methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

#pragma mark - private methods

- (void)setUp {
    self.itemInset = 1;
    self.lineInset = 1;
    self.numberOfItems = 0;
    self.numberOfColumn = 0;
    self.itemWidth = ARGridViewAbsentValue;
    self.itemHeight = ARGridViewAbsentValue;
    self.items = [NSMutableArray array];
    
    self.wraperView = [[UIView alloc] init];
    self.wraperView.clipsToBounds = YES;
    self.wraperView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.wraperView];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.wraperView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.wraperView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.wraperView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.wraperView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];

}

#pragma mark - public methods

- (void)reloadAllItems {
    NSAssert(self.configuration != nil, @"configuration should not be nil!");
    [self.wraperView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.items removeAllObjects];
    if (self.numberOfItems < self.numberOfColumn) {
        self.numberOfColumn = self.numberOfItems;
    }
    
    [self relayoutWithVisibleItemsCount:self.numberOfItems];
    
    for (NSUInteger count = 0; count < self.numberOfItems; count++) {
        UIView *view = self.configuration(count);
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.wraperView addSubview:view];
        
        NSUInteger column = count % self.numberOfColumn;
        NSUInteger line = count/self.numberOfColumn;
        
        [self layoutItem:view atIndex:count column:column line:line];
        
        [self.items addObject:view];
    }
}

- (void)relayoutWithVisibleItemsCount:(NSUInteger)count {
    if (count <= self.numberOfItems) {
        NSUInteger numberOfColumn = self.numberOfColumn;
        if (count < self.numberOfColumn) {
            numberOfColumn = count;
        }
        NSUInteger maxLines = numberOfColumn > 0 ? ceilf(count / numberOfColumn) : 1;
        CGFloat maxWidth = numberOfColumn * (self.itemWidth + self.itemInset) - self.itemInset;
        CGFloat maxHeight = maxLines * (self.itemHeight + self.lineInset) - self.lineInset;
        if (maxWidth <= 0) {
            maxWidth = 0;
        }
        if (maxHeight <= 0) {
            maxHeight = 0;
        }
        
        if (self.wraperWidthConstraint) {
            [self.wraperView removeConstraint:self.wraperWidthConstraint];
        }
        if (self.wraperHeightConstraint) {
            [self.wraperView removeConstraint:self.wraperHeightConstraint];
        }
        self.wraperHeightConstraint = [NSLayoutConstraint constraintWithItem:self.wraperView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:maxHeight];
        [self.wraperView addConstraint:self.wraperHeightConstraint];
        
        self.wraperWidthConstraint = [NSLayoutConstraint constraintWithItem:self.wraperView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:maxWidth];
        [self.wraperView addConstraint:self.wraperWidthConstraint];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

#pragma mark - layout methods

- (void)layoutItem:(UIView *)item atIndex:(NSUInteger)index column:(NSUInteger)column line:(NSUInteger)line {
    if (self.itemWidth != ARGridViewAbsentValue) {
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.itemWidth];
        [item addConstraint:widthConstraint];
    }
    
    if (self.itemHeight != ARGridViewAbsentValue) {
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.itemHeight];
        [item addConstraint:heightConstraint];
    }
    
    if (column == 0) {
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.wraperView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        [self.wraperView addConstraint:leftConstraint];
    }else{
        UIView *preView = self.items[index - 1];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:preView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeLeft multiplier:1 constant:-self.itemInset];
        [self.wraperView addConstraint:leftConstraint];
    }
    
    if (line == 0) {
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.wraperView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        [self.wraperView addConstraint:topConstraint];
    }else{
        NSUInteger topViewIndex = self.numberOfColumn*line - self.numberOfColumn + column;
        UIView *topView = self.items[topViewIndex];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTop multiplier:1 constant:-self.lineInset];
        [self.wraperView addConstraint:topConstraint];
    }
}

@end
