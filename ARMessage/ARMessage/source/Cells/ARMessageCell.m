//
//  ARMessageCell.m
//  ARMessage
//
//  Created by August on 15/4/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARMessageCell.h"

@implementation ARMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)fillWithMessage:(id<ARMessageProtocol>)message
{}

-(void)updateMessageStatusWithStatus:(ARMessageStatus)status
{}

@end
