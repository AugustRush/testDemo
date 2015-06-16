//
//  DBInfo.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-3-21.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//



#define kMinMaxDefualtList @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]




#define kDefaultDBName @"BSPDatabase"

#define kTBUserDataName @"TBUserData"
#define kTBUserInfoName @"TBUserInfo"

//#define kTBFriendInfoName @"TBFriendInfo"
//#define kTBFriendInfoName @"TBFriendInfo01"
#define kTBFriendInfoName @"TBFriendInfo02"

#define kTBUserRelationName @"TBUserRelation"
#define kTBSuggestName @"TBSuggest"
#define kTBNoticeName @"TBNotice"
#define kTBUserDeviceInfoName @"TBUserDeviceInfoName"


#define kTBJDUSerInfoName @"TBJDUserInfo"

#define kTBPraiseUserName @"TBPraiseUserName"


#define kTBUserDataKeyAry @[@"ID",@"MEMID",@"WEIGHT",@"BMI",\
@"FAT",@"SKINFAT",@"OFFALFAT",@"MUSCLE",\
@"METABOLISM",@"WATER",@"BONE",@"BODYAGE",\
@"STATUS",@"CHECKDATE",@"CREATETIME",@"MODIFYTIME",\
@"devcode",@"longit",@"latit",@"location",@"isFriendData",@"userId",@"ryFit"]

//,@"ryFit"

#define kTBUserInfoKeyAry @[@"userId",@"loginName",@"loginPwd",@"deviceNo",\
@"sex",@"age",@"weight",@"height",\
@"focusModel",@"photoPath",@"cname",@"loginId",\
@"remindmode",@"remindcycle",@"memid",@"plan",\
@"target",@"privacy",@"mode",@"lastCheckDate",\
@"fat",@"nickname",@"countpraise",@"location",\
@"isLoc",@"birthday"]

//,@"birthday"

#define kTBFriendInfoKeyAry @[@"userId",@"mid",@"memidatt",@"isspeci",\
@"status",@"mright",@"insertTime",@"cname",\
@"nickName",@"loginId",@"photopath",@"ismutual",\
@"isRead",@"birthday",@"age",@"sex",\
@"countpraise",@"weight",@"bmi",@"fat",\
@"checkdate",@"mid_att",@"mright_att"]

#define kTBUserRelationKeyAry @[@"userId",@"FuserId",]

#define kTBSuggestKeyAry @[@"id",@"memid",@"suggesttype",@"admin",\
@"content",@"status",@"createtime"]

#define kTBNoticeKeyAry @[@"id",@"noticetype",@"time",@"actionName",\
@"content",@"picurl",@"userId"]

#define kTBUserDeviceInfoKeyAry @[@"id",@"memid",@"devcode",@"location",\
@"status",@"createtime",@"modifytime"]



#define kTBPraiseUserKeyAry @[@"userId",@"type",@"memid",@"nickname",\
@"cname",@"photopath",@"sex",@"status",\
@"createtime"]


#define kTBJDUSerInfoKeyAry @[@"userId",@"uid",@"user_nick",@"access_token",\
@"refresh_token",@"expires_in",@"time"]

