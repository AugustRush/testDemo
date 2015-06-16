//
//  DataService.m
//  BLHealth
//
//  Created by lyywhg on 13-3-26.
//  Copyright (c) 2013年 lyywhg. All rights reserved.
//

#import "DataService.h"

@implementation DataService


- (void)dealloc
{
    _errorCode = nil;
    [_errorMsg release];
    [super dealloc];
}

- (NSString *)errorMsgOfRequestError:(NSError *)error
{
    ASINetworkErrorType errorCode = error.code;
    
    NSString *errorMsg = nil;
    
    switch (errorCode)
    {
        case ASIConnectionFailureErrorType:
        {
            //连接失败
            errorMsg = L(@"A connection failure occurred");
            
            break;
        }
        case ASIRequestTimedOutErrorType:
        {
            //请求超时
            errorMsg = L(@"The request timed out");
            
            break;
        }
        case ASIAuthenticationErrorType:
        {
            //认证失败
            errorMsg = L(@"Authentication needed");
            
            break;
        }
        case ASIRequestCancelledErrorType:
        {
            //请求被取消
            errorMsg = L(@"The request was cancelled");
            
            break;
        }
        case ASIUnableToCreateRequestErrorType:
        {
            //url不合法，无法创建网络请求
            errorMsg = L(@"Unable to create request (bad url?)");
            
            break;
        }
        case ASIInternalErrorWhileBuildingRequestType:
        {
            //无法连接代理服务器
            errorMsg =  L(@"Unable to obtain information on proxy servers needed for request");
            
            break;
        }
        case ASIInternalErrorWhileApplyingCredentialsType:
        {
            //无法获取认证信息
            errorMsg = L(@"Failed to get authentication object from response headers");
            
            break;
        }
        case ASIFileManagementError:
        {
            DLog(@"%@",[[error userInfo] objectForKey:NSLocalizedDescriptionKey]);
            //文件操作有误
            errorMsg = L(@"Fail to handle file operation");;
            
            break;
        }
        case ASITooMuchRedirectionErrorType:
        {
            //重定向次数过多
            errorMsg = @"The request failed because it redirected too many times";
            
            break;
        }
        case ASICompressionError:
        {
            //数据解压失败
            errorMsg = @"Compression data failed";
            
            break;
        }
        default:
        {
            //发生未知错误
            errorMsg = @"Unknown exception";
            
            break;
        }
    }
    
    return L(errorMsg);
}

- (BOOL)isResponseSuccess:(NSDictionary *)items RequestCmd:(NSInteger)cmdCode
{
    //解析状态信息，返回response的状态。
    
    //pan_safeboxOpt_0001_s : SNRetCode的格式
    NSString *SNRetCode = [items objectForKey:@"SNRetCode"];
    
    BOOL isSessionFailed = YES;//[ErrorAnalyzeUtil isSessionFailed:SNRetCode];
    if (isSessionFailed)
    {
        return NO;
    }
    
    NSString *isSuccess = @"e";
    NSString *SNRetMsg = [items objectForKey:@"SNRetMsg"];
    self.errorMsg = SNRetMsg;
    
    if (IsStrEmpty(SNRetCode))
    {
        isSuccess = @"e";
        self.errorMsg = L(@"服务器异常，请稍后重试");
    }else{
        NSArray *temparr = [SNRetCode componentsSeparatedByString:@"_"];
        if (!IsArrEmpty(temparr))
        {
            isSuccess = (NSString *)[temparr lastObject];
            if ([temparr count]>3)
            {
                self.errorCode = [temparr objectAtIndex:2];
            }
        }
        else
        {
            isSuccess = @"e";
        }
    }
    if ([isSuccess isEqualToString:@"s"])
    {
        return YES;
    }
    else
    {
        if (IsStrEmpty(self.errorCode))
        {
            self.errorMsg = L(@"服务器异常，请稍后重试");
        }
        else
        {
            self.errorMsg = L(@"服务器异常，请稍后重试");//[ErrorAnalyzeUtil getErrorMsg:cmdCode errorCode:[self.errorCode intValue]];
        }
        return NO;
    }
}

- (id)dataInfoOfResponse:(NSDictionary *)items
{
    if ([items isKindOfClass:[NSDictionary class]])
    {
        id data = [items objectForKey:@"data"];
        return data;
    }
    else
    {
        return nil;
    }
}

@end
