//
//  UserDeviceInfoEntity.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-3-31.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"


@interface UserDeviceInfoEntity : BaseEntity


@property(nonatomic,strong)NSString *UDI_id;                //自增序号
@property(nonatomic,strong)NSString *UDI_memid;             //会员ID  userId
@property(nonatomic,strong)NSString *UDI_devcode;           //设备编号
@property(nonatomic,strong)NSString *UDI_location;          //位置

@property(nonatomic,strong)NSString *UDI_status;            //0 绑定中  1 已解绑
@property(nonatomic,strong)NSString *UDI_createtime;        //绑定时间
@property(nonatomic,strong)NSString *UDI_modifytime;        //解绑时间


@end
