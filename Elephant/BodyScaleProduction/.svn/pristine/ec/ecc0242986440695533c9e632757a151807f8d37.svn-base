//
//  DBHelper.m
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabase.h"



@implementation DBHelper

- (FMDatabase *)getDatabase
{
    return _dataBase;
}
    
-(void)dealloc
{
    //NSLog(@"DBHelper dealloc");
}


/// 连接数据库
- (void) connect:(NSString *)path
{

    NSFileManager * fileManager = [NSFileManager defaultManager];
    [fileManager fileExistsAtPath:path];

	if (!_dataBase) {
        _dataBase = [[FMDatabase alloc] initWithPath:path];
		
	}
    
    if (![_dataBase open]) {
        //NSLog(@"不能打开数据库");
    }
	
}

/// 关闭连接
- (void) close
{
    if (_dataBase) {
        [_dataBase close];
    }
}


-(void)beginTransaction
{
    if (_dataBase) {
        [_dataBase beginTransaction];
    }
}
-(void)rollback
{
    if (_dataBase) {
        [_dataBase rollback];
    }
}
-(void)commitTransaction
{
    if (_dataBase) {
        [_dataBase commit];
    }
}


@end
