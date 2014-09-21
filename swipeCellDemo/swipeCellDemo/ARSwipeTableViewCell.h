//
//  ARSwipeTableViewCell.h
//  swipeCellDemo
//
//  Created by August on 14-8-20.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARSwipeTableViewCell;

/**
 *  触发左右按钮时的回调代理
 */
@protocol ARSwipeTableViewCellDelegate <NSObject>

@optional

-(void)swipeCell:(ARSwipeTableViewCell *)cell didTriggerLeftItemWithIndex:(NSInteger)index;
-(void)swipeCell:(ARSwipeTableViewCell *)cell didTriggerRightItemWithIndex:(NSInteger)index;

@end

/**
 *  cell 的左右item数组，所有item应为UIView的子类
 */
@protocol ARSwipeTableViewCellDataSource <NSObject>

@optional
-(NSArray *)leftItemsForSwipeCell:(ARSwipeTableViewCell *)swipeCell;
-(NSArray *)rightItemsForSwipeCell:(ARSwipeTableViewCell *)swipeCell;

@end

/**
 *  swipe cell
 */

@interface ARSwipeTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat menuItemWidth;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, assign) id<ARSwipeTableViewCellDelegate> delegate;
@property (nonatomic, assign) id<ARSwipeTableViewCellDataSource> dataSource;


@end