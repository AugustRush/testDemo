//
//  ARMessageCell.h
//  ARMessage
//
//  Created by August on 15/4/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARMessageProtocol.h"

@class ARMessageCell;
@protocol ARMessageCellDelegate <NSObject>

-(void)messageCell:(ARMessageCell *)cell didSelectURL:(NSURL *)URL;

@end

@interface ARMessageCell : UITableViewCell

@property (nonatomic, assign) id<ARMessageCellDelegate> delegate;

-(void) fillWithMessage:(id<ARMessageProtocol>)message;
-(void) updateMessageStatusWithStatus:(ARMessageStatus)status;

@end
