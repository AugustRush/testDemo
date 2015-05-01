//
//  Message.h
//  ARMessage
//
//  Created by August on 15/4/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARMessage.h"

@interface Message : NSObject<ARMessageProtocol>

@property (nonatomic, assign) ARMessageType type;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) ARMessageStatus status;

@end
