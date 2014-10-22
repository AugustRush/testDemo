//
//  SqliteUtils.h
//  SqliteManager
//
//  Created by August on 14/10/19.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_INLINE NSString *test1(NSString *a){
    return a;
};

@interface SqliteUtils : NSObject

NSString *dbClummn(NSString*name, NSString *type);

@end