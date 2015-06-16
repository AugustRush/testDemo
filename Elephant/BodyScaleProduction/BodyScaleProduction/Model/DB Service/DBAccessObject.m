//
//  DBAccessObject.m
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "DBAccessObject.h"

#import "Helpers.h"
#import "FMDatabaseAdditions.h"



#import "DBInfo.h"






@implementation DBAccessObject


#pragma mark -
#pragma mark 辅助
-(BOOL)checkTable:(NSString *)tableName
{
    FMDatabase *_db = [_dbManager getDatabase];
    FMResultSet * set = [_db executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",tableName]];
    
    [set next];
    
    NSInteger count = [set intForColumnIndex:0];
    
    return !!count;
    
}

-(NSString *)inputStr:(NSString *)ipStr
{
    return [Helpers strIsEmty:ipStr]?@"":ipStr;
}


-(NSString *)fillSaveSql:(NSString *)tableName
           paramKeyArray:(NSArray *)pAry
{
    NSMutableString *_sql = [NSMutableString stringWithFormat:@"INSERT INTO %@ (",tableName];
    
    
    for (int i = 0; i < pAry.count - 1; i++) {
        [_sql appendString:[NSString stringWithFormat:@"%@,",pAry[i]]];
    }
    if (pAry.count > 0) {
        [_sql appendString:[NSString stringWithFormat:@"%@",pAry[pAry.count - 1]]];
    }
    
    [_sql appendString:@") VALUES ("];
    for (int i = 0; i < pAry.count - 1; i++) {
        [_sql appendString:@"?,"];
    }
    if (pAry.count > 0) {
        [_sql appendString:@"?"];
    }
    [_sql appendString:@")"];
    
    return _sql;
}


/* 根据entity 填充param */
-(NSArray *)fillJDUserInfoParamAry:(JDUserInfoEntity *)obj
{
    /*
    @"userId",@"uid",@"user_nick",@"access_token",
    @"refresh_token",@"expires_in",@"time"
     */
    NSArray *_ary = @[[self inputStr:obj.userId],
                      [self inputStr:obj.uid],
                      [self inputStr:obj.user_nick],
                      [self inputStr:obj.access_token],
                      
                      [self inputStr:obj.refresh_token],
                      [self inputStr:obj.expires_in ],
                      [self inputStr:obj.time]
                      ];
    return _ary;
}


-(NSArray *)fillUserInfoParamAry:(UserInfoEntity *)obj
{
    NSArray *_ary = @[[self inputStr:obj.UI_userId],
                      [self inputStr:obj.UI_loginName],
                      [self inputStr:obj.UI_loginPwd],
                      [self inputStr:obj.UI_deviceNo],
                      
                      [self inputStr:obj.UI_sex],
                      [self inputStr:obj.UI_age],
                      [self inputStr:obj.UI_weight],
                      [self inputStr:obj.UI_height],
                      
                      [self inputStr:obj.UI_focusModel],
                      [self inputStr:obj.UI_photoPath],
                      [self inputStr:obj.UI_cname],
                      [self inputStr:obj.UI_loginId],
                      
                      [self inputStr:obj.UI_remindmode],
                      [self inputStr:obj.UI_remindcycle],
                      [self inputStr:obj.UI_memid],
                      [self inputStr:obj.UI_plan],
                      
                      [self inputStr:obj.UI_target],
                      [self inputStr:obj.UI_privacy],
                      [self inputStr:obj.UI_mode],
                      [self inputStr:obj.UI_lastCheckDate],
                      
                      
                      [self inputStr:obj.UI_fat],
                      [self inputStr:obj.UI_nickname],
                      [self inputStr:obj.UI_countpraise],
                      [self inputStr:obj.UI_lastlocation],
                      
                      [self inputStr:obj.UI_isLoc],
                      [self inputStr:obj.UI_birthday]
                      ];
    return _ary;
}

-(NSArray *)fillFriendInfoParamAry:(FriendInfoEntity *)obj
{

    NSArray *_ary = @[[self inputStr:obj.FI_userId],
                      [self inputStr:obj.FI_mid],
                      [self inputStr:obj.FI_memidatt],
                      [self inputStr:obj.FI_isspeci],
                      
                      [self inputStr:obj.FI_status],
                      [self inputStr:obj.FI_mright],
                      [self inputStr:obj.FI_insertTime],
                      [self inputStr:obj.FI_cname],
                      
                      [self inputStr:obj.FI_nickName],
                      [self inputStr:obj.FI_loginId],
                      [self inputStr:obj.FI_photopath],
                      [self inputStr:obj.FI_ismutual],
                      
                      [self inputStr:obj.FI_isRead],
                      [self inputStr:obj.FI_birthday],
                      [self inputStr:obj.FI_age],
                      [self inputStr:obj.FI_sex],
                      
                      [self inputStr:obj.FI_countpraise],
                      [self inputStr:obj.FI_weight],
                      [self inputStr:obj.FI_bmi],
                      [self inputStr:obj.FI_fat],
                      
                      
                      [self inputStr:obj.FI_checkdate],
                      [self inputStr:obj.FI_mid_att],
                      [self inputStr:obj.FI_mright_att]
                      
                      
                      ];
    return _ary;

}

-(NSArray *)fillUserDataParamAry:(UserDataEntity *)obj
{
    NSArray *_ary = @[[self inputStr:obj.UD_ID],
                      [self inputStr:obj.UD_MEMID],
                      [self inputStr:obj.UD_WEIGHT],
                      [self inputStr:obj.UD_BMI],
                      
                      [self inputStr:obj.UD_FAT],
                      [self inputStr:obj.UD_SKINFAT],
                      [self inputStr:obj.UD_OFFALFAT],
                      [self inputStr:obj.UD_MUSCLE],
                      
                      [self inputStr:obj.UD_METABOLISM],
                      [self inputStr:obj.UD_WATER],
                      [self inputStr:obj.UD_BONE],
                      [self inputStr:obj.UD_BODYAGE],
                      
                      [self inputStr:obj.UD_STATUS],
                      [self inputStr:obj.UD_CHECKDATE],
                      [self inputStr:obj.UD_CREATETIME],
                      [self inputStr:obj.UD_MODIFYTIME],
                      
                      [self inputStr:obj.UD_devcode],
                      [self inputStr:obj.UD_longit],
                      [self inputStr:obj.UD_latit],
                      [self inputStr:obj.UD_location],
                      
                      [self inputStr:obj.UD_isFriendData],
                      [self inputStr:obj.UD_userId],
                      [self inputStr:obj.UD_ryFit]];
    return _ary;
}


-(NSArray *)fillSuggestParamAry:(SuggestEntity *)obj
{
    NSArray *_ary = @[[self inputStr:obj.S_id],
                      [self inputStr:obj.S_memid],
                      [self inputStr:obj.S_suggesttype],
                      [self inputStr:obj.S_admin],
                      
                      [self inputStr:obj.S_content],
                      [self inputStr:obj.S_status],
                      [self inputStr:obj.S_createtime]];
    return _ary;
}

-(NSArray *)fillNoticeEntityParamAry:(NoticeEntity *)obj
{

    NSArray *_ary = @[[self inputStr:obj.N_id],
                      [self inputStr:obj.N_noticetype],
                      [self inputStr:obj.N_time],
                      [self inputStr:obj.N_actionName],
                      
                      [self inputStr:obj.N_content],
                      [self inputStr:obj.N_picurl],
                      [self inputStr:obj.N_userId]];
    return _ary;
}

-(NSArray *)fillUserDeviceInfoEntityParamAry:(UserDeviceInfoEntity *)obj
{
    
    NSArray *_ary = @[[self inputStr:obj.UDI_id],
                      [self inputStr:obj.UDI_memid],
                      [self inputStr:obj.UDI_devcode],
                      [self inputStr:obj.UDI_location],
                      
                      [self inputStr:obj.UDI_status],
                      [self inputStr:obj.UDI_createtime],
                      [self inputStr:obj.UDI_modifytime]];
    return _ary;
}


-(NSArray *)fillUserPraiseParamAry:(UserPraiseEntity *)obj
{
    
    NSArray *_ary = @[[self inputStr:obj.up_userId],
                      [self inputStr:obj.up_type],
                      [self inputStr:obj.up_memid],
                      [self inputStr:obj.up_nickname],
                      
                      [self inputStr:obj.up_cname],
                      [self inputStr:obj.up_photopath],
                      [self inputStr:obj.up_sex],
                      [self inputStr:obj.up_status],
                      
                      [self inputStr:obj.up_createtime]];
    return _ary;
}


-(NSMutableArray *)fillDic:(NSArray *)keyAry rs:(FMResultSet *)rs
{
    NSMutableArray * array  = [NSMutableArray arrayWithCapacity:[rs columnCount]];
	while ([rs next])
    {
        NSMutableDictionary *_objDic = [[NSMutableDictionary alloc]init];
        
        for (int i = 0; i < keyAry.count; i++) {
            
            NSString *_value = [rs stringForColumn:keyAry[i]];
            
            if (_value == NULL) {
                _value = @"";
            }
            
            [_objDic setObject:_value
                        forKey:keyAry[i]];
            
        }
        
        [array addObject:_objDic];
        
	}
    return array;
}


#pragma mark -
#pragma mark basic
+(id)createDBAccessObject:(DBHelper *)dbm
{
    DBAccessObject *_dbao   = [[DBAccessObject alloc]init];
    _dbao->_dbManager       = dbm;
    return _dbao;
}

-(void)over
{
    _dbManager = nil;
}

-(void)dealloc
{
    ////NSLog(@"DBAccessObject dealloc");
}






#pragma mark -

/**
 *  查询数据数量
 *
 *  @param tableName 表名字
 *  @param condition 筛选条件
 *
 *  @return 数据条数
 */
- (NSNumber *)countOfRowInTable:(NSString *)tableName
                   conditionStr:(NSString *)condition
{
    NSNumber * _count = @0;
    
    @try {
        
        NSMutableString * sql = [NSMutableString stringWithFormat:@"select count(*) as db_ttt_C from %@",tableName];
        if (condition) {
            [sql appendFormat:@" %@",condition];
        }
        
        
        FMDatabase *_db   = [_dbManager getDatabase];
        FMResultSet * _rs = [_db executeQuery:sql];
        
        if (_rs.columnCount > 0) {
            NSDictionary *_dic = nil;
            while ([_rs next]) {
                _dic = _rs.resultDictionary;
                
                _count =  (_dic[@"db_ttt_C"] &&  [_dic[@"db_ttt_C"] isKindOfClass:[NSNumber class]] )
                ? _dic[@"db_ttt_C"] : @0 ;
            }
            
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"selectRid-exception:%@",exception.description);
    }
    @finally {
        return _count;
    }
    
    
    
}


-(int)createCol:(NSString *)tableName
        colName:(NSString *)colName
{
    int state = 0;
    
    @try {

            FMDatabase *_db             = [_dbManager getDatabase];
            
            NSMutableString *_sqlStr    = [NSMutableString stringWithFormat:@"alter table %@ add %@ text",tableName,colName];
            
            
            BOOL res = [_db executeUpdate:_sqlStr];
        if (res){
                state = 1;
            }
    
    }
    @catch (NSException *exception) {
        NSLog(@"createCol-exception:%@",exception.description);
        

    }
    @finally {
        return state;
    }
    
}


#pragma mark 京东用户表操作
/**
 * @brief 创建TBUserInfo表
 *
 */
-(int)createTBJDUserInfo
{
    int state = 0;
    if ([self checkTable:kTBJDUSerInfoName])
    {
        ////NSLog(@"table %@ 已存在",kTBUserInfoName);
        state = 2;
    }
    else
    {
        FMDatabase *_db             = [_dbManager getDatabase];
        NSMutableString *_sqlStr    = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (",
                                       kTBJDUSerInfoName];
        
        [_sqlStr appendString:@"tid INTEGER PRIMARY KEY AUTOINCREMENT,"];
        
        for (int i = 0; i < kTBJDUSerInfoKeyAry.count - 1; i++) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT,",kTBJDUSerInfoKeyAry[i]]];
        }
        if (kTBJDUSerInfoKeyAry.count > 0) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT)",kTBJDUSerInfoKeyAry[kTBJDUSerInfoKeyAry.count - 1]]];
        }
        
        BOOL res = [_db executeUpdate:_sqlStr];
        if (!res) {
            //NSLog(@"table %@ 创建失败:%@",kTBUserInfoName,_sqlStr);
        }else{
            state = 1;
        }
    }
    return state;
}


- (NSArray *)findJDUserInfoByConditionStr:(NSString *)conditionStr
{
    NSMutableString * query =
                [NSMutableString stringWithFormat:@"SELECT * FROM %@",kTBJDUSerInfoName] ;
    
    if (conditionStr) {
        [query appendString:conditionStr];
    }
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    NSMutableArray *_ary = [self fillDic:kTBJDUSerInfoKeyAry rs:rs];
	[rs close];
    return _ary;
}


-(int)updateJDUserInfoByUser:(NSDictionary *)user
                conditionStr:(NSString *)conditionStr
{
    int _result = 0;
    if (user) {
        FMDatabase *_db     = [_dbManager getDatabase];
        NSMutableString *_sql = [NSMutableString stringWithFormat:@"UPDATE %@ SET",
                                 kTBJDUSerInfoName];
        
        NSInteger _keyIndex = user.allKeys.count - 1;
        for (int i = 0; i < _keyIndex; i++) {
            NSString *_keyStr = user.allKeys[i];
            [_sql appendFormat:@" %@ = '%@',",_keyStr,[self inputStr:user[_keyStr]]];
        }
        if (user.allKeys.count > 0) {
            
            [_sql appendFormat:@" %@ = '%@'",
             user.allKeys[_keyIndex],
             [self inputStr:user[user.allKeys[_keyIndex]]]];
        }
        if (conditionStr) {
            [_sql appendString:conditionStr ];
        }
        

        
        if (![_db executeUpdate:_sql]) {

            
        }else{
            _result = 1;
        }
    }
    
    
    return _result;
}

- (int)saveJDUserInfo:(JDUserInfoEntity *)user
{
    int state = 0;
    if (user) {
        FMDatabase *_db             = [_dbManager getDatabase];
        
        NSArray *_paramAry = [self fillJDUserInfoParamAry:user];
        
        
        
        NSString *_sql = [self fillSaveSql:kTBJDUSerInfoName
                             paramKeyArray:kTBJDUSerInfoKeyAry];
        

        
        BOOL _flag = [ _db executeUpdate:_sql
                    withArgumentsInArray:_paramAry];
        
        if (_flag){
            state = 1;
        }
    }
    
    
    return state;
}



#pragma mark UserData  个人测量数据表 操作块
/**
 * @brief 创建TBUserData表
 *
 */
-(int)createTBUserData
{
    int state = 0;
    if ([self checkTable:kTBUserDataName])
    {
        ////NSLog(@"table %@ 已存在",kTBUserDataName);
        state = 2;
    }
    else
    {
        FMDatabase *_db             = [_dbManager getDatabase];
        NSMutableString *_sqlStr    = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (",
                                       kTBUserDataName];
        
        [_sqlStr appendString:@"tid INTEGER PRIMARY KEY AUTOINCREMENT,"];

        for (int i = 0; i < kTBUserDataKeyAry.count - 1; i++) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT,",
                                   kTBUserDataKeyAry[i]]];
        }
        if (kTBUserDataKeyAry.count > 0) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT)",
                                   kTBUserDataKeyAry[kTBUserDataKeyAry.count - 1]]];
        }

        BOOL res = [_db executeUpdate:_sqlStr];
        if (!res) {
            //NSLog(@"table %@ 创建失败",kTBUserDataName);
        }else{
            state = 1;
        }
    }
    return state;
}

/**
 * @brief 保存一条UserData记录
 *
 * @param info 需要保存的数据对象
 */
- (int)saveUserData:(UserDataEntity *)info
{
    int _result = 0;
    if (info) {
        FMDatabase *_db             = [_dbManager getDatabase];
        
        NSArray *_paramAry = [self fillUserDataParamAry:info];;

        NSString *_sql = [self fillSaveSql:kTBUserDataName
                             paramKeyArray:kTBUserDataKeyAry];

        BOOL _flag = [ _db executeUpdate:_sql
                    withArgumentsInArray:_paramAry];
        
        if (_flag) {
            _result = 1;
        }
    }
    
    return _result;
    
}



- (NSArray *)findUserDataByConditionStr:(NSString *)conditionStr
{
    NSMutableString * query = [NSMutableString stringWithFormat:@"SELECT * FROM %@",
                               kTBUserDataName] ;
    
    if (conditionStr) {
        [query appendString:conditionStr];
    }
    
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
    NSMutableArray *_ary = [self fillDic:kTBUserDataKeyAry rs:rs];
	[rs close];
    return _ary;
}




/**
 * @brief   根据 Uid 查询好友的UserData列表
 *
 * @param   uid用户userId
 * @return  UserData列表
 */
- (NSArray *)findUserDataByUid:(NSString *)uid
                    minDateStr:(NSString *)minDateStr
                    maxDateStr:(NSString *)maxDateStr
{
    
    NSMutableString * query = [NSMutableString stringWithFormat:@"SELECT * FROM %@ WHERE userId = '%@' AND CHECKDATE <= '%@' AND CHECKDATE >= '%@' ORDER BY CHECKDATE ASC",
                               kTBUserDataName,
                               uid,maxDateStr,
                               minDateStr] ;
    ////NSLog(@"query:%@",query);
    

    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
	NSMutableArray *_ary = [self fillDic:kTBUserDataKeyAry rs:rs];
	[rs close];
    return _ary;
}




/**
 * @brief   根据 Uid 查询UserData列表
 *
 * @param   uid用户userId
 * @return  UserData列表
 */
- (NSArray *)findUserDataByUid:(NSString *)uid
                          sort:(int)sort
{
    NSMutableString * query = [NSMutableString stringWithFormat:@"SELECT * FROM %@ WHERE userId = '%@' AND isFriendData = '0' ORDER BY CHECKDATE",
                               kTBUserDataName,
                               uid] ;
    
    if (sort) {
        [query appendString:@" ASC"];
    }else{
        [query appendString:@" DESC"];
    }
    
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
	NSMutableArray *_ary = [self fillDic:kTBUserDataKeyAry rs:rs];
	[rs close];
    return _ary;
}




/**
 * @brief   根据 Uid 查询UserData列表
 *
 * @param   uid用户userId dataId:数据id
 * @return  UserData列表
 */
- (NSArray *)findUserDataByUid:(NSString *)uid
                        dataId:(NSString *)dataId
{
    NSMutableString * query = [NSMutableString stringWithFormat:@"SELECT * FROM %@ WHERE userId = '%@' AND isFriendData = '0' AND ID = '%@' ORDER BY CHECKDATE",
                               kTBUserDataName,
                               uid,dataId] ;

    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    NSMutableArray *_ary = [self fillDic:kTBUserDataKeyAry rs:rs];
	[rs close];
    return _ary;
    

}






/**
 * @brief   根据 uid 查询最近的UserData列表
 *
 * @param   uid
 * @return  UserData对象列表
 */
- (NSArray *)findUserDataByUid:(NSString *)uid
                           num:(int)num
{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE userId = '%@' AND isFriendData = '0' ORDER BY CHECKDATE DESC LIMIT %d",
                        kTBUserDataName,
                        uid,
                        num] ;

    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
	NSMutableArray *_ary = [self fillDic:kTBUserDataKeyAry rs:rs];
	[rs close];
    return _ary;
}


/**
 * @brief 查询UserData列表
 */
- (NSArray *)findUserData
{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@",kTBUserDataName] ;
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
    NSMutableArray *_ary = [self fillDic:kTBUserDataKeyAry rs:rs];
	[rs close];
    return _ary;
}


/**
 * @brief   根据 dataId 查询好友的UserData列表
 *
 * @param   dataId:ID
 * @return  UserData列表
 */
- (NSArray *)findUserDataByDataId:(NSString *)dataId
{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE ID = '%@' AND isFriendData = '1'",
                        kTBUserDataName,
                        dataId] ;
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
	NSMutableArray *_ary = [self fillDic:kTBUserDataKeyAry rs:rs];
	[rs close];
    return _ary;
}


/**
 * @brief
 *
 * @param   checkDate:ID uid:用户id
 * @return  UserData列表
 */
- (NSArray *)findUserDataByCheckDate:(NSString *)checkDate
                                 uid:(NSString *)uid
{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE userId = '%@' AND CHECKDATE = '%@' AND isFriendData = '0'",
                        kTBUserDataName,
                        uid,
                        checkDate] ;
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
	NSMutableArray *_ary = [self fillDic:kTBUserDataKeyAry rs:rs];
	[rs close];
    return _ary;
}

/**
 * @brief   查询userdata是否存在
 *
 * @param   uid
 * @return  UserData对象的tid
 */
- (int)userDataIsExistByUid:(NSString *)uid
                  checkDate:(NSString *)cd
{
    NSString * query = [NSString stringWithFormat:@"SELECT tid FROM %@ WHERE userId = '%@' AND CHECKDATE = '%@' AND isFriendData = '0' LIMIT 1",
                        kTBUserDataName,
                        uid,
                        cd] ;
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
    int _tid = -1;
    
	while ([rs next])
    {
        _tid = [rs intForColumn:@"tid"];
	}
    
    
    
	[rs close];
    
    
    
    
    return _tid;
}

/**
 * @brief 删除一条UserData数据
 *
 * @param ConditionStr 筛选条件
 */
- (int)deleteUserDataByConditionStr:(NSString *)conditionStr
{
    int _result             = 0;
    FMDatabase *_db         = [_dbManager getDatabase];
    NSMutableString * query = [NSMutableString stringWithFormat:@"DELETE FROM %@",kTBUserDataName];
    
    if (conditionStr) {
        [query appendString:conditionStr];
    }
    
    if ([_db executeUpdate:query]) {
        
        _result = 1;
    }else{
        //NSLog(@"删除失败，%@",query);
    }
    
    return _result;
}

/**
 * @brief 修改用户的信息
 *
 * @param user 需要修改的用户信息
 */
- (int)updateUserDataByID:(NSDictionary *)info
{
    int _result         = 0;
    if (info)
    {
        FMDatabase *_db     = [_dbManager getDatabase];
        NSMutableString *_sql = [NSMutableString stringWithFormat:@"UPDATE %@ SET",
                                 kTBUserDataName];
        
        [_sql appendFormat:@" ID = '%@',",[self inputStr:info[@"ID"]]];
        [_sql appendFormat:@" MEMID = '%@',",[self inputStr:info[@"MEMID"]]];
        [_sql appendFormat:@" WEIGHT = '%@',",[self inputStr:info[@"WEIGHT"]]];
        [_sql appendFormat:@" BMI = '%@',",[self inputStr:info[@"BMI"]]];
        
        [_sql appendFormat:@" FAT = '%@',",[self inputStr:info[@"FAT"]]];
        [_sql appendFormat:@" SKINFAT = '%@',",[self inputStr:info[@"SKINFAT"]]];
        [_sql appendFormat:@" OFFALFAT = '%@',",[self inputStr:info[@"OFFALFAT"]]];
        [_sql appendFormat:@" MUSCLE = '%@',",[self inputStr:info[@"MUSCLE"]]];
        
        [_sql appendFormat:@" METABOLISM = '%@',",[self inputStr:info[@"METABOLISM"]]];
        [_sql appendFormat:@" WATER = '%@',",[self inputStr:info[@"WATER"]]];
        [_sql appendFormat:@" BONE = '%@',",[self inputStr:info[@"BONE"]]];
        [_sql appendFormat:@" BODYAGE = '%@',",[self inputStr:info[@"BODYAGE"]]];
        
        [_sql appendFormat:@" STATUS = '%@',",[self inputStr:info[@"STATUS"]]];
        [_sql appendFormat:@" CHECKDATE = '%@',",[self inputStr:info[@"CHECKDATE"]]];
        [_sql appendFormat:@" CREATETIME = '%@',",[self inputStr:info[@"CREATETIME"]]];
        [_sql appendFormat:@" MODIFYTIME = '%@'",[self inputStr:info[@"MODIFYTIME"]]];
        
        
        [_sql appendFormat:@" WHERE ID = '%@'",[self inputStr:info[@"ID"]]];
        
        if (![_db executeUpdate:_sql]) {
            //NSLog(@"update_sql 失败 # %@",_sql);
        }else{
            _result = 1;
        }
    }
    else
    {
        //NSLog(@"update_sql 失败 # 输入为空");
    }
    
    
    return _result;
}


/**
 * @brief 根据ID修改用户的信息
 *
 * @param user 需要修改的用户信息
 * @return 0:失败，1:成功
 */
- (int)updateUserDataByUid:(NSString *)uid
                 checkDate:(NSString *)checkDate
{
    int _result         = 0;
    /*
    if (info)
    {
        FMDatabase *_db     = [_dbManager getDatabase];
        NSMutableString *_sql = [NSMutableString stringWithFormat:@"UPDATE %@ SET",
                                 kTBUserDataName];
        
        [_sql appendFormat:@" ID = '%@',",[self inputStr:info[@"ID"]]];
        [_sql appendFormat:@" MEMID = '%@',",[self inputStr:info[@"MEMID"]]];
        [_sql appendFormat:@" WEIGHT = '%@',",[self inputStr:info[@"WEIGHT"]]];
        [_sql appendFormat:@" BMI = '%@',",[self inputStr:info[@"BMI"]]];
        
        [_sql appendFormat:@" FAT = '%@',",[self inputStr:info[@"FAT"]]];
        [_sql appendFormat:@" SKINFAT = '%@',",[self inputStr:info[@"SKINFAT"]]];
        [_sql appendFormat:@" OFFALFAT = '%@',",[self inputStr:info[@"OFFALFAT"]]];
        [_sql appendFormat:@" MUSCLE = '%@',",[self inputStr:info[@"MUSCLE"]]];
        
        [_sql appendFormat:@" METABOLISM = '%@',",[self inputStr:info[@"METABOLISM"]]];
        [_sql appendFormat:@" WATER = '%@',",[self inputStr:info[@"WATER"]]];
        [_sql appendFormat:@" BONE = '%@',",[self inputStr:info[@"BONE"]]];
        [_sql appendFormat:@" BODYAGE = '%@',",[self inputStr:info[@"BODYAGE"]]];
        
        [_sql appendFormat:@" STATUS = '%@',",[self inputStr:info[@"STATUS"]]];
        [_sql appendFormat:@" CHECKDATE = '%@',",[self inputStr:info[@"CHECKDATE"]]];
        [_sql appendFormat:@" CREATETIME = '%@',",[self inputStr:info[@"CREATETIME"]]];
        [_sql appendFormat:@" MODIFYTIME = '%@'",[self inputStr:info[@"MODIFYTIME"]]];
        
        
        [_sql appendFormat:@" WHERE ID = '%@'",[self inputStr:info[@"ID"]]];
        
        if (![_db executeUpdate:_sql]) {
            //NSLog(@"update_sql 失败 # %@",_sql);
        }else{
            _result = 1;
        }
    }
    else
    {
        //NSLog(@"update_sql 失败 # 输入为空");
    }
    
    */
    return _result;
}


/**
 * @brief 根据tid修改用户的信息
 *
 * @param info 需要修改的用户信息  tid 表格唯一id标示
 * @return 0:失败，1:成功
 */
- (int)updateUserData:(NSDictionary *)info
                  tid:(int)tid
{
    int _result = 0;
    if (info) {
        FMDatabase *_db     = [_dbManager getDatabase];
        NSMutableString *_sql = [NSMutableString stringWithFormat:@"UPDATE %@ SET",
                                 kTBUserDataName];
        
        NSInteger _keyIndex = info.allKeys.count - 1;
        for (int i = 0; i < _keyIndex; i++) {
            NSString *_keyStr = info.allKeys[i];
            [_sql appendFormat:@" %@ = '%@',",_keyStr,[self inputStr:info[_keyStr]]];
        }
        if (info.allKeys.count > 0) {
            
            [_sql appendFormat:@" %@ = '%@'",
             info.allKeys[_keyIndex],
             [self inputStr:info[info.allKeys[_keyIndex]]]];
        }
        
        [_sql appendString:[NSString stringWithFormat:@" WHERE tid = %d", tid ] ];

        
        if (![_db executeUpdate:_sql]) {
            //NSLog(@"update_sql 失败 # %@",_sql);
            
        }else{
            _result = 1;
        }
    }else{
        //NSLog(@"update_sql 失败 # 输入为空");
    }
    return _result;
}



#pragma mark -
#pragma mark UserInfo 用户信息表 操作块
/**
 * @brief 创建TBUserInfo表
 *
 */
-(int)createTBUserInfo
{
    int state = 0;
    if ([self checkTable:kTBUserInfoName])
    {
        ////NSLog(@"table %@ 已存在",kTBUserInfoName);
        state = 2;
    }
    else
    {
        FMDatabase *_db             = [_dbManager getDatabase];
        NSMutableString *_sqlStr    = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (",
                                       kTBUserInfoName];

        [_sqlStr appendString:@"tid INTEGER PRIMARY KEY AUTOINCREMENT,"];
        
        for (int i = 0; i < kTBUserInfoKeyAry.count - 1; i++) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT,",kTBUserInfoKeyAry[i]]];
        }
        if (kTBUserInfoKeyAry.count > 0) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT)",kTBUserInfoKeyAry[kTBUserInfoKeyAry.count - 1]]];
        }
        
        BOOL res = [_db executeUpdate:_sqlStr];
        if (!res) {
            //NSLog(@"table %@ 创建失败:%@",kTBUserInfoName,_sqlStr);
        }else{
            state = 1;
        }
    }
    return state;
}

/**
 * @brief  保存一条UserInfo记录
 *
 * @param  user 需要保存的数据对象
 * @return 0:失败，1:成功
 */
- (int)saveUserInfo:(UserInfoEntity *)user
{
    int state = 0;
    if (user) {
        FMDatabase *_db             = [_dbManager getDatabase];
        
        NSArray *_paramAry = [self fillUserInfoParamAry:user];
        
        
        
        NSString *_sql = [self fillSaveSql:kTBUserInfoName
                             paramKeyArray:kTBUserInfoKeyAry];
        
        ////NSLog(@"_sql:%@",_sql);
        
        BOOL _flag = [ _db executeUpdate:_sql
                    withArgumentsInArray:_paramAry];
        
        if (!_flag) {
            //NSLog(@"插入操作失败");
        }else{
            state = 1;
        }
    }
    else
    {
        //NSLog(@"插入失败,输入为 nil");
    }
    
    return state;
}


/**
 * @brief  根据uid 更新 UserInfo记录
 *
 * @param  user 需要保存的数据对象
 * @return 0:失败，1:成功
 */
-(int)updateUserInfoByUid:(NSDictionary *)user
{
    int _result = 0;
    if (user && user[@"userId"]) {
        FMDatabase *_db     = [_dbManager getDatabase];
        NSMutableString *_sql = [NSMutableString stringWithFormat:@"UPDATE %@ SET",
                                 kTBUserInfoName];
        
        NSInteger _keyIndex = user.allKeys.count - 1;
        for (int i = 0; i < _keyIndex; i++) {
            NSString *_keyStr = user.allKeys[i];
            [_sql appendFormat:@" %@ = '%@',",_keyStr,[self inputStr:user[_keyStr]]];
        }
        if (user.allKeys.count > 0) {
            
            [_sql appendFormat:@" %@ = '%@'",
                user.allKeys[_keyIndex],
                [self inputStr:user[user.allKeys[_keyIndex]]]];
        }
        
        [_sql appendString:[NSString stringWithFormat:@" WHERE userId = '%@'", user[@"userId"]] ];
        ////NSLog(@"_sql:%@",_sql);

        if (![_db executeUpdate:_sql]) {
            //NSLog(@"update_sql 失败 # %@",_sql);
            
        }else{
            _result = 1;
        }
    }else{
        //NSLog(@"update_sql 失败 # 输入为空");
    }
    return _result;
}


/**
 * @brief  根据uid条件查询UserInfo列表
 *
 * @return 用户列表
 */
- (NSArray *)findUserInfoByUid:(NSString *)uid
{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE userId = '%@'",
                        kTBUserInfoName,
                        uid] ;
    
    
    
    FMDatabase *_db         = [_dbManager getDatabase];
    FMResultSet * rs        = [_db executeQuery:query];
    /*
    NSMutableArray * array  = [NSMutableArray arrayWithCapacity:[rs columnCount]];
	while ([rs next])
    {
        NSMutableDictionary *_objDic = [[NSMutableDictionary alloc]init];
        
        for (int i = 0; i < kTBUserInfoKeyAry.count; i++) {
     
            NSString *_value = [rs stringForColumn:kTBUserInfoKeyAry[i]];

            if (_value == NULL) {
                _value = @"";
            }
            
            [_objDic setObject:_value
                        forKey:kTBUserInfoKeyAry[i]];

        }
        
        [array addObject:_objDic];
        
	}
     */
    NSMutableArray *_ary = [self fillDic:kTBUserInfoKeyAry rs:rs];
	[rs close];
    return _ary;
}


/**
 * @brief  根据loc条件查询UserInfo列表
 *
 * @return 用户列表
 */
- (NSArray *)findUserInfoByIsLoc:(int)loc
{
    /* zhangpoor 20140529  修改 WHERE isLoc = '%@' */
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@",kTBUserInfoName] ;
    
    ////NSLog(@"query:%@",query);
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    NSMutableArray *_ary = [self fillDic:kTBUserInfoKeyAry rs:rs];
	[rs close];
    return _ary;
    
    
    
}


-(int)deleteUserByUid:(NSString *)uid
{
    int _result         = 0;
    FMDatabase *_db     = [_dbManager getDatabase];
    NSString * query    = [NSString stringWithFormat:@"DELETE FROM %@ WHERE userId = '%@'",
                           kTBUserInfoName,
                           uid];
    
    if ([_db executeUpdate:query]) {
        
        _result = 1;
    }else{
        //NSLog(@"删除失败，%@",query);
    }
    
    return _result;
}





#pragma mark -
#pragma mark UserPraise  赞／激励／提醒称重人 操作块
/**
 *  创建TBPraiseUser表
 *
 *  @return 0:失败，1:成功
 */
- (int)createTBPraiseUser
{
    int state = 0;
    if ([self checkTable:kTBPraiseUserName])
    {
        ////NSLog(@"table %@ 已存在",kTBFriendInfoName);
        state = 2;
    }
    else
    {
        FMDatabase *_db             = [_dbManager getDatabase];
        NSMutableString *_sqlStr    = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (",
                                       kTBPraiseUserName];
        
        
        
        [_sqlStr appendString:@"tid INTEGER PRIMARY KEY AUTOINCREMENT,"];
        
        for (int i = 0; i < kTBPraiseUserKeyAry.count - 1; i++) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT,",kTBPraiseUserKeyAry[i]]];
        }
        if (kTBPraiseUserKeyAry.count > 0) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT)",kTBPraiseUserKeyAry[kTBPraiseUserKeyAry.count - 1]]];
        }
        
        BOOL res = [_db executeUpdate:_sqlStr];
        if (!res) {
            //NSLog(@"table %@ 创建失败:%@",kTBPraiseUserName,_sqlStr);
        }else{
            state = 1;
        }
        
    }
    return state;
}

/**
 *  保存UserPraiseEntity对象
 *
 *  @param pUser UserPraiseEntity对象
 *
 *  @return 0:失败，1:成功
 */
- (int)savePraiseUser:(UserPraiseEntity *)pUser
{
    int state = 0;
    if (pUser) {
        FMDatabase *_db             = [_dbManager getDatabase];
        
        NSArray *_paramAry = [self fillUserPraiseParamAry:pUser];
        
        
        
        NSString *_sql = [self fillSaveSql:kTBPraiseUserName
                             paramKeyArray:kTBPraiseUserKeyAry];
        
        
        
        BOOL _flag = [ _db executeUpdate:_sql
                    withArgumentsInArray:_paramAry];
        
        if (!_flag) {
            //NSLog(@"插入kTBPraiseUserName操作失败");
        }else{
            state = 1;
        }
    }
    else
    {
        //NSLog(@"插入kTBPraiseUserName失败,输入为 nil");
    }
    
    return state;
}

/**
 *  根据userId查询PraiseUser列表
 *
 *  @param userId 目标uid
 *
 *  @return UserPraiseEntity列表
 */
- (NSArray *)findPraiseUserByUserId:(NSString *)userId
                               type:(NSString *)type
{
    NSMutableString * query = [NSMutableString stringWithFormat:@"SELECT * FROM %@ WHERE userId = '%@'",kTBPraiseUserName,userId] ;
    
    if (type) {
        [query appendFormat:@" AND type = '%@'",type];
    }
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
    NSMutableArray *_ary =  [self fillDic:kTBPraiseUserKeyAry rs:rs];
	[rs close];
    return _ary;
}


/**
 *  删除PraiseUser对象
 *
 *  @param uid  主用户id
 *  @param type 类型
 *
 *  @return 0:失败，1:成功
 */
- (int)deletePraiseUserByUid:(NSString *)uid
                        type:(NSString *)type
{
    int _result         = 0;
    FMDatabase *_db     = [_dbManager getDatabase];
    NSMutableString * query = [NSMutableString stringWithFormat:@"DELETE FROM %@ WHERE userId = '%@'",kTBPraiseUserName,uid];
    
    if (type) {
        [query appendFormat:@" AND type = '%@'",type];
    }
    
    if ([_db executeUpdate:query]) {
        
        _result = 1;
    }else{
        //NSLog(@"删除失败，%@",query);
    }
    
    return _result;
}



#pragma mark -
#pragma mark FriendInfo  好友信息表 操作块
/**
 * @brief 创建TBFriendInfo表
 *
 */
-(int)createTBFriendInfo
{
    int state = 0;
    if ([self checkTable:kTBFriendInfoName])
    {
        ////NSLog(@"table %@ 已存在",kTBFriendInfoName);
        state = 2;
    }
    else
    {
        FMDatabase *_db             = [_dbManager getDatabase];
        NSMutableString *_sqlStr    = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (",
                                       kTBFriendInfoName];
        
        
        
        [_sqlStr appendString:@"tid INTEGER PRIMARY KEY AUTOINCREMENT,"];
        
        for (int i = 0; i < kTBFriendInfoKeyAry.count - 1; i++) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT,",kTBFriendInfoKeyAry[i]]];
        }
        if (kTBFriendInfoKeyAry.count > 0) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT)",kTBFriendInfoKeyAry[kTBFriendInfoKeyAry.count - 1]]];
        }
        
        BOOL res = [_db executeUpdate:_sqlStr];
        if (!res) {
            //NSLog(@"table %@ 创建失败:%@",kTBFriendInfoName,_sqlStr);
        }else{
            state = 1;
        }
        
    }
    return state;
}

/**
 * @brief  保存FriendInfo
 *
 * @param  好友信息对象
 * @return 0:失败，1:成功
 */
- (int)saveFriendInfo:(FriendInfoEntity *)user
{
    int state = 0;
    if (user) {
        FMDatabase *_db             = [_dbManager getDatabase];
        
        NSArray *_paramAry = [self fillFriendInfoParamAry:user];
        
        
        
        NSString *_sql = [self fillSaveSql:kTBFriendInfoName
                             paramKeyArray:kTBFriendInfoKeyAry];
        
        
        
        BOOL _flag = [ _db executeUpdate:_sql
                    withArgumentsInArray:_paramAry];
        
        if (!_flag) {
            //NSLog(@"插入FriendInfo操作失败");
        }else{
            state = 1;
        }
    }
    else
    {
        //NSLog(@"插入FriendInfo失败,输入为 nil");
    }
    
    return state;
}


- (NSArray *)findFriendInfoByCondition:(NSString *)condition;
{

    
    //NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@",kTBFriendInfoName];
    
    NSMutableString * query = [NSMutableString stringWithFormat:@"SELECT * FROM %@",
                               kTBFriendInfoName] ;
    if (condition) {
        [query appendString:condition];
    }
    
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
    
    NSMutableArray *_ary =  [self fillDic:kTBFriendInfoKeyAry rs:rs];
	[rs close];
    
    
    return _ary;
}




- (int)deleteFriendByConditionStr:(NSString *)conditionStr;
{
    int _result         = 0;
    FMDatabase *_db     = [_dbManager getDatabase];
    NSMutableString * query    = [NSMutableString stringWithFormat:@"DELETE FROM %@",
                                  kTBFriendInfoName];
    
    if (conditionStr && [conditionStr isKindOfClass:[NSString class]]) {
        [query appendString:conditionStr];
    }
    if ([_db executeUpdate:query]) {
        
        _result = 1;
    }else{
        //NSLog(@"删除失败，%@",query);
    }
    
    return _result;
}

/**
 * @brief  根据mid删除FriendInfo对象
 *
 * @param  删除FriendInfo对象的mid
 * @return 0:失败，1:成功
 */
- (int)deleteFriendInfoByMid:(NSString *)Mid
{
    int _result         = 0;
    FMDatabase *_db     = [_dbManager getDatabase];
    NSString * query    = [NSString stringWithFormat:@"DELETE FROM %@ WHERE mid = '%@'",
                           kTBFriendInfoName,
                           Mid];
    
    if ([_db executeUpdate:query]) {
        
        _result = 1;
    }else{
        //NSLog(@"删除失败，%@",query);
    }
    
    return _result;
}




/**
 *  更新 好友信息
 *
 *  @param fiEntity  更新内容
 *  @param condition 筛选语句
 *
 *  @return 0:失败，1:成功
 */
-(int)updateFriend:(NSDictionary *)fiEntity
         condition:(NSString *)condition
{
    int _result         = 0;
    if (fiEntity)
    {
        @try {
            FMDatabase *_db     = [_dbManager getDatabase];
            NSMutableString *_sql = [NSMutableString stringWithFormat:@"UPDATE %@ SET",
                                     kTBFriendInfoName];
            
            
            for (NSString *_key in fiEntity.allKeys) {
                [_sql appendFormat:@" %@ = '%@',",_key,[self inputStr:fiEntity[_key]]];
            }
            
            
            [_sql replaceCharactersInRange:NSMakeRange(_sql.length - 1, 1) withString:@""];
            
            if (condition) {
                [_sql appendString:condition];
            }
            
            if ([_db executeUpdate:_sql])
            {
                _result = 1;
            }
        }
        @catch (NSException *exception) {
            NSLog(@"exception:%@",exception.description);
        }
        @finally {
            return _result;
        }
        
        
    }
    
    
    return _result;
}


#pragma mark -
#pragma mark Suggest  建议及回复表 操作块
/**
 * @brief 创建TBSuggest表
 *
 * @return 0:失败，1:成功
 */
-(int)createTBSuggest
{
    int state = 0;
    if ([self checkTable:kTBSuggestName])
    {
        ////NSLog(@"table %@ 已存在",kTBSuggestName);
        state = 2;
    }
    else
    {
        FMDatabase *_db             = [_dbManager getDatabase];
        NSMutableString *_sqlStr    = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (",
                                       kTBSuggestName];
        
        
        
        [_sqlStr appendString:@"tid INTEGER PRIMARY KEY AUTOINCREMENT,"];
        
        for (int i = 0; i < kTBSuggestKeyAry.count - 1; i++) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT,",kTBSuggestKeyAry[i]]];
        }
        if (kTBSuggestKeyAry.count > 0) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT)",kTBSuggestKeyAry[kTBSuggestKeyAry.count - 1]]];
        }
        
        BOOL res = [_db executeUpdate:_sqlStr];
        if (!res) {
            //NSLog(@"table %@ 创建失败:%@",kTBSuggestName,_sqlStr);
        }else{
            state = 1;
        }
        
    }
    return state;
}

/**
 * @brief  根据uid删除TBSuggest对象
 *
 * @param  删除TBSuggest对象的uid
 * @return 0:失败，1:成功
 */
- (int)deleteSuggestByUid:(NSString *)uid
{
    int _result         = 0;
    FMDatabase *_db     = [_dbManager getDatabase];
    NSString * query    = [NSString stringWithFormat:@"DELETE FROM %@ WHERE memid = '%@'",
                           kTBSuggestName,
                           uid];
    
    if ([_db executeUpdate:query]) {

        _result = 1;
    }else{
        //NSLog(@"删除失败，%@",query);
    }
    
    return _result;
}

/**
 * @brief  保存TBSuggest
 *
 * @param  建议及回复信息对象
 * @return 0:失败，1:成功
 */
- (int)saveSuggest:(SuggestEntity *)suggest
{
    int _result = 0;
    if (suggest) {
        FMDatabase *_db             = [_dbManager getDatabase];
        
        NSArray *_paramAry = [self fillSuggestParamAry:suggest];;
        
        NSString *_sql = [self fillSaveSql:kTBSuggestName
                             paramKeyArray:kTBSuggestKeyAry];

        BOOL _flag = [ _db executeUpdate:_sql
                    withArgumentsInArray:_paramAry];
        
        
        
        if (!_flag) {
            //NSLog(@"插入操作失败");
        }else{
            _result = 1;
        }
    }else{
        //NSLog(@"插入失败,输入为 nil");
    }
    
    return _result;
    
}

/**
 * @brief  创建TBFriendInfo表
 *
 * @param  uid 需要获取的uid
 * @return 建议列表
 */
- (NSArray *)findSuggestByUids:(NSString *)uid
{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE memid = '%@' ORDER BY createtime ASC",
                        kTBSuggestName,
                        uid] ;
    
    
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
    
    NSMutableArray *_ary =  [self fillDic:kTBSuggestKeyAry rs:rs];
	[rs close];
    return _ary;
}



#pragma mark -
#pragma mark Notice  时间提示信息 操作块
/**
 * @brief 创建TBNotice表
 *
 * @return 0:失败，1:成功
 */
-(int)createTBNotice
{
    int state = 0;
    if ([self checkTable:kTBNoticeName])
    {
        ////NSLog(@"table %@ 已存在",kTBNoticeName);
        state = 2;
    }
    else
    {
        FMDatabase *_db             = [_dbManager getDatabase];
        NSMutableString *_sqlStr    = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (",
                                       kTBNoticeName];
        
        
        
        [_sqlStr appendString:@"tid INTEGER PRIMARY KEY AUTOINCREMENT,"];
        
        for (int i = 0; i < kTBNoticeKeyAry.count - 1; i++) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT,",kTBNoticeKeyAry[i]]];
        }
        if (kTBNoticeKeyAry.count > 0) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT)",kTBNoticeKeyAry[kTBNoticeKeyAry.count - 1]]];
        }
        
        BOOL res = [_db executeUpdate:_sqlStr];
        if (!res) {
            //NSLog(@"table %@ 创建失败:%@",kTBNoticeName,_sqlStr);
        }else{
            state = 1;
        }
        
    }
    return state;
}

/**
 * @brief  保存TBNotice
 *
 * @param  时间提示信息对象
 * @return 0:失败，1:成功
 */
- (int)saveTBNotice:(NoticeEntity *)notice;
{
    int _result = 0;
    if (notice) {
        FMDatabase *_db             = [_dbManager getDatabase];
        
        NSArray *_paramAry = [self fillNoticeEntityParamAry:notice];
        
        NSString *_sql = [self fillSaveSql:kTBNoticeName
                             paramKeyArray:kTBNoticeKeyAry];
        
        BOOL _flag = [ _db executeUpdate:_sql
                    withArgumentsInArray:_paramAry];
        
        
        
        if (!_flag) {
            //NSLog(@"插入操作失败");
        }else{
            _result = 1;
        }
    }else{
        //NSLog(@"插入失败,输入为 nil");
    }
    
    return _result;
    
}


/**
 * @brief  根据uid删除TBNotice对象
 *
 * @param  删除TBNotice对象的uid
 * @return 0:失败，1:成功
 */
- (int)deleteNoticeByUid:(NSString *)uid
{
    int _result         = 0;
    FMDatabase *_db     = [_dbManager getDatabase];
    NSString * query    = [NSString stringWithFormat:@"DELETE FROM %@ WHERE userId = '%@'",
                           kTBNoticeName,
                           uid];
    
    if ([_db executeUpdate:query]) {

        _result = 1;
    }else{
        //NSLog(@"删除失败，%@",query);
    }
    
    return _result;
}

/**
 * @brief  根据uid查询TBNotice列表
 *
 * @param  uid 需要获取的uid
 * @return TBNotice列表
 */
- (NSArray *)findNoticeByUid:(NSString *)uid;
{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE userId = '%@'",
                        kTBNoticeName,
                        uid] ;
    
    
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
    NSMutableArray *_ary = [self fillDic:kTBNoticeKeyAry rs:rs];
	[rs close];
    return _ary;
}



/**
 * @brief  根据条件u查询TBNotice列表
 *
 * @param  conditionStr  筛选字符串
 * @return TBNotice列表
 */
- (NSArray *)findNoticeByConditionStr:(NSString *)conditionStr
{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@",
                        kTBNoticeName] ;
    
    if (conditionStr) {
        query = [query stringByAppendingString:conditionStr];
    }
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
	NSMutableArray *_ary = [self fillDic:kTBNoticeKeyAry rs:rs];
	[rs close];
    return _ary;
}



#pragma mark -
#pragma mark UserDeviceInfo  用户与设备信息
/**
 * @brief 创建TBUserDeviceInfo表
 *
 * @return 0:失败，1:成功
 */
-(int)createTBUserDeviceInfo
{
    int state = 0;
    if ([self checkTable:kTBUserDeviceInfoName])
    {
        ////NSLog(@"table %@ 已存在",kTBUserDeviceInfoName);
        state = 2;
    }
    else
    {
        FMDatabase *_db             = [_dbManager getDatabase];
        NSMutableString *_sqlStr    = [NSMutableString stringWithFormat:@"CREATE TABLE %@ (",
                                       kTBUserDeviceInfoName];
        
        
        
        [_sqlStr appendString:@"tid INTEGER PRIMARY KEY AUTOINCREMENT,"];
        
        for (int i = 0; i < kTBUserDeviceInfoKeyAry.count - 1; i++) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT,",kTBUserDeviceInfoKeyAry[i]]];
        }
        if (kTBUserDeviceInfoKeyAry.count > 0) {
            [_sqlStr appendString:[NSString stringWithFormat:@"%@ TEXT)",kTBUserDeviceInfoKeyAry[kTBUserDeviceInfoKeyAry.count - 1]]];
        }
        
        BOOL res = [_db executeUpdate:_sqlStr];
        if (!res) {
            //NSLog(@"table %@ 创建失败:%@",kTBUserDeviceInfoName,_sqlStr);
        }else{
            state = 1;
        }
        
    }
    return state;
}

/**
 * @brief  保存TBUserDeviceInfo
 *
 * @param  用户设备关系对象
 * @return 0:失败，1:成功
 */
- (int)saveUserDeviceInfo:(UserDeviceInfoEntity *)udi;
{
    int _result = 0;
    if (udi) {
        FMDatabase *_db             = [_dbManager getDatabase];
        
        NSArray *_paramAry = [self fillUserDeviceInfoEntityParamAry:udi];
        
        NSString *_sql = [self fillSaveSql:kTBUserDeviceInfoName
                             paramKeyArray:kTBUserDeviceInfoKeyAry];
        
        BOOL _flag = [ _db executeUpdate:_sql
                    withArgumentsInArray:_paramAry];
        
        
        
        if (!_flag) {
            //NSLog(@"插入操作失败");
        }else{
            _result = 1;
        }
    }else{
        //NSLog(@"插入失败,输入为 nil");
    }
    
    return _result;
    
}

/**
 * @brief  根据uid删除UserDeviceInfo对象
 *
 * @param  删除UserDeviceInfo对象的uid
 * @return 0:失败，1:成功
 */
- (int)deleteUserDeviceInfoByUid:(NSString *)uid
{
    int _result         = 0;
    FMDatabase *_db     = [_dbManager getDatabase];
    NSString * query    = [NSString stringWithFormat:@"DELETE FROM %@ WHERE memid = '%@'",
                           kTBUserDeviceInfoName,
                           uid];
    
    if ([_db executeUpdate:query]) {

        _result = 1;
    }else{
        //NSLog(@"删除失败，%@",query);
    }
    
    return _result;
}


/**
 * @brief  根据uid查询TBUserDeviceInfo列表
 *
 * @param  uid 需要获取的uid
 * @return TBUserDeviceInfo列表:元素类型UserDeviceInfoEntity
 */
- (NSArray *)findUserDeviceInfoByUid:(NSString *)uid;
{
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE memid = '%@'",
                        kTBUserDeviceInfoName,
                        uid] ;
    
    
    
    FMDatabase *_db     = [_dbManager getDatabase];
    FMResultSet * rs    = [_db executeQuery:query];
    
    NSMutableArray *_ary = [self fillDic:kTBUserDeviceInfoKeyAry rs:rs];
	[rs close];
    return _ary;
}

@end
