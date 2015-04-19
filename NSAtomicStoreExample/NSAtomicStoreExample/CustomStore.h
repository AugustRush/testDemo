//
//  CustomStore.h
//  NSAtomicStoreExample
//
//  Created by August on 15/4/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CustomStore : NSAtomicStore
{
    NSMutableDictionary *nodeCacheRef;
}

@end
