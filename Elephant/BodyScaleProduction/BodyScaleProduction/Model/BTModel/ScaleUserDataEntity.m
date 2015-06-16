//
//  ScaleUserDataEntity.m
//  BodyScale
//
//  Created by Go Salo on 14-2-19.
//  Copyright (c) 2014年 于菲. All rights reserved.
//

#import "ScaleUserDataEntity.h"
#import "CalculateTool.h"
#import "Helpers.h"

@implementation ScaleUserDataEntity



- (UserDataEntity *)convertToUserDataEntityWithHeight:(float)height
{

    UserDataEntity *userDataEntity = [UserDataEntity new];
    
    //NSLog(@"self.tmie:%@",self.tmie);
    
    NSString *timeString = [Helpers getDateStr:self.tmie];
    
    //NSLog(@"timeString:%@",timeString);
    
    
    if (timeString.length > 19) {
        timeString = [timeString substringToIndex:19];
    } else {
        
    }
    userDataEntity.UD_CHECKDATE     = [NSString stringWithFormat:@"%@", timeString];
    userDataEntity.UD_WEIGHT        = [NSString stringWithFormat:@"%.1f", self.weight];
    userDataEntity.UD_WATER         = [NSString stringWithFormat:@"%.1f",self.water];
    userDataEntity.UD_MUSCLE        = [NSString stringWithFormat:@"%.1f",self.muscle];
    
    userDataEntity.UD_BONE          = [NSString stringWithFormat:@"%.1f",self.bone];
    userDataEntity.UD_METABOLISM    = [NSString stringWithFormat:@"%d",self.bmr];
    userDataEntity.UD_BODYAGE       = [NSString stringWithFormat:@"%d",self.bodyage];
    userDataEntity.UD_SKINFAT       = [NSString stringWithFormat:@"%.1f",self.sfat];
    
    userDataEntity.UD_OFFALFAT      = [NSString stringWithFormat:@"%.1f",self.infat];
    userDataEntity.UD_FAT           = [NSString stringWithFormat:@"%.1f", self.bf];
    userDataEntity.UD_ID            = @"";
    userDataEntity.UD_STATUS        = @"";
    
    userDataEntity.UD_MEMID         = @"";
    userDataEntity.UD_CREATETIME    = @"";
    userDataEntity.UD_MODIFYTIME    = @"";
    userDataEntity.UD_isFriendData  = @"0";
    
    

    float _eBmr = [CalculateTool calculateEuropaBmrByFat:[[CalculateTool inputStr:userDataEntity.UD_FAT] floatValue]
                                                  weight:[[CalculateTool inputStr:userDataEntity.UD_WEIGHT] floatValue]];
    userDataEntity.UD_eBMR         = [NSString stringWithFormat:@"%d",(int)_eBmr];
    

    float _height = height;
    
    
    userDataEntity.UD_devcode       = @"";        //体脂仪设备号
    userDataEntity.UD_longit        = [GloubleProperty sharedInstance].lng;        //经度
    userDataEntity.UD_latit         = [GloubleProperty sharedInstance].lat;        //纬度
    userDataEntity.UD_BMI           = [NSString stringWithFormat:@"%.1f",[self getBMIByWeight:self.weight
                                                                                       height:_height]];;
    userDataEntity.UD_location      = [NSString stringWithFormat:@"%d", self.userId];
    userDataEntity.UD_userId = @"";
    
    return userDataEntity;
}


-(float)getBMIByWeight:(float)weight
                height:(float)height
{
    if (height == 0) {
        return 0;
    }

    return weight  / ( height * height / 10000);
}


@end
