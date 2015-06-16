//
//  SYUtility.m
//  BLEDemo
//
//  Created by Zhanghao on 3/19/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import "SYUtility.h"

static NSDateFormatter *_dateFormatter = nil;

@implementation SYUtility

NSString *dateToString(NSDate *date, NSString *format){
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    _dateFormatter.dateFormat = format;
    return [_dateFormatter stringFromDate:date];
}

NSDate *stringToDate(NSString *dateString, NSString *format)
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    _dateFormatter.dateFormat = format;
    return [_dateFormatter dateFromString:dateString];
}

@end
