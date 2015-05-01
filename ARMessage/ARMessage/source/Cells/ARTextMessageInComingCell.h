//
//  ARTextMessageInComingCell.h
//  ARMessage
//
//  Created by August on 15/4/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARMessageCell.h"
#import "ARMessageAvatar.h"
#import "ARMessagesCellTextView.h"

@interface ARTextMessageInComingCell : ARMessageCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet ARMessagesCellTextView *textView;
@property (weak, nonatomic) IBOutlet ARMessageAvatar *avatarImageView;
@property (weak, nonatomic) IBOutlet UIButton *resendButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeTopConstraint;

@end
