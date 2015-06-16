//
//  MatchNetConfig.h
//  MatchNet
//
//  Created by  on 12-9-21.
//  Copyright (c) 2012年 FFLtd. All rights reserved.

//----------------------------------------------------------------------------------------------


//1、网络环境切换

 // #define kPreTest        1
//#define kSitTest        1
#define kDevTest        1
//#define kReleaseH       1

//----------------------------------------------------------------------------------------------

//2、信息搜集服务器切换
//#define kPreInfoTest        1
  #define kSitInfoTest        1
//#define kReleaseInfoH       1

//3.友盟统计环境切换(测试环境／生产环境)
  #define kUMNG_TEST        1
//#define kUMNG_RELEASE     1

//4.配置更新渠道
 #define kItunesAppLink                           @"http://itunes.apple.com/cn/app/id424598114?l=en&mt=8"

//----------------------------------------------------------------------------------------------
#define DEBUGLOG
#ifdef DEBUGLOG
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#       define DLog(...)
#endif

//----------------------------------------------------------------------------------------------
/*3、打印开关控制*/

//----------------------------------------------------------------------------------------------


/*4、数据收集开关控制*/
#define DEBUG_COLLECT_DATA 1

//----------------------------------------------------------------------------------------------
//5、下载渠道切换
#pragma mark -
#pragma mark 下载渠道

#define kDownloadChannelAppStore                @"app store"
#define kDownloadChannel91Helper                @"http://zs.91.com/"
#define kDownloadChannelMatchNetAppStore        @"MatchNet App Store"
#define kDownloadChannelBeijingYiXun            @"BeiJingYiXun"
#define kDownloadChannelWeiFeng                 @"WeiFeng"
#define kDownloadChannelTongBuTui               @"TongBuTui"
#define kDownloadChannelPPHelper                @"PPHelper"
#define kDownloadChannelPaoJiao                 @"PaoJiao"
#define kDownloadChannelTaiPingYang             @"TaiPingYang"
#define kDownloadChannelCanDou                  @"CanDou"
#define kDownloadChannelSoHu                    @"SoHu"

#define kDownloadChannel                        kDownloadChannelAppStore

//----------------------------------------------------------------------------------------------

