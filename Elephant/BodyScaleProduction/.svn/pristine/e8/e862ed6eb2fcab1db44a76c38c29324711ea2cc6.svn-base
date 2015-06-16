/*!
 @header JD_JOS_SDK
 @abstract 京东登录授权SDK，联系：yangdaoren@jd.com
 @author Jaguar Yang
 @version v1.0 2014/04/29 Created
 @updated 2014-04-29
 @availability iOS 5.0 and later
 @Copyright 2014 京东 - 云平台 All rights reserved.
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define JD_JOS_SDK_VERSION @"1.01"

@interface JDUserInfo : NSObject
/*!
 @property
 @abstract uid 京东主键
 */
@property (nonatomic, strong, readonly) NSString *uid;
/*!
 @property
 @abstract user_nick 京东PIN
 */
@property (nonatomic, strong, readonly) NSString *user_nick;
/*!
 @property
 @abstract access_token 授权token
 */
@property (nonatomic, strong, readonly) NSString *access_token;
/*!
 @property
 @abstract refresh_token 刷新token
 */
@property (nonatomic, strong, readonly) NSString *refresh_token;//刷新token
/*!
 @property
 @abstract expires_in 失效时间（秒）
 */
@property (nonatomic, assign, readonly) int expires_in;
/*!
 @property
 @abstract time 在此时间内允许重置token（毫秒）
 */
@property (nonatomic, assign, readonly) double time;

@end
/*!
 @Block
 @abstract 回调Block
 @discussion 回调Block
 */
typedef void (^LoginBlock)(JDUserInfo *userInfo);

/*!
 @protocol
 @abstract 京东登录授权SDK协议
 */
@protocol JD_JOS_SDK <NSObject>

/*!
 @method
 @abstract 设置参数
 @discussion 参数名称key见Constants JDAppXXX部分
 @result 无
 */
- (void)SetOption:(NSDictionary *)dictionary;

/*!
 @method
 @abstract 启动
 @discussion 启动
 @result 无
 */
-(void) Login:(UIViewController *) viewController Block:(LoginBlock)block;

@end

/*!
 @class
 @abstract 京东登录授权SDK
 */
@interface JD_JOS_SDK : NSObject<UIWebViewDelegate>

/*!
 @method
 @abstract 单例，所有的调用从这里开始
 @discussion 单例，所有的调用从这里开始，唯一合法入口
 @result id<JD_JOS_SDK>
 */
+ (id<JD_JOS_SDK>) manager;

@end
/*!
 @abstract App Key
 @discussion NSString类型，App Key
 */
FOUNDATION_EXPORT NSString *const JDOptionAppKey;
/*!
 @abstract 密钥
 @discussion NSString类型，密钥
 */
FOUNDATION_EXPORT NSString *const JDOptionAppSecret;
/*!
 @abstract 密钥
 @discussion NSString类型，回调地址
 */
FOUNDATION_EXPORT NSString *const JDOptionAppRedirectUri;
/*!
 @abstract navbar背景色
 @discussion UIColor类型，可选，navbar背景色
 */
FOUNDATION_EXPORT NSString *const JDOptionNavbarColor;
