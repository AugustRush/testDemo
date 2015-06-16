//
//  SYGlobal.h
//  iChrono365
//
//  Created by 刘平伟 on 13-11-25.
//  Copyright (c) 2013年 刘平伟. All rights reserved.
//

#ifndef iChrono365_SYGlobal_h
#define iChrono365_SYGlobal_h

//////////////////public

#define kMainBounds                         [[UIScreen mainScreen] applicationFrame]
#define kIsiOS_7                            [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f     //  判断是不是 iOS 7 以上系统
#define kSystermVersion                     [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

#define SYColor(r,g,b)                      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define SYCurrentDeviceIsIpad               [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad //判断是否为ipad
#define SYCurrentDeviceIsIphone             [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#define SYLocalString(str)                  [[LanguageManager bundle] localizedStringForKey:str value:@"" table:nil]

#define SYImage(imageName)                  [UIImage imageNamed:imageName]
#define SYDefaultFont(size)                 [UIFont systemFontOfSize:size]
#define SYDefaultBoldFont(size)             [UIFont boldSystemFontOfSize:size]

#define SYImageWithFile(a,b)                [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:a ofType:b]]
#define SYKeyWindow                         [[UIApplication sharedApplication] keyWindow]

#define SYIntegerNumber(a)                  [NSNumber numberWithInteger:a]
#define SYFloatNumber(a)                    [NSNumber numberWithFloat:a]
#define SYIntToString(a)                    [NSString stringWithFormat:@"%d",a]
#define SYFloatToString(a)                  [NSString stringWithFormat:@"%.1f",a]
#define SYIpadResizeScale                   [[UIScreen mainScreen] applicationFrame].size.width/320
#define SYUserDefaults                      [NSUserDefaults standardUserDefaults]

#define SYAppIsFirstRunKey                  @"AppIsFirstRun"
#define SYCustomDeviceIDKey                 @"SYChronoID"
#define SYLoginedUsersListFileName          @"S3l5nedu3s"

////login

#define SYLoginUserNameAndPassKey           @"userLogin_NameAndPass"
#define SYLoginIsRememberNameAndPass        @"_isRememberNameAndPass"
#define SYNottemporaryUser                  @"isNotTemporaryUser"

//////////////////////home

#define HOME_PAGE_LABEL_GRAY_COLOR  [UIColor colorWithRed:146/255.0f green:146/255.0f blue:146/255.0f alpha:1.0f]    //  首页的灰色字体颜色 色值

#define Register_Page_Back_Color    [UIColor colorWithRed:249/255.0f green:249/255.0f blue:249/255.0f alpha:1.0f]

#define SYGreenColor                [UIColor colorWithRed:65/255.0f green:220/255.0f blue:153/255.0f alpha:1.0f]
#define SYRedColor                  [UIColor colorWithRed:255/255.0f green:101/255.0f blue:116/255.0f alpha:1.0f]

#define SYTextfieldBorderGrayColor  [UIColor colorWithRed:214/255.0f green:214/255.0f blue:214/255.0f alpha:1.0f]

#define SYHomeSubmitBPDataNoti                  @"submitBloodPressureDataNoti"
#define SYHomeSubmitBGDataNoti                  @"submitBloodSugarValueNoti"
#define SYHomeSubmitTempDataNoti                @"submitBodyTempDataNoti"
#define SYHomeSubmitWeightDataNoti              @"submitWeightDataNoti"
#define SYHomeSubmitHeightDataNoti              @"submitHeightDataNoti"

#define SYLoginSuccessNoti                      @"hasLoginSuccessedNoti"
#define SYChangeUserSuccessNoti                 @"hasChangedUserSuccess"

#define kFamilyAttentionPersonCellDeleteNoti    @"family_AttentionCell_DeleteNoti"
#define kPersonHistoryTableCellSelectedNoti     @"attentionPersonHIsCellSelNoti"
#define kBaseInfoCtrInputCompletedNoti          @"baseInfoInputCompleteNoti"

#define kAttentionPersonTableNoti               @"attentionPersonTableCellSelected"

///////设置
#define kModifyFocusModelNoti                   @"set_modifyFocusModelSuccessNoti"
#define SYDefaultLanguageInApp                  @"InAppCurrentLanguage"

#define SYRequestSuccessCode                    @"1"
#define SYNotLoginError                         @"您还未登陆"


#define SYUserMeasureHistoryDataKey             @"__HisMeasureDataForUser_key"

//////////////////////NewMessage

#define SYNewMessAgreeFocusMePersonNoti         @"newMess_agreeFocusMePersonNoti"

#define SYNewMessRefuseFocusMePersonNoti        @"newMess_RefuseFocusMePersonNoti"
//  SYlog 输出
#ifdef DEBUG
#define SYLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define SYLog(format, ...)
#endif



