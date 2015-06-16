//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h


/*
#合作身份者ID，以2088开头由16位纯数字组成的字符串
partner=2088211563995681
#商户的私钥
key=l9cg5v6gkei7fxnveca8ap7avz52hp1v
#服务器异步通知页面路径
notifyUrl=http://demo.ichronocloud.com/shop/alipay_notify!alipayNotify.action
#页面跳转同步通知页面路径
returnUrl=http://demo.ichronocloud.com/shop/alipay_return!alipayReturn.action
#卖家支付宝账号
sellerEmail=pay@ichronocloud.com
#订单标题
subject=康诺云商品支付
#调试用 创建txt日志文件夹路径
log_path=D:\\
#字符编码格式  目前支持gbk或utf-8
input_charset=utf-8
#签名方式 不需修改
sign_type=MD5
 */

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088211563995681"
//收款支付宝账号
#define SellerID  @"pay@ichronocloud.com"
//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @""
//商户私钥，自助生成
#define PartnerPrivKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANfUeD7vYVMy0FpgXUpz7ltt2j/Y/RPwsvYm+UnjGBm4tYmkbTkt9cY03vJaC/xxpmUZteabMDQJdBRUrVf1JcwmwP18bzEUXFiXtCWrVaCisTS7Lp4AgTNYxI6eBOSRAENOQ5b/mYpKFWSyyUYa+FsZ9tZZWj3zBlA0pQiAUczFAgMBAAECgYBVDgtRKf8dzYGkjCNXqvY9G76NuNKLYCj2rodBYfhmco9ALgdJKF6Z/M37jhb5JkSfxREVTwUhDLStKm2hox+AalRhfset7KCm6WOUBZEUqzZCJ9XVc8q09OubjbRaWOjRXgSK56YxPmW2NQpJNDu5p1fZTJq21kmKSIbit4lxZQJBAPFSnqKxN2+EiNodCHXvBAVWEHfn8wCQQw+2JItfp+9CFWu5DEQU8hlZK0G9XT+CLCEGQsKiLoeJcxlvpqddSIsCQQDk9O3Z1ug0mj32ex5Ei6anGbA4iAud5iCC7/q/MkQLIHR9kUNaf01v9IJeD1i/+eB6Tr6914ll8/tT39aboJnvAkEAlyYAZjZJWnfQn4x/uB40joMRXYjSExBIcJbM3N7U+G6TrB0DKcFUwbuv9ET/GsAVk7mwJugd7JaSmOPtpfYvcQJAb/jE9ftfNpKUaR3PMLCngSNUBmGqZL9t+PtKQwVfN53Yuqw3J2QIyA7pTvzsZ37Z5JbsO8XUQVMv/9YBi7zgawJBAM3ttNCllehp7CEtvMWSY3FfQyBU5TZfUGKipCbF6kVBYSDf6v4XfJGKquyF0X+iwRZM0ti3SuuNNwACg1wgyqM="


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#endif
