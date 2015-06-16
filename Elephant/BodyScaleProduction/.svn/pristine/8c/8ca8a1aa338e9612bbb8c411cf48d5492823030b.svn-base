//
//  DBHelper.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FMDatabase;

@interface DBHelper : NSObject
{
    FMDatabase          *_dataBase;
}

- (FMDatabase *)getDatabase;
- (void) connect:(NSString *)path;
- (void) close;

-(void)beginTransaction;
-(void)rollback;
-(void)commitTransaction;

@end
