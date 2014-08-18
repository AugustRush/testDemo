//
//  QWHTTPErrorDefine.h
//  Test AFNetwork
//
//  Created by August on 14-8-18.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#ifndef Test_AFNetwork_QWHTTPErrorDefine_h
#define Test_AFNetwork_QWHTTPErrorDefine_h

typedef NS_ENUM(NSUInteger, QWHTTPErrorCode) {
    302,
    404,
    502,
    10000,
    10001
};


const NSString *QWHTTPErrorMessages[] = {
    [302] = @"跳转";
    [404] = @"服务器链接异常";
};


#endif
