//
//  VCHTTPClient+ChannelList.m
//  ARVeryCD
//
//  Created by August on 14-8-5.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "VCHTTPClient+ChannelList.h"

@implementation VCHTTPClient (ChannelList)

+(void)fetchChannelListWithParamaters:(NSDictionary *)paramaters
                        FinishedBlock:(void (^)(NSArray *))finishedBlock
                          failedBlock:(void (^)(NSError *))failedBlock
{
    [[VCHTTPClient GET_requestWithPath:urlChanenlEntryList paramaters:paramaters]subscribeNext:^(NSDictionary *response) {
        if ([response[@"results"] isKindOfClass:[NSArray class]]) {
            NSArray *entrys = [MTLJSONAdapter modelsOfClass:NSClassFromString(@"VCChanelListEntry") fromJSONArray:response[@"results"] error:nil];
            NSLog(@"entrys is %@",entrys);
            finishedBlock(entrys);
        }
    } error:^(NSError *error) {
        failedBlock(error);
    }];;
}

@end
