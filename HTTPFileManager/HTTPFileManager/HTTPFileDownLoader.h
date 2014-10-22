//
//  HTTPFileDownLoader.h
//  HTTPFileManager
//
//  Created by August on 14/10/21.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPFileDownLoadOperation.h"

@interface HTTPFileDownLoader : NSObject<NSURLConnectionDataDelegate>
//{
//@private
//    NSMutableData *_recieveData;
//}

-(void)loadImage;

@end
