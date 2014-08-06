//
//  VCHTTPClient+ChannelList.h
//  ARVeryCD
//
//  Created by August on 14-8-5.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "VCHTTPClient.h"

@interface VCHTTPClient (ChannelList)

+(void)fetchChannelListWithParamaters:(NSDictionary *)paramaters
                        FinishedBlock:(void(^)(NSArray *entrys))finishedBlock
                          failedBlock:(void(^)(NSError *error))failedBlock;

@end
