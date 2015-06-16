//
//  UserInfomationModel.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-18.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "UserInfomationModel.h"
#import "HTTPService.h"
#import "Helpers.h"


@interface UserInfomationModel()

{

    
}

@end


@implementation UserInfomationModel



-(int)getRequest:(NSString *)rStr
{
    int _request = 10005;
    if (rStr && ![rStr isKindOfClass:[NSNull class]]) {
        _request = [rStr intValue];
    }
    return _request;
}

- (void)requestRegisterWithloginName:(NSString *)loginName
                            password:(NSString *)password
                            nickName:(NSString *)nickname
                                 sex:(NSString *)sex
                              weight:(NSString *)weight
                              height:(NSString *)height
                                 age:(NSString *)age
                           validCode:(NSString *)validCode
                                mode:(NSString *)mode
                                plan:(NSString *)plan
                              target:(NSString *)target
                             privacy:(NSString *)privacy
                                data:(id)userData
{
    NSString *sign = [[[[[[loginName stringByAppendingString:sex]
                          stringByAppendingString:weight]
                         stringByAppendingString:height]
                        stringByAppendingString:age]
                       stringByAppendingString:validCode]
                      stringByAppendingString:APPOINT_KEY];

    NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
    [param setObject:loginName forKey:@"loginName"];
    [param setObject:[NSString encrypt:password] forKey:@"password"];
    [param setObject:nickname forKey:@"nickName"];
    [param setObject:sex forKey:@"sex"];
    [param setObject:weight forKey:@"weight"];
    [param setObject:height forKey:@"height"];
    [param setObject:age forKey:@"age"];
    [param setObject:validCode forKey:@"validCode"];
    [param setObject:mode forKey:@"mode"];
    [param setObject:plan forKey:@"plan"];
    [param setObject:target forKey:@"target"];
    [param setObject:privacy forKey:@"privacy"];
    [param setObject:[sign md5String] forKey:@"sign"];
    [[HTTPService sharedClient] POST:BodyScaleRegister_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 if ([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]) {

                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     if (userData) {
                                         [param setObject:userData forKey:@"userData"];
                                     }
                                     
                                     [self.delegate responseCode:result
                                                        actionId:REGISTER_BODY_SCALE_CODE
                                                            info:responseObject
                                                     requestInfo:param];

                                 }
                                 NSLog(@"registureSucced%@",responseObject);
                             }failure:^(id task, NSError *error){
                                 int result = REQUEST_FAILURE_CODE;
                                 if (userData) {
                                     [param setObject:userData forKey:@"userData"];
                                 }
                                 [self.delegate responseCode:result
                                                    actionId:REGISTER_BODY_SCALE_CODE 
                                                        info:error
                                                 requestInfo:param];
                                 NSLog(@"failer");
                             }];


}

- (void)requestSendValidCodeWithloginName:(NSString *)loginName validType:(NSString *)validType
{
    NSString *sign = [[loginName stringByAppendingString:validType] stringByAppendingString:APPOINT_KEY];
    NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
    [param setObject:loginName forKey:@"loginName"];
    [param setObject:validType forKey:@"validType"];
    [param setObject:[sign md5String] forKey:@"sign"];
    [[HTTPService sharedClient] POST:BodyScaleSendValidCode_URL
                         parameters:param
                            success:^(id task, id responseObject){
                                if ([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]) {
                                    
                                    int result = [self getRequest:responseObject[@"result"]];
                                    
                                    [self.delegate responseCode:result
                                                       actionId:SEND_VALID_CODE
                                                           info:responseObject
                                                    requestInfo:param];

                                }
                                                                    NSLog(@"yanzheng");

                           }failure:^(id task, NSError *error){
                               int result = REQUEST_FAILURE_CODE;
                               [self.delegate responseCode:result
                                                  actionId:SEND_VALID_CODE
                                                      info:error
                                               requestInfo:param];
                           }];
}

- (void)requestQueryLoginDataWithsessionId:(NSString *)sessionId
                                    userId:(NSString *)userId
                                  userInfo:(id)info
{
    NSString *sign = [sessionId stringByAppendingString:APPOINT_KEY];
    NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
    [param setObject:sessionId forKey:@"sessionId"];
    [param setObject:userId forKey:@"userId"];
    [param setObject:[sign md5String] forKey:@"sign"];
    [[HTTPService sharedClient] POST:BodyScaleQueryLoginData_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     
                                     [param setObject:info forKey:@"userInfo"];
                                     
                                     
                                     [self.delegate responseCode:result
                                                        actionId:QUERY_LOGIN_DATA_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                             }failure:^(id task, NSError *error){
                                 [param setObject:info forKey:@"userInfo"];
                                 NSLog(@"failure");
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:QUERY_LOGIN_DATA_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}

- (void)requestLoginWithloginName:(NSString *)loginName
                         loginPwd:(NSString *)loginPwd
                         userInfo:(NSDictionary *)userInfo
{
    NSString *requestDataString = [self currentDateString];
    NSString *sign = [[loginName stringByAppendingString:requestDataString] stringByAppendingString:APPOINT_KEY];
    NSMutableDictionary *param = [self getPublicParamWithDateString:requestDataString];
    [param setObject:loginName forKey:@"loginName"];
    [param setObject:loginPwd/*[NSString encrypt:loginPwd]*/ forKey:@"loginPwd"];
    [param setObject:[sign md5String] forKey:@"sign"];

    [[HTTPService sharedClient] POST:BodyScaleLogin_URL
                          parameters:param
                             success:^(id task, id responseObject) {
                                 if ([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]) {
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     if (userInfo) {
                                         [param setObject:userInfo forKey:@"userInfo"];
                                     }
                                     [self.delegate responseCode:result
                                                        actionId:LOGIN_REQUEST_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                             } failure:^(id task, NSError *error) {
                                 if ([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]) {
                                     int result = REQUEST_FAILURE_CODE;
                                     if (userInfo) {
                                         [param setObject:userInfo forKey:@"userInfo"];
                                     }
                                     [self.delegate responseCode:result
                                                        actionId:LOGIN_REQUEST_CODE
                                                            info:error
                                                     requestInfo:param];
                                 }
                             }];
}

//登出
- (void)requestLogoutWithsessionId:(NSString *)sessionId
{
    NSString *sign = [sessionId stringByAppendingString:APPOINT_KEY];
    NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
    [param setObject:sessionId forKey:@"sessionId"];
    [param setObject:[sign md5String] forKey:@"sign"];
    [[HTTPService sharedClient] POST:BodyScaleLogout_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 
                                 //NSLog(@"requestLogoutWithsessionId ok");
                                 
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     //NSLog(@"requestLogoutWithsessionId ok 2");
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     [self.delegate responseCode:result
                                                        actionId:LOGOUT_REQUEST_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                             }failure:^(id task, NSError *error){
                                 //NSLog(@"failure");
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:LOGOUT_REQUEST_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}

- (void)requestUpdateUserInformationWithsessionId:(NSString *)sessionId
                                          loginId:(NSString *)loginId
                                         passWord:(NSString *)passWord
                                        validCode:(NSString *)validCode
                                              age:(NSString *)age
                                         nickname:(NSString *)nickname
                                          chnName:(NSString *)chnName
                                              sex:(NSString *)sex
                                   homeProvinceId:(NSString *)homeProvinceId
                                 homeProvinceName:(NSString *)homeProvinceName
                                       homeCityId:(NSString *)homeCityId
                                     homeCityname:(NSString *)homeCityname
                                       homeAreaId:(NSString *)homeAreaId
                                     homeAreaName:(NSString *)homeAreaName
                                   locaProvinceId:(NSString *)locaProvinceId
                                 locaProvinceName:(NSString *)locaProvinceName
                                       locaCityId:(NSString *)locaCityId
                                     locaCityName:(NSString *)locaCityName
                                       locaAreaId:(NSString *)locaAreaId
                                     locaAreaName:(NSString *)locaAreaName
                                        photoPath:(NSString *)photoPath
                                         birthday:(NSString *)birthday
                                           height:(NSString *)height
                                           weight:(NSString *)weight
                                       profession:(NSString *)profession
                                     privacyLevel:(NSString *)privacyLevel
                                         authBind:(NSString *)authBind
                                           status:(NSString *)status
                                           remark:(NSString *)remark
                                        regStatus:(NSString *)regStatus
                                     bodyscaleLoc:(NSString *)bodyscaleLoc{
    NSString *sign = [sessionId stringByAppendingString:APPOINT_KEY];
    NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
    
    if (sessionId) {
        [param setObject:sessionId forKey:@"sessionId"];
    }
    if (age) {
        [param setObject:[Helpers inputStr:age] forKey:@"age"];
    }
    
    if (chnName) {
        [param setObject:[Helpers inputStr:chnName ]forKey:@"chnName"];
    }
    if (sex) {
        [param setObject:[Helpers inputStr:sex] forKey:@"sex"];
    }
    if (photoPath) {
        [param setObject:[Helpers inputStr:photoPath] forKey:@"photoPath"];
    }
    if (weight) {
        [param setObject:[Helpers inputStr:weight] forKey:@"weight"];
    }
    
    if (privacyLevel) {
        [param setObject:[Helpers inputStr:privacyLevel] forKey:@"privacyLevel"];
    }
    if (height) {
        [param setObject:[Helpers inputStr:height] forKey:@"height"];
    }
    
    if (nickname) {
        [param setObject:[Helpers inputStr:nickname] forKey:@"nickname"];
    }
    
    
    /*
     [param setObject:validCode forKey:@"validCode"];
     [param setObject:homeProvinceId forKey:@"homeProvinceId"];
     [param setObject:homeProvinceName forKey:@"homeProvinceName"];
     [param setObject:homeCityId forKey:@"homeCityId"];
     [param setObject:homeCityname forKey:@"homeCityname"];
     [param setObject:homeAreaId forKey:@"homeAreaId"];
     [param setObject:homeAreaName forKey:@"homeAreaName"];
     [param setObject:locaProvinceId forKey:@"locaProvinceId"];
     [param setObject:locaProvinceName forKey:@"locaProvinceName"];
     [param setObject:locaCityId forKey:@"locaCityId"];
     [param setObject:locaCityName forKey:@"locaCityName"];
     [param setObject:locaAreaId forKey:@"locaAreaId"];
     [param setObject:locaAreaName forKey:@"locaAreaName"];
     [param setObject:birthday forKey:@"birthday"];
     [param setObject:profession forKey:@"profession"];
     [param setObject:authBind forKey:@"authBind"];
     [param setObject:status forKey:@"status"];
     [param setObject:remark forKey:@"remark"];
     [param setObject:regStatus forKey:@"regStatus"];
     [param setObject:bodyscaleLoc forKey:@"bodyscaleLoc"];
     
     */
    [param setObject:[sign md5String] forKey:@"sign"];
    [[HTTPService sharedClient] POST:BodyScaleUpdateUserInformation_URL
                          parameters:param
                             success:^(id task, id responseObject) {
                                 
                                
                                 BOOL _flag =[self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)];
                              if (_flag) {
                                  
                                  int result = [self getRequest:responseObject[@"result"]];
                                  
                                  
                                  NSLog(@"responseObject result:%@",responseObject[@"result"]);
                                  
                                  [self.delegate responseCode:result
                                                     actionId:UPDATE_USER_INFO_CODE
                                                         info:responseObject
                                                  requestInfo:param];

                              }else{
                                  NSLog(@"requestUpdateUserInformationWithsessionId _flag not ok");
                              }
                          } failure:^(id task, NSError *error) {
                              NSLog(@"requestUpdateUserInformationWithsessionId not ok");
                              
                              int result = REQUEST_FAILURE_CODE;
                              [self.delegate responseCode:result
                                                 actionId:UPDATE_USER_INFO_CODE
                                                     info:error
                                              requestInfo:param];
                          }];
    
}

// 上传文件
- (void)requestUploadFileWithfileName:(NSString *)fileName
                                 data:(NSData *)data {
    NSString *requestDateString = [self currentDateString];
    NSString *sign = [[fileName stringByAppendingString:requestDateString] stringByAppendingString:APPOINT_KEY];
    
    NSMutableDictionary *param = [self getPublicParamWithDateString:requestDateString];
    [param setObject:fileName forKey:@"fileName"];
    [param setObject:[sign md5String] forKey:@"sign"];
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithDictionary:param];
    
    [[HTTPService sharedClient] POST:BodyScaleUploadData_URL
                          parameters:param
                               block:^(id<AFMultipartFormData> formData) {
                                   [formData appendPartWithFileData:data name:@"fileStream" fileName:fileName mimeType:@"image/png"];
                               }
                             success:^(id task, id responseObject) {
                                 NSLog(@"response object : %@", responseObject[@"errorMsg"]);
                                 
                                 
                                 int result = [self getRequest:responseObject[@"result"]];
                                 

                                 if ([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]) {
                                     [self.delegate responseCode:result
                                                        actionId:UPLOADFILE_CODE
                                                            info:responseObject
                                                     requestInfo:requestParam];
                                     
                                 }
                             }
                             failure:^(id task, NSError *error) {
                                 NSLog(@"error : %@", error);
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:UPLOADFILE_CODE
                                                        info:error
                                                 requestInfo:requestParam];
                             }];
    
}

//查询时间提示信息
- (void)requestQueryNoticeWithsessionId:(NSString *)sessionId
                               userInfo:(id)userInfo
{
    NSString *sign = [sessionId stringByAppendingString:APPOINT_KEY];
    NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
    [param setObject:sessionId forKey:@"sessionId"];
    [param setObject:[sign md5String] forKey:@"sign"];
    [[HTTPService sharedClient] POST:BodyScaleQueryNotice_URL
                          parameters:param
                             success:^(id task, id responseObject){

                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){

                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     if (userInfo) {
                                         [param setObject:userInfo forKey:@"userInfo"];
                                     }
                                     [self.delegate responseCode:result
                                                        actionId:QUERY_NOTICE_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                             }failure:^(id task, NSError *error){
  
                                 int result = REQUEST_FAILURE_CODE;
                                 if (userInfo) {
                                     [param setObject:userInfo forKey:@"userInfo"];
                                 }
                                 [self.delegate responseCode:result
                                                    actionId:QUERY_NOTICE_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}

-(void)requestResetPWDWithloginName:(NSString *)loginName
                          validCode:(NSString *)validCode
                             newPwd:(NSString *)newPwd
{
    {
        NSString *sign = [loginName stringByAppendingString:APPOINT_KEY];
        NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
        [param setObject:loginName forKey:@"loginName"];
        [param setObject:validCode forKey:@"validCode"];
        [param setObject:[NSString encrypt:newPwd] forKey:@"newPwd"];
        [param setObject:[sign md5String] forKey:@"sign"];
        [[HTTPService sharedClient] POST:BodyScaleResetPwd_URL
                              parameters:param
                                 success:^(id task, id responseObject){
                                     
                                     if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                         
                                         
                                         int result = [self getRequest:responseObject[@"result"]];
                                         
                                         [self.delegate responseCode:result
                                                            actionId:RESET_PWD_CODE
                                                                info:responseObject
                                                         requestInfo:param];
                                     }
                                 }failure:^(id task, NSError *error){
                                     
                                     int result = REQUEST_FAILURE_CODE;
                                     [self.delegate responseCode:result
                                                        actionId:RESET_PWD_CODE
                                                            info:error
                                                     requestInfo:param];
                                 }];
    }
}




/**
 *  添加关注
 *
 *  @param sessionId      sessionId + focusUserId +约定串
 *  @param focusUserId    需要关注的用户id
 *  @param focusLoginName 需要关注的用户名 focusUserId && focusLoginName不能同时为空
 *  @param mRight         对方权限 0:无权限;1:查看;2:编辑;
 *  @param specFocusFlag  1特别关注标识，其它值不理会
 *  @param appType        1:血压 2：体脂仪
 */
-(void)requestAddFocusWithSessionId:(NSString *)sessionId
                        focusUserId:(NSNumber *)focusUserId
                     focusLoginName:(NSString *)focusLoginName
                             mRight:(NSNumber *)mRight
                      specFocusFlag:(NSNumber *)specFocusFlag
                            appType:(NSNumber *)appType
{
    NSString *sign = @"";
    
    if (focusUserId) {
        sign = [[sessionId  stringByAppendingString:[focusUserId stringValue] ]
                                                stringByAppendingString:APPOINT_KEY];
    }else{
        sign = [[sessionId  stringByAppendingString:@"" ]
                stringByAppendingString:APPOINT_KEY];
    }
    
    
    
    NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
    
    if (sessionId) {
        [param setObject:sessionId forKey:@"sessionId"];
    }

    if (focusUserId) {
        [param setObject:focusUserId forKey:@"focusUserId"];
    }else{
        [param setObject:@"" forKey:@"focusUserId"];
    }
    if (focusLoginName) {
        [param setObject:focusLoginName forKey:@"focusLoginName"];
    }
    if (mRight) {
        [param setObject:mRight forKey:@"mRight"];
    }
    if (specFocusFlag) {
        [param setObject:specFocusFlag forKey:@"specFocusFlag"];
    }
    if (appType) {
        [param setObject:appType forKey:@"appType"];
    }

    [param setObject:[sign md5String] forKey:@"sign"];
    
    
    [[HTTPService sharedClient] POST:BodyScaleAddFocus_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     [self.delegate responseCode:result
                                                        actionId:ADD_FOCUS_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                                 
                             }failure:^(id task, NSError *error){
                                 
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:ADD_FOCUS_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}


/**
 *  修改好友权限
 *
 *  @param sessionId sessionId + mId +约定串          必填
 *  @param mId       列表下发自增字段Mid                必填
 *  @param mRight    对方权限 0:无权限;1:查看;2:编辑     必填
 *  @param appType   1:血压计 2：体脂仪                 必填
 */
-(void)requestMRightFocusWithSessionId:(NSString *)sessionId
                                   mId:(NSNumber *)mId
                                mRight:(NSNumber *)mRight
                               appType:(NSNumber *)appType
{
    NSString *sign = [[sessionId  stringByAppendingString:[mId stringValue] ]
                stringByAppendingString:APPOINT_KEY];

    NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
    
    if (sessionId) {
        [param setObject:sessionId forKey:@"sessionId"];
    }
    
    if (mId) {
        [param setObject:mId forKey:@"mId"];
    }

    if (mRight) {
        [param setObject:mRight forKey:@"mRight"];
    }

    if (appType) {
        [param setObject:appType forKey:@"appType"];
    }
    
    [param setObject:[sign md5String] forKey:@"sign"];
    
    [[HTTPService sharedClient] POST:BodyScaleMRightFocus_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     [self.delegate responseCode:result
                                                        actionId:MRIGHT_FOCUS_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                                 
                             }failure:^(id task, NSError *error){
                                 
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:MRIGHT_FOCUS_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}


/**
 *  获取 新消息 （谁对你发起了加好友申请）
 *
 *  @param sessionId sessionId + reqTime + 约定串          必填
 *  @param foucsMe   传1表示 需要查询关注我的新信息
 */
-(void)requestMyMsgCountsWithSessionId:(NSString *)sessionId
                               foucsMe:(NSNumber *)foucsMe
{
    NSString *_reqTime  = [self currentDateString];
    
    NSString *sign = [[sessionId  stringByAppendingString:_reqTime ]
                      stringByAppendingString:APPOINT_KEY];
    
    NSMutableDictionary *param = [self getPublicParamWithDateString:_reqTime];
    
    if (sessionId) {
        [param setObject:sessionId forKey:@"sessionId"];
    }
    
    if (foucsMe) {
        [param setObject:foucsMe forKey:@"foucsMe"];
    }
    
    
    [param setObject:[sign md5String] forKey:@"sign"];
    
    [[HTTPService sharedClient] POST:BodyScaleMyMsgCounts_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     [self.delegate responseCode:result
                                                        actionId:MY_SMG_COUNTS_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                                 
                             }failure:^(id task, NSError *error){
                                 
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:MY_SMG_COUNTS_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}


/**
 *  删除关注人
 *
 *  @param sessionId sessionId+ mId +约定串                            必填
 *  @param mId       列表下发自增字段Mid  FriendInfoEntity.FI_mid        必填
 */
-(void)requestDeleteFocusWithSessionId:(NSString *)sessionId
                                   mId:(NSNumber *)mId
{
    NSString *sign = [[sessionId  stringByAppendingString:[mId stringValue] ]
                      stringByAppendingString:APPOINT_KEY];
    
    NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
    
    if (sessionId) {
        [param setObject:sessionId forKey:@"sessionId"];
    }
    
    if (mId) {
        [param setObject:mId forKey:@"mId"];
    }
    
    
    
    [param setObject:[sign md5String] forKey:@"sign"];
    
    [[HTTPService sharedClient] POST:BodyScaleDeleteFoucus_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     [self.delegate responseCode:result
                                                        actionId:DELETE_FOCUS_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                                 
                             }failure:^(id task, NSError *error){
                                 
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:DELETE_FOCUS_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}


/**
 *  同意或拒绝关注
 *
 *  @param sessionId sessionId+ mId +约定串
 *  @param mId       查询关注人下发的mid
 *  @param appType   1:血压 2：体脂仪
 *  @param stutas    状态 0:正常(同意); 1:已解除（拒绝）; 2:待确认;
 */
-(void)requestAgreeFocusWithSessionId:(NSString *)sessionId
                                  mId:(NSNumber *)mId
                              appType:(NSNumber *)appType
                               stutas:(NSNumber *)stutas
{
    NSString *sign = [[sessionId  stringByAppendingString:[mId stringValue] ]
                      stringByAppendingString:APPOINT_KEY];
    
    NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
    
    if (sessionId) {
        [param setObject:sessionId forKey:@"sessionId"];
    }
    if (mId) {
        [param setObject:mId forKey:@"mId"];
    }
    if (appType) {
        [param setObject:appType forKey:@"appType"];
    }
    if (stutas) {
        [param setObject:stutas forKey:@"stutas"];
    }
    
    
    
    [param setObject:[sign md5String] forKey:@"sign"];
    
    [[HTTPService sharedClient] POST:BodyScaleAgreeFoucus_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     [self.delegate responseCode:result
                                                        actionId:AGREE_FOCUS_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                                 
                             }failure:^(id task, NSError *error){
                                 
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:AGREE_FOCUS_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}


/**
 *  关注我的用户列表
 *
 *  @param sessionId sessionId+约定串
 *  @param appType   1:血压 2：体脂仪
 */
-(void)requestFocusMeListWithSessionId:(NSString *)sessionId
                               appType:(NSNumber *)appType
{
    NSString *sign = [sessionId stringByAppendingString:APPOINT_KEY];
    
    NSMutableDictionary *param = [self getPublicParamWithDateString:[self currentDateString]];
    
    if (sessionId) {
        [param setObject:sessionId forKey:@"sessionId"];
    }
    
    if (appType) {
        [param setObject:appType forKey:@"appType"];
    }
    
    
    
    [param setObject:[sign md5String] forKey:@"sign"];
    
    [[HTTPService sharedClient] POST:BodyScaleFocusMeList_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     [self.delegate responseCode:result
                                                        actionId:FOCUSME_LIST_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                                 
                             }failure:^(id task, NSError *error){
                                 
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:FOCUSME_LIST_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}


/**
 *  将关注我的信息置成已读
 *
 *  @param sessionId sessionId+ reqTime +mId+约定串
 *  @param mId       mId 若未 nil 则标记当前用户所有消息为已读
 */
-(void)requestFocusMeSetReadWithSessionId:(NSString *)sessionId
                                      mId:(NSString *)mId
{
    NSString *_reqTime  = [self currentDateString];
    
    NSString *sign = @"";
    
    if (mId) {
        sign = [[[sessionId  stringByAppendingString:_reqTime ] stringByAppendingString:mId]
                                    stringByAppendingString:APPOINT_KEY];
    }else{
        sign = [[[sessionId  stringByAppendingString:_reqTime ] stringByAppendingString:@"null"]
                stringByAppendingString:APPOINT_KEY];
    
    }
    
    
    NSMutableDictionary *param = [self getPublicParamWithDateString:_reqTime];

    

  
    
    if (sessionId) {
        [param setObject:sessionId forKey:@"sessionId"];
    }
    
    if (mId) {
        [param setObject:mId forKey:@"mId"];
    }
    
    
    [param setObject:[sign md5String] forKey:@"sign"];
    
    
    
    [[HTTPService sharedClient] POST:BodyScaleFocusMeSetRead_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     [self.delegate responseCode:result
                                                        actionId:FOCUSME_SETREAD_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                                 
                             }failure:^(id task, NSError *error){
                                 
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:FOCUSME_SETREAD_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}


/**
 *  删除关注人新信息
 *
 *  @param sessionId sessionId+ mId +约定串
 *  @param mId       列表下发自增字段Mid
 */
-(void)requestDelFocusMsgWithSessionId:(NSString *)sessionId
                                   mid:(NSNumber *)mid
{
    NSString *_reqTime  = [self currentDateString];
    
    NSString *sign = @"";
    
    if (mid) {
        sign = [[sessionId  stringByAppendingString:[mid stringValue]]
                                    stringByAppendingString:APPOINT_KEY];
    }
    

    NSMutableDictionary *param = [self getPublicParamWithDateString:_reqTime];
    
    
    
    
    
    if (sessionId) {
        [param setObject:sessionId forKey:@"sessionId"];
    }
    
    if (mid) {
        [param setObject:mid forKey:@"mid"];
    }
    
    
    [param setObject:[sign md5String] forKey:@"sign"];
    
    
    
    [[HTTPService sharedClient] POST:BodyScaleDelFocusMsg_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     [self.delegate responseCode:result
                                                        actionId:DEL_FOCUSMSG_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                                 
                             }failure:^(id task, NSError *error){
                                 
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:DEL_FOCUSMSG_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}


/**
 *  检测用户名是否已经被使用
 *
 *  @param loginName 用户名
 */
-(void)requestCheckLonginWithLoginName:(NSString *)loginName
{
    NSString *_reqTime  = [self currentDateString];
    
    NSString *sign = @"";
    
    if (loginName) {
        sign = [loginName stringByAppendingString:APPOINT_KEY];
    }
    
    
    NSMutableDictionary *param = [self getPublicParamWithDateString:_reqTime];

    
    if (loginName) {
        [param setObject:loginName forKey:@"loginName"];
    }
    
    
    [param setObject:[sign md5String] forKey:@"sign"];
    
    
    
    [[HTTPService sharedClient] POST:BodyScaleCheckLoginName_URL
                          parameters:param
                             success:^(id task, id responseObject){
                                 
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     
                                     
                                     int result = [self getRequest:responseObject[@"result"]];
                                     
                                     [self.delegate responseCode:result
                                                        actionId:CHECK_LOGINNAME_CODE
                                                            info:responseObject
                                                     requestInfo:param];
                                 }
                                 
                             }failure:^(id task, NSError *error){
                                 
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:CHECK_LOGINNAME_CODE
                                                        info:error
                                                 requestInfo:param];
                             }];
}


/**
 *  京东用户，登陆我方服务器
 *
 *  @param oid JDUserInfo.uid
 */
-(void)requestJDLoginWithOpenId:(NSString *)oid
                       nickName:(NSString *)nickName
{
    
    NSString *_reqTime  = [self currentDateString];
    
    NSString *sign = [[[[ThirdSide_PlatformStr stringByAppendingString:ThirdSide_MerchantCodeStr]
                            stringByAppendingString:ThirdSide_Login_BusinessCode]
                                stringByAppendingString:_reqTime]
                      stringByAppendingString:ThirdSide_key];
    if (oid) {
        if ([oid isKindOfClass:[NSNull class]]) {
            oid = @"";
        }
    }else{
        oid = @"";
    }
    if (nickName) {
        if ([nickName isKindOfClass:[NSNull class]]) {
            nickName = @"";
        }
    }
    else{
        nickName = @"";
    }
    
    NSMutableString *_jsonStr = [[NSMutableString alloc]init];
    
    [_jsonStr appendString:@"{"];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\":",ThirdSide_PlatformKey]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\",",ThirdSide_PlatformStr]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\":",ThirdSide_MerchantCodeKey]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\",",ThirdSide_MerchantCodeStr]  ];   
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\":",ThirdSide_BusinessCodeKey]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\",",ThirdSide_Login_BusinessCode]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\":",ThirdSide_RequestTimeKey]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\",",_reqTime]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\":[{",ThirdSide_ContentKey]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\":",@"openid"]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\",",oid]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\":",@"nickname"]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\",",nickName]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\":",@"photopath"]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\",",@""]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\":",@"sex"]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\",",@"2"]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\":",@"birthday"]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\"",@"0"]  ];
    [_jsonStr appendString:@"}],"];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\":",@"sign"]  ];
    [_jsonStr appendString:[NSString stringWithFormat:@"\"%@\"",[sign md5String]]  ];
    [_jsonStr appendString:@"}"];

    NSDictionary *_pDic = @{
                                    @"parameter":_jsonStr
                                    };
    //NSString *strURL = @"http://192.168.5.138:5060/api/login.htm";

    
    
    [[HTTPService sharedClient] POSTWithFullURL:kJingDongLongin_URL
                                     parameters:_pDic
                                        success:^(id task, id responseObject){
                                            [self disMissHUDWithText:@"" afterDelay:0];
                                 if([self.delegate respondsToSelector:@selector(responseCode:actionId:info:requestInfo:)]){
                                     
                                     
                                     int result = [self getRequest:responseObject[@"code"]];
                                    [self.delegate responseCode:result
                                                        actionId:THIRDSIDE_LOGIN_CODE
                                                            info:responseObject
                                                     requestInfo:_pDic];
                                 }
                                 
                             }
                                        failure:^(id task, NSError *error){
                                 [self disMissHUDWithText:@"" afterDelay:0];
                                 int result = REQUEST_FAILURE_CODE;
                                 [self.delegate responseCode:result
                                                    actionId:THIRDSIDE_LOGIN_CODE
                                                        info:error
                                                 requestInfo:_pDic];
                             }];
    
     
}





@end
