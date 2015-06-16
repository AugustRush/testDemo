//
//  UITableViewCell+Helper.m
//  BLEDemo
//
//  Created by Zhanghao on 3/22/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import "UITableViewCell+Helper.h"

@implementation UITableViewCell (Helper)

- (void)cleanUp {
    self.textLabel.font = [UIFont systemFontOfSize:15.0f];
    self.detailTextLabel.font = [UIFont systemFontOfSize:15.0f];
    
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
}

@end
