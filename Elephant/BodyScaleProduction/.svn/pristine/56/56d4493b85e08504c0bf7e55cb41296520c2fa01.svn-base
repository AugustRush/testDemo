//
//  JDPlusModel.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-5-28.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDDataEntity.h"
#import "JDUserInfoEntity.h"
#import "UserDataEntity.h"
#import "JD_JOS_SDK.h"

/**
 *  登录回调函数
 *
 *  @param isSuccess  是否登录成功
 *  @param jdUserInfo 登陆成功后，JDUserInfo对象；不成功，为nil
 */
typedef void(^JDLoginCallBack)(BOOL isSuccess, JDUserInfo *jdUserInfo);


/**
 *  登录回调函数
 *
 *  @param isSuccess  是否登录成功
 *  @param errMsg 登陆不成功后，错误信息；成功，为nil
 */
//typedef void(^JDUploadCallBack)(BOOL isSuccess, NSString *errMsg);

@interface JDPlusModel : NSObject





/**
 *  京东登录
 *
 *  @param appKey        appKey
 *  @param appSecret     appSecret
 *  @param appRDURL      重定向url
 *  @param color         导航栏颜色
 *  @param navController 导航视图控制器
 *  @param callback      回调函数
 */
+(void)loginWithAppKey:(NSString *)appKey
             appSecret:(NSString *)appSecret
        appRedirectUrl:(NSString *)appRDURL
           navBarColor:(UIColor *)color
   targetNavController:(UIViewController *)navController
              callback:(JDLoginCallBack)callback;

/**
 *  京东上传数据
 *
 *  @param data 数据对象
 *  @param user 用户信息
 */
+(NSString *)uploadData:(JDDataEntity *)data
                   user:(JDUserInfoEntity *)user;


/**
 *  将data转换为JDdata
 *
 *  @param data UserDataEntity
 *
 *  @return JDData
 */
+(JDDataEntity *)transDataToJDData:(UserDataEntity *)data;

@end
