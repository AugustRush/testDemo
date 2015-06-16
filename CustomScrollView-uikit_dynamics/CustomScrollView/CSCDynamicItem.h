//
//  CSCDynamicItem.h
//  CustomScrollView
//
//  Created by Arkadiusz on 03-07-14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSCDynamicItem : NSObject <UIDynamicItem>

@property (nonatomic, readwrite) CGPoint center;
@property (nonatomic, readonly) CGRect bounds;
@property (nonatomic, readwrite) CGAffineTransform transform;

@end
