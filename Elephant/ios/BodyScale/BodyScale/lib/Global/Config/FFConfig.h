//
//  FFConfig.h
//  
//
//  Created by 两元鱼 on 14/12/26.
//  Copyright (c) 2014年 FFLtd. All rights reserved.
//



#define  dFirstLogin                       NSStringFromSelector(@selector(firstLogin))
#define  dCloseQQ                          NSStringFromSelector(@selector(closeQQ))

#define  dUserName                         NSStringFromSelector(@selector(userName))
#define  dUserHeader                       NSStringFromSelector(@selector(userHeader))
#define  dUserShowName                     NSStringFromSelector(@selector(userShowName))
#define  dPassword                         NSStringFromSelector(@selector(password))
#define  dUserPhoneNumber                  NSStringFromSelector(@selector(userPhoneNumber))
#define  dUserEmail                        NSStringFromSelector(@selector(userEmail))
#define  dUserRealName                     NSStringFromSelector(@selector(userRealName))

#define  dUserNickName                     NSStringFromSelector(@selector(userNickName))
#define  dUserHeight                       NSStringFromSelector(@selector(userHeight))
#define  dUserAge                          NSStringFromSelector(@selector(userAge))
#define  dUserGender                       NSStringFromSelector(@selector(userGender))
#define  dNowUserId                        NSStringFromSelector(@selector(nowUserId))

#define  dUserId                           NSStringFromSelector(@selector(userId))
#define  dPrivateCode                      NSStringFromSelector(@selector(privateCode))
#define  dNeedAutoLogin                    NSStringFromSelector(@selector(needAutoLogin))



#define  dSavePassword                     NSStringFromSelector(@selector(savePassword))
#define  dIsLogined                        NSStringFromSelector(@selector(isLogined))
#define  dNeedOfflineLogin                 NSStringFromSelector(@selector(needOfflineLogin))
#define  dNeedAutoLogin                    NSStringFromSelector(@selector(needAutoLogin))
#define  dOpenUUID                         NSStringFromSelector(@selector(openUUID))
#define  dFavIndex                         NSStringFromSelector(@selector(favIndex))

@interface FFConfig : NSObject
{
	NSUserDefaults                                      *defaults;
}

+(FFConfig *)            currentConfig;


@property (readwrite, strong) NSUserDefaults             *defaults;

@property (nonatomic, readwrite, strong) NSNumber    *firstLogin;
@property (nonatomic, readwrite, strong) NSNumber    *closeQQ;

@property (nonatomic, readwrite, strong) NSString    *userName;
@property (nonatomic, readwrite, strong) NSNumber    *needAutoLogin;

@property (nonatomic, readwrite, strong) NSString    *userHeader;
@property (nonatomic, readwrite, strong) NSString    *userShowName;
@property (nonatomic, readwrite, strong) NSString    *password;
@property (nonatomic, readwrite, strong) NSString    *userPhoneNumber;
@property (nonatomic, readwrite, strong) NSString    *userEmail;
@property (nonatomic, readwrite, strong) NSString    *userRealName;

@property (nonatomic, readwrite, strong) NSString *userNickName;
@property (nonatomic, readwrite, strong) NSString *userHeight;
@property (nonatomic, readwrite, strong) NSNumber *userAge;
@property (nonatomic, readwrite, strong) NSNumber *userGender;
@property (nonatomic, readwrite, strong) NSString *nowUserId;

@property (nonatomic, readwrite, strong) NSString    *userId;
@property (nonatomic, readwrite, strong) NSString    *privateCode;

@property (nonatomic, readwrite, strong) NSNumber    *savePassword;
@property (nonatomic, readwrite, strong) NSNumber    *isLogined;
@property (nonatomic, readwrite, strong) NSNumber    *needOfflineLogin;
@property (nonatomic, readwrite, strong) NSString    *openUUID;
@property (nonatomic, readwrite, strong) NSString    *favIndex;

@end
