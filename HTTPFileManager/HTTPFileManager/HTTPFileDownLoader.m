//
//  HTTPFileDownLoader.m
//  HTTPFileManager
//
//  Created by August on 14/10/21.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "HTTPFileDownLoader.h"

@interface HTTPFileDownLoader ()

@property (nonatomic, strong) NSThread *downTaskThread;
@property (nonatomic, strong) NSURLResponse *URLReponse;

@end

@implementation HTTPFileDownLoader

-(instancetype)init
{
    if (self) {

//        _recieveData = [NSMutableData data];
        self.downTaskThread = [[NSThread alloc] initWithTarget:self selector:@selector(startDownloadRunloop:) object:nil];
        [self.downTaskThread start];
        
//        NSString *urlString1 = @"http://uptestdata.imoffice.cn:5186/mfs/audio/DownloadFileImg.php?Cid=99813&Uid=2050281&Fid=b3103d2758e499831d24c6651dd9718e";
//            NSURL *URL = [NSURL URLWithString:@"http://uptestdata.imoffice.cn:5186/mfs/ChatPic/DownloadFileImg.php?Cid=99813&Uid=2050281&Fid=ae2a717f30c07af139d7882a8b555128"];
//        if (arc4random()%2) {
//            URL = [NSURL URLWithString:urlString1];
//        }
//            NSURLRequest *URLReuqest = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
//            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:URLReuqest delegate:self startImmediately:NO];
//        [connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [connection start];

    }
    return self;
}

-(void)startDownloadRunloop:(id)__unused object
{
    @autoreleasepool {
        [[NSThread currentThread] setName:@"_downloadThread"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
//        [runLoop run];
    }

}

-(void)loadImage
{
    HTTPFileDownLoadOperation *opration = [[HTTPFileDownLoadOperation alloc] init];
    NSURLConnection *connect = [opration creatNewDownloadTask];
//    [connect scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [opration performSelector:@selector(creatNewDownloadTask) onThread:self.downTaskThread withObject:nil waitUntilDone:NO];
    [connect start];
}


-(void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}

@end
