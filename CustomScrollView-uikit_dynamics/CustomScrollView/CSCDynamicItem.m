//
//  CSCDynamicItem.m
//  CustomScrollView
//
//  Created by Arkadiusz on 03-07-14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import "CSCDynamicItem.h"

@implementation CSCDynamicItem

- (instancetype)init {
    self = [super init];

    if (self) {
        // Sets non-zero `bounds`, because otherwise Dynamics throws an exception.
        _bounds = CGRectMake(0, 0, 1, 1);
    }

    return self;
}

@end
