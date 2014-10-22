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

        _recieveData = [NSMutableData data];
        self.downTaskThread = [[NSThread alloc] initWithTarget:self selector:@selector(startDownloadRunloop:) object:nil];
        [self.downTaskThread start];
        
        NSString *urlString1 = @"http://uptestdata.imoffice.cn:5186/mfs/audio/DownloadFileImg.php?Cid=99813&Uid=2050281&Fid=b3103d2758e499831d24c6651dd9718e";
            NSURL *URL = [NSURL URLWithString:@"http://uptestdata.imoffice.cn:5186/mfs/ChatPic/DownloadFileImg.php?Cid=99813&Uid=2050281&Fid=ae2a717f30c07af139d7882a8b555128"];
        if (arc4random()%2) {
            URL = [NSURL URLWithString:urlString1];
        }
            NSURLRequest *URLReuqest = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:URLReuqest delegate:self startImmediately:NO];
        [connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [connection start];

    }
    return self;
}

-(void)startDownloadRunloop:(id)__unused object
{
    @autoreleasepool {
        [[NSThread currentThread] setName:@"_downloadThread"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }

}

#pragma mark - NSURLConnectionDelegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.URLReponse = response;
    NSLog(@"response is %lld %@",response.expectedContentLength,response.MIMEType);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_recieveData appendData:data];
    NSLog(@"bbbb progress is %f",_recieveData.length*1.0/self.URLReponse.expectedContentLength);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"cccc");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"dddd");
    UIImage *image = [[UIImage alloc] initWithData:_recieveData];
    if (image != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"testImage" object:image];
        });
    }
}

-(void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}

@end
