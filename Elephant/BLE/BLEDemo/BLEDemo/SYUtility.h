//
//  SYUtility.h
//  BLEDemo
//
//  Created by Zhanghao on 3/19/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYUtility : NSObject

NSString *dateToString(NSDate *date, NSString *format);
NSDate *stringToDate(NSString *dateString, NSString *format);

@end
