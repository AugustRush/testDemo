//
//  ShareEngine.h
//  ShareEngineExample
//
//  Created by 陈欢 on 13-10-8.
//  Copyright (c) 2013年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"

@protocol ShareEngineDelegate;

@interface ShareEngine : NSObject<WXApiDelegate,SinaWeiboDelegate, SinaWeiboRequestDelegate>
{
    SinaWeibo           *sinaWeiboEngine;
}
@property (nonatomic, assign) id<ShareEngineDelegate> delegate;

+ (ShareEngine *) sharedInstance;

- (BOOL)handleOpenURL:(NSURL *)url;

- (void)registerApp;

/**
 *@description 判断是否登录
 *@param weibotype:微博类型
 */
- (BOOL)isLogin:(ShareType)weiboType;

/**
 *@description 微博登录
 *@param weibotype:微博类型
 */
- (void)loginWithType:(ShareType)weiboType;

/**
 *@description 退出微博
 *@param weibotype:微博类型
 */
- (void)logOutWithType:(ShareType)weiboType;

/**
 *@description 发送微信消息
 *@param message:文本消息 url:分享链接 weibotype:微信消息类型
 */
//- (void)sendWeChatMessage:(NSString*)message WithUrl:(NSString*)url WithType:(ShareType)weiboType;
- (void)sendWeChatMessageWithType:(ShareType)weiboType sendImage:(UIImage *)sendImage;

/**
 *@description 发送微博成功
 *@param message:文本消息 weibotype:微博类型
 */
- (void)sendShareMessage:(NSString*)message shareImage:(UIImage *)image WithType:(ShareType)weiboType;


@end

/**
 * @description 微博登录及发送微博类容结果的回调
 */
@protocol ShareEngineDelegate <NSObject>
@optional
/**
 *@description 发送微博成功
 *@param weibotype:微博类型
 */
- (void)shareEngineDidLogIn:(ShareType)weibotype;

/**
 *@description 发送微博成功
 *@param weibotype:微博类型
 */
- (void)shareEngineDidLogOut:(ShareType)weibotype;

/**
 *@description 发送微博成功
 */
- (void)shareEngineSendSuccess;

/**
 *@descrition 发送微博失败
 *@param error:失败代码
 */
- (void)shareEngineSendFail:(NSError *)error;
@end
