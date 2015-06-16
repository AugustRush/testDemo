//
//  CmdConstant.h
//  MatchNet
//
//  Created by 两元鱼 on 11/25/11.
//  Copyright (c) 2011 FFLtd. All rights reserved.
//


#define HTTP_TIMEOUT    30

typedef enum ActionSheetCode
{
	// 系统命令
	CC_ASBegin             = 200,   //
    CC_IMAS,
    CC_VAS,
    CC_GetPicAS,
    CC_SavePicAS,
    CC_RemovePicAS,
    
    
    CC_ShareAS,
    CC_ASEnd,

}E_ACTIONSHEETCODE;

typedef enum CmdCode
{
	// 系统命令
	CC_VersionCheck             = 0x0001,   //
	CC_NetCheck					= 0x0002,   //
    CC_SystemCodeUpLink,
    
    // 用户命令
    CC_LoginAction              = 0x0011,
    CC_UnionLoginAction,
    CC_RegistAction,
    CC_AutoLoginAction,
    CC_LogoutAction,
    CC_IsExistAction,
    CC_UpdateUserInfo,
    CC_GetUserInfo1,
    CC_SendMessage,
    CC_FindPassword,
    CC_GetUserInfo,
    CC_ChangeUserInfo,
    CC_UserCodeUpLink,
    
    // 查询命令
    CC_TopicListAction          = 0x0021,
    CC_TopicPostCommitAction,
    CC_TopicCommitListAction,
    CC_TopicPostAction,
    
} E_CMDCODE;


typedef enum ControllerMoveType
{
    PUSHWITHANIMATION,
    PUSHWITHOUTANIMATION,
    PRESENTWITHANIMATION,
    PRESENTWITHOUTANIMATION
    
} E_CONTROLLERMOVETYPE;
//需要登录的接口
static const int CC_NEED_LOGIN_QUEUE[] =
{
    //CmdCodeValue,
};
//需要重写cookie的接口，例如彩票服务器，酒店服务器的域名不同，需要重写下cookie，否则cookie不能带过去
static const int CC_NEED_COOKIE_QUEUE[] =
{
    //CMDCodeKey,
};