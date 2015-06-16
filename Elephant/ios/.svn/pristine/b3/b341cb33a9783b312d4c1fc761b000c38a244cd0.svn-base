//
//  DAO.h
//  BodyScale
//
//  Created by 两元鱼 on 12/6/11.
//  Copyright (c) 2011 FFLtd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"
#import "TableFieldMap.h"

@interface DAO : NSObject {
@protected
    FMDatabaseQueue	*_databaseQueue;
}
       
@end

@interface DAO()

@property (nonatomic,strong) FMDatabaseQueue *databaseQueue;

+ (void)createTablesNeeded;

@end

