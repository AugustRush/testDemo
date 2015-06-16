//
//  SYMeasureHistoryDataOBJ.m
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-20.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYMeasureHistoryDataOBJ.h"

@implementation SYMeasureHistoryDataOBJ

-(void)parseWithString:(NSString *)string
{
    if (string.length == 19) {
        self.measureTime = [string substringToIndex:10];
        self.SBP = [[string substringWithRange:NSMakeRange(10, 3)] floatValue];
        self.DBP = [[string substringWithRange:NSMakeRange(13, 3)] floatValue];
        self.HR = [[string substringWithRange:NSMakeRange(16, 3)] floatValue];
    }
}

-(NSDictionary *)parseToDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[NSString stringWithFormat:@"%.0f",self.SBP] forKey:@"SBP"];
    [dict setValue:[NSString stringWithFormat:@"%.0f",self.DBP] forKey:@"DBP"];
    [dict setValue:[NSString stringWithFormat:@"%.0f",self.HR] forKey:@"HR"];
    if (self.measureTime) {
         [dict setValue:self.measureTime forKey:@"measureTime"];
    }
    return dict;
}

+(SYMeasureHistoryDataOBJ *)parseToOBJWith:(NSDictionary *)dict
{
    SYMeasureHistoryDataOBJ *obj = [[SYMeasureHistoryDataOBJ alloc] init];
    if (dict[@"SBP"]) {
        obj.SBP = [dict[@"SBP"] floatValue];
    }
    if (dict[@"DBP"]) {
        obj.DBP = [dict[@"DBP"] floatValue];
    }
    if (dict[@"HR"]) {
        obj.HR = [dict[@"HR"] floatValue];
    }
    if (dict[@"measureTime"]) {
        obj.measureTime = dict[@"measureTime"];
    }
    return obj;
}

@end
