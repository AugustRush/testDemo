//
//  UserDataEntity.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "UserDataEntity.h"

@implementation UserDataEntity

@synthesize UD_BMI,UD_BODYAGE,UD_BONE,UD_CHECKDATE,
UD_CREATETIME,UD_FAT,UD_ID,UD_isFriendData,
UD_MEMID,UD_METABOLISM,UD_MODIFYTIME,UD_MUSCLE,
UD_OFFALFAT,UD_SKINFAT,UD_STATUS,UD_WATER,
UD_WEIGHT,UD_userId,UD_devcode,UD_latit,
UD_longit,UD_location,UD_checkCount,UD_dataStatus,
UD_pcEntityList,UD_eBMR,UD_ryFit;


-(id)init
{
    self = [super init];
    if (self) {
        self.UD_dataStatus = DataStatus_default;
    }
    return self;
}

@end
