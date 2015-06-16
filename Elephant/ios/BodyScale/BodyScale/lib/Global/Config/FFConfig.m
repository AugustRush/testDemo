//
//  FFConfig.m
//  
//
//  Created by 两元鱼 on 14/12/26.
//  Copyright (c) 2014年 FFLtd. All rights reserved.
//


#import "FFConfig.h"
#import "NSString+SEL.h"

@implementation FFConfig

@synthesize defaults;

@dynamic firstLogin;
@dynamic closeQQ;

@dynamic userName;
@dynamic userHeader;
@dynamic userShowName;
@dynamic password;
@dynamic userPhoneNumber;
@dynamic userEmail;
@dynamic userRealName;

@dynamic userNickName;
@dynamic userHeight;
@dynamic userAge;
@dynamic userGender;
@dynamic nowUserId;

@dynamic userId;
@dynamic privateCode;
@dynamic needAutoLogin;

@dynamic savePassword;
@dynamic isLogined;
@dynamic needOfflineLogin;
@dynamic openUUID;
@dynamic favIndex;

-(id) init
{
    if(!(self = [super init]))
    {
        return self;
	}
    self.defaults = [NSUserDefaults standardUserDefaults];
	
    [self.defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                     @NO, dFirstLogin,
                                     @0, dCloseQQ,
                                     
                                     @"", dUserName,
                                     @"", dUserHeader,
                                     @"请先登录", dUserShowName,
                                     @"", dPassword,
                                     @"", dUserPhoneNumber,
                                     @"", dUserEmail,
                                     @"", dUserRealName,
                                     
                                     @"", dUserNickName,
                                     @"", dUserHeight,
                                     @0, dUserAge,
                                     @0, dUserGender,
                                     @"", dNowUserId,
                                     
                                     @"1", dUserId,
                                     @"", dPrivateCode,
                                     @NO, dNeedAutoLogin,
                                     @YES, dSavePassword,
                                     @NO, dIsLogined,
                                     @NO, dNeedOfflineLogin,
                                     @"", dOpenUUID,
                                     @"-1", dFavIndex,
                                     nil]];
    
	return self;
}

-(void) dealloc
{
    self.defaults = nil;
    self.firstLogin = nil;
    self.closeQQ = nil;
    
    self.userName = nil;
    self.userHeader = nil;
    self.userShowName = nil;
    self.password = nil;
    self.userPhoneNumber = nil;
    self.userEmail = nil;
    self.userRealName = nil;
    
    self.userNickName = nil;
    self.userHeight = nil;
    self.userAge = nil;
    self.userGender = nil;
    
    self.nowUserId = nil;
    
    self.userId = nil;
    self.privateCode = nil;
    self.needAutoLogin = nil;
	self.savePassword = nil;
    self.isLogined = nil;
    self.needOfflineLogin = nil;
    self.openUUID = nil;
    self.favIndex = nil;
}

+(FFConfig *) currentConfig
{
    static FFConfig *instance;
    if(!instance)
    {
        instance = [[FFConfig alloc] init];
    }
    return instance;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([NSStringFromSelector(aSelector) hasPrefix:@"set"])
    {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
	}
    return [NSMethodSignature signatureWithObjCTypes:"@@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *selector = NSStringFromSelector(anInvocation.selector);
    if ([selector hasPrefix:@"set"])
    {
        NSRange firstChar, rest;
        firstChar.location  = 3;
        firstChar.length    = 1;
        rest.location       = 4;
        rest.length         = selector.length - 5;
        
        selector = [NSString stringWithFormat:@"%@%@", [[selector substringWithRange:firstChar] lowercaseString], [selector substringWithRange:rest]];
        id value;
        [anInvocation getArgument:&value atIndex:2];
        if ([value isKindOfClass:[NSArray class]]) 
        {
            [self.defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:selector];
        }
        else
        {
            [self.defaults setObject:value forKey:selector];
        }
    }
    else
    {
        id value = [self.defaults objectForKey:selector];
        if ([value isKindOfClass:[NSData class]]) 
        {
            value = [NSKeyedUnarchiver unarchiveObjectWithData:value];
        }
        [anInvocation setReturnValue:&value];
    }
}

@end