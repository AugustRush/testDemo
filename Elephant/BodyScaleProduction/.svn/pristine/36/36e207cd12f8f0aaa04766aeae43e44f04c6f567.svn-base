//
//  UserInfoEntity.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BaseEntity.h"
#import "JDUserInfoEntity.h"
#import "UserDataEntity.h"

@interface UserInfoEntity : BaseEntity


@property(nonatomic,strong)NSString  *UI_userId;
@property(nonatomic,strong)NSString  *UI_loginName;
@property(nonatomic,strong)NSString  *UI_loginPwd;
@property(nonatomic,strong)NSString  *UI_isLoc;
@property(nonatomic,strong)NSString  *UI_deviceNo;

@property(nonatomic,strong)NSString  *UI_sex;                   //性别0：女；1：男
@property(nonatomic,strong)NSString  *UI_age;                   //年龄
@property(nonatomic,strong)NSString  *UI_weight;                //体重
@property(nonatomic,strong)NSString  *UI_fat;                   //脂肪率
@property(nonatomic,strong)NSString  *UI_height;                //身高  cm
@property(nonatomic,strong)NSString  *UI_lastCheckDate;         //最后一次测量时间
@property(nonatomic,strong)NSString  *UI_focusModel;

@property(nonatomic,strong)NSString  *UI_photoPath;             //头像地址
@property(nonatomic,strong)NSString  *UI_cname;                 //真实姓名
@property(nonatomic,strong)NSString  *UI_loginId;               //登录名称
@property(nonatomic,strong)NSString  *UI_remindmode;
@property(nonatomic,strong)NSString  *UI_remindcycle;

@property(nonatomic,strong)NSString  *UI_memid;
@property(nonatomic,strong)NSString  *UI_plan;
@property(nonatomic,strong)NSString  *UI_target;
@property(nonatomic,strong)NSString  *UI_privacy;               //隐私策略/权限 0:仅自己可见 1：关注人可见
@property(nonatomic,strong)NSString  *UI_mode;                  //0：常规模式 1：智能模式

@property(nonatomic,strong)NSString  *UI_nickname;              //昵称
@property(nonatomic,strong)NSString  *UI_lastlocation;          //体脂仪绑定位置 最后一次
@property(nonatomic,strong)NSString  *UI_countpraise;           //赞的数量

@property(nonatomic,strong)NSString  *UI_birthday;              //生日，2000-01-01 格式

@property(nonatomic,strong)UserDataEntity *UI_lastUserData;
@property(nonatomic,strong)NSArray  *UI_deviceList;
@property(nonatomic,strong)NSString *UI_url;                    //购买地址

@property(nonatomic,strong)JDUserInfoEntity *UI_jdUser;          //jd访问token

- (NSString *)description;

@end
