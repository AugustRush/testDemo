//
//  HTTPFileDownLoadOperation.h
//  HTTPFileManager
//
//  Created by August on 14/10/22.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPFileDownLoadOperation : NSObject

@property (nonatomic, strong, readonly) NSMutableData *recieveData;

@end
