//
//  CONSTS.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-18.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#ifndef BodyScaleProduction_CONSTS_h
#define BodyScaleProduction_CONSTS_h



////#warning 外网IP
//#define SERVICE_URL                 @"http://api.ichronocloud.com"
//#define BASE_URL                    @"http://api.ichronocloud.com"      //这里填写base url
//#define kJingDongLongin_URL         @"http://60.191.203.41/api/login.htm" //我方服务器第三方登陆URL
////获取订单信息接口
//#define kGetOrderInfo_URL           @"http://store.rysmart.com/shop/external!saveOrder.action"
////获取商品信息URL（生产环境）
//#define kGetProductInfo_URL         @"http://store.rysmart.com/shop/external!getProductList.action"
//#define kGetTradeInfo_URL           @"http://store.rysmart.com/shop/external!orderDetail.action"
////#服务器异步通知页面路径
//#define kALiNotifyUrl               @"http://store.rysmart.com/shop/alipay_notify!appAlipayNotify.action"
//#define kALiProdutImgHeadUrl        @"http://static.ichronocloud.com/shopcc-jt/template/shop/images/Pic/"


#warning 内网IP
#define DOMAIN_URL        @"http://192.168.5.11/inf"
#define BASE_URL          @"http://192.168.5.11/inf"
#define SERVICE_URL       @"http://192.168.5.11"              // 这里填写base url

#define kJingDongLongin_URL @"http://192.168.5.11/api/login.htm" //我方服务器第三方登陆URL
//获取订单信息接口
#define kGetOrderInfo_URL   @"http://demo.ichronocloud.com/shop/external!saveOrder.action"
//获取商品信息URL（测试环境）
#define kGetProductInfo_URL @"http://demo.ichronocloud.com/shop/external!getProductList.action"
#define kGetTradeInfo_URL   @"http://demo.ichronocloud.com/shop/external!orderDetail.action"
//#服务器异步通知页面路径
#define kALiNotifyUrl       @"http://demo.ichronocloud.com/shop/alipay_notify!appAlipayNotify.action"

#define kALiProdutImgHeadUrl       @"http://demo.ichronocloud.com/static/shopcc-jt/template/shop/images/Pic/"

#define BodyScaleRegister_URL                     @"registerBodyscale.htm"          //体脂仪用户注册
#define BodyScaleSendValidCode_URL                @"sendValidCode.htm"              //发送验证码
#define BodyScaleLogin_URL                        @"login.htm"                      //登录
#define BodyScaleLogout_URL                       @"user/logout.htm"                //登出
#define BodyScaleQueryLoginData_URL               @"bodyscale/queryLoginData.htm"   //查询登录数据
#define BodyScaleSubmitMeasurementData_URL        @"bodyscale/submitData.htm"       //提交体脂仪测量数据
#define BodyScaleQueryMeasurementData_URL         @"bodyscale/queryData.htm"        //查询测量数据
#define BodyScaleQueryLatestMeasurementData_URL   @"bodyscale/queryLatestData.htm"  //查询测量数据—按索引
#define BodyScaleSetting_URL                      @"bodyscale/setting.htm"          //用户设置
#define BodyScaleQuerySetting_URL                 @"bodyscale/querySetting.htm"     //查询用户设置
#define BodyScaleModifyPassword_URL               @"user/modifyPwd.htm"             //修改密码
#define BodyScaleSubmitSuggest_URL                @"bodyscale/submitSuggest.htm"    //用户建议
#define BodyScaleQuerySuggest_URL                 @"bodyscale/querySuggest.htm"     //查询建议及回复
#define BodyScaleSubmitDimensionalCode            @"submitDimensionalCode.htm"      //提交二维码数据
#define BodyScaleUpdateUserInformation_URL        @"user/updateMemberInfo.htm"      //更新用户基本信息
#define BodyScaleQueryDimensionalCode_URL         @"queryDimensionalCode.htm"       //查询二维码是否存在
#define BodyScaleUploadData_URL                   @"uploadFile.htm"                 //上传文件
#define BodyScaleQueryDevCode_URL                 @"bodyscale/queryDevCode.htm"     //获取体脂仪设备编号
#define BodyScaleSubmitBatchData_URL              @"bodyscale/submitBatchData.htm"  //批量提交测量数据
#define BodyScaleSubmitBind_URL                   @"bodyscale/submitBind.htm"       //体脂仪用户绑定
#define BodyScaleCancelBind_URL                   @"bodyscale/cancelBind.htm"       //体脂仪用户解除绑定
#define BodyScaleQueryNotice_URL                  @"bodyscale/queryNotice.htm"      //查询时间提示信息
#define BodyScaleResetPwd_URL                     @"resetPwd.htm"                   //重置密码
#define BodyScaleQueryFocusData_URL               @"bodyscale/queryFocusData.htm"   //查询好友信息

#define BodyScaleAddFocus_URL                     @"user/addFocus.htm"              //加关注(添加好友)
#define BodyScaleMRightFocus_URL                  @"user/mRightFocus.htm"           //关注授权/取消授权
#define BodyScaleSubmitPraise_URL                 @"bodyscale/submitPraise.htm"     //用户赞/激励
#define BodyScaleQueryPraise_URL                  @"bodyscale/queryPraise.htm"      //查询赞激励
#define BodyScaleMyMsgCounts_URL                  @"user/myMsgCounts.htm"           //查询用户新信息(谁请求加我好友)
#define BodyScaleDeleteFoucus_URL                 @"user/deleteFocus.htm"           //删除关注人
#define BodyScaleAgreeFoucus_URL                  @"user/agreeFocus.htm"            //同意或拒绝他人关注
#define BodyScaleFocusMeSetRead_URL               @"user/focusMeSetRead.htm"        //将关注我的信息置成已读
#define BodyScaleFocusMeList_URL                  @"user/focusMeList.htm"           //关注我的用户列表
#define BodyScaleDelFocusMsg_URL                  @"user/delFocusMsg.htm"           //删除关注人新信息
#define BodyScaleDeleteData_URL                   @"bodyscale/deleteData.htm"       //删除单条测量数据息
#define BodyScaleCheckCodeInvalid_URL             @"checkCodeInvalid.htm"           //验证验证码是否正确,用户是否已注册
#define BodyScaleGetDevColor_URL                  @"getDevColor.htm"                //获取体脂仪设备颜色
#define BodyScaleCheckLoginName_URL               @"checkLoginName.htm"             //验证验用户名是否已注册


//社会化分享
typedef enum
{
    sinaWeibo,
    weChat,
    weChatFriend,
    QQZone
}ShareType;

#define kSinaAppKey             @"2392945173"
#define kSinaSecret             @"576788741e4b1c32f879031bf71acd88"
#define kSinaRedirectURI        @"https://api.weibo.com/oauth2/default.html"


#define kGetAlipayNotificationName  @"getAliyPayCallback"
#define kAlipayNotificationName     @"aliyPayCallback"
#define kAlipayOpenUrlName          @"aliyPay19841111"
#define kJingDongAppKey             @"6802AAAAFCFF89718A455FB6FB362DC1"
#define kJingDongAppSecret          @"dfeb9f85fc7c40c5b8e76d40b10e1e2f"
#define kJingDongAppRedirect_URL    @"http://yunsmart.com"                    //京东重定向URL
#define kJingDongProductDataType    @"body_fat"                               //京东产品函数类型
#define kJingDongProductId          @"72"                                     //京东产品id
#define kJingDongProductSecret      @"YbtYKdt40SYtSxb4N57AeU6bcyKyMkHu3QOrXfFTcx2iPVql"  //京东产品密钥
#define kJingDongMethod             @"jingdong.cloud.smart.health"            //京东子函数名
#define kJingDongProduct_Url        @"http://gw.api.360buy.com/routerjson"    //京东上传数据url




#define kWeChatAppId            @"wx8ad04d9c3bb6e62e"
#define kWeChatAppKey           @"19075bad61017911d861a977f58706f6"

#define kQQZoneAppId            @"1101345833"
#define kQQZoneAppKey           @"RMeWpswI1oGHhGn0"

#define AccessTokenKey          @"WeiBoAccessToken"
#define ExpirationDateKey       @"WeiBoExpirationDate"
#define ExpireTimeKey           @"WeiBoExpireTime"
#define UserIDKey               @"WeiBoUserID"
#define OpenIdKey               @"WeiBoOpenId"
#define OpenKeyKey              @"WeiBoOpenKey"
#define RefreshTokenKey         @"WeiBoRefreshToken"
#define NameKey                 @"WeiBoName"
#define SSOAuthKey              @"WeiBoIsSSOAuth"


// Flurry统计
#define RYFIT_FLURRY_APP_KEY                      @"XFYBBZ3KCHFJC8SNJCNX"
#define APP_SYSTEM_VERSION                        @"APP_SYSTEM_VERSION"             // 系统版本统计
#define USER_SIGN_UP_EVENT                        @"USER_SIGN_UP_EVENT"             // 用户注册统计
#define USER_LOG_IN_EVENT                         @"USER_LOG_IN_EVENT"              // 用户登录统计
#define USER_LOG_OUT_EVENT                        @"USER_LOG_OUT_EVENT"             // 用户退出登录统计
#define AGREE_ADD_FRIEND_EVENT                    @"AGREE_ADD_FRIEND_EVENT"         // 同意添加好友统计
#define IGNORE_ADD_FRIEND_EVENT                   @"IGNORE_ADD_FRIEND_EVENT"        // 忽略（删除）添加好友统计
#define LIKE_ME_EVENT                             @"LIKE_ME_EVENT"                  // 点赞统计
#define NOTIFY_WEIGHT_EVENT                       @"NOTIFY_WEIGHT_EVENT"            // 提醒称重统计
#define START_WEIGHTING_EVENT                     @"START_WEIGHTING_EVENT"          // 开始称重统计

#endif
