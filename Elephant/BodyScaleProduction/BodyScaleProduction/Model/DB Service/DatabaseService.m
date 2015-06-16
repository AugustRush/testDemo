//
//  DatabaseService.m
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-3-18.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//


#import "DatabaseService.h"
#import "DBHelper.h"
#import "DBAccessObject.h"

#import "UserDataEntity.h"
#import "UserInfoEntity.h"
#import "FriendInfoEntity.h"
#import "SuggestEntity.h"
#import "NoticeEntity.h"
#import "UserPraiseEntity.h"
#import "JDUserInfoEntity.h"

#import "DBInfo.h"
#import "NSDate+SLExtend.h"
#import "CalculateTool.h"

#define kDefaultDBName @"BSPDatabase"
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)









@implementation DatabaseService

+ (instancetype)defaultDatabaseService
{
    static DatabaseService *_defaultDatabaseService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _defaultDatabaseService = [[DatabaseService alloc] init];
        
        [_defaultDatabaseService createDataBase];
        
    });
    
    return _defaultDatabaseService;
}
- (void) dealloc {
    //NSLog(@"DatabaseService dealloc");
}



#pragma mark -
#pragma mark 测试
-(void)save200DataInfo:(NSString *)uid
{
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        
        for (int i = 0; i < 200; i++) {
            UserDataEntity *_ud = [[UserDataEntity alloc]init];
            
            _ud.UD_ID           = [NSString stringWithFormat:@"%d",i];
            _ud.UD_MEMID        = uid;
            _ud.UD_WEIGHT       = @"50.24823467";
            _ud.UD_BMI          = @"15";
            
            _ud.UD_FAT          = @"12";
            _ud.UD_SKINFAT      = @"23";
            _ud.UD_OFFALFAT     = @"20";
            _ud.UD_MUSCLE       = @"6";
            
            _ud.UD_METABOLISM   = @"60";
            _ud.UD_WATER        = @"70";
            _ud.UD_BONE         = @"8";
            _ud.UD_BODYAGE      = @"20";
            
            _ud.UD_STATUS       = @"0";
            _ud.UD_CHECKDATE    = [Helpers getDateStrFromDate:[NSDate date]
                                                    bySeconds:-3600 * 5 * (i+3) ];
            _ud.UD_CREATETIME   = _ud.UD_CHECKDATE;
            _ud.UD_MODIFYTIME   = _ud.UD_CHECKDATE;
            
            _ud.UD_location     = @"1";
            _ud.UD_devcode      = @"abc";
            _ud.UD_latit        = @"31.55";
            _ud.UD_longit       = @"122.22";
            
            _ud.UD_isFriendData = @"0";
            _ud.UD_userId       = uid;
            
            [_dbaObj saveUserData:_ud];
            
        }
        
        
        
        
    }
    @catch (NSException *exception) {
        
        
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
    }
    
}


-(void)fix20140611
{
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        [_dbaObj createCol:kTBUserInfoName colName:@"birthday"];
        [_dbaObj createCol:kTBUserDataName colName:@"ryFit"];
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception:%@",exception.description);
        if (_dbManager) {
            [_dbManager rollback];
        }
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
    }
}
#pragma mark -
#pragma mark 辅助函数
-(NSString *)getPath
{
    NSString *_path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                          NSUserDomainMask,
                                                          YES)
                      objectAtIndex:0];
	
    return [_path stringByAppendingString:[NSString stringWithFormat:@"/%@",kDefaultDBName]];;
}


-(NSDictionary *)fillUpdateJDUserInfo:(JDUserInfoEntity *)user

{
    
    NSMutableDictionary *_dic = [[NSMutableDictionary alloc]init];
    if (user.userId) {
        [_dic setObject:user.uid forKey:@"userId"];
    }
    if (user.uid) {
        [_dic setObject:user.uid forKey:@"uid"];
    }
    if (user.access_token) {
        [_dic setObject:user.access_token forKey:@"access_token"];
    }
    if (user.time) {
        [_dic setObject:user.time
                 forKey:@"uid"];
    }
    if (user.expires_in) {
        [_dic setObject:user.expires_in
                 forKey:@"expires_in"];
    }
    if (user.user_nick) {
        [_dic setObject:user.user_nick forKey:@"user_nick"];
    }
    if (user.refresh_token) {
        [_dic setObject:user.refresh_token forKey:@"refresh_token"];
    }
    
    
    
    return _dic;
}

-(NSDictionary *)fillUpdateUserInfo:(UserInfoEntity *)user
                         originUser:(NSDictionary *)dic
{
    BOOL _flag = (dic == nil);
    NSMutableDictionary *_dic = [[NSMutableDictionary alloc]init];
    
    if (user.UI_loginName) {
        [_dic setObject:user.UI_loginName forKey:@"loginName"];
    }
    else{
        if (_flag) {
            user.UI_loginName = @"";
        }else{
            user.UI_loginName = dic[@"loginName"];
        }
    }
    if (user.UI_loginPwd) {
        [_dic setObject:user.UI_loginPwd forKey:@"loginPwd"];
    }
    else{
        if (_flag) {
            user.UI_loginPwd = @"";
        }else{
            user.UI_loginPwd = dic[@"loginPwd"];
        }
    }
    if (user.UI_loginId) {
        [_dic setObject:user.UI_loginId forKey:@"loginId"];
    }
    else{
        if (_flag) {
            user.UI_loginId = @"";
        }else{
            user.UI_loginId = dic[@"loginId"];
        }
    }
    if (user.UI_memid) {
        [_dic setObject:user.UI_memid forKey:@"memid"];
    }
    else{
        if (_flag) {
            user.UI_memid = @"";
        }else{
            user.UI_memid = dic[@"memid"];
        }
    }
    if (user.UI_mode) {
        [_dic setObject:user.UI_mode forKey:@"mode"];
    }
    else{
        if (_flag) {
            user.UI_mode = @"";
        }else{
            user.UI_mode = dic[@"mode"];
        }
    }
    
    if (user.UI_plan) {
        [_dic setObject:user.UI_plan forKey:@"plan"];
    }
    else{
        if (_flag) {
            user.UI_plan = @"";
        }else{
            user.UI_plan = dic[@"plan"];
        }
    }
    if (user.UI_weight) {
        [_dic setObject:user.UI_weight forKey:@"weight"];
    }
    else{
        if (_flag) {
            user.UI_weight = @"";
        }else{
            user.UI_weight = dic[@"weight"];
        }
    }
    if (user.UI_privacy) {
        [_dic setObject:user.UI_privacy forKey:@"privacy"];
    }
    else{
        if (_flag) {
            user.UI_privacy = @"";
        }else{
            user.UI_privacy = dic[@"privacy"];
        }
    }
    if (user.UI_remindcycle) {
        [_dic setObject:user.UI_remindcycle forKey:@"remindcycle"];
    }
    else{
        if (_flag) {
            user.UI_remindcycle = @"";
        }else{
            user.UI_remindcycle = dic[@"remindcycle"];
        }
    }
    if (user.UI_height) {
        [_dic setObject:user.UI_height forKey:@"height"];
    }
    else{
        if (_flag) {
            user.UI_height = @"";
        }else{
            user.UI_height = dic[@"height"];
        }
    }
    
    if (user.UI_remindmode) {
        [_dic setObject:user.UI_remindmode forKey:@"remindmode"];
    }
    else{
        if (_flag) {
            user.UI_remindmode = @"";
        }else{
            user.UI_remindmode = dic[@"remindmode"];
        }
    }
    if (user.UI_cname) {
        [_dic setObject:user.UI_cname forKey:@"cname"];
    }
    else{
        if (_flag) {
            user.UI_cname = @"";
        }else{
            user.UI_cname = dic[@"cname"];
        }
    }
    if (user.UI_age) {
        [_dic setObject:user.UI_age forKey:@"age"];
    }
    else{
        if (_flag) {
            user.UI_age = @"";
        }else{
            user.UI_age = dic[@"age"];
        }
    }
    if (user.UI_deviceNo) {
        [_dic setObject:user.UI_deviceNo forKey:@"deviceNo"];
    }
    else{
        if (_flag) {
            user.UI_deviceNo = @"";
        }else{
            user.UI_deviceNo = dic[@"deviceNo"];
        }
    }
    if (user.UI_sex) {
        [_dic setObject:user.UI_sex forKey:@"sex"];
    }
    else{
        if (_flag) {
            user.UI_sex = @"";
        }else{
            user.UI_sex = dic[@"sex"];
        }
    }
    
    if (user.UI_photoPath) {
        [_dic setObject:user.UI_photoPath forKey:@"photoPath"];
    }
    else{
        if (_flag) {
            user.UI_photoPath = @"";
        }else{
            user.UI_photoPath = dic[@"photoPath"];
        }
    }
    if (user.UI_target) {
        [_dic setObject:user.UI_target forKey:@"target"];
    }
    else{
        if (_flag) {
            user.UI_target = @"";
        }else{
            user.UI_target = dic[@"target"];
        }
    }
    if (user.UI_userId) {
        [_dic setObject:user.UI_userId forKey:@"userId"];
    }
    else{
        if (_flag) {
            user.UI_userId = @"";
        }else{
            user.UI_userId = dic[@"userId"];
        }
    }
    if (user.UI_focusModel) {
        [_dic setObject:user.UI_focusModel forKey:@"focusModel"];
    }
    else{
        if (_flag) {
            user.UI_focusModel = @"";
        }else{
            user.UI_focusModel = dic[@"focusModel"];
        }
    }
    if (user.UI_isLoc) {
        [_dic setObject:user.UI_isLoc forKey:@"isLoc"];
    }
    else{
        if (_flag) {
            user.UI_isLoc = @"";
        }else{
            user.UI_isLoc = dic[@"isLoc"];
        }
    }
    
    if (user.UI_fat) {
        [_dic setObject:user.UI_fat forKey:@"fat"];
    }
    else{
        if (_flag) {
            user.UI_fat = @"";
        }else{
            user.UI_fat = dic[@"fat"];
        }
    }
    if (user.UI_lastCheckDate) {
        [_dic setObject:user.UI_lastCheckDate forKey:@"lastCheckDate"];
    }
    else{
        if (_flag) {
            user.UI_lastCheckDate = @"";
        }else{
            user.UI_lastCheckDate = dic[@"lastCheckDate"];
        }
    }
    if (user.UI_nickname) {
        [_dic setObject:user.UI_nickname forKey:@"nickname"];
    }
    else{
        if (_flag) {
            user.UI_nickname = @"";
        }else{
            user.UI_nickname = dic[@"nickname"];
        }
    }
    
    if (user.UI_countpraise) {
        [_dic setObject:user.UI_countpraise forKey:@"countpraise"];
    }
    else{
        if (_flag) {
            user.UI_countpraise = @"";
        }else{
            user.UI_countpraise = dic[@"countpraise"];
        }
    }
    
    if (user.UI_lastlocation) {
        [_dic setObject:user.UI_lastlocation forKey:@"location"];
    }
    else{
        if (_flag) {
            user.UI_lastlocation = @"";
        }else{
            user.UI_lastlocation = dic[@"location"];
        }
    }
    
    if (user.UI_birthday) {
        [_dic setObject:user.UI_birthday forKey:@"birthday"];
    }
    else{
        if (_flag) {
            user.UI_birthday = @"";
        }else{
            user.UI_birthday = dic[@"birthday"];
        }
    }
    
    return _dic;
}

-(NSDictionary *)fillUpdateUserData:(UserDataEntity *)userData
{
    NSMutableDictionary *_dic = [[NSMutableDictionary alloc]init];
    
    if (userData.UD_ID) {
        [_dic setObject:userData.UD_ID forKey:@"ID"];
    }
    if (userData.UD_MEMID) {
        [_dic setObject:userData.UD_MEMID forKey:@"MEMID"];
    }
    if (userData.UD_WEIGHT) {
        [_dic setObject:userData.UD_WEIGHT forKey:@"WEIGHT"];
    }
    if (userData.UD_BMI) {
        [_dic setObject:userData.UD_BMI forKey:@"BMI"];
    }
    if (userData.UD_FAT) {
        [_dic setObject:userData.UD_FAT forKey:@"FAT"];
    }
    if (userData.UD_SKINFAT) {
        [_dic setObject:userData.UD_SKINFAT forKey:@"SKINFAT"];
    }
    if (userData.UD_OFFALFAT) {
        [_dic setObject:userData.UD_OFFALFAT forKey:@"OFFALFAT"];
    }
    if (userData.UD_MUSCLE) {
        [_dic setObject:userData.UD_MUSCLE forKey:@"MUSCLE"];
    }
    if (userData.UD_METABOLISM) {
        [_dic setObject:userData.UD_METABOLISM forKey:@"METABOLISM"];
    }
    if (userData.UD_WATER) {
        [_dic setObject:userData.UD_WATER forKey:@"WATER"];
    }
    if (userData.UD_BONE) {
        [_dic setObject:userData.UD_BONE forKey:@"BONE"];
    }
    if (userData.UD_BODYAGE) {
        [_dic setObject:userData.UD_BODYAGE forKey:@"BODYAGE"];
    }
    if (userData.UD_STATUS) {
        [_dic setObject:userData.UD_STATUS forKey:@"STATUS"];
    }
    if (userData.UD_CHECKDATE) {
        [_dic setObject:userData.UD_CHECKDATE forKey:@"CHECKDATE"];
    }
    if (userData.UD_CREATETIME) {
        [_dic setObject:userData.UD_CREATETIME forKey:@"CREATETIME"];
    }
    if (userData.UD_MODIFYTIME) {
        [_dic setObject:userData.UD_MODIFYTIME forKey:@"MODIFYTIME"];
    }
    if (userData.UD_devcode) {
        [_dic setObject:userData.UD_devcode forKey:@"devcode"];
    }
    if (userData.UD_longit) {
        [_dic setObject:userData.UD_longit forKey:@"longit"];
    }
    if (userData.UD_userId) {
        [_dic setObject:userData.UD_userId forKey:@"userId"];
    }
    if (userData.UD_isFriendData) {
        [_dic setObject:userData.UD_isFriendData forKey:@"isFriendData"];
    }
    if (userData.UD_location) {
        [_dic setObject:userData.UD_location forKey:@"location"];
    }
    if (userData.UD_latit) {
        [_dic setObject:userData.UD_latit forKey:@"latit"];
    }
    if (userData.UD_ryFit) {
        [_dic setObject:userData.UD_ryFit forKey:@"ryFit"];
    }
    
    
    return _dic;
}

-(NSDictionary *)fillUpdateFriend:(FriendInfoEntity *)friend
{
    NSMutableDictionary *_dic = [[NSMutableDictionary alloc]init];
    /*
     @"checkdate",@"mid_att",@"mright_att"]
     */
    if (friend.FI_userId) {
        [_dic setObject:friend.FI_userId forKey:@"userId"];
    }
    if (friend.FI_mid) {
        [_dic setObject:friend.FI_mid forKey:@"mid"];
    }
    if (friend.FI_memidatt) {
        [_dic setObject:friend.FI_memidatt forKey:@"memidatt"];
    }
    if (friend.FI_isspeci) {
        [_dic setObject:friend.FI_isspeci forKey:@"isspeci"];
    }
    
    if (friend.FI_status) {
        [_dic setObject:friend.FI_status forKey:@"status"];
    }
    if (friend.FI_mright) {
        [_dic setObject:friend.FI_mright forKey:@"mright"];
    }
    if (friend.FI_insertTime) {
        [_dic setObject:friend.FI_insertTime forKey:@"insertTime"];
    }
    if (friend.FI_cname) {
        [_dic setObject:friend.FI_cname forKey:@"cname"];
    }
    
    if (friend.FI_nickName) {
        [_dic setObject:friend.FI_nickName forKey:@"nickName"];
    }
    if (friend.FI_loginId) {
        [_dic setObject:friend.FI_loginId forKey:@"loginId"];
    }
    if (friend.FI_photopath) {
        [_dic setObject:friend.FI_photopath forKey:@"photopath"];
    }
    if (friend.FI_ismutual) {
        [_dic setObject:friend.FI_ismutual forKey:@"ismutual"];
    }
    
    if (friend.FI_isRead) {
        [_dic setObject:friend.FI_isRead forKey:@"isRead"];
    }
    if (friend.FI_birthday) {
        [_dic setObject:friend.FI_birthday forKey:@"birthday"];
    }
    if (friend.FI_age) {
        [_dic setObject:friend.FI_age forKey:@"age"];
    }
    if (friend.FI_sex) {
        [_dic setObject:friend.FI_sex forKey:@"sex"];
    }
    
    if (friend.FI_countpraise) {
        [_dic setObject:friend.FI_countpraise forKey:@"countpraise"];
    }
    if (friend.FI_weight) {
        [_dic setObject:friend.FI_weight forKey:@"weight"];
    }
    if (friend.FI_bmi) {
        [_dic setObject:friend.FI_bmi forKey:@"bmi"];
    }
    if (friend.FI_fat) {
        [_dic setObject:friend.FI_fat forKey:@"fat"];
    }
    
    if (friend.FI_checkdate) {
        [_dic setObject:friend.FI_checkdate forKey:@"checkdate"];
    }
    if (friend.FI_mid_att) {
        [_dic setObject:friend.FI_mid_att forKey:@"mid_att"];
    }
    if (friend.FI_mright_att) {
        [_dic setObject:friend.FI_mright_att forKey:@"mright_att"];
    }
    
    
    
    
    return _dic;
}




-(UserDataEntity *)fillUserDataEntity:(NSDictionary *)info
{
    UserDataEntity *obj     = [[UserDataEntity alloc]init];
    
    obj.UD_ID               = info[@"ID"];
    obj.UD_MEMID            = info[@"MEMID"];
    obj.UD_METABOLISM       = info[@"METABOLISM"];
    obj.UD_MODIFYTIME       = info[@"MODIFYTIME"];
    
    
    obj.UD_MUSCLE           = info[@"MUSCLE"];
    obj.UD_OFFALFAT         = info[@"OFFALFAT"];
    obj.UD_SKINFAT          = info[@"SKINFAT"];
    obj.UD_STATUS           = info[@"STATUS"];
    
    
    obj.UD_WATER            = info[@"WATER"];
    obj.UD_WEIGHT           = info[@"WEIGHT"];
    obj.UD_FAT              = info[@"FAT"];
    obj.UD_BMI              = info[@"BMI"];
    
    
    obj.UD_BODYAGE          = info[@"BODYAGE"];
    obj.UD_BONE             = info[@"BONE"];
    obj.UD_CHECKDATE        = info[@"CHECKDATE"];
    obj.UD_CREATETIME       = info[@"CREATETIME"];
    
    obj.UD_longit           = info[@"longit"];
    obj.UD_latit            = info[@"latit"];
    obj.UD_devcode          = info[@"devcode"];
    obj.UD_location         = info[@"location"];
    obj.UD_ryFit            = info[@"ryFit"];
    
    obj.UD_isFriendData     = info[@"isFriendData"];
    obj.UD_userId           = info[@"userId"];
    
    
    
    float _eBmr = [CalculateTool calculateEuropaBmrByFat:[[CalculateTool inputStr:obj.UD_FAT] floatValue]
                                                  weight:[[CalculateTool inputStr:obj.UD_WEIGHT] floatValue]];
    obj.UD_eBMR         = [NSString stringWithFormat:@"%d",(int)_eBmr];
    
    
    obj.UD_BODYAGE      = [NSString stringWithFormat:@"%d",[obj.UD_BODYAGE intValue]] ;
    obj.UD_METABOLISM   = [NSString stringWithFormat:@"%d",[obj.UD_METABOLISM intValue]] ;
    obj.UD_BMI          = [NSString stringWithFormat:@"%.1f",[obj.UD_BMI floatValue]] ;
    
    obj.UD_WEIGHT       = [NSString stringWithFormat:@"%.1f",[obj.UD_WEIGHT floatValue]] ;
    obj.UD_FAT          = [NSString stringWithFormat:@"%.1f",[obj.UD_FAT floatValue]] ;
    obj.UD_SKINFAT      = [NSString stringWithFormat:@"%.1f",[obj.UD_SKINFAT floatValue]] ;
    obj.UD_BONE         = [NSString stringWithFormat:@"%.1f",[obj.UD_BONE floatValue]] ;
    obj.UD_MUSCLE       = [NSString stringWithFormat:@"%.1f",[obj.UD_MUSCLE floatValue]] ;
    obj.UD_WATER        = [NSString stringWithFormat:@"%.1f",[obj.UD_WATER floatValue]] ;
    obj.UD_OFFALFAT     = [NSString stringWithFormat:@"%.1f",[obj.UD_OFFALFAT floatValue]] ;
    
    
    return obj;
}

-(JDUserInfoEntity *)fillJDUserInfoEntity:(NSDictionary *)info
{
    JDUserInfoEntity *obj     = [[JDUserInfoEntity alloc]init];
    
    obj.userId           = info[@"userId"];
    obj.uid        = info[@"uid"];
    obj.user_nick         = info[@"user_nick"];
    obj.access_token          = info[@"access_token"];
    obj.refresh_token          = info[@"refresh_token"];
    
    obj.expires_in            = info[@"expires_in"];
    obj.time         = info[@"time"];
    
    
    
    return obj;
}

-(UserInfoEntity *)fillUserInfoEntity:(NSDictionary *)info
{
    UserInfoEntity *obj     = [[UserInfoEntity alloc]init];
    
    obj.UI_userId           = info[@"userId"];
    obj.UI_loginName        = info[@"loginName"];
    obj.UI_loginPwd         = info[@"loginPwd"];
    obj.UI_loginId          = info[@"loginId"];
    obj.UI_privacy          = info[@"privacy"];
    
    obj.UI_cname            = info[@"cname"];
    obj.UI_deviceNo         = info[@"deviceNo"];
    obj.UI_age              = info[@"age"];
    obj.UI_deviceNo         = info[@"deviceNo"];
    obj.UI_isLoc            = info[@"isLoc"];
    
    obj.UI_weight           = info[@"weight"];
    obj.UI_height           = info[@"height"];
    obj.UI_sex              = info[@"sex"];
    obj.UI_photoPath        = info[@"photoPath"];
    obj.UI_plan             = info[@"plan"];
    
    obj.UI_target           = info[@"target"];
    obj.UI_remindmode       = info[@"remindmode"];
    obj.UI_remindcycle      = info[@"remindcycle"];
    obj.UI_mode             = info[@"mode"];
    obj.UI_memid            = info[@"memid"];
    
    obj.UI_nickname         = info[@"nickname"];
    obj.UI_fat              = info[@"fat"];
    obj.UI_lastCheckDate    = info[@"lastCheckDate"];
    obj.UI_countpraise      = info[@"countpraise"];
    
    obj.UI_lastlocation    = info[@"location"];
    obj.UI_birthday         = info[@"birthday"];
    
    return obj;
}

-(FriendInfoEntity *)fillFriendInfoEntity:(NSDictionary *)info
{
    FriendInfoEntity *obj   = [[FriendInfoEntity alloc]init];
    
    obj.FI_userId           = info[@"userId"];
    obj.FI_age              = info[@"age"];
    obj.FI_birthday         = info[@"birthday"];
    obj.FI_bmi              = info[@"bmi"];
    
    obj.FI_checkdate        = info[@"checkdate"];
    obj.FI_cname            = info[@"cname"];
    obj.FI_countpraise      = info[@"countpraise"];
    obj.FI_fat              = info[@"fat"];
    
    obj.FI_insertTime       = info[@"insertTime"];
    obj.FI_ismutual         = info[@"ismutual"];
    obj.FI_isRead           = info[@"isRead"];
    obj.FI_isspeci          = info[@"isspeci"];
    
    obj.FI_loginId          = info[@"loginId"];
    obj.FI_memidatt         = info[@"memidatt"];
    obj.FI_mid              = info[@"mid"];
    obj.FI_mright           = info[@"mright"];
    
    obj.FI_nickName         = info[@"nickName"];
    obj.FI_photopath        = info[@"photopath"];
    obj.FI_sex              = info[@"sex"];
    obj.FI_status           = info[@"status"];
    
    obj.FI_weight           = info[@"weight"];
    obj.FI_mright_att       = info[@"mright_att"];
    obj.FI_mid_att          = info[@"mid_att"];
    
    return obj;
}

-(SuggestEntity *)fillSuggestEntity:(NSDictionary *)info
{
    SuggestEntity *obj      = [[SuggestEntity alloc]init];
    
    obj.S_id                = info[@"id"];
    obj.S_memid             = info[@"memid"];
    obj.S_admin             = info[@"admin"];
    obj.S_content           = info[@"content"];
    
    obj.S_createtime        = info[@"createtime"];
    obj.S_status            = info[@"status"];
    obj.S_suggesttype       = info[@"suggesttype"];
    
    
    
    return obj;
}

-(NoticeEntity *)fillNoticeEntity:(NSDictionary *)info
{
    NoticeEntity *obj       = [[NoticeEntity alloc]init];
    
    obj.N_id                = info[@"id"];
    obj.N_userId            = info[@"userId"];
    obj.N_time              = info[@"time"];
    obj.N_picurl            = info[@"picurl"];
    
    
    obj.N_noticetype        = info[@"noticetype"];
    obj.N_content           = info[@"content"];
    obj.N_actionName        = info[@"actionName"];
    
    
    
    return obj;
}

-(UserDeviceInfoEntity *)fillUserDeviceInfoEntity:(NSDictionary *)info
{
    UserDeviceInfoEntity *obj       = [[UserDeviceInfoEntity alloc]init];
    
    obj.UDI_id                      = info[@"id"];
    obj.UDI_memid                   = info[@"memid"];
    obj.UDI_devcode                 = info[@"devcode"];
    obj.UDI_location                = info[@"location"];
    
    
    obj.UDI_status                  = info[@"status"];
    obj.UDI_createtime              = info[@"createtime"];
    obj.UDI_modifytime              = info[@"modifytime"];
    
    
    
    return obj;
}

-(UserPraiseEntity *)fillPraiseUserEntity:(NSDictionary *)info
{
    UserPraiseEntity *obj   = [[UserPraiseEntity alloc]init];
    
    obj.up_userId           = info[@"userId"];
    obj.up_type             = info[@"type"];
    obj.up_status           = info[@"status"];
    obj.up_sex              = info[@"sex"];
    
    
    obj.up_photopath        = info[@"photopath"];
    obj.up_nickname         = info[@"nickname"];
    obj.up_memid            = info[@"memid"];
    obj.up_createtime       = info[@"createtime"];
    
    
    obj.up_cname            = info[@"cname"];
    
    
    
    
    return obj;
}


#pragma mark -
#pragma mark 业务逻辑
/**
 * @brief 创建数据库
 */
- (void) createDataBase
{
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        
        /* 创建数据库内容 */
        NSUserDefaults *_udf = [NSUserDefaults standardUserDefaults];
        NSString *_sqlId = [_udf objectForKey:@"sqlId"];
        
        
        int i =  [_dbaObj createTBUserInfo];
        [_dbaObj createTBJDUserInfo];
        [_dbaObj createTBFriendInfo];
        [_dbaObj createTBPraiseUser];
        [_dbaObj createTBUserData];
        [_dbaObj createTBSuggest];
        [_dbaObj createTBNotice];
        [_dbaObj createTBUserDeviceInfo];
        
        
        
        
        if ( i == 2 && ![@"20140611"isEqualToString:_sqlId ] ) {
            
            
            [_udf setObject:@"20140611" forKey:@"sqlId"];
            [_udf synchronize];
            
            
            [_dbaObj createCol:kTBUserInfoName colName:@"birthday"];
            [_dbaObj createCol:kTBUserDataName colName:@"ryFit"];
        }
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
    }
    @catch (NSException *exception) {
        
        
        
        if (_dbManager) {
            [_dbManager rollback];
        }
        
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
    }
}


#pragma mark -
#pragma mark jd用户
- (int)saveJDUser:(JDUserInfoEntity *)user
{
    int _result = 0;
    
    if (!user) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        
        NSArray *_userList = [_dbaObj findJDUserInfoByConditionStr:user.userId];
        
        if ( _userList && _userList.count > 0) {
            
            _result = [_dbaObj updateJDUserInfoByUser:[self fillUpdateJDUserInfo:user]
                                         conditionStr:
                       [NSString stringWithFormat:@" where userId = '%@'",user.userId] ];
        }else{
            
            _result = [_dbaObj saveJDUserInfo:user];
            
        }
        
        
    }
    @catch (NSException *exception) {
        
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}

- (JDUserInfoEntity *)getJDUserByUid:(NSString *)uid
{
    JDUserInfoEntity *_tempUser = nil;
    if (!uid) {
        return _tempUser;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        
        
        NSArray *_ary = [_dbaObj findJDUserInfoByConditionStr:
                         [NSString stringWithFormat:@" where userId = '%@'",uid]];
        if (_ary && _ary.count > 0) {
            _tempUser =  [self fillJDUserInfoEntity:_ary[0]];
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _tempUser;
    }
}


#pragma mark 用户数据 UserData
/**
 *  根据用户id 获取 数据总量
 *
 *  @param uid 用户id
 *
 *  @return 数据总量
 */
-(int)getDataCountByUid:(NSString *)uid;
{
    int _result = 0;
    
    if (!uid) {
        return _result;
    }
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        _result = [[_dbaObj countOfRowInTable:kTBUserDataName
                                 conditionStr:[NSString stringWithFormat:@"WHERE userId = '%@'",uid] ] intValue];
    }
    @catch (NSException *exception) {
        
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}

/**
 * @brief   保存用户数据
 *
 * @param   dataList 当前用户id
 * @return  0保存失败，1保存成功
 */
-(int)saveUserData:(NSArray *)dataList
{
    int _result = 0;
    
    if (!dataList) {
        return _result;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        
        int _flag = 1;
        for (int i = 0 ; i < dataList.count; i++) {
            
            _flag *= [_dbaObj saveUserData: dataList[i]];
            
        }
        
        _result = _flag;
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
    }
    @catch (NSException *exception) {
        
        
        if (_dbManager) {
            [_dbManager rollback];
        }
        
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}



/**
 * @brief   保存用户数据
 *
 * @param   dataList 当前用户id
 * @return  0保存失败，1保存成功
 */
-(int)saveSingleUserData:(UserDataEntity *)userData
{
    int _result = 0;
    
    if (!userData) {
        return _result;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        int _tid =  [_dbaObj userDataIsExistByUid:userData.UD_userId
                                        checkDate:userData.UD_CHECKDATE];
        if (_tid == -1) {
            _result = [ _dbaObj saveUserData: userData ];
        }else{
            _result = [ _dbaObj updateUserData:[self fillUpdateUserData:userData]
                                           tid:_tid];
        }
        
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
        
        
    }
    @catch (NSException *exception) {
        
        
        if (_dbManager) {
            [_dbManager rollback];
        }
        
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}


/**
 * @brief   保存用户数据
 *
 * @param   dataList 当前用户id
 * @return  0保存失败，1保存成功
 */
-(int)saveSingleUnsubmitUserData:(UserDataEntity *)userData
{
    int _result = 0;
    
    if (!userData) {
        return _result;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        
        int _tid =  [_dbaObj userDataIsExistByUid:userData.UD_userId
                                        checkDate:userData.UD_CHECKDATE];
        if (_tid == -1) {
            _result = [ _dbaObj saveUserData: userData ];
        }else{
            _result = [ _dbaObj updateUserData:[self fillUpdateUserData:userData]
                                           tid:_tid];
        }
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
        
    }
    @catch (NSException *exception) {
        
        if (_dbManager) {
            [_dbManager rollback];
        }
        
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}



/**
 * @brief   保存注册时用户数据
 *
 * @param   userData 用户数据对象
 * @return  0保存失败，1保存成功
 */
-(int)saveRegUserData:(UserDataEntity *)userData
{
    int _result = 0;
    
    if (!userData) {
        return _result;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        
        
        int _tid =  [_dbaObj userDataIsExistByUid:@"-999"
                                        checkDate:userData.UD_CHECKDATE];
        if (_tid == -1) {
            _result = [ _dbaObj saveUserData: userData ];
        }else{
            _result = [ _dbaObj updateUserData:[self fillUpdateUserData:userData]
                                           tid:_tid];
        }
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
    }
    @catch (NSException *exception) {
        
        
        if (_dbManager) {
            [_dbManager rollback];
        }
        
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}









-(NSDictionary *)getDayDatasByDate:(NSDate *)targetDate
                     userDataByUid:(NSString *)uid
{
    NSDictionary *_dicResult = @{@"dataList":[[NSMutableArray alloc]init],
                                 @"minNumList":[NSMutableArray arrayWithArray:kMinMaxDefualtList],
                                 @"maxNumList":[NSMutableArray arrayWithArray:kMinMaxDefualtList]};
    
    if ([Helpers strIsEmty:uid] || !targetDate) {
        return _dicResult;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        NSMutableArray *_result     = _dicResult[@"dataList"];
        NSMutableArray *_maxList    = _dicResult[@"maxNumList"];
        NSMutableArray *_minList    = _dicResult[@"minNumList"];
        
        
        _dbManager              = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj                 = [DBAccessObject createDBAccessObject:_dbManager];
        NSDictionary *_tDic     = [Helpers getDateInfoForDate:targetDate];
        
        
        NSString *_minDateStr =  [NSString stringWithFormat:@"%@-%@-%@ 00:00:00",
                                  _tDic[@"year"],
                                  _tDic[@"month"],
                                  _tDic[@"day"]];
        NSString *_maxDateStr =  [NSString stringWithFormat:@"%@-%@-%@ 23:59:59",
                                  _tDic[@"year"],
                                  _tDic[@"month"],
                                  _tDic[@"day"]];
        
        NSArray *_ary = [_dbaObj findUserDataByUid:uid
                                        minDateStr:_minDateStr
                                        maxDateStr:_maxDateStr];
        
        if (_ary && _ary.count >0) {
            for (int i = 0; i < _minList.count; i++) {
                _minList[i] = @10000;
            }
            
            NSDictionary *_udDic    = nil;
            UserDataEntity *_ud     = nil;
            CalculateParam *_cp     = nil;
            UserInfoEntity *_user   = [GloubleProperty sharedInstance].currentUserEntity;
            
            for (int i  = 0; i < _ary.count; i++) {
                _udDic  = _ary[i];
                _ud     = [self fillUserDataEntity:_udDic];
                _cp     = [[CalculateParam alloc]init];
                [_cp addData:_ud userInfo:_user];
                if (_cp.dataCount > 0) {
                    _ud = [_cp getDataMax:_maxList min:_minList];
                    
                    [_result addObject:_ud];
                }
                
            }
            
            for (int i = 0; i < _minList.count; i++) {
                if([_minList[i] intValue] == 10000){
                    _minList[i] = @0;
                }
            }
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"getDayDatasByDate-Exc:%@",exception.description);
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _dicResult;
    }
}

-(NSDictionary *)getWeek:(NSDate *)targetDate
           userDataByUid:(NSString *)uid
{
    NSDictionary *_dicResult = @{@"dataList":[[NSMutableArray alloc]init],
                                 @"minNumList":[NSMutableArray arrayWithArray:kMinMaxDefualtList],
                                 @"maxNumList":[NSMutableArray arrayWithArray:kMinMaxDefualtList]};
    
    if ([Helpers strIsEmty:uid] || !targetDate) {
        return _dicResult;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        NSMutableArray *_result     = _dicResult[@"dataList"];
        NSMutableArray *_maxList    = _dicResult[@"maxNumList"];
        NSMutableArray *_minList    = _dicResult[@"minNumList"];
        
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        NSDictionary *_tDic = [Helpers getDateInfoForDate:targetDate];
        
        NSDate *_tDate = [Helpers getDateByString:[NSString stringWithFormat:@"%@-%@-%@ 00:00:00",
                                                   _tDic[@"year"],
                                                   _tDic[@"month"],
                                                   _tDic[@"day"]]
                          ];
        
        int _weekDay = [(NSString *)_tDic[@"weekday"] intValue]  - 1 ;
        
        NSString *_minDateStr =  [Helpers getDateStrFromDate:_tDate
                                                   bySeconds:-3600 * 24 * _weekDay];
        NSString *_maxDateStr =  [Helpers getDateStrFromDate:_tDate
                                                   bySeconds:-3600 * 24 * _weekDay + 3600 * 24 * 7 - 1];
        
        NSArray *_ary = [_dbaObj findUserDataByUid:uid
                                        minDateStr:_minDateStr
                                        maxDateStr:_maxDateStr];
        
        if (_ary.count > 0) {
            
            for (int i = 0; i < _minList.count; i++) {
                _minList[i] = @10000;
            }
            
            UserDataEntity *_ud     = nil;
            UserInfoEntity *_user   = [GloubleProperty sharedInstance].currentUserEntity;
            CalculateParam *_cp     = nil;
            NSString *_YMD          = nil;
            NSString *_ymdC         = nil;
            for (int i = 0 ; i < _ary.count; i++) {
                
                _ud     = [self fillUserDataEntity:_ary[i]];
                _ymdC   = [_ud.UD_CHECKDATE componentsSeparatedByString:@" "][0];
                
                if (!_cp) {
                    _cp     = [[CalculateParam alloc]init];
                    _YMD    = _ymdC;
                }
                
                if ([_ymdC isEqualToString:_YMD]) {
                    [_cp addData:_ud userInfo:_user];
                    if (i == (_ary.count - 1) && _cp.dataCount > 0) {
                        [_result addObject:[_cp getDataMax:_maxList min:_minList]];
                    }
                }
                else{
                    
                    if ( _cp.dataCount > 0) {
                        [_result addObject:[_cp getDataMax:_maxList min:_minList]];
                    }
                    _cp     = [[CalculateParam alloc]init];
                    [_cp addData:_ud userInfo:_user];
                    _YMD    = _ymdC;
                }
                
            }
            
            for (int i = 0; i < _minList.count; i++) {
                if([_minList[i] intValue] == 10000){
                    _minList[i] = @0;
                }
            }
            
        }
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _dicResult;
    }
}


-(NSDictionary *)getMonth:(NSDate *)targetDate
            userDataByUid:(NSString *)uid
{
    
    NSDictionary *_dicResult = @{@"dataList":[[NSMutableArray alloc]init],
                                 @"minNumList":[NSMutableArray arrayWithArray:kMinMaxDefualtList],
                                 @"maxNumList":[NSMutableArray arrayWithArray:kMinMaxDefualtList]};
    
    
    
    if ([Helpers strIsEmty:uid] || !targetDate) {
        return _dicResult;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    
    
    @try {
        NSMutableArray *_result     = _dicResult[@"dataList"];
        NSMutableArray *_maxList    = _dicResult[@"maxNumList"];
        NSMutableArray *_minList    = _dicResult[@"minNumList"];
        
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        int _days = [NSDate daysInMonthByDate:targetDate];
        NSDictionary *_tDic = [Helpers getDateInfoForDate:targetDate];
        
        NSString *_minDateStr = [NSString stringWithFormat:@"%@-%@-01 00:00:00",
                                 _tDic[@"year"],
                                 _tDic[@"month"]];
        
        NSString *_maxDateStr = [NSString stringWithFormat:@"%@-%@-%02d 23:59:59",
                                 _tDic[@"year"],
                                 _tDic[@"month"],
                                 _days];
        
        NSArray *_ary = [_dbaObj findUserDataByUid:uid
                                        minDateStr:_minDateStr
                                        maxDateStr:_maxDateStr];
        
        
        if (_ary.count > 0) {
            
            for (int i = 0; i < _minList.count; i++) {
                _minList[i] = @10000;
            }
            
            UserDataEntity *_ud     = nil;
            UserInfoEntity *_user   = [GloubleProperty sharedInstance].currentUserEntity;
            CalculateParam *_cp     = nil;
            NSString *_YMD          = nil;
            NSString *_ymdC         = nil;
            for (int i = 0 ; i < _ary.count; i++) {
                
                _ud     = [self fillUserDataEntity:_ary[i]];
                _ymdC   = [_ud.UD_CHECKDATE componentsSeparatedByString:@" "][0];
                
                if (!_cp) {
                    _cp     = [[CalculateParam alloc]init];
                    _YMD    = _ymdC;
                }
                
                if ([_ymdC isEqualToString:_YMD]) {
                    [_cp addData:_ud userInfo:_user];
                    if (i == (_ary.count - 1) && _cp.dataCount > 0) {
                        
                        [_result addObject:[_cp getDataMax:_maxList min:_minList]];
                    }
                }
                else{
                    if ( _cp.dataCount > 0) {
                        [_result addObject:[_cp getDataMax:_maxList min:_minList]];
                    }
                    _cp     = [[CalculateParam alloc]init];
                    [_cp addData:_ud userInfo:_user];
                    _YMD    = _ymdC;
                }
                
            }
            
            
            for (int i = 0; i < _minList.count; i++) {
                if([_minList[i] intValue] == 10000){
                    _minList[i] = @0;
                }
            }
        }
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _dicResult;
    }
}

-(NSDictionary *)getYear:(NSDate *)targetDate
           userDataByUid:(NSString *)uid
{
    
    NSDictionary *_dicResult = @{@"dataList":[[NSMutableArray alloc]init],
                                 @"minNumList":[NSMutableArray arrayWithArray:kMinMaxDefualtList],
                                 @"maxNumList":[NSMutableArray arrayWithArray:kMinMaxDefualtList]};
    
    
    
    if ([Helpers strIsEmty:uid] || !targetDate) {
        return _dicResult;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        NSMutableArray *_result     = _dicResult[@"dataList"];
        NSMutableArray *_maxList    = _dicResult[@"maxNumList"];
        NSMutableArray *_minList    = _dicResult[@"minNumList"];
        
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        
        
        NSDictionary *_tDic = [Helpers getDateInfoForDate:targetDate];
        
        NSString *_minDateStr = [NSString stringWithFormat:@"%@-01-01 00:00:00",
                                 _tDic[@"year"] ];
        
        NSString *_maxDateStr = [NSString stringWithFormat:@"%@-12-31 23:59:59",
                                 _tDic[@"year"] ];
        
        NSArray *_ary = [_dbaObj findUserDataByUid:uid
                                        minDateStr:_minDateStr
                                        maxDateStr:_maxDateStr];
        
        
        if (_ary.count > 0) {
            
            for (int i = 0; i < _minList.count; i++) {
                _minList[i] = @10000;
            }
            
            //UserDataEntity *_ud         = nil;
            UserInfoEntity *_user       = [GloubleProperty sharedInstance].currentUserEntity;
            int _age                    = [_user.UI_age intValue];
            CalculateParam *_cp         = nil;
            NSString *_YMD              = nil;
            NSString *_ymdC             = nil;
            NSDictionary *_udDic        = nil;
            
            NSMutableArray  *_dayAry    = [[NSMutableArray alloc]init];
            
            for (int i = 0 ; i < _ary.count; i++) {
                _udDic  = _ary[i];
                //_ud     = [self fillUserDataEntity:_ary[i]];
                //_ymdC   = [_ud.UD_CHECKDATE componentsSeparatedByString:@" "][0];
                _ymdC     = [(NSString *)_udDic[@"CHECKDATE"] componentsSeparatedByString:@" "][0];
                
                if (!_cp) {
                    _cp     = [[CalculateParam alloc]init];
                    _YMD    = _ymdC;
                }
                
                if ([_ymdC isEqualToString:_YMD]) {
                    //[_cp addData:_ud userInfo:_user];
                    [_cp addData:_udDic age:_age];
                    if (i == (_ary.count - 1) && _cp.dataCount > 0) {
                        
                        //[_dayAry addObject:[_cp getDataMax:nil min:nil]];
                        [_dayAry addObject:[_cp getCPData]];
                    }
                }
                else{
                    if ( _cp.dataCount > 0) {
                        //[_dayAry addObject:[_cp getDataMax:nil min:nil]];
                        [_dayAry addObject:[_cp getCPData]];
                    }
                    _cp     = [[CalculateParam alloc]init];
                    //[_cp addData:_ud userInfo:_user];
                    [_cp addData:_udDic age:_age];
                    _YMD    = _ymdC;
                }
                
            }
            
            
            if (_dayAry.count > 0) {
                _cp     = nil;
                //_ud     = nil;
                CalculateParam *_cpTemp = nil;
                _udDic  = nil;
                _YMD    = nil;
                _ymdC   = nil;
                
                for (int i = 0 ; i < _dayAry.count; i++) {
                    
                    _cpTemp = _dayAry[i];
                    _ymdC   = /*[NSString stringWithFormat:@"%@-%@",
                               [_ud.UD_CHECKDATE componentsSeparatedByString:@"-"][0],*/
                    //[_ud.UD_CHECKDATE componentsSeparatedByString:@"-"][1]; //];
                    [_cpTemp.dateStr componentsSeparatedByString:@"-"][1];
                    
                    if (!_cp) {
                        _cp     = [[CalculateParam alloc]init];
                        _YMD    = _ymdC;
                    }
                    
                    if ([_ymdC isEqualToString:_YMD]) {
                        //[_cp addData:_ud userInfo:_user];
                        [_cp addData:_cpTemp age:_age];
                        if (i == (_dayAry.count - 1) && _cp.dataCount > 0) {
                            
                            [_result addObject:[_cp getDataMax:_maxList min:_minList]];
                        }
                    }
                    else{
                        if ( _cp.dataCount > 0) {
                            [_result addObject:[_cp getDataMax:_maxList min:_minList]];
                        }
                        _cp     = [[CalculateParam alloc]init];
                        //[_cp addData:_ud userInfo:_user];
                        [_cp addData:_cpTemp age:_age];
                        _YMD    = _ymdC;
                    }
                    
                }
                
            }
            
            for (int i = 0; i < _minList.count; i++)
            {
                if([_minList[i] intValue] == 10000){
                    _minList[i] = @0;
                }
            }
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _dicResult;
    }
}

/**
 * @brief   根据用户userId获取UserData数据
 *
 * @param   uid 目标用户userId
 * @return  UserData 列表：元素类型UserDataEntity
 */
-(NSArray *)getUserDataByUid:(NSString *)uid
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:uid]) {
        return _result;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        NSArray *_ary = [_dbaObj findUserDataByUid:uid sort:0];
        
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_udDic = _ary[i];
            [_result addObject:[self fillUserDataEntity:_udDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}



-(NSArray *)getUserDataByUid:(NSString *)uid
                      pageId:(int)pageId
                countPerPage:(int)cPP
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        NSMutableString *_conditionStr = [[NSMutableString alloc]init];
        [_conditionStr appendString:@" WHERE"];
        if (![Helpers strIsEmty:uid]) {
            [_conditionStr appendString:@" userId = '"];
            [_conditionStr appendString:uid];
            [_conditionStr appendString:@"' AND"];
        }
        [_conditionStr appendString:@" isFriendData = '0' ORDER BY CHECKDATE DESC"];
        
        if (pageId >= 0 && cPP > 0) {
            [_conditionStr appendFormat:@" LIMIT %d,%d",pageId * cPP , cPP];
        }
        
        NSArray *_ary = [_dbaObj findUserDataByConditionStr:_conditionStr];
        /*
         NSArray *_ary = [_dbaObj findUserDataByConditionStr:@" WHERE userId = '%@' AND isFriendData = '0' ORDER BY CHECKDATE DESC LIMIT 1"];
         */
        
        
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_udDic = _ary[i];
            [_result addObject:[self fillUserDataEntity:_udDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}


/**
 * @brief   根据用户userId获取最后一条UserData数据
 *
 * @param   uid 目标用户userId num:最后第几条
 * @return  UserData 对象
 */
-(UserDataEntity *)getUserDataByUid:(NSString *)uid
                                num:(int)num
{
    UserDataEntity *_result = nil;
    
    if ([Helpers strIsEmty:uid]) {
        return _result;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        NSArray *_ary = [_dbaObj findUserDataByUid:uid num:num];
        
        
        if (_ary && _ary.count > num - 1) {
            
            NSDictionary *_udDic    = _ary[num - 1];
            _result                 = [self fillUserDataEntity:_udDic];
            
        }
        
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}


/**
 * @brief   根据用户userId获取最后一条UserData数据
 *
 * @param   uid 目标用户userId num:最后几条
 * @return  UserData 对象列表
 */
-(NSArray *)getLastUserDataListByUid:(NSString *)uid
                                 num:(int)num
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:uid] || num  < 1) {
        return _result;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        NSArray *_ary = [_dbaObj findUserDataByUid:uid num:num];
        
        if (_ary) {
            for (int i = 0; i < _ary.count; i++) {
                NSDictionary *_udDic    = _ary[i];
                [_result  addObject: [self fillUserDataEntity:_udDic]];
            }
        }
        
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}





/**
 * @brief   根据用户userId获取最后一条UserData数据
 *
 * @param   uid 目标用户userId date:日期
 * @return  UserData 对象
 */
-(UserDataEntity *)getUserDataByUid:(NSString *)uid
                               date:(NSString *)checkDate
{
    UserDataEntity *_result = nil;
    
    if ([Helpers strIsEmty:uid] || [Helpers strIsEmty:checkDate]) {
        return _result;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        NSArray *_ary = [_dbaObj findUserDataByCheckDate:checkDate uid:uid];
        
        
        if (_ary && _ary.count > 0) {
            
            NSDictionary *_udDic    = _ary[0];
            _result                 = [self fillUserDataEntity:_udDic];
            
        }
        
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}

/**
 * @brief   根据用户userId获取最后一条UserData数据
 *
 * @param   uid 目标用户userId dataId:数据id
 * @return  UserData 对象 列表
 */
-(NSArray *)getUserDataByUid:(NSString *)uid
                      dataId:(NSString *)dataId
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:uid]) {
        return _result;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        NSArray *_ary = [_dbaObj findUserDataByUid:uid dataId:dataId];
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_udDic = _ary[i];
            [_result addObject:[self fillUserDataEntity:_udDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}



/**
 * @brief   根据用户dataId获取UserData数据
 *
 * @param   dataId:数据id
 * @return  UserData 对象 列表
 */
-(NSArray *)getUserDataByDataId:(NSString *)dataId
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:dataId]) {
        return _result;
    }
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        NSString *_cStr = [NSString stringWithFormat:@" WHERE ID = '%@' AND isFriendData = '0'",dataId];
        NSArray *_ary = [_dbaObj findUserDataByConditionStr:_cStr];
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_udDic = _ary[i];
            [_result addObject:[self fillUserDataEntity:_udDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}


/**
 *  根据数据id删除数据
 *
 *  @param dataId 数据id
 */
-(int)deleteDataByDid:(NSString *)dataId
{
    int _result = 0;
    
    if (!dataId) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        
        _result = [_dbaObj deleteUserDataByConditionStr:
                   [NSString stringWithFormat:@" where ID = '%@'",dataId] ];
        
        
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
        
    }
    @catch (NSException *exception) {
        //NSLog(@"NSException:%@",exception.description);
        if (_dbManager) {
            [_dbManager rollback];
        }
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}

#pragma mark -
#pragma mark userInfo
/**
 * @brief   获取本机用户列表
 *
 * @param   uid 当前用户id
 * @return  结果列表: 元素类型UserInfoEntity
 */
- (NSArray *)getLocalUserList:(NSString *)uid
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:uid]) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        NSArray *_ary = [_dbaObj findUserInfoByIsLoc:1];
        
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_userDic = _ary[i];
            
            if (![uid isEqualToString:_userDic[@"userId"]]) {
                UserInfoEntity *_tempUser = [self fillUserInfoEntity:_userDic];
                UserDataEntity *_lastUd = [[DatabaseService defaultDatabaseService]getUserDataByUid:_tempUser.UI_userId num:1];
                if (_lastUd) {
                    _tempUser.UI_lastCheckDate = _lastUd.UD_CHECKDATE;
                    _tempUser.UI_lastUserData  = _lastUd;
                }
                [_result addObject:_tempUser];
            }
            
        }
        
        
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
    
    return _result;
}

/**
 * @brief   根据uid获得用户
 *
 * @param   uid 目标用户id
 * @return  结果对象: 元素类型UserInfoEntity
 */
- (UserInfoEntity *)getUserByUid:(NSString *)uid
{
    UserInfoEntity *_tempUser = nil;
    if (!uid) {
        return _tempUser;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        
        
        NSArray *_ary = [_dbaObj findUserInfoByUid:uid];
        
        
        
        if (_ary && _ary.count > 0) {
            
            NSDictionary *_userDic = _ary[0];
            
            _tempUser = [self fillUserInfoEntity:_userDic];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _tempUser;
    }
}




/**
 * @brief   保存登录用户
 *
 * @param   user 用户信息对象
 * @return  0保存失败，1保存成功，2其他状况
 */
- (int)saveLoginUser:(UserInfoEntity *)user
{
    int _result = 0;
    
    if (!user || !user.UI_userId) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        
        NSArray *_userList = [_dbaObj findUserInfoByUid:user.UI_userId];
        
        if ( _userList && _userList.count > 0) {
            _result = [_dbaObj updateUserInfoByUid:[self fillUpdateUserInfo:user
                                                                 originUser:_userList[0]]];
        }else{
            _result = [_dbaObj saveUserInfo:user];
            [self fillUpdateUserInfo:user originUser:nil];
        }
        
        
    }
    @catch (NSException *exception) {
        
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}

/**
 *  删除用用户
 *
 *  @param uid 用户id
 *
 *  @return 0失败，1成功
 */
- (int)deleteUser:(NSString *)uid{
    int _result = 0;
    
    if (!uid ) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        
        _result = [_dbaObj deleteUserByUid:uid];
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
    }
    @catch (NSException *exception) {
        
        if (_dbManager) {
            [_dbManager rollback];
        }
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}

#pragma mark    赞／激励／提醒称重人
/**
 *  根据主userId查询 赞／激励／提醒称重人 列表
 *
 *  @param userId 主userId
 *  @param type   1：赞 ，2：激励 3:提醒称重 4.全部
 *
 *  @return
 */
-(NSArray *)getPariseUserListbyUserId:(NSString *)userId
                                 type:(NSString *)tp
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:userId]  ) {
        return _result;
    }
    
    if ([Helpers strIsEmty:tp]) {
        tp = @"4";
    }
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        
        NSArray *_ary = [_dbaObj findPraiseUserByUserId:userId
                                                   type:tp];
        
        
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_userDic = _ary[i];
            [_result addObject:[self fillPraiseUserEntity:_userDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}

/**
 *  保存PariseUserList
 *
 *  @param pUserList PariseUser 对象列表
 *
 *  @return  0失败，1成功
 */
-(int)savePariseUserList:(NSArray *)pUserList uid:(NSString *)uid
{
    int _result = 0;
    
    if (!pUserList || !uid) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        [_dbaObj deletePraiseUserByUid:uid type:nil];
        
        _result = 1;
        
        for (int i = 0; i < pUserList.count; i++) {
            _result *= [_dbaObj savePraiseUser:pUserList[i]];
        }
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
    }
    @catch (NSException *exception) {
        
        _result = 0;
        if (_dbManager) {
            [_dbManager rollback];
        }
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}

#pragma mark    好友信息 friendInfo
/**
 * @brief   获取用户好友列表
 *
 * @param   uid 用户id
 * @return  结果列表: 元素类型UserInfoEntity
 */
- (NSArray *)getUserFriendList:(NSString *)uid
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:uid]) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        
        NSArray *_ary = [_dbaObj findFriendInfoByCondition:
                         [NSString stringWithFormat:@" WHERE userId = '%@' and status = '0'",uid ]];
        
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_userDic = _ary[i];
            [_result addObject:[self fillFriendInfoEntity:_userDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}


/**
 *  根据用户id 和 好友id 查询好友
 *
 *  @param uid      用户id
 *  @param memidatt 好友id
 *
 *  @return 结果列表: 元素类型FriendInfoEntity
 */
- (NSArray *)getUserFriendListByUid:(NSString *)uid
                           memidatt:(NSString *)memidatt
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:uid] || [Helpers strIsEmty:memidatt]) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        
        NSArray *_ary = [_dbaObj findFriendInfoByCondition:
                         [NSString stringWithFormat:@" WHERE userId = '%@' and memidatt = '%@'",
                          uid,
                          memidatt ]];
        
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_userDic = _ary[i];
            [_result addObject:[self fillFriendInfoEntity:_userDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}


/**
 * @brief   获取用户非好友列表
 *
 * @param   uid 用户id
 * @return  结果列表: 元素类型UserInfoEntity
 */
- (NSArray *)getUserARFriendList:(NSString *)uid
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:uid]) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        
        NSArray *_ary = [_dbaObj findFriendInfoByCondition:
                         [NSString stringWithFormat:@" WHERE userId = '%@' and status != '0'",uid ]];
        
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_userDic = _ary[i];
            [_result addObject:[self fillFriendInfoEntity:_userDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}


/**
 * @brief   获取好友请求列表
 *
 * @param   uid 用户id
 * @return  结果列表: 元素类型UserInfoEntity
 */
- (NSArray *)getPreUserFriendList:(NSString *)uid
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:uid]) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        
        NSArray *_ary = [_dbaObj findFriendInfoByCondition:
                         [NSString stringWithFormat:@" WHERE userId = '%@' and status = '2'",uid ]];
        
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_userDic = _ary[i];
            [_result addObject:[self fillFriendInfoEntity:_userDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}


/**
 * @brief  保存friendList
 *
 * @param  friendList 好友对象数组
 * @return 0:失败，1:成功
 */
- (int)saveFriendList:(NSArray *)friendList
               userId:(NSString *)uid
{
    int _result = 0;
    
    if (!friendList && !uid) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        int _flag = [_dbaObj deleteFriendByConditionStr:
                     [NSString stringWithFormat:@"  WHERE userId = '%@'",uid]];
        
        
        
        if (_flag == 0) {
            //NSLog(@"删除 Suggest 失败");
        }
        
        _result = 1;
        
        for (int i = 0 ; i < friendList.count; i++) {
            _result *= [_dbaObj saveFriendInfo:friendList[i]];
        }
        
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
        
    }
    @catch (NSException *exception) {
        //NSLog(@"NSException:%@",exception.description);
        if (_dbManager) {
            [_dbManager rollback];
        }
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}


/**
 * @brief  删除friend
 *
 * @param  fEntity 好友对象
 * @return 0:失败，1:成功
 */
- (int)deleteFriend:(FriendInfoEntity *)fEntity
{
    int _result = 0;
    
    if (!fEntity) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        _result = [_dbaObj deleteFriendByConditionStr:
                   [NSString stringWithFormat:@"  WHERE mid = '%@'",fEntity.FI_mid]];
        
        
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
        
    }
    @catch (NSException *exception) {
        //NSLog(@"NSException:%@",exception.description);
        if (_dbManager) {
            [_dbManager rollback];
        }
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}


/**
 *  更新好有信息
 *
 *  @param fEntity 好有对象
 * @return 0:失败，1:成功
 */
-(int)updateFriend:(FriendInfoEntity *)fEntity
{
    int _result = 0;
    
    if (!fEntity) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        
        _result = [_dbaObj updateFriend:[self fillUpdateFriend:fEntity]
                              condition:[NSString stringWithFormat:@" where mid = '%@'",fEntity.FI_mid] ];
        
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"NSException:%@",exception.description);
        if (_dbManager) {
            [_dbManager rollback];
        }
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}


#pragma mark    建议回复 Suggest
/**
 * @brief  保存Suggests
 *
 * @param  建议及回复信息对象数组
 * @return 0:失败，1:成功
 */
- (int)saveSuggest:(NSArray *)suggestList uid:(NSString *)uid
{
    int _result = 0;
    
    if (!suggestList) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        int _flag = [_dbaObj deleteSuggestByUid:uid];
        
        if (_flag == 0) {
            //NSLog(@"删除 Suggest 失败");
        }
        
        _result = 1;
        
        for (int i = 0 ; i < suggestList.count; i++) {
            _result *= [_dbaObj saveSuggest:suggestList[i]];
        }
        
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
        
    }
    @catch (NSException *exception) {
        //NSLog(@"NSException:%@",exception.description);
        if (_dbManager) {
            [_dbManager rollback];
        }
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}

/**
 * @brief  根据uid 获取 Suggests
 *
 * @param  用户id
 * @return Suggests列表
 */
- (NSArray *)getSuggestListByUiduid:(NSString *)uid
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:uid]) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        NSArray *_ary = [_dbaObj findSuggestByUids:uid];
        
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_suggestDic = _ary[i];
            [_result addObject:[self fillSuggestEntity:_suggestDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}


#pragma mark -
#pragma mark Notice  时间提示信息

/**
 * @brief  保存Notice
 *
 * @param  noticeList建议及回复信息对象数组  uid用户id
 * @return 0:失败，1:成功
 */
- (int)saveNotices:(NSArray *)noticeList uid:(NSString *)uid
{
    int _result = 0;
    
    if (!noticeList || [Helpers strIsEmty:uid]) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        int _flag = [_dbaObj deleteNoticeByUid:uid];
        
        if (_flag == 0) {
            //NSLog(@"删除 Notice 失败");
        }
        
        _result = 1;
        
        for (int i = 0 ; i < noticeList.count; i++) {
            _result *= [_dbaObj saveTBNotice:noticeList[i]];
        }
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"NSException:%@",exception.description);
        if (_dbManager) {
            [_dbManager rollback];
        }
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}

/**
 * @brief  根据uid 获取 Notices
 *
 * @param  用户id
 * @return Notice列表
 */
- (NSArray *)getNoticeListByUid:(NSString *)uid;
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:uid]) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        NSArray *_ary = [_dbaObj findNoticeByUid:uid];
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_noticeDic = _ary[i];
            [_result addObject:[self fillNoticeEntity:_noticeDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}


/**
 * @brief  根据uid 获取 Notices
 *
 * @param  用户id
 * @return Notice对象
 */
- (NoticeEntity *)getNowNoticeByUid:(NSString *)uid;
{
    NoticeEntity *_result = nil;
    
    if ([Helpers strIsEmty:uid]) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        NSString *_dateStr = [[Helpers getDateStr:[NSDate date]] componentsSeparatedByString:@" "][1];
        _dateStr = [NSString stringWithFormat:@"%@:%@",
                    [_dateStr componentsSeparatedByString:@":"][0],
                    [_dateStr componentsSeparatedByString:@":"][1]];
        NSString *_cStr = [NSString stringWithFormat:@" where userId = '%@' and time > '%@' order by time asc",
                           uid,_dateStr];
        NSArray *_ary = [_dbaObj findNoticeByConditionStr:_cStr];
        
        
        if (_ary && _ary.count > 0) {
            _result = [self fillNoticeEntity:_ary[0]];
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}

#pragma mark -
#pragma mark UserDeviceInfo  用户与设备关系

/**
 * @brief  保存UserDeviceInfo
 *
 * @param  UserDeviceInfoList 用户与设备关系对象数组
 * @return 0:失败，1:成功
 */
- (int)saveUserDeviceInfos:(NSArray *)userDeviceInfoList uid:(NSString *)uid
{
    int _result = 0;
    
    if (!userDeviceInfoList || !uid) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        if (_dbManager) {
            [_dbManager beginTransaction];
        }
        
        int _flag = [_dbaObj deleteUserDeviceInfoByUid:uid];
        
        if (_flag == 0) {
            //NSLog(@"删除 Notice 失败");
        }
        
        _result = 1;
        
        for (int i = 0 ; i < userDeviceInfoList.count; i++) {
            _result *= [_dbaObj saveUserDeviceInfo:userDeviceInfoList[i]];
        }
        
        if (_dbManager) {
            [_dbManager commitTransaction];
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"NSException:%@",exception.description);
        
        if (_dbManager) {
            [_dbManager rollback];
        }
        
        if (self.target &&
            [self.target respondsToSelector:@selector(databaseServiceOperation:state:)])
        {
            [self.target databaseServiceOperation:@{ @"info":exception }
                                            state:OperationException];
        }
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        
        return _result;
    }
}

/**
 * @brief  根据uid 获取 UserDeviceInfos
 *
 * @param  用户id
 * @return Notice列表
 */
- (NSArray *)getUserDeviceInfoListByUid:(NSString *)uid;
{
    NSMutableArray *_result = [[NSMutableArray alloc]init];
    
    if ([Helpers strIsEmty:uid]) {
        return _result;
    }
    
    
    DBHelper *_dbManager    = nil;
    DBAccessObject *_dbaObj = nil;
    
    @try {
        _dbManager    = [[DBHelper alloc]init];
        [_dbManager connect:[self getPath]];
        
        _dbaObj       = [DBAccessObject createDBAccessObject:_dbManager];
        
        
        NSArray *_ary = [_dbaObj findUserDeviceInfoByUid:uid];
        
        
        
        for (int i = 0 ; i < _ary.count; i++) {
            
            NSDictionary *_noticeDic = _ary[i];
            [_result addObject:[self fillUserDeviceInfoEntity:_noticeDic]];
            
        }
        
    }
    @catch (NSException *exception) {
        //NSLog(@"Exc:%@",exception.description);
        
    }
    @finally {
        if (_dbaObj) {
            [_dbaObj over];
        }
        if (_dbManager) {
            [_dbManager close];
        }
        return _result;
    }
}

@end
