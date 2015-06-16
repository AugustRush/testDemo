//
//  MSGFocusMeEntity.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-5-9.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BaseEntity.h"

@interface MSGFocusMeEntity : BaseEntity
/*
age = 23;
cname = "<null>";
createdate = "2014-05-09 15:05:35";
isRead = 1;
 
ismutual = 0;
isspeci = 0;
loginId = "334521055@qq.com";
mId = 397;
 
myRight = 1;
nickName = "334521055@qq.com";
photopath = "<null>";
sex = 1;
 
status = 0;
userId = 1089;
 */

@property(nonatomic,copy)NSString  *msgFm_age;          //年龄
@property(nonatomic,copy)NSString  *msgFm_cname;        //中文姓名
@property(nonatomic,copy)NSString  *msgFm_createdate;   //关注日期
@property(nonatomic,copy)NSString  *msgFm_isRead;       //0未读，1已读

@property(nonatomic,copy)NSString  *msgFm_ismutual;     //是否互相关注 0：否 1：是
@property(nonatomic,copy)NSString  *msgFm_isspeci;      //否是特别关注 0：否；1：是；
@property(nonatomic,copy)NSString  *msgFm_loginId;      //登录id
@property(nonatomic,copy)NSString  *msgFm_mId;          //关注人列表ID自增,用于授权，确认关注，特别关注,删除关注

@property(nonatomic,copy)NSString  *msgFm_myRight;      //对方权限 0:无权限;1:查看;2:编辑;
@property(nonatomic,copy)NSString  *msgFm_nickName;     //昵称
@property(nonatomic,copy)NSString  *msgFm_photopath;    //不带域名的头像地址
@property(nonatomic,copy)NSString  *msgFm_sex;          //性别

@property(nonatomic,copy)NSString  *msgFm_status;       //状态 0:正常; 1:已解除; 2:待确认;
@property(nonatomic,copy)NSString  *msgFm_userId;       //关注我的用户id号,用于添加关注

@end
