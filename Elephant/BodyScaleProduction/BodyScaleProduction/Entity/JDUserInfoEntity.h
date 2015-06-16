//
//  JDUserInfoEntity.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-6-5.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BaseEntity.h"

@interface JDUserInfoEntity : BaseEntity

@property (nonatomic, strong) NSString *userId;//时云用户id

/*!
 @property
 @abstract uid 京东主键
 */
@property (nonatomic, strong) NSString *uid;
/*!
 @property
 @abstract user_nick 京东PIN
 */
@property (nonatomic, strong) NSString *user_nick;
/*!
 @property
 @abstract access_token 授权token
 */
@property (nonatomic, strong) NSString *access_token;
/*!
 @property
 @abstract refresh_token 刷新token
 */
@property (nonatomic, strong) NSString *refresh_token;//刷新token
/*!
 @property
 @abstract expires_in 失效时间（秒）
 */
@property (nonatomic, strong) NSString *expires_in;
/*!
 @property
 @abstract time 在此时间内允许重置token（毫秒）
 */
@property (nonatomic, strong) NSString *time;

@end
