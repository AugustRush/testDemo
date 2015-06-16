//
//  NSString-NULL.h
//  FFLtd
//
//  Created by 两元鱼 on 10-9-23.
//  Copyright 2010 FFLtd. All rights reserved.
//



@interface NSString (NSStringNULL)

- (id)initWithUTF8NULLString:(const char *)nullTerminatedCString;

@end
