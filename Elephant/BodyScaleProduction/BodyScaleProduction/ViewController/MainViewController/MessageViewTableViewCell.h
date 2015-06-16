//
//  MessageViewTableViewCell.h
//  BodyScaleProduction
//
//  Created by Zhanghao on 5/9/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSGFocusMeEntity;

@interface MessageViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (nonatomic, copy) void (^agreeBlock)(NSString *mid);

- (void)fillCellWithEntity:(MSGFocusMeEntity *)entity;

@end
