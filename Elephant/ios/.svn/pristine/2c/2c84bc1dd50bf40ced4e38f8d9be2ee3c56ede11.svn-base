//
//  DatabaseManager.h
//  DZB
//
//  Created by 两元鱼 on 10-10-31.
//  Copyright 2010 FFLtd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabaseQueue;
@interface DatabaseManager : NSObject 
{
	BOOL _isInitializeSuccess;
    
	BOOL _isDataBaseOpened;
	
	NSString *_writablePath;
    
    FMDatabaseQueue *_databaseQueue;
}

@property (nonatomic, strong) NSString *writablePath;

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

+ (DatabaseManager*)currentManager;

- (BOOL)isDatabaseOpened;

- (void)openDataBase;

- (void)closeDataBase;


+ (void)releaseManager;


@end
