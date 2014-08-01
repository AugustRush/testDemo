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
//    [[VCHTTPClient GET_requestWithPath:urlHomeZongyiList paramaters:nil] subscribeNext:^(NSDictionary *x) {
//        NSLog(@"x is %@",[[x allValues] objectAtIndex:0]);
//        NSArray *entrys = [[x allValues] objectAtIndex:0];
//        finishedBlock([MTLJSONAdapter modelsOfClass:NSClassFromString(@"VCHomeEntry") fromJSONArray:entrys error:nil]);
//        NSLog(@"23423423 is %@",[MTLJSONAdapter modelsOfClass:NSClassFromString(@"VCHomeEntry") fromJSONArray:entrys error:nil]);
//    }];
    
    NSMutableArray *entryList = [NSMutableArray arrayWithCapacity:6];
    
    RACSignal *recomand = [VCHTTPClient GET_requestWithPath:urlHomeRecommandList paramaters:nil];
    RACSignal *tv = [VCHTTPClient GET_requestWithPath:urlHomeTVList paramaters:nil];
    RACSignal *Movie = [VCHTTPClient GET_requestWithPath:urlHomeMovieList paramaters:nil];
    RACSignal *Cartoon = [VCHTTPClient GET_requestWithPath:urlHomeCartoonList paramaters:nil];
    RACSignal *zongYi = [VCHTTPClient GET_requestWithPath:urlHomeZongyiList paramaters:nil];
    RACSignal *Edu = [VCHTTPClient GET_requestWithPath:urlHomeEduList paramaters:nil];
    
    RACSignal *total = @[recomand,tv,Movie,Cartoon,zongYi,Edu].rac_sequence.signal;
    [total subscribeNext:^(RACSignal *signal) {
        [signal subscribeNext:^(NSDictionary *response) {
            NSArray *entrys = [[response allValues] objectAtIndex:0];
           [entryList addObject:[MTLJSONAdapter
                                 modelsOfClass:NSClassFromString(@"VCHomeEntry")
                                 fromJSONArray:entrys
                                 error:nil]];
        } completed:^{
            if (entryList.count == 6) {
                NSLog(@"entry list is %@",entryList);
                finishedBlock(entryList);
            }
        }];

    } error:^(NSError *error) {
        failedBlock(error);
    }];
}

@end
