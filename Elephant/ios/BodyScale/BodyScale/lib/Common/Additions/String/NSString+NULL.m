//
//  NSString-NULL.m
//  FFLtd
//
//  Created by 两元鱼 on 10-9-23.
//  Copyright 2010 FFLtd. All rights reserved.
//

#import "NSString+NULL.h"


@implementation NSString (NSStringNULL)
- (id)initWithUTF8NULLString:(const char *)nullTerminatedCString{
 
	if(nullTerminatedCString==NULL)
		return nil;
	else{
		return [self initWithUTF8String:nullTerminatedCString];
	}
	
}
@end
