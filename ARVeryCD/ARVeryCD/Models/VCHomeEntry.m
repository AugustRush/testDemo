//
//  VCHomeEntry.m
//  ARVeryCD
//
//  Created by August on 14-7-31.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "VCHomeEntry.h"

@implementation VCHomeEntry

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"thumbImageUrl":@"thumbnail",
             @"videoName":@"entry.cname",
             @"recommandThumbnailUrl":@"entry.thumbnail"};
}

+(NSValueTransformer *)thumbImageUrlJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^NSString *(NSString *original) {
        NSArray *thumbnailElements = [original componentsSeparatedByString:@"/"] ;
        NSString *URL = [NSString stringWithFormat:@"http://i-%@.vcimg.com/crop/%@(150x210)/thumb.jpg",[thumbnailElements objectAtIndex:0],[thumbnailElements objectAtIndex:1]];
        return URL;
    }];
}

+(NSValueTransformer *)recommandThumbnailUrlJSONTransformer
{
    return [self thumbImageUrlJSONTransformer];
}

@end
