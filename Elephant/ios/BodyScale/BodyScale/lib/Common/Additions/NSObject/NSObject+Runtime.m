//
//  NSObject+Runtime.m
//  FFLtd
//
//  Created by 两元鱼 on 13-4-8.
//  Copyright (c) 2013年 FFLtd. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

- (NSArray *)getPropertiesNameList{
    NSMutableArray *nameArr = [[NSMutableArray alloc] init];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    if (properties == NULL) {
        free(properties);
        return nameArr;
    }
    for (i = 0; i< outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc]
                                   initWithCString:property_getName(property)
                                   encoding:NSUTF8StringEncoding];
        if (!IsStrEmpty(propertyName)) {
            [nameArr addObject:propertyName];
        }else{
            continue;
        }
    }
    free(properties);
    return nameArr;
}

- (NSMutableDictionary *)getAllPropertyDic{
    NSMutableDictionary *propertiesDic = [[NSMutableDictionary alloc] init];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    if (properties == NULL) {
        free(properties);
        return propertiesDic;
    }
    for (i = 0; i< outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc]
                                   initWithCString:property_getName(property)
                                   encoding:NSUTF8StringEncoding];
        id propertyValue = [self valueForKey:propertyName];
        if (!IsStrEmpty(propertyName)) {
            if (!IsNilOrNull(propertyValue)&& [propertyValue isKindOfClass:[NSString class]])
            {
                [propertiesDic setObject:propertyValue forKey:propertyName];
   
            }else if(!IsNilOrNull(propertyValue)&&
                     strcmp([propertyValue objCType], @encode(NSInteger))==0)
            {
                NSNumber *valueNum = [NSNumber numberWithInteger:(NSInteger)propertyValue];
                [propertiesDic setObject:valueNum forKey:propertyName];
            }else{
            
                DLog(@"An Unreconized Object Accur");
            }
        }else{
            continue;
        }
    }
    free(properties);
    return propertiesDic;
}

@end
