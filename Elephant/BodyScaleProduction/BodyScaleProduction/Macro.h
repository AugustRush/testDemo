//
//  Macro.h
//  BodyScaleProduction
//
//  Created by Cloud_Ding on 14-3-20.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#ifndef BodyScaleProduction_Macro_h
#define BodyScaleProduction_Macro_h

typedef NS_ENUM(NSInteger, RFGender) {
    RFGenderFemales = 0,
    RFGenderMales   = 1
};


//第三方登陆健康云服务器 相关参数
#define ThirdSide_PlatformKey           @"platform"         //平台代码 平台-(1:PC 2:IOS 3:ANDROID 4:WP)
#define ThirdSide_MerchantCodeKey       @"merchantCode"     //商户号
#define ThirdSide_BusinessCodeKey       @"businessCode"     //业务代码,详情见各接口定义
#define ThirdSide_RequestTimeKey        @"requestTime"      //请求时间 yyyyMMddHHmmss
#define ThirdSide_ContentKey            @"content"

#define ThirdSide_key                   @"894D94361A243577F0A497C4EAB6462A178900022D1D95B2EAE04" //key 0.o
#define ThirdSide_PlatformStr           @"2"                //ios平台
#define ThirdSide_MerchantCodeStr       @"888888888888"     //目前随便填
#define ThirdSide_Login_BusinessCode    @"100001"           //登陆 业务代码
#define ThirdSide_REQUEST_SUCCESS_CODE  000000              //第三方请求成功码

//判断是否为第一次登录

#define AppNotIsFirstEnter                 @"appNotIsFirstEnter"
#define APPISNotFirstEnter                 @"APPISNotFirstEnter"

//更新提示
#define APP_URL  @"http://itunes.apple.com/lookup?id=858357581"
#define trackView_URL   @"https://itunes.apple.com/cn/app/ryfit/id858357581?mt=8"
#define kRyFitCurrentVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]

//判断是否为iPad
#define BodyScaleCurrentDeviceIsIpad  [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
//判断系统版本
#define kIsiOS_7                            [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f
//设备类型
#define BodyScaleDeviceType                  @"deviceType"
#define BodyScaleDeviceTypeValue             @"2"    // 0:电脑;1:anroid;2:iphone;3:ipad;

#define kIsiPhone5                          ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && [[UIScreen mainScreen] bounds].size.height == 568.0)

//设备imie或是设备系列号
//TODO:唯一设备编号
#define BodyScaleDeviceCode                  @"deviceCode"
#define BodyScaleDeviceCodeValue             @"AAAAAAAAA"
#define BodyScaleDeviceIDKey                 @"SYChronoID"
//客户端版本名称
#define BodyScaleAppVer                      @"appVer"
#define BodyScaleAppVerValue                 [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]]
//请求时间
#define BodyScaleReqTime                     @"reqTime"

//约定串
#define APPOINT_KEY @"894D94361A243577F0A497C4EAB6462A178900022D1D95B2EAE04"

//请求结果
#define REQUEST_SUCCESS_CODE               1
#define REQUEST_FAILURE_CODE                -1000

//请求接口号
#define SEND_VALID_CODE                   3
#define LOGIN_REQUEST_CODE                4
#define LOGOUT_REQUEST_CODE               5
#define MODIFY_PWD_CODE                   6
#define RESET_PWD_CODE                    7

#define ADD_FOCUS_CODE                    17

#define AGREE_FOCUS_CODE                  19

#define FOCUSME_LIST_CODE                 21
#define FOCUSME_SETREAD_CODE              22  
#define DEL_FOCUSMSG_CODE                 23

#define MRIGHT_FOCUS_CODE                 29

#define DELETE_FOCUS_CODE                 31
#define UPDATE_USER_INFO_CODE             32

#define MY_SMG_COUNTS_CODE                34

#define CHECK_LOGINNAME_CODE              40
#define UPLOADFILE_CODE                   41
#define SUBMIT_DIMENSIONAL_CODE           42

#define CHECKCODE_INVALID_CODE            47
#define GET_DEVCOLOR_CODE                 48


#define BASE_BODYSCALE_CODE               63

#define REGISTER_BODY_SCALE_CODE          (BASE_BODYSCALE_CODE + 1)
#define SUBMIT_DATA_CODE                  (BASE_BODYSCALE_CODE + 2)
#define QUERY_DATA_CODE                   (BASE_BODYSCALE_CODE + 3)
#define QUERY_LATEST_DATA_CODE            (BASE_BODYSCALE_CODE + 4)
#define USER_SETTING_CODE                 (BASE_BODYSCALE_CODE + 5)
#define QUERY_SETTING_CODE                (BASE_BODYSCALE_CODE + 6)
#define SUBMIT_SUGGEST_CODE               (BASE_BODYSCALE_CODE + 7)
#define SUBMIT_PRAISE_CODE                (BASE_BODYSCALE_CODE + 8)
#define QUERY_PRAISE_CODE                 (BASE_BODYSCALE_CODE + 9)
#define QUERY_LOGIN_DATA_CODE             (BASE_BODYSCALE_CODE + 10)
#define QUERY_SUGGEST_CODE                (BASE_BODYSCALE_CODE + 11)
#define QUERY_DIMENSIONAL_CODE            (BASE_BODYSCALE_CODE + 12)
#define QUERY_DEV_CODE                    (BASE_BODYSCALE_CODE + 13)
#define SUBMIT_BATCH_DATA_CODE            (BASE_BODYSCALE_CODE + 14)
#define SUBMIT_BIND_CODE                  (BASE_BODYSCALE_CODE + 15)
#define CANCEL_BIND_CODE                  (BASE_BODYSCALE_CODE + 16)
#define QUERY_NOTICE_CODE                 (BASE_BODYSCALE_CODE + 17)
#define QUERY_FOCUS_DATA_CODE             (BASE_BODYSCALE_CODE + 18)
#define DELETE_DATA_CODE                  (BASE_BODYSCALE_CODE + 19)



#define THIRDSIDE_LOGIN_CODE            100001      //第三方登陆业务代码
#define JD_UPLOAD_CODE                  101001      //京东上传代码

#define WX_GET_ACCESSTOKEN_CODE         110001      //微信支付 获取 accessToken
#define WX_GET_PREPAYID_CODE            110002      //微信支付 获取 PrepayI


#define GET_PROUDCTINFO_CODE            200001      //获取商品信息代码
#define GET_ORDERINFO_CODE              200002      //获取订单信息代码

#define kHistoryDataCountPerPage    20              //历史数据分页每页条数


//AQ
#define WEAK_SELF               __weak typeof(self) wself = self
#define STRONG_WEAK_SELF        __strong typeof(wself) sself = wself

// Table View
#define TableViewCellTitleFont   [UIFont systemFontOfSize:16]
#define TableViewCellTitleColor [UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:1]
#define TableViewCellSubtitleColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]

#endif
