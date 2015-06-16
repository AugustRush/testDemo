//
//  NSStringExtension.h
//  MB
//
//  Created by wangwei on 13-10-24.
//  Copyright (c) 2013年 FFLtd. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

@interface NSString (MyExtensions)
- (NSString *) md5;
- (NSString *)trimSpecialCharacter;
+ (NSString *)GenUUID;
- (int)checksum;
- (NSInteger)convertToInt;

@end
