//
//  ARMessageCaculator.h
//  ARMessage
//
//  Created by August on 15/4/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Calculation.h"
#import "ARMessageProtocol.h"

@interface ARMessageCaculator : NSObject

+(CGFloat)heightWithMessage:(id<ARMessageProtocol>)message showTime:(BOOL)showTime;

@end
