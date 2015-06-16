//
//  DAO.m
//  BodyScale
//
//  Created by 两元鱼 on 12/6/11.
//  Copyright (c) 2011 FFLtd. All rights reserved.
//

#import "DAO.h"
#import "DatabaseManager.h"

@implementation DAO

@synthesize databaseQueue = _databaseQueue;

- (id)init{ 
    self = [super init];
    
	if(self)
    {
		self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
	}
    
	return self;
}

- (void)dealloc
{
}

- (FMDatabaseQueue *)databaseQueue
{
    if (![[DatabaseManager currentManager] isDatabaseOpened]) {
        [[DatabaseManager currentManager] openDataBase];
        self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
        if (_databaseQueue)  [DAO createTablesNeeded];
    }
    return _databaseQueue;
}

+ (void)createTablesNeeded
{    
    @autoreleasepool
    {
        FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
        
        [databaseQueue inDatabase:^(FMDatabase *database){
            
            NSString *UserInfoListTB_CREATE_Sql = [NSString stringWithFormat:@"create table if not exists %@(%@ text not null, %@ text not null, %@ text not null, %@ text not null, %@ text not null, %@ text not null, %@ text not null, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text,  %@ text, %@ text, %@ text, %@ text, %@ text, primary key(%@, %@))", kUserInfoList_Table, kUserInfoType, kUserInfoSuperId, kUserInfoId, kUserInfoNickName, kUserInfoSex, kUserInfoPhone, kUserInfoEmail, kUserInfoRealName, kUserInfoHeader, kUserInfoAge, kUserInfoHeight, kUserInfoLastTime, kUserInfoDefault13, kUserInfoDefault14, kUserInfoDefault15, kUserInfoDefault16, kUserInfoDefault17, kUserInfoDefault18, kUserInfoDefault19, kUserInfoDefault20, kUserInfoDefault21, kUserInfoSuperId, kUserInfoId];

            //执行sql
            BOOL isUserInfoListTBCreateSuccess = [database executeUpdate:UserInfoListTB_CREATE_Sql];
            if (!isUserInfoListTBCreateSuccess)
            {
                DLog(@"errorCode==%d:%@",[database lastErrorCode], [database lastErrorMessage]);
            }
        }];
    }
}

@end