//
//  VCHTTPClient+Channel.m
//  ARVeryCD
//
//  Created by August on 14-8-1.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "VCHTTPClient+Channel.h"

@implementation VCHTTPClient (Channel)

+(void)fetchChannelListWithFinishedBlock:(void (^)(NSArray *))finishedBlock
                             failedBlock:(void (^)(NSError *))failedBlock
{
    RACSignal *fetchChannels = [VCHTTPClient GET_requestWithPath:urlChannelList paramaters:nil];
    [fetchChannels subscribeNext:^(NSArray *response) {
        NSArray *channels = [MTLJSONAdapter modelsOfClass:NSClassFromString(@"VCChannel")
                                            fromJSONArray:response
                                                    error:nil];
        finishedBlock(channels);
    } error:^(NSError *error) {
        failedBlock(error);
    }];
}

@end
