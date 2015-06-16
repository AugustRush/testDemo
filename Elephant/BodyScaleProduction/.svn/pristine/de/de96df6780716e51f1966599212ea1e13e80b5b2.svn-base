//
//  AliPayPlusModel.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-6-9.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlixLibService.h"
#import "AlixPayOrder.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "DataVerifier.h"
#import "AlixPayResult.h"

@interface AliPayPlusModel : NSObject


@property(nonatomic,weak)id target;
@property(nonatomic)SEL callback;

+ (instancetype)sharedInstance;
-(void)pay:(NSDictionary *)dic;

@end
