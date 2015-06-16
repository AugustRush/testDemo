//
//  HTTPBaseModel.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-18.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTPBaseModelDelegate <NSObject>

@optional

- (void)responseCode:(int)code actionId:(int)actionId info:(id)info requestInfo:(id)requestInfo;

@end

@interface HTTPBaseModel : NSObject

@property (nonatomic, weak)id<HTTPBaseModelDelegate> delegate;

- (id)initWithDelegate:(id<HTTPBaseModelDelegate>)delegate;
- (NSMutableDictionary *)getPublicParamWithDateString:(NSString *)dateString;
- (NSString *)currentDateString;

@end


