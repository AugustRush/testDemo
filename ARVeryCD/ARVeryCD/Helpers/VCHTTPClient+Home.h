//
//  VCHTTPClient+Home.h
//  ARVeryCD
//
//  Created by August on 14-7-31.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "VCHTTPClient.h"

@interface VCHTTPClient (Home)

+(void)fetchHomeListWithFinishedBlock:(void(^)(NSArray *list))finishedBlock
                          failedBlock:(void(^)(NSError *error))failedBlock;

@end
