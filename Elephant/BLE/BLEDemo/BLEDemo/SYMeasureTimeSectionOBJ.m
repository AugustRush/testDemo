//
//  SYMeasureTimeSectionOBJ.m
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-20.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYMeasureTimeSectionOBJ.h"

@implementation SYMeasureTimeSectionOBJ

-(void)calculateEndTime
{
    _endTime = _startTime + _measureTimes*_measureFrequecy/60 + 1;
}

@end
