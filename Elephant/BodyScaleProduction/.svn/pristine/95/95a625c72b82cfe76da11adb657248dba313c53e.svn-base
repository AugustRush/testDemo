//
//  UserInfoEntity.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "UserInfoEntity.h"

@implementation UserInfoEntity

@synthesize UI_age,UI_cname,UI_deviceNo,UI_focusModel,
UI_height,UI_isLoc,UI_loginId,UI_loginName,
UI_loginPwd,UI_memid,UI_mode,UI_photoPath,
UI_plan,UI_privacy,UI_remindcycle,UI_remindmode,
UI_sex,UI_target,UI_userId,UI_weight,UI_fat,UI_lastCheckDate,UI_lastUserData,
UI_nickname,UI_countpraise,UI_lastlocation,UI_deviceList,UI_url,UI_jdUser;

- (NSString *)description {
    return [NSString stringWithFormat:@"\n身高:%@\n年龄:%@\n性别:%@\n生日:%@", self.UI_height, self.UI_age, [self.UI_sex intValue] == 0 ? @"女" : @"男", self.UI_birthday];
}

- (NSString *)UI_age {
    NSString *age = nil;
    if (self.UI_birthday.length > 4) {
        int year = [self.UI_birthday intValue];
        int thisYear = [[[[NSDate date] convertToStandardYYYYMMDDDateFormat] substringToIndex:4] intValue];
        age = [NSString stringWithFormat:@"%d", thisYear - year];
    } else {
        age = UI_age;
    }
     
    return age;
}

@end
