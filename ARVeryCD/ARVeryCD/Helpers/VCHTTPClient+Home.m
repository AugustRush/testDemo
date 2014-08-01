//
//  VCHTTPClient+Home.m
//  ARVeryCD
//
//  Created by August on 14-7-31.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "VCHTTPClient+Home.h"

@implementation VCHTTPClient (Home)

+(void)fetchHomeListWithFinishedBlock:(void (^)(NSArray *))finishedBlock
                          failedBlock:(void (^)(NSError *))failedBlock
{
    NSMutableArray *entryList = [NSMutableArray arrayWithCapacity:6];
    
    RACSignal *recomand = [VCHTTPClient GET_requestWithPath:urlHomeRecommandList paramaters:nil];
    RACSignal *tv = [VCHTTPClient GET_requestWithPath:urlHomeTVList paramaters:nil];
    RACSignal *Movie = [VCHTTPClient GET_requestWithPath:urlHomeMovieList paramaters:nil];
    RACSignal *Cartoon = [VCHTTPClient GET_requestWithPath:urlHomeCartoonList paramaters:nil];
    RACSignal *zongYi = [VCHTTPClient GET_requestWithPath:urlHomeZongyiList paramaters:nil];
    RACSignal *Edu = [VCHTTPClient GET_requestWithPath:urlHomeEduList paramaters:nil];
    
    NSArray *requestArr = @[recomand,tv,Movie,Cartoon,zongYi,Edu];
    RACSignal *total = requestArr.rac_sequence.signal;
    [total subscribeNext:^(RACSignal *signal) {
        [signal subscribeNext:^(NSDictionary *response) {
            NSNumber *catagoryNum = [response allKeys][0];
            NSString *classString = catagoryNum.integerValue != 1?@"VCHomeEntry":@"VCRecommandEntry";
            NSArray *entrys = [[response allValues] objectAtIndex:0];
            
            [entryList addObject:@{catagoryNum:[MTLJSONAdapter
                                 modelsOfClass:NSClassFromString(classString)
                                 fromJSONArray:entrys
                                                error:nil]}];
        } completed:^{
            NSLog(@"response allkeys");
            if (entryList.count == requestArr.count) {
//                NSLog(@"entry list is %@",entryList);
                finishedBlock(entryList);
            }
        }];

    } error:^(NSError *error) {
        failedBlock(error);
    }];
}

@end
