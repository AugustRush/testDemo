//
//  VCHTTPClient+Channel.h
//  ARVeryCD
//
//  Created by August on 14-8-1.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "VCHTTPClient.h"

@interface VCHTTPClient (Channel)

+(void)fetchChannelListWithFinishedBlock:(void(^)(NSArray *channels))finishedBlock
                             failedBlock:(void(^)(NSError *error))failedBlock;

@end
