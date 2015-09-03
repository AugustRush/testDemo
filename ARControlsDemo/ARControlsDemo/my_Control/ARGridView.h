//
//  ARGridView.h
//  ARControlsDemo
//
//  Created by August on 15/8/7.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARGridView : UIView

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) NSUInteger numberOfColumn;
@property (nonatomic, assign) NSUInteger numberOfItems;
@property (nonatomic, assign) CGFloat itemInset;
@property (nonatomic, assign) CGFloat lineInset;
@property (nonatomic, copy) UIView *(^configuration)(NSUInteger index);

@property (nonatomic, strong, readonly) NSMutableArray *items;

- (void)reloadAllItems;

- (void)relayoutWithVisibleItemsCount:(NSUInteger)count;

@end
