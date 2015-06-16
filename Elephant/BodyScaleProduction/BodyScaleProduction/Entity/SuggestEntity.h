//
//  SuggestEntity.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-3-27.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"

@interface SuggestEntity : BaseEntity


@property(nonatomic,strong)NSString *S_id;              //自增序号 建议id
@property(nonatomic,strong)NSString *S_memid;           //会员Id  userId
@property(nonatomic,strong)NSString *S_suggesttype;     //建议类型  1: 血压 2：体脂仪  int
@property(nonatomic,strong)NSString *S_admin;           //管理员ID

@property(nonatomic,strong)NSString *S_content;         //建议内容
@property(nonatomic,strong)NSString *S_status;          //标志位  0：客户信息  1：系统管理员回复信息
@property(nonatomic,strong)NSString *S_createtime;       //记录时间


@end
