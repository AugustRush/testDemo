//
//  ARImageMessageinComingCell.h
//  ARMessage
//
//  Created by August on 15/4/29.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARMessageCell.h"

@interface ARImageMessageinComingCell : ARMessageCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIButton *resendButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoWidthConstraint;

@end
