//
//  HTTPFileDownLoadOperation.h
//  HTTPFileManager
//
//  Created by August on 14/10/22.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTTPFileDownLoadOperation : NSOperation<NSURLConnectionDataDelegate>
{
@private
    NSURLConnection *_URLConnection;
    NSMutableData *_recieveData;
    NSURLResponse *_URLResponse;
}

-(NSURLConnection *)creatNewDownloadTask;

@end
