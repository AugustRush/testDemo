//
//  BHServiceDataCentre.m
//  BLHealth
//
//  Created by lyywhg on 14-5-22.
//  Copyright (c) 2014年 BLHealth. All rights reserved.
//

#import "BHServiceDataCentre.h"
#import "Reachability.h"
#import "ASIHTTPRequest.h"
#import "SNCHTTPRequest.h"
#import "JSONKit.h"


@interface BHServiceDataCentre()

@property (nonatomic, retain) ASIHTTPRequest *createHttpRequest;
@property (nonatomic, copy) NSString *localDataPath;
@property (nonatomic, assign) BOOL haveLocalData;

@end

@implementation BHServiceDataCentre
static BHServiceDataCentre *sharedObj = nil;

#pragma mark
#pragma mark - Init & Dealloc
+ (BHServiceDataCentre *)sharedInstance
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        sharedObj = [[super allocWithZone:NULL] init];
    });
    return sharedObj;
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
- (id)init
{
    @synchronized(self)
    {
        self = [super init];
        return self;
    }
}
- (void)dealloc
{
    HTTP_RELEASE_SAFELY(_createHttpRequest);
    [super dealloc];
}
#pragma mark
#pragma mark - Init & Add
#pragma mark
#pragma mark - Other Action
- (void)cancelServiceRequest
{
    [self blHealthRequestStop];
}

- (void)cancelServiceRequest:(UIViewController*)vc
{
    // cancel Action
}
/*
 *
 *        ToDo  Dictionary
 *
 */

- (void)multifileUploadRequestWithByDict:(NSDictionary *)serviceDict
                            WithFileList:(NSArray*)fileList
                              controller:(NeedInheritViewController *)viewController type:(NSInteger)type
                      serviceAnswerBlock:(BHServiceDataCentreBlock)block

{
    __block BHServiceDataCentreBlock tBlock = [block copy];
    
    //    viewController.tableView.alpha = 0.0f;
    
    if ([viewController respondsToSelector:@selector(displayOverFlowActivityView)])
    {
        [viewController displayOverFlowActivityView];
    }
    NSString *cloudSyncServer = [NSString stringWithFormat:@"http://bodyscale.cookst.com/api/server.php?ac=avatar"];
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@",cloudSyncServer];
    DLog(@"url:%@",urlString);
    self.createHttpRequest = [SNCHTTPRequest multifileUploadRequestWithURL:urlString andPostData:serviceDict fileData:fileList failedBlock:^(NSString *errorCode, NSString *errorMsg){
        
        DLog(@"fail");
        tBlock(NO, nil, nil, 0);

    } completionBlock:^(id jsonString) {
        
        DLog(@"OK");
        tBlock(YES, [jsonString objectFromJSONString], nil, 0);

    }];
}

- (void)blHealthRequestStop
{
    [self.createHttpRequest cancel];
}
- (BOOL)isHaveHealthLocalData:(NSString *)localPathString
{
    NSString *path = [NSString stringWithFormat:@"%@", localPathString];
    self.localDataPath = [path copy];
    BOOL dir = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&dir])
    {
        _haveLocalData = NO;
    }
    else
    {
        _haveLocalData = YES;
    }
    return _haveLocalData;
}

@end