//
//  ARMessageCaculator.m
//  ARMessage
//
//  Created by August on 15/4/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARMessageCaculator.h"
#import "ARMessageUIConfigs.h"

@implementation ARMessageCaculator

+(CGFloat)heightWithMessage:(id<ARMessageProtocol>)message showTime:(BOOL)showTime
{
    ARMessageType type = [message type];
    switch (type) {
        case ARMessageTypeText:
            return [self textMessageSizeWithMessage:message showTime:showTime];
            break;
        case ARMessageTypeImage:
            
            break;
        case ARMessageTypeOriginal:
            
            break;
            
        default:
            break;
    }
    
    return 0;
}

+(CGFloat)textMessageSizeWithMessage:(id<ARMessageProtocol>)message showTime:(BOOL)showTime
{
    CGFloat screenWidth = kScreenWidth;
    CGSize textSize = [message.text usedSizeForMaxWidth:screenWidth-106
                                               withFont:ARMessageTextFont];
    textSize.height += 16;
    
    CGFloat timeHeight = 18;
    if (showTime) {
        timeHeight += (ARMessageTimeFont.lineHeight +ARMessageTimeTopInset);
    }
    textSize.height += timeHeight;
    return textSize.height;

}

@end
