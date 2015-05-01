//
//  ARTextMessageInComingCell.m
//  ARMessage
//
//  Created by August on 15/4/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARTextMessageInComingCell.h"
#import "ARMessageUIConfigs.h"

@interface ARTextMessageInComingCell ()<UITextViewDelegate>

@end

@implementation ARTextMessageInComingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tintColor = ARMessageInComingBuddleColor;
    [self.contentView bringSubviewToFront:self.textView];
    
    self.timeLabel.font = ARMessageTimeFont;
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.textAlignment = 1;
    self.timeLabel.textColor = ARMessageTimeColor;
    
    self.avatarImageView.backgroundColor = [UIColor grayColor];
    self.avatarImageView.borderWidth = 0;
    
    self.textView.textColor = [UIColor whiteColor];
    self.textView.font = ARMessageTextFont;
    self.textView.dataDetectorTypes = UIDataDetectorTypeLink;
    self.textView.delegate = self;
    
    self.resendButton.hidden = YES;
    
    self.indicatorView.hidesWhenStopped = YES;
}

#pragma mark - UITextViewDelegate methods

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if ([self.delegate respondsToSelector:@selector(messageCell:didSelectURL:)]) {
        [self.delegate messageCell:self didSelectURL:URL];
    }
    return YES;
}

-(void)fillWithMessage:(id<ARMessageProtocol>)message
{
    self.textView.text = [message text];
    
    [self updateMessageStatusWithStatus:ARMessageStatusSending];
}

-(void)updateMessageStatusWithStatus:(ARMessageStatus)status
{
    switch (status) {
        case ARMessageStatusSending:
        {
            self.resendButton.hidden = YES;
            [self.indicatorView startAnimating];
        }
            break;
        case ARMessageStatusSendFailed:
        {
            self.resendButton.hidden = NO;
            [self.indicatorView stopAnimating];
        }
            break;
        case ARMessageStatusSendSuccess:
        {
            self.resendButton.hidden = YES;
            [self.indicatorView stopAnimating];
        }
            break;
        default:
            break;
    }
}

@end
