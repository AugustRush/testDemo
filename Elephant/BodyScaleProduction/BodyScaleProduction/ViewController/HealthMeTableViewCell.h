//
//  HealthMeTableViewCell.h
//  BodyScaleProduction
//
//  Created by Zhanghao on 5/16/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendInfoEntity;

@interface HealthMeTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^userLikeBlock)(void);
@property (nonatomic, copy) void (^notifyWeightBlock)(void);

- (void)fillCellWithFriendInfoEntity:(FriendInfoEntity *)entity;

+ (CGFloat)cellHeightByPermission:(BOOL)hasPermission;

@end
