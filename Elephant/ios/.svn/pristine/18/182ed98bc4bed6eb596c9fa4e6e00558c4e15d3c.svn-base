//
//  BHServiceDataCentre.h
//  BLHealth
//
//  Created by lyywhg on 14-5-22.
//  Copyright (c) 2014年 BLHealth. All rights reserved.
//
//  新服务请求类


#import "DataService.h"

#if NS_BLOCKS_AVAILABLE
typedef void (^BHServiceDataCentreBlock)(BOOL, NSDictionary *, NSArray *, NSInteger);
#endif

@interface BHServiceDataCentre : DataService

@property (nonatomic, retain) NSDictionary *reqDict;

+ (BHServiceDataCentre *)sharedInstance;

- (void)cancelServiceRequest:(UIViewController*)vc;
- (void)cancelServiceRequest;

- (void)multifileUploadRequestWithByDict:(NSDictionary *)serviceDict
                            WithFileList:(NSArray*)fileList
                              controller:(NeedInheritViewController *)viewController type:(NSInteger)type
                      serviceAnswerBlock:(BHServiceDataCentreBlock)block;

- (void)blHealthRequestStop;

/*
 上传图片
 
 fileList是个数组，其中每个文件是个字典型（文件data 文件名，文件类型，以及所有文件的key）
 [request addData:dict[@"data"] withFileName:dict[@"name"] andContentType:dict[@"type"] forKey:dict[@"key"]];
 
 */
@end
