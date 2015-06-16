//
//  SYMeasureTimeSectionOBJ.h
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-20.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYMeasureTimeSectionOBJ : NSObject

@property (nonatomic, assign) NSInteger startTime;
@property (nonatomic, assign) NSInteger measureFrequecy;
@property (nonatomic, assign) NSInteger measureTimes;
@property (nonatomic, assign, readonly) NSInteger endTime;

-(void)calculateEndTime;

@end
