//
//  VCChanelListEntry.m
//  ARVeryCD
//
//  Created by August on 14-8-5.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "VCChanelListEntry.h"

@implementation VCChanelListEntry

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"thumbImageUrl":@"thumbnail",
             @"videoName":@"cname",
             @"entryId":@"id"};
}

+(NSValueTransformer *)thumbImageUrlJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^NSString *(NSString *original) {
        NSArray *thumbnailElements = [original componentsSeparatedByString:@"/"] ;
        NSString *URL = [NSString stringWithFormat:@"http://i-%@.vcimg.com/crop/%@(240x340)/thumb.jpg",[thumbnailElements objectAtIndex:0],[thumbnailElements objectAtIndex:1]];
        return URL;
    }];
}

@end
