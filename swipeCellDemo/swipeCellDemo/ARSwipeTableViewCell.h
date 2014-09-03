//
//  ARSwipeTableViewCell.h
//  swipeCellDemo
//
//  Created by August on 14-8-20.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ARSwipeTableViewCellSwipeType) {
    ARSwipeTableViewCellSwipeTypeLeft,
    ARSwipeTableViewCellSwipeTypeRight
};

/**
 *  delegate triger action
 */
@class ARSwipeTableViewCell;

@protocol ARSwipeTableViewCellDelegate <NSObject>

@optional
-(void)swipeCell:(ARSwipeTableViewCell *)cell swipeCompletedWithType:(ARSwipeTableViewCellSwipeType)type;

@end

/**
 *  swipeCell dataSouce methods to get left and right items, item should be UIImageView.
 */
@protocol ARSwipeTableViewCellDataSource <NSObject>

@optional
-(NSArray *)leftItemsWithSwipeCell:(ARSwipeTableViewCell *)swipeCell;
-(NSArray *)rightItemsWithSwipeCell:(ARSwipeTableViewCell *)swipeCell;

@end

@interface ARSwipeTableViewCell : UITableViewCell

@property (nonatomic, assign) id<ARSwipeTableViewCellDelegate> delegate;
@property (nonatomic, assign) id<ARSwipeTableViewCellDataSource> dataSource;


@end
