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

@class ARSwipeTableViewCell;
@protocol ARSwipeTableViewCellDelegate <NSObject>

-(void)cell:(ARSwipeTableViewCell *)cell swipeCompletedWithType:(ARSwipeTableViewCellSwipeType)type;

@end

@interface ARSwipeTableViewCell : UITableViewCell

@property (nonatomic, assign) id<ARSwipeTableViewCellDelegate>delegate;
//在UITableCell的基础上添加了左边,右边的菜单按钮

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
                   leftItems:(NSArray *)leftItems
                  rightItems:(NSArray *)rightItems;



@end
