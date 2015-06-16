//
//  SYOptionalViewController.h
//  BLEDemo
//
//  Created by Zhanghao on 3/20/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SYOptionType) {
    SYOptionTypeUserType,
    SYOptionTypeMeasureMode,
    SYOptionTypeUserChange,
    SYOptionTypeNone
};

@interface SYOptionalViewController : UITableViewController

- (instancetype)initWithType:(SYOptionType)type parameter:(NSString *)parameter;

@property (nonatomic, copy) void (^completionHandler)(SYOptionType, NSString *);

@end
