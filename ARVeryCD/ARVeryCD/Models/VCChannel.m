//
//  VCChannel.m
//  ARVeryCD
//
//  Created by August on 14-8-1.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "VCChannel.h"

@implementation VCChannel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"channelName":@"name",
             @"channelThumbnail":@"thumbnail",
             @"channelDescription":@"description",
             @"chanelId":@"catalog_id"};
}

@end
