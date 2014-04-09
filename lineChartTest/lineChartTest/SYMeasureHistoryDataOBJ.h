//
//  SYMeasureHistoryDataOBJ.h
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-20.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYMeasureHistoryDataOBJ : NSObject

@property (nonatomic, copy) NSString *measureTime;
@property (nonatomic, assign) CGFloat SBP;
@property (nonatomic, assign) CGFloat DBP;
@property (nonatomic, assign) CGFloat HR;

-(void)parseWithString:(NSString *)string;

@end
