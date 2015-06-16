//
//  CalculateTool.m
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-4-21.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "CalculateTool.h"
#import "Helpers.h"
#import "DatabaseService.h"
#import "PCEntity.h"


#define kWeightMax      150
#define kWeightMin      5
#define kBMIMax         40
#define kBMIMin         10
#define kFatMax         75
#define kFatMin         5
#define kSkinFatMax     60
#define kSkinFatMin     5
#define kBoneMax        10
#define kBoneMin        0.1
#define kMuscleMax      75
#define kMuscleMin      25
#define kWaterMax       80
#define kWaterMin       10
#define kBmrMax         3000
#define kBmrMin         0
#define kOffalFatMax    30
#define kOffalFatMin    1
#define kBodyAgeMax     80
#define kBodyAgeMin     10


@interface CalculateParam()

@end
@implementation CalculateParam



/*
 -(void)addDataOld01:(UserDataEntity *)data
 {
 //if ([CalculateTool calculateDataIsValid:data])
 UserInfoEntity *_user = [GloubleProperty sharedInstance].currentUserEntity;
 if ([CalculateTool calculateRyFitWithUserInfo:_user
 data:data])
 {
 _wT = [data.UD_WEIGHT floatValue];
 if (_wT > 0 && _wT <= 150) {
 _w      += _wT;
 _wC++;
 }
 
 _bmiT = [data.UD_BMI floatValue];
 if (_bmiT > 0 && _bmiT <= 40) {
 _bmi += _bmiT;
 _bmiC++;
 }
 
 _fT = [data.UD_FAT floatValue];
 if (_fT > 0 && _fT <= 75) {
 _f      += _fT;
 _fC++;
 }
 
 _sT = [data.UD_SKINFAT floatValue];
 if (_sT > 0 && _sT <= 60) {
 _s      += _sT;
 _sC++;
 }
 
 _boneT = [data.UD_BONE floatValue];
 if (_boneT >0 && _boneT <= 10) {
 _bone += _boneT;
 _boneC++;
 }
 
 _muT     = [data.UD_MUSCLE floatValue];
 if (_muT >0 && _muT <= 75) {
 _mu += _muT;
 _muC++;
 }
 
 _waterT     = [data.UD_WATER floatValue];
 if (_waterT > 0 && _waterT <= 80) {
 _water += _waterT;
 _waterC++;
 }
 
 _bmrT     = [data.UD_METABOLISM floatValue];
 if (_bmrT > 0 && _bmrT <= 3000) {
 _bmr += _bmrT;
 _bmrC++;
 }
 
 _eBmrT     = [data.UD_eBMR floatValue];
 if (_eBmrT > 0 && _eBmrT <= 3000) {
 _eBmr += _eBmrT;
 _eBmrC++;
 }
 
 _oT     = [data.UD_OFFALFAT floatValue];
 if (_oT > 0 && _oT <= 30) {
 _o += _oT;
 _oC++;
 }
 
 
 _bAgeT     = [data.UD_BODYAGE floatValue];
 if (_bAgeT > 0 && _bAgeT <= 80) {
 _bAge += _bAgeT;
 _bAgeC++;
 }
 }
 }
 */

-(void)addData:(UserDataEntity *)data
      userInfo:(UserInfoEntity *)user
{
    //if ([CalculateTool calculateDataIsValid:data])
    UserInfoEntity *_user = user;
    if ([CalculateTool calculateRyFitWithUserInfo:_user
                                             data:data] != -1)
    {
        _dataCount++;
        _dateStr    = data.UD_CHECKDATE;
        
        _ryFitT += [ [CalculateTool inputStr:data.UD_ryFit]         floatValue];
        _wT     += [ [CalculateTool inputStr:data.UD_WEIGHT]        floatValue];
        _bmiT   += [ [CalculateTool inputStr:data.UD_BMI]           floatValue];
        _fT     += [ [CalculateTool inputStr:data.UD_FAT]           floatValue];
        _sT     += [ [CalculateTool inputStr:data.UD_SKINFAT]       floatValue];
        _boneT  += [ [CalculateTool inputStr:data.UD_BONE]          floatValue];
        _muT    += [ [CalculateTool inputStr:data.UD_MUSCLE]        floatValue];
        _waterT += [ [CalculateTool inputStr:data.UD_WATER]         floatValue];
        _bmrT   += [ [CalculateTool inputStr:data.UD_METABOLISM]    floatValue];
        _eBmrT  += [ [CalculateTool inputStr:data.UD_eBMR]          floatValue];
        _oT     += [ [CalculateTool inputStr:data.UD_OFFALFAT]      floatValue];
        _bAgeT  += [ [CalculateTool inputStr:data.UD_BODYAGE]       floatValue];
        
    }
}

-(void)addData:(id)data
           age:(int)age
{
    //if ([CalculateTool calculateDataIsValid:data])
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *_dataInfo = data;
        
        float _bodyAge  = [ [CalculateTool inputStr:_dataInfo[@"BODYAGE"]]       floatValue];
        float _off      = [ [CalculateTool inputStr:_dataInfo[@"OFFALFAT"]]      floatValue];
        float _BMI      = [ [CalculateTool inputStr:_dataInfo[@"BMI"]]           floatValue];
        
        float _ry       = [CalculateTool calculateRyFitWithAge:age
                                                       bodyAge:_bodyAge
                                                        offFat:_off
                                                           bmi:_BMI];
        
        if (_ry != -1)
        {
            _dataCount++;
            _dateStr    = _dataInfo[@"CHECKDATE"];
            
            _ryFitT += _ry;
            
            _wT     += [ [CalculateTool inputStr:_dataInfo[@"WEIGHT"]]        floatValue];
            _bmiT   += _BMI;
            _fT     += [ [CalculateTool inputStr:_dataInfo[@"FAT"]]           floatValue];
            _sT     += [ [CalculateTool inputStr:_dataInfo[@"SKINFAT"]]       floatValue];
            _boneT  += [ [CalculateTool inputStr:_dataInfo[@"BONE"]]          floatValue];
            _muT    += [ [CalculateTool inputStr:_dataInfo[@"MUSCLE"]]        floatValue];
            _waterT += [ [CalculateTool inputStr:_dataInfo[@"WATER"]]         floatValue];
            _bmrT   += [ [CalculateTool inputStr:_dataInfo[@"METABOLISM"]]    floatValue];
            _eBmrT  += [ [CalculateTool inputStr:_dataInfo[@"eBMR"]]          floatValue];
            _oT     += _off;
            _bAgeT  += _bodyAge;
            
        }
    }
    else if ([data isKindOfClass:[CalculateParam class]]) {
        
        CalculateParam *_dataInfo = data;
        
        float _bodyAge  = _dataInfo.bAgeT;
        float _off      = _dataInfo.oT;
        float _BMI      = _dataInfo.bmiT;
        
        float _ry       = [CalculateTool calculateRyFitWithAge:age
                                                       bodyAge:_bodyAge
                                                        offFat:_off
                                                           bmi:_BMI];
        
        
        if (_ry != -1)
        {
            _dataCount++;
            _dateStr    = _dataInfo.dateStr;
            
            _ryFitT += _ry;
            //NSLog(@"%@_ry:%f_ryFitT:%f",_dataInfo.dateStr,_ry,_ryFitT);
            
            _wT     += _dataInfo.wT;
            _bmiT   += _BMI;
            _fT     += _dataInfo.fT;
            _sT     += _dataInfo.sT;
            _boneT  += _dataInfo.boneT;
            _muT    += _dataInfo.muT;
            _waterT += _dataInfo.waterT;
            _bmrT   += _dataInfo.bmrT;
            _eBmrT  += _dataInfo.eBmrT;
            _oT     += _off;
            _bAgeT  += _bodyAge;
            
        }
    }
    
    
}

-(UserDataEntity *)getDataMax:(NSMutableArray *)maxList
                          min:(NSMutableArray *)minList;
{
    UserDataEntity *_data = [[UserDataEntity alloc]init];
    _data.UD_CHECKDATE    = _dateStr;
    
    float ryFit   = ( _dataCount == 0 ? 0 : _ryFitT / _dataCount );
    float rw      = ( _dataCount == 0 ? 0 : _wT / _dataCount );
    float rbmi    = ( _dataCount == 0 ? 0 : _bmiT / _dataCount );
    float rf      = ( _dataCount == 0 ? 0 : _fT / _dataCount );
    float rs      = ( _dataCount == 0 ? 0 : _sT / _dataCount );
    float rbone   = ( _dataCount == 0 ? 0 : _boneT / _dataCount );
    float rmu     = ( _dataCount == 0 ? 0 : _muT / _dataCount );
    float rwater  = ( _dataCount == 0 ? 0 : _waterT / _dataCount );
    float rbmr    = ( _dataCount == 0 ? 0 : _bmrT / _dataCount );
    float reBmr   = ( _dataCount == 0 ? 0 : _eBmrT / _dataCount );
    float ro      = ( _dataCount == 0 ? 0 : _oT / _dataCount );
    float rbAge   = ( _dataCount == 0 ? 0 : _bAgeT / _dataCount );
    
    
    
    if (maxList) {
        
        _data.UD_ryFit          = [NSString stringWithFormat:@"%.1f",ryFit];
        _data.UD_WEIGHT         = [NSString stringWithFormat:@"%.1f",rw];
        _data.UD_BMI            = [NSString stringWithFormat:@"%.1f",rbmi];
        _data.UD_FAT            = [NSString stringWithFormat:@"%.1f",rf];
        _data.UD_SKINFAT        = [NSString stringWithFormat:@"%.1f",rs];
        _data.UD_BONE           = [NSString stringWithFormat:@"%.1f",rbone];
        _data.UD_MUSCLE         = [NSString stringWithFormat:@"%.1f",rmu];
        _data.UD_WATER          = [NSString stringWithFormat:@"%.1f",rwater];
        _data.UD_METABOLISM     = [NSString stringWithFormat:@"%d",(int)roundf(rbmr)];
        _data.UD_eBMR           = [NSString stringWithFormat:@"%d",(int)roundf(reBmr)];
        _data.UD_OFFALFAT       = [NSString stringWithFormat:@"%.1f",ro];
        _data.UD_BODYAGE        = [NSString stringWithFormat:@"%d",(int)roundf(rbAge)];
        
        
        ryFit   = [_data.UD_ryFit       floatValue];
        rw      = [_data.UD_WEIGHT      floatValue];
        rbmi    = [_data.UD_BMI         floatValue];
        rf      = [_data.UD_FAT         floatValue];
        rs      = [_data.UD_SKINFAT     floatValue];
        rbone   = [_data.UD_BONE        floatValue];
        rmu     = [_data.UD_MUSCLE      floatValue];
        rwater  = [_data.UD_WATER       floatValue];
        rbmr    = [_data.UD_METABOLISM  floatValue];
        reBmr   = [_data.UD_eBMR        floatValue];
        ro      = [_data.UD_OFFALFAT    floatValue];
        rbAge   = [_data.UD_BODYAGE     floatValue];
        
        
        maxList[PCTp_weight] = [NSNumber numberWithFloat:
                                [CalculateTool calculateMaxValueByOValue:
                                 [maxList[PCTp_weight] floatValue]
                                                                  tValue:rw ] ];
        minList[PCTp_weight] = [NSNumber numberWithFloat:
                                [CalculateTool calculateMinValueByOValue:
                                 [minList[PCTp_weight] floatValue]
                                                                  tValue:rw]];
        maxList[PCTp_bmi] = [NSNumber numberWithFloat:
                             [CalculateTool calculateMaxValueByOValue:[maxList[PCTp_bmi] floatValue]
                                                               tValue:rbmi ] ];
        minList[PCTp_bmi] = [NSNumber numberWithFloat:
                             [CalculateTool calculateMinValueByOValue:[minList[PCTp_bmi] floatValue]
                                                               tValue:rbmi ]];
        maxList[PCTp_fat] = [NSNumber numberWithFloat:
                             [CalculateTool calculateMaxValueByOValue:[maxList[PCTp_fat] floatValue]
                                                               tValue:rf ] ];
        minList[PCTp_fat] = [NSNumber numberWithFloat:
                             [CalculateTool calculateMinValueByOValue:[minList[PCTp_fat] floatValue]
                                                               tValue:rf]];
        maxList[PCTp_skin] = [NSNumber numberWithFloat:
                              [CalculateTool calculateMaxValueByOValue:[maxList[PCTp_skin] floatValue]
                                                                tValue:rs ] ];
        minList[PCTp_skin] = [NSNumber numberWithFloat:
                              [CalculateTool calculateMinValueByOValue:[minList[PCTp_skin] floatValue]
                                                                tValue:rs]];
        maxList[PCTp_boneWeight] = [NSNumber numberWithFloat:
                                    [CalculateTool calculateMaxValueByOValue:[maxList[PCTp_boneWeight] floatValue]
                                                                      tValue:rbone ] ];
        minList[PCTp_boneWeight] = [NSNumber numberWithFloat:
                                    [CalculateTool calculateMinValueByOValue:[minList[PCTp_boneWeight] floatValue]
                                                                      tValue:rbone]];
        maxList[PCTp_muscle]     = [NSNumber numberWithFloat:
                                    [CalculateTool calculateMaxValueByOValue:[maxList[PCTp_muscle] floatValue]
                                                                      tValue:rmu ] ];
        minList[PCTp_muscle] = [NSNumber numberWithFloat:
                                [CalculateTool calculateMinValueByOValue:[minList[PCTp_muscle] floatValue]
                                                                  tValue:rmu]];
        maxList[PCTp_water]     = [NSNumber numberWithFloat:
                                   [CalculateTool calculateMaxValueByOValue:[maxList[PCTp_water] floatValue]
                                                                     tValue:rwater ] ];
        minList[PCTp_water] = [NSNumber numberWithFloat:
                               [CalculateTool calculateMinValueByOValue:[minList[PCTp_water] floatValue]
                                                                 tValue:rwater]];
        
        
        maxList[PCTp_bmr]   = [NSNumber numberWithFloat:
                               [CalculateTool calculateMaxValueByOValue:[maxList[PCTp_bmr] floatValue]
                                                                 tValue:rbmr ] ];
        minList[PCTp_bmr]   = [NSNumber numberWithInt:
                               [CalculateTool calculateMinValueByOValue:[minList[PCTp_bmr] floatValue]
                                                                 tValue:rbmr]];
        
        maxList[PCTp_eBmr]  = [NSNumber numberWithInt:
                               [CalculateTool calculateMaxValueByOValue:[maxList[PCTp_eBmr] floatValue]
                                                                 tValue:reBmr ] ];
        minList[PCTp_eBmr] = [NSNumber numberWithInt:
                              [CalculateTool calculateMinValueByOValue:[maxList[PCTp_eBmr] floatValue]
                                                                tValue:reBmr ] ];
        
        maxList[PCTp_offal] = [NSNumber numberWithFloat:
                               [CalculateTool calculateMaxValueByOValue:[maxList[PCTp_offal] floatValue]
                                                                 tValue:ro ] ];
        minList[PCTp_offal] = [NSNumber numberWithFloat:
                               [CalculateTool calculateMinValueByOValue:[minList[PCTp_offal] floatValue]
                                                                 tValue:ro]];
        maxList[PCTp_bodyage] = [NSNumber numberWithInt:
                                 [CalculateTool calculateMaxValueByOValue:[maxList[PCTp_bodyage] floatValue]
                                                                   tValue:rbAge ]];
        minList[PCTp_bodyage] = [NSNumber numberWithInt:
                                 [CalculateTool calculateMinValueByOValue:[minList[PCTp_bodyage] floatValue]
                                                                   tValue:rbAge] ];
        maxList[PCTp_ryFit] = [NSNumber numberWithFloat:
                               [CalculateTool calculateMaxValueByOValue:[maxList[PCTp_ryFit] floatValue]
                                                                 tValue:ryFit ] ];
        minList[PCTp_ryFit] = [NSNumber numberWithFloat:
                               [CalculateTool calculateMinValueByOValue:[minList[PCTp_ryFit] floatValue]
                                                                 tValue:ryFit]];
        
    }
    else
    {
        _data.UD_ryFit          = [NSString stringWithFormat:@"%f",ryFit];
        _data.UD_WEIGHT         = [NSString stringWithFormat:@"%f",rw];
        _data.UD_BMI            = [NSString stringWithFormat:@"%f",rbmi];
        _data.UD_FAT            = [NSString stringWithFormat:@"%f",rf];
        _data.UD_SKINFAT        = [NSString stringWithFormat:@"%f",rs];
        _data.UD_BONE           = [NSString stringWithFormat:@"%f",rbone];
        _data.UD_MUSCLE         = [NSString stringWithFormat:@"%f",rmu];
        _data.UD_WATER          = [NSString stringWithFormat:@"%f",rwater];
        _data.UD_METABOLISM     = [NSString stringWithFormat:@"%f",rbmr];
        _data.UD_eBMR           = [NSString stringWithFormat:@"%f",reBmr];
        _data.UD_OFFALFAT       = [NSString stringWithFormat:@"%f",ro];
        _data.UD_BODYAGE        = [NSString stringWithFormat:@"%f",rbAge];
        
    }
    
    return _data;
}


-(CalculateParam *)getCPData
{
    CalculateParam *_cp = [[CalculateParam alloc]init];
    
    _cp.dateStr    = _dateStr;
    _cp.ryFitT     = ( _dataCount == 0 ? 0 : _ryFitT / _dataCount );
    _cp.wT         = ( _dataCount == 0 ? 0 : _wT / _dataCount );
    _cp.bmiT       = ( _dataCount == 0 ? 0 : _bmiT / _dataCount );
    _cp.fT         = ( _dataCount == 0 ? 0 : _fT / _dataCount );
    _cp.sT         = ( _dataCount == 0 ? 0 : _sT / _dataCount );
    _cp.boneT      = ( _dataCount == 0 ? 0 : _boneT / _dataCount );
    _cp.muT        = ( _dataCount == 0 ? 0 : _muT / _dataCount );
    _cp.waterT     = ( _dataCount == 0 ? 0 : _waterT / _dataCount );
    _cp.bmrT       = ( _dataCount == 0 ? 0 : _bmrT / _dataCount );
    _cp.eBmrT      = ( _dataCount == 0 ? 0 : _eBmrT / _dataCount );
    _cp.oT         = ( _dataCount == 0 ? 0 : _oT / _dataCount );
    _cp.bAgeT      = ( _dataCount == 0 ? 0 : _bAgeT / _dataCount );
    
    
    return _cp;
}

@end

@implementation CalculateTool



+ (int)convertToInt:(NSString *)strtemp {
    
    int strlength = 0;
    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return (strlength+1)/2;
}



#pragma mark - 辅助
+(NSString *)inputStr:(id)ipStr
{
    NSString *_result = @"";
    
    if (ipStr == nil || ipStr == NULL) {
        return _result ;
    }
    if ([ipStr isKindOfClass:[NSNull class]]) {
        return _result;
    }
    
    if ([ipStr isKindOfClass:[NSString class]]) {
        _result = ipStr;
    }
    
    if ([ipStr isKindOfClass:[NSNumber class]]) {
        _result = [(NSNumber *)ipStr stringValue];
    }
    
    return _result;
}


+(BOOL)checkData:(UserDataEntity *)ude
{
    BOOL _flag = NO;
    UserDataEntity *_lastData = [[DatabaseService defaultDatabaseService]
                                 getUserDataByUid:ude.UD_userId
                                 num:1];
    if (_lastData) {
        
        float _oldW = [ [CalculateTool inputStr:_lastData.UD_WEIGHT]  floatValue];
        float _oldF = [ [CalculateTool inputStr:_lastData.UD_FAT]  floatValue];
        float _newW = [ [CalculateTool inputStr:ude.UD_WEIGHT]  floatValue];
        float _newF = [ [CalculateTool inputStr:ude.UD_FAT]  floatValue];
        
        
        
        if ( fabsf((_oldW - _newW)) <= 2.5 ) {
            if ( fabsf((_oldF - _newF)) <= 30 ) {
                _flag = YES;
            }
        }
        
    }else{
        _flag = YES;
    }
    
    
    return _flag;
}


#pragma mark - function
+(BOOL)calculateDataIsValid:(UserDataEntity *)data
{
    
    BOOL _flag      = YES;
    
    float _wT       = [data.UD_WEIGHT floatValue];
    float _bmiT     = [data.UD_BMI floatValue];
    float _fT       = [data.UD_FAT floatValue];
    float _sT       = [data.UD_SKINFAT floatValue];
    float _boneT    = [data.UD_BONE floatValue];
    float _muT      = [data.UD_MUSCLE floatValue];
    float _waterT   = [data.UD_WATER floatValue];
    float _bmrT     = [data.UD_METABOLISM floatValue];
    float _eBmrT    = [data.UD_eBMR floatValue];
    float _oT       = [data.UD_OFFALFAT floatValue];
    float _bAgeT    = [data.UD_BODYAGE floatValue];
    
    if (data) {
        
        if (!_flag ||
            _wT <= 0 ||
            _wT > kWeightMax ||
            _wT < kWeightMin)
        {
            _flag = NO;
        }
        if (!_flag ||
            _bmiT <= 0 ||
            _bmiT > kBMIMax ||
            _bmiT < kBMIMin)
        {
            _flag = NO;
        }
        if (!_flag ||
            _fT <= 0 ||
            _fT > kFatMax ||
            _fT < kFatMin)
        {
            _flag = NO;
        }
        if (!_flag ||
            _sT <= 0 ||
            _sT > kSkinFatMax ||
            _sT < kSkinFatMin)
        {
            _flag = NO;
        }
        if (!_flag ||
            _boneT <= 0 ||
            _boneT > kBoneMax ||
            _boneT < kBoneMin)
        {
            _flag = NO;
        }
        if (!_flag ||
            _muT <= 0 ||
            _muT > kMuscleMax ||
            _muT < kMuscleMin)
        {
            _flag = NO;
        }
        if (!_flag ||
            _waterT <= 0 ||
            _waterT > kWaterMax ||
            _waterT < kWaterMin)
        {
            _flag = NO;
        }
        
        if (!_flag ||
            _bmrT <= 0 ||
            _bmrT > kBmrMax ||
            _bmrT < kBmrMin)
        {
            _flag = NO;
        }
        if (!_flag ||
            _eBmrT <= 0 ||
            _eBmrT > kBmrMax ||
            _eBmrT < kBmrMin)
        {
            _flag = NO;
        }
        
        if (!_flag ||
            _oT <= 0 ||
            _oT > kOffalFatMax ||
            _oT < kOffalFatMin)
        {
            _flag = NO;
        }
        if (!_flag ||
            _bAgeT <= 0 ||
            _bAgeT > kBodyAgeMax ||
            _bAgeT < kBodyAgeMin)
        {
            _flag = NO;
        }
    }
    else
    {
        _flag = NO;
    }
    
    
    return _flag;
}


+(void)calculateFixMaxList:(NSMutableArray *)maxList
                   minList:(NSMutableArray *)minList
{
    float _maxFixRate = 1.1;
    float _minFixRate = 0.9;
    
    for (int i = 0; i < maxList.count; i++) {
        NSNumber *_num = maxList[i];
        
        
        maxList[i] =  [NSNumber numberWithInt:ceilf( [_num intValue] * _maxFixRate )]  ;
    }
    
    
    for (int i = 0; i < minList.count; i++) {
        NSNumber *_num = minList[i];
        
        
        minList[i] =  [NSNumber numberWithInt:floorf( [_num intValue] * _minFixRate )]  ;
    }
    
}


+(float)calculateBMIWith:(float)weight
                  height:(float)height
{
    float _bmi = 0;
    if (height > 0)
    {
        _bmi =  weight / ( height * height);
    }
    else{
        _bmi = 0;
    }
    
    return _bmi;
}

/**
 *  计算BMI
 *
 *  @param user 用户信息对象
 *
 *  @return BMI值 若 height <= 0 BMI为 0
 */
+(float)calculateBMIWithUserInfo:(UserInfoEntity *)user
{
    float _bmi = 0;
    if (user) {
        if (user.UI_lastUserData) {
            
            float _w = 0;
            float _h = 0;
            
            if (user.UI_lastUserData.UD_WEIGHT && ![user.UI_lastUserData.UD_WEIGHT isEqual:[NSNull null]]) {
                _w = [user.UI_lastUserData.UD_WEIGHT floatValue];
            }
            if (user.UI_height && ![user.UI_height isEqual:[NSNull null]]) {
                _h = [user.UI_height floatValue];
            }
            
            if (_h > 0)
            {
                _bmi =  _w / ( _h * _h / 10000.0);
            }
            else{
                _bmi = 0;
            }
        }
    }
    return _bmi;
}


/**
 *  计算BMR
 *
 *  @param user 用户信息对象
 *
 *  @return BMR值
 */

+(float)calculateBMRWithUserInfo:(UserInfoEntity *)user
{
    float _standard = 0;
    if (user) {
        
        if (user.UI_age && ![user.UI_age isEqual:[NSNull null]]) {
            int age     = [user.UI_age intValue];
            
            if (user.UI_lastUserData &&
                user.UI_lastUserData.UD_WEIGHT &&
                ![user.UI_lastUserData.UD_WEIGHT isEqual:[NSNull null]])
            {
                float _weight = [user.UI_lastUserData.UD_WEIGHT floatValue];
                
                
                if (age >= 10 && age < 18) {
                    _standard = 17.5 * _weight + 651;
                }
                else if (age >= 18 && age < 30) {
                    _standard = 15.3 * _weight + 679;
                }
                else if (age >= 30) {
                    _standard = 11.6 * _weight + 879;
                }
            }
            
            
        }
        
    }
    
    return _standard;
}


/**
 *  计算BMR (亚洲标准)
 *
 *  @param user 用户信息对象
 *
 *  @return BMI值
 */

+(float)calculateAsiaBMRWithUserInfo:(UserInfoEntity *)user
{
    float _standard = 0;
    if (user) {
        int age     = [[CalculateTool inputStr:user.UI_age] intValue];
        int sex     = [[CalculateTool inputStr:user.UI_sex] intValue];
        if (age <= 11
            ) {
            if (sex) {
                _standard = 1330;
            }else{
                _standard = 1200;
            }
        }
        else if (age >= 12 &&
                 age <= 14
                 ) {
            if (sex) {
                _standard = 1490;
            }else{
                _standard = 1360;
            }
        }
        else if (age >= 15 &&
                 age <= 17
                 ) {
            if (sex) {
                _standard = 1580;
            }else{
                _standard = 1280;
            }
        }
        else if (age >= 18 &&
                 age <= 29
                 ) {
            if (sex) {
                _standard = 1510;
            }else{
                _standard = 1120;
            }
        }
        else if (age >= 30 &&
                 age <= 49
                 ) {
            if (sex) {
                _standard = 1530;
            }else{
                _standard = 1150;
            }
        }
        else if (age >= 50 &&
                 age <= 69
                 ) {
            if (sex) {
                _standard = 1400;
            }else{
                _standard = 1110;
            }
        }
        else if (age >= 70 ) {
            if (sex) {
                _standard = 1280;
            }else{
                _standard = 1010;
            }
        }
    }
    
    
    
    
    
    return _standard;
}


/**
 *  计算RyFit指数
 *
 *  @param user 目标用户对象
 *  @param data 测量数据
 *
 *  @return RyFit指数   -1为异常(不再0～100之间）
 */
+(float)calculateRyFitWithUserInfo:(UserInfoEntity *)user
                              data:(UserDataEntity *)data
{
    
    float _result = -1;
    
    if (user && data) {
        int _age        = [[CalculateTool inputStr:user.UI_age] intValue];
        int _bodyAge    = [[CalculateTool inputStr:data.UD_BODYAGE] intValue];
        float _off      = [[CalculateTool inputStr:data.UD_OFFALFAT] floatValue];
        float _bmi      = [[CalculateTool inputStr:data.UD_BMI] floatValue];
        
        if (_bodyAge != 0 &&
            _off     != 0 &&
            _bmi     != 0 )
        {
            float _ageNum = 85 + (_age - _bodyAge) * 2;
            float _offNum = 100 - _off * 4.0;
            
            float _bmiNum = 0 ;
            
            if (_bmi < 18) {
                _bmiNum = 100 - 3.0 * 2 - (18 - _bmi) * 5.0;
            }
            else if (_bmi >= 18 && _bmi <= 24){
                _bmiNum = 100 - fabs(_bmi - 20) * 3.0;
            }
            else if (_bmi > 24){
                _bmiNum = 100 - 3.0 * 4 - (_bmi - 24) * 5.0;
                
            }
            
            float _ryfit =  0.2 * _offNum +
            0.3 * _bmiNum +
            0.5 * _ageNum;
            
            
            if (_ryfit >= 0 && _ryfit <= 100) {
                _result = _ryfit;
            }
        }
        
    }
    data.UD_ryFit = [NSString stringWithFormat:@"%f",_result];
    
    
    return [[NSString stringWithFormat:@"%.1f",_result] floatValue];
}


+(float)calculateRyFitWithAge:(float)age
                      bodyAge:(float)bAge
                       offFat:(float)off
                          bmi:(float)bmi
{
    
    float _result = -1;
    if (bAge != 0 &&
        off  != 0 &&
        bmi  != 0 )
    {
        float _ageNum = 85 + (age - bAge) * 2;
        float _offNum = 100 - off * 4.0;
        float _bmiNum = 0 ;
        
        if (bmi < 18) {
            _bmiNum = 100 - 3.0 * 2 - (18 - bmi) * 5.0;
        }
        else if (bmi >= 18 && bmi <= 24){
            _bmiNum = 100 - fabs(bmi - 20) * 3.0;
        }
        else if (bmi > 24){
            _bmiNum = 100 - 3.0 * 4 - (bmi - 24) * 5.0;
            
        }
        
        float _ryfit =  0.2 * _offNum +
        0.3 * _bmiNum +
        0.5 * _ageNum;
        
        
        if (_ryfit >= 0 && _ryfit <= 100) {
            _result = _ryfit;
        }
    }
    
    return _result;
}



#pragma mark - 体征计算 块开始
/**
 *  计算体征数据
 *
 *  @param userData 测量数据
 *  @param height   用户身高
 *  @param age      用户真实年龄
 *  @param sex      用户性别
 *  @param uid      用户uid
 *
 *  @return PCEntity对象元素数组 11项体征，11个元素
 */
+(NSArray *)calculatePhysicalCharacteristics:(UserDataEntity *)userData
                                      height:(float)height
                                         age:(int)age
                                         sex:(int)sex
                                         uid:(NSString *)uid
{
    if (!userData) {
        
        NSArray *_ary = @[
                          [CalculateTool calculatePC_weight:0
                                                      lastW:0
                                                        bmi:0
                                                     height:height/100.0],
                          [CalculateTool calculatePC_bmi:0
                                                 lastBmi:0],
                          [CalculateTool calculatePC_fat:0
                                                 lastfat:0
                                                     sex:sex
                                                     age:age],
                          [CalculateTool calculatePC_water:0
                                                 lastwater:0
                                                       sex:sex
                                                       age:age],
                          
                          [CalculateTool calculatePC_muscle:0
                                                 lastmuscle:0
                                                     height:height
                                                        sex:sex],
                          [CalculateTool calculatePC_bone:0
                                                 lastbone:0
                                                      sex:sex
                                                   weight:0],
                          
                          
                          [CalculateTool calculatePC_bmr:0
                                                 lastbmr:0
                                                  weight:0
                                                     age:age
                                                     sex:sex isAsia:1],
                          [CalculateTool calculatePC_bmr:0
                                                 lastbmr:0
                                                  weight:0
                                                     age:age
                                                     sex:sex
                                                  isAsia:0],
                          
                          [CalculateTool calculatePC_skin:0
                                                 lastskin:0
                                                      sex:sex],
                          [CalculateTool calculatePC_offal:0
                                                 lastoffal:0],
                          [CalculateTool calculatePC_bodyage:0
                                                 lastbodyage:0
                                                         age:age]
                          
                          ];
        
        return _ary;
    }
    
    
    float _bmi      = [[CalculateTool inputStr:userData.UD_BMI] floatValue];
    float _weight   = [[CalculateTool inputStr:userData.UD_WEIGHT] floatValue];
    float _fat      = [[CalculateTool inputStr:userData.UD_FAT] floatValue];
    float _skin     = [[CalculateTool inputStr:userData.UD_SKINFAT] floatValue];
    float _offal    = [[CalculateTool inputStr:userData.UD_OFFALFAT] floatValue];
    float _muscle   = [[CalculateTool inputStr:userData.UD_MUSCLE] floatValue];
    
    float _eBmr     = [CalculateTool calculateEuropaBmrByFat:_fat weight:_weight];
    float _bmr      = [[CalculateTool inputStr:userData.UD_METABOLISM] floatValue];
    
    float _bone     = [[CalculateTool inputStr:userData.UD_BONE] floatValue];
    float _water    = [[CalculateTool inputStr:userData.UD_WATER] floatValue];
    int _bodyage    = [[CalculateTool inputStr:userData.UD_BODYAGE] intValue];
    
    
    
    
    
    
    UserDataEntity *_lastData = [[DatabaseService defaultDatabaseService]
                                 getUserDataByUid:uid num:2];
    /* 若第二条数据不存在，则填充为第一条数据内容 */
    if (!_lastData) {
        _lastData = [[UserDataEntity alloc]init];
        _lastData.UD_WEIGHT     = userData.UD_WEIGHT;
        _lastData.UD_WATER      = userData.UD_WATER;
        _lastData.UD_SKINFAT    = userData.UD_SKINFAT;
        _lastData.UD_STATUS     = userData.UD_STATUS;
        _lastData.UD_BMI        = userData.UD_BMI;
        
        _lastData.UD_BODYAGE    = userData.UD_BODYAGE;
        _lastData.UD_BONE       = userData.UD_BONE;
        _lastData.UD_METABOLISM = userData.UD_METABOLISM;
        _lastData.UD_MUSCLE     = userData.UD_MUSCLE;
        _lastData.UD_OFFALFAT   = userData.UD_OFFALFAT;
        
        _lastData.UD_FAT        = userData.UD_FAT;
        
    }
    
    
    NSArray *_ary = @[
                      [CalculateTool calculatePC_weight:_weight
                                                  lastW:[[CalculateTool inputStr:_lastData.UD_WEIGHT] floatValue]
                                                    bmi:_bmi
                                                 height:height/100.0],
                      [CalculateTool calculatePC_bmi:_bmi
                                             lastBmi:[[CalculateTool inputStr:_lastData.UD_BMI] floatValue]],
                      [CalculateTool calculatePC_fat:_fat
                                             lastfat:[[CalculateTool inputStr:_lastData.UD_FAT] floatValue]
                                                 sex:sex
                                                 age:age],
                      [CalculateTool calculatePC_water:_water
                                             lastwater:[[CalculateTool inputStr:_lastData.UD_WATER] floatValue]
                                                   sex:sex
                                                   age:age],
                      
                      
                      [CalculateTool calculatePC_muscle:_muscle
                                             lastmuscle:[[CalculateTool inputStr:_lastData.UD_MUSCLE] floatValue]
                                                 height:height
                                                    sex:sex],
                      [CalculateTool calculatePC_bone:_bone
                                             lastbone:[[CalculateTool inputStr:_lastData.UD_BONE] floatValue]
                                                  sex:sex
                                               weight:_weight],
                      
                      
                      
                      
                      [CalculateTool calculatePC_bmr:_bmr
                                             lastbmr:[[CalculateTool inputStr:_lastData.UD_METABOLISM] floatValue]
                                              weight:_weight
                                                 age:age
                                                 sex:sex isAsia:1],
                      [CalculateTool calculatePC_bmr:_eBmr
                                             lastbmr:[CalculateTool calculateEuropaBmrByFat:[[CalculateTool inputStr:_lastData.UD_FAT] floatValue]
                                                                                     weight:[[CalculateTool inputStr:_lastData.UD_WEIGHT] floatValue]]
                                              weight:_weight
                                                 age:age
                                                 sex:sex isAsia:0],
                      
                      
                      [CalculateTool calculatePC_skin:_skin
                                             lastskin:[[CalculateTool inputStr:_lastData.UD_SKINFAT] floatValue]
                                                  sex:sex],
                      [CalculateTool calculatePC_offal:_offal
                                             lastoffal:[[CalculateTool inputStr:_lastData.UD_OFFALFAT] floatValue]],
                      [CalculateTool calculatePC_bodyage:_bodyage
                                             lastbodyage:[[CalculateTool inputStr:_lastData.UD_BODYAGE] floatValue]
                                                     age:age]
                      
                      ];
    //NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    
    return _ary;
}




+(NSArray *)calculatePhysicalCharacteristicsByData:(UserDataEntity *)userData
{
    
    
    UserInfoEntity *_user = [GloubleProperty sharedInstance].currentUserEntity;
    
    if (!_user) {
        return @[];
    }
    
    float _height   = [[CalculateTool inputStr:_user.UI_height] floatValue];
    int _age        = [[CalculateTool inputStr:_user.UI_age] intValue];
    int _sex        = [[CalculateTool inputStr:_user.UI_sex] intValue];
    NSString *_uid  = [CalculateTool inputStr:_user.UI_userId];
    
    return [CalculateTool calculatePhysicalCharacteristics:userData
                                                    height:_height
                                                       age:_age
                                                       sex:_sex
                                                       uid:_uid];
}

+(NSArray *)calculatePhysicalCharacteristicsByData:(UserDataEntity *)userData
                                    withUserEnitty:(UserInfoEntity *)userInfo
{
    
    
    UserInfoEntity *_user = userInfo;
    
    if (!_user) {
        return @[];
    }
    
    float _height   = [[CalculateTool inputStr:_user.UI_height] floatValue];
    int _age        = [[CalculateTool inputStr:_user.UI_age] intValue];
    int _sex        = [[CalculateTool inputStr:_user.UI_sex] intValue];
    NSString *_uid  = [CalculateTool inputStr:_user.UI_userId];
    
    return [CalculateTool calculatePhysicalCharacteristics:userData
                                                    height:_height
                                                       age:_age
                                                       sex:_sex
                                                       uid:_uid];
}






#pragma mark *分支
+(PCEntity *)calculatePC_weight:(float)oW
                          lastW:(float)lW
                            bmi:(float)bmi
                         height:(float)height
{
    float _hSQ      = height * height;
    
    PCEntity *_pce      = [[PCEntity alloc]init];
    _pce.pc_tp          = PCType_weight;
    _pce.pc_deltaValue  = oW - lW;
    _pce.pc_originValue = oW;
    if (bmi < 18.5) {
        _pce.pc_description = @"偏瘦";
    }else if (bmi >= 18.5 && bmi < 24){
        _pce.pc_description = @"标准";
    }else if (bmi >= 24 && bmi < 28){
        _pce.pc_description = @"超重";
    }else if (bmi >= 28){
        _pce.pc_description = @"肥胖";
    }
    if ([@"标准" isEqualToString:_pce.pc_description]) {
        _pce.pc_status = YES;
    }else{
        _pce.pc_status = NO;
    }
    //NSLog(@"weight:%@",_pce.pc_description);
    
    
    if (_hSQ == 0) {
        _pce.pc_filedPointList = @[@5.0,@150.0];
    }
    else{
        float _p1 = 18.5 * _hSQ;
        float _p2 = 24.0 * _hSQ;
        float _p3 = 28.0 * _hSQ;
        
        if (_p1 > 5 && _p3 < 150) {
            _pce.pc_filedPointList = @[
                                       @5.0,
                                       [NSNumber numberWithFloat: _p1],
                                       [NSNumber numberWithFloat: _p2],
                                       [NSNumber numberWithFloat: _p3],
                                       @150.0
                                       ];
        }else{
            
            _pce.pc_filedPointList = @[@5.0,@150.0];
        }
        
    }
    
    
    
    
    return _pce;
}


+(PCEntity *)calculatePC_bmi:(float)oBmi
                     lastBmi:(float)lBmi
{
    PCEntity *_pce      = [[PCEntity alloc]init];
    _pce.pc_tp          = PCType_bmi;
    _pce.pc_deltaValue  = oBmi - lBmi;
    _pce.pc_originValue = oBmi;
    if (oBmi < 18.5) {
        _pce.pc_description = @"偏瘦";
    }else if (oBmi >= 18.5 && oBmi < 24){
        _pce.pc_description = @"标准";
    }else if (oBmi >= 24 && oBmi < 28){
        _pce.pc_description = @"超重";
    }else if (oBmi >= 28){
        _pce.pc_description = @"肥胖";
    }
    
    if ([@"标准" isEqualToString:_pce.pc_description]) {
        _pce.pc_status = YES;
    }else{
        _pce.pc_status = NO;
    }
    //NSLog(@"bmi:%@",_pce.pc_description);
    _pce.pc_filedPointList = @[
                               @10.0,
                               @18.5,
                               @24.0,
                               @28.0,
                               @40.0
                               ];
    
    return _pce;
}


+(PCEntity *)calculatePC_fat:(float)oFat
                     lastfat:(float)lFat
                         sex:(int)sex
                         age:(int)age
{
    PCEntity *_pce      = [[PCEntity alloc]init];
    _pce.pc_tp          = PCType_fat;
    _pce.pc_deltaValue  = oFat - lFat;
    _pce.pc_originValue = oFat;
    NSArray  *_fatFiledList = nil;
    NSString *_fatStr = @"";
    if (sex) {
        if (age > 30) {
            if (oFat < 16) {
                _fatStr = @"偏瘦";
            }else if (oFat >= 16 && oFat < 23){
                _fatStr = @"标准";
            }else if (oFat >= 23 && oFat < 25){
                _fatStr = @"超重";
            }else if (oFat >= 25){
                _fatStr = @"肥胖";
            }
            _fatFiledList = @[@5.0,
                              @16.0,
                              @23.0,
                              @25.0,
                              @75.0];
        }
        else{
            if (oFat < 13) {
                _fatStr = @"偏瘦";
            }else if (oFat >= 13 && oFat < 21){
                _fatStr = @"标准";
            }else if (oFat >= 21 && oFat < 25){
                _fatStr = @"超重";
            }else if (oFat >= 25){
                _fatStr = @"肥胖";
            }
            _fatFiledList = @[@5.0,
                              @13.0,
                              @21.0,
                              @25.0,
                              @75.0];
        }
    }
    else{
        if (age > 30) {
            if (oFat < 19) {
                _fatStr = @"偏瘦";
            }else if (oFat >= 19 && oFat < 27){
                _fatStr = @"标准";
            }else if (oFat >= 27 && oFat < 30){
                _fatStr = @"超重";
            }else if (oFat >= 30){
                _fatStr = @"肥胖";
            }
            _fatFiledList = @[@5.0,
                              @19.0,
                              @27.0,
                              @30.0,
                              @75.0];
        }
        else{
            if (oFat < 16) {
                _fatStr = @"偏瘦";
            }else if (oFat >= 16 && oFat < 23){
                _fatStr = @"标准";
            }else if (oFat >= 23 && oFat < 30){
                _fatStr = @"超重";
            }else if (oFat >= 30){
                _fatStr = @"肥胖";
            }
            _fatFiledList = @[@5.0,
                              @16.0,
                              @23.0,
                              @30.0,
                              @75.0];
        }
    }
    
    _pce.pc_filedPointList  = _fatFiledList;
    _pce.pc_description     = _fatStr;
    if ([@"标准" isEqualToString:_pce.pc_description]) {
        _pce.pc_status = YES;
    }else{
        _pce.pc_status = NO;
    }
    //NSLog(@"Fat:%@",_pce.pc_description);
    
    return _pce;
}

+(PCEntity *)calculatePC_skin:(float)oSkin
                     lastskin:(float)lSkin
                          sex:(int)sex
{
    PCEntity *_pce      = [[PCEntity alloc]init];
    _pce.pc_tp          = PCType_skin;
    _pce.pc_deltaValue  = oSkin - lSkin;
    _pce.pc_originValue = oSkin;
    
    NSArray *_fpList = nil;
    NSString *_skinStr = @"";
    if (sex) {
        if (oSkin < 8.6) {
            _skinStr = @"偏低";
        }else if (oSkin >= 8.6 && oSkin < 16.7){
            _skinStr = @"标准";
        }else if (oSkin >= 16.7){
            _skinStr = @"偏高";
        }
        _fpList = @[@5.0,@8.6,@16.7,@60.0];
    }
    else{
        if (oSkin < 18.5) {
            _skinStr = @"偏低";
        }else if (oSkin >= 18.5 && oSkin < 26.7){
            _skinStr = @"标准";
        }else if (oSkin >= 26.7){
            _skinStr = @"偏高";
        }
        _fpList = @[@5.0,@18.5,@26.7,@60.0];
    }
    
    _pce.pc_filedPointList  = _fpList;
    _pce.pc_description     = _skinStr;
    
    if ([@"标准" isEqualToString:_pce.pc_description]) {
        _pce.pc_status = YES;
    }else{
        _pce.pc_status = NO;
    }
    //NSLog(@"Skin:%@",_pce.pc_description);
    
    return _pce;
}

+(PCEntity *)calculatePC_offal:(float)oOffal
                     lastoffal:(float)lOffal
{
    PCEntity *_pce      = [[PCEntity alloc]init];
    _pce.pc_tp          = PCType_offal;
    _pce.pc_deltaValue  = oOffal - lOffal;
    _pce.pc_originValue = oOffal;
    
    NSString *_offalStr = @"";
    if (oOffal < 10) {
        _offalStr = @"标准";
    }
    else if (oOffal >= 10 && oOffal <= 15)
    {
        _offalStr = @"偏高";
    }
    else if (oOffal > 15)
    {
        _offalStr = @"过高";
    }
    
    _pce.pc_filedPointList  = @[@1,@10,@15,@30];
    _pce.pc_description     = _offalStr;
    
    if ([@"标准" isEqualToString:_pce.pc_description]) {
        _pce.pc_status = YES;
    }else{
        _pce.pc_status = NO;
    }
    //NSLog(@"Offal:%@",_pce.pc_description);
    
    return _pce;
}


+(PCEntity *)calculatePC_muscle:(float)oMuscle
                     lastmuscle:(float)lMuscle
                         height:(float)height
                            sex:(int)sex

{
    PCEntity *_pce      = [[PCEntity alloc]init];
    _pce.pc_tp          = PCType_muscle;
    
    _pce.pc_deltaValue  = oMuscle - lMuscle;
    _pce.pc_originValue = oMuscle;
    
    NSArray *_fpList = nil;
    NSString *_muscleStr = @"";
    if (sex) {
        
        float _minM = 0;
        float _maxM = 0;
        
        if (height <= 160) {
            
            _minM   = 42.5 - 4;
            _maxM   = 42.5 + 4;
            
            if (oMuscle < _minM) {
                _muscleStr = @"偏低";
            }
            else if (oMuscle >= _minM && oMuscle <= _maxM)
            {
                _muscleStr = @"标准";
            }
            else if (oMuscle > _maxM)
            {
                _muscleStr = @"偏高";
            }
            
        }
        else if (height > 160 && height <= 170){
            
            _minM = 48.2 - 4.2;
            _maxM = 48.2 + 4.2;
            
            
            if (oMuscle < _minM) {
                
                _muscleStr = @"偏低";
                
            }
            else if (oMuscle >= _minM && oMuscle <= _maxM)
            {
                _muscleStr = @"标准";
            }
            else if (oMuscle > _maxM)
            {
                _muscleStr = @"偏高";
            }
            
        }
        else if (height > 170){
            
            _minM = 54.4 - 5;
            _maxM = 54.4 + 5;
            
            
            if (oMuscle < _minM) {
                
                _muscleStr = @"偏低";
                
            }
            else if (oMuscle >= _minM && oMuscle <= _maxM)
            {
                _muscleStr = @"标准";
            }
            else if (oMuscle > _maxM)
            {
                _muscleStr = @"偏高";
            }
            
        }
        
        _fpList = @[@25,
                    [NSNumber numberWithFloat:_minM],
                    [NSNumber numberWithFloat:_maxM],
                    @75];
    }
    else{
        
        float _minM = 0;
        float _maxM = 0;
        
        if (height <= 150) {
            
            _minM = 31.9 - 2.8;
            _maxM = 31.9 + 2.8;
            
            if (oMuscle < _minM) {
                
                _muscleStr = @"偏低";
                
            }
            else if (oMuscle >= _minM && oMuscle <= _maxM)
            {
                _muscleStr = @"标准";
            }
            else if (oMuscle > _maxM)
            {
                _muscleStr = @"偏高";
            }
            
        }
        else if (height > 150 && height <= 160){
            
            _minM = 35.2 - 2.3;
            _maxM = 35.2 + 2.3;
            
            
            if (oMuscle < _minM) {
                
                _muscleStr = @"偏低";
                
            }
            else if (oMuscle >= _minM && oMuscle <= _maxM)
            {
                _muscleStr = @"标准";
            }
            else if (oMuscle > _maxM)
            {
                _muscleStr = @"偏高";
            }
            
        }
        else if (height > 160){
            
            _minM = 39.5 - 3;
            _maxM = 39.5 + 3;
            
            
            if (oMuscle < _minM) {
                
                _muscleStr = @"偏低";
                
            }
            else if (oMuscle >= _minM && oMuscle <= _maxM)
            {
                _muscleStr = @"标准";
            }
            else if (oMuscle > _maxM)
            {
                _muscleStr = @"偏高";
            }
            
        }
        
        _fpList = @[@25,
                    [NSNumber numberWithFloat:_minM],
                    [NSNumber numberWithFloat:_maxM],
                    @75];
        
    }
    
    _pce.pc_filedPointList  = _fpList;
    _pce.pc_description     = _muscleStr;
    
    if ([@"标准" isEqualToString:_pce.pc_description]) {
        _pce.pc_status = YES;
    }else{
        _pce.pc_status = NO;
    }
    //NSLog(@"Muscle:%@",_pce.pc_description);
    return _pce;
}


/*int*/
+(PCEntity *)calculatePC_bmr:(float)oBmr
                     lastbmr:(float)lBmr
                      weight:(float)weight
                         age:(int)age
                         sex:(int)sex
                      isAsia:(int)isAsia
{
    PCEntity *_pce      = [[PCEntity alloc]init];
    _pce.pc_tp          = isAsia ? PCType_bmr : PCType_eBmr;
    _pce.pc_deltaValue  = oBmr - lBmr;
    _pce.pc_originValue = (int)oBmr;
    
    NSString *_bmrStr   = @"";
    float _standard     = 0;
    
    if (isAsia) {
        
        if (age <= 11
            ) {
            if (sex) {
                _standard = 1330;
            }else{
                _standard = 1200;
            }
        }
        else if (age >= 12 &&
                 age <= 14
                 ) {
            if (sex) {
                _standard = 1490;
            }else{
                _standard = 1360;
            }
        }
        else if (age >= 15 &&
                 age <= 17
                 ) {
            if (sex) {
                _standard = 1580;
            }else{
                _standard = 1280;
            }
        }
        else if (age >= 18 &&
                 age <= 29
                 ) {
            if (sex) {
                _standard = 1510;
            }else{
                _standard = 1120;
            }
        }
        else if (age >= 30 &&
                 age <= 49
                 ) {
            if (sex) {
                _standard = 1530;
            }else{
                _standard = 1150;
            }
        }
        else if (age >= 50 &&
                 age <= 69
                 ) {
            if (sex) {
                _standard = 1400;
            }else{
                _standard = 1110;
            }
        }
        else if (age >= 70 ) {
            if (sex) {
                _standard = 1280;
            }else{
                _standard = 1010;
            }
        }
        
    }
    else{
        if (age >= 10 && age < 18)
        {
            _standard = 17.5 * weight + 651;
            
        }
        else if (age >= 18 && age < 30)
        {
            _standard = 15.3 * weight + 679;
            
        }
        else if (age >= 30)
        {
            _standard = 11.6 * weight + 879;
            
        }
    }
    
    if (oBmr < _standard) {
        _bmrStr = @"未达标";
    }else{
        _bmrStr = @"达标";
    }
    
    _pce.pc_filedPointList  = @[[NSNumber numberWithFloat:(_standard - 500)],
                                [NSNumber numberWithFloat:_standard],
                                [NSNumber numberWithFloat:(_standard + 500)]
                                ];
    
    _pce.pc_description     = _bmrStr;
    
    if ([@"达标" isEqualToString:_pce.pc_description]) {
        _pce.pc_status = YES;
    }else{
        _pce.pc_status = NO;
    }
    //NSLog(@"Bmr:%@",_pce.pc_description);
    return _pce;
}

+(PCEntity *)calculatePC_bone:(float)oBone
                     lastbone:(float)lBone
                          sex:(int)sex
                       weight:(float)weight
{
    
    PCEntity *_pce      = [[PCEntity alloc]init];
    
    _pce.pc_tp          = PCType_boneWeight;
    _pce.pc_deltaValue  = oBone - lBone;
    _pce.pc_originValue = oBone;
    
    NSArray *_fpList    = @[@0.1,@10];
    NSString *_boneStr = @"";
    
    float _boneNum = oBone * weight / 100.0;
    
    
    if (sex) {
        if (_boneNum  < 3.1) {
            _boneStr = @"偏低";
        }
        else if (_boneNum >= 3.1 && _boneNum <= 3.3){
            _boneStr = @"标准";
        }
        else if (_boneNum > 3.3) {
            _boneStr = @"偏高";
        }
        
        
        if (weight == 0) {
            _fpList    = @[@0.1,@10];
        }
        else{
            
            float _p1 = 3.1 * 100 / weight;
            float _p2 = 3.3 * 100 / weight;
            
            
            if (_p1 > 0.1 && _p2 < 10) {
                _fpList = @[
                            @0.1,
                            [NSNumber numberWithFloat:_p1],
                            [NSNumber numberWithFloat:_p2],
                            @10
                            ];
            }
            else{
                _fpList    = @[@0.1,@10];
            }
            
            
        }
        
    }
    else{
        if (_boneNum < 2.4) {
            _boneStr = @"偏低";
        }
        else if (_boneNum >= 2.4 && _boneNum <= 2.6){
            _boneStr = @"标准";
        }
        else if (_boneNum > 2.6) {
            _boneStr = @"偏高";
        }
        
        
        if (weight == 0) {
            _fpList    = @[@0.1,@10];
        }
        else{
            
            float _p1 = 2.4 * 100 / weight;
            float _p2 = 2.6 * 100 / weight;
            
            
            if (_p1 > 0.1 && _p2 < 10) {
                _fpList = @[
                            @0.1,
                            [NSNumber numberWithFloat:_p1],
                            [NSNumber numberWithFloat:_p2],
                            @10
                            ];
            }
            else{
                _fpList    = @[@0.1,@10];
            }
            
            
        }
    }
    
    _pce.pc_filedPointList  = _fpList;
    _pce.pc_description     = _boneStr;
    if ([@"标准" isEqualToString:_pce.pc_description]) {
        _pce.pc_status = YES;
    }else{
        _pce.pc_status = NO;
    }
    //NSLog(@"Bone:%@",_pce.pc_description);
    return _pce;
}

+(PCEntity *)calculatePC_water:(float)oWater
                     lastwater:(float)lWater
                           sex:(int)sex
                           age:(int)age
{
    
    PCEntity *_pce      = [[PCEntity alloc]init];
    
    _pce.pc_tp          = PCType_water;
    _pce.pc_deltaValue  = oWater - lWater;
    _pce.pc_originValue = oWater;
    
    NSArray *_fpList = @[@10,@80];
    NSString *_waterStr = @"";
    if (sex) {
        if (age > 30) {
            if (oWater < 53.3) {
                _waterStr = @"偏低";
            }else if (oWater >= 53.3 && oWater <= 55.6){
                _waterStr = @"标准";
            }else if (oWater > 55.6){
                _waterStr = @"偏高";
            }
            _fpList = @[@10,@53.3,@55.6,@80];
        }else{
            if (oWater < 53.6) {
                _waterStr = @"偏低";
            }else if (oWater >= 53.6 && oWater <= 57){
                _waterStr = @"标准";
            }else if (oWater > 57){
                _waterStr = @"偏高";
            }
            _fpList = @[@10,@53.6,@57,@80];
        }
    }
    else{
        if (age > 30) {
            if (oWater < 48.1) {
                _waterStr = @"偏低";
            }else if (oWater >= 48.1 && oWater <= 51.5){
                _waterStr = @"标准";
            }else if (oWater > 51.5){
                _waterStr = @"偏高";
            }
            _fpList = @[@10,@48.1,@51.5,@80];
        }else{
            if (oWater < 49.5) {
                _waterStr = @"偏低";
            }else if (oWater >= 49.5 && oWater <= 52.9){
                _waterStr = @"标准";
            }else if (oWater > 52.9){
                _waterStr = @"偏高";
            }
            _fpList = @[@10,@49.5,@52.9,@80];
        }
    }
    
    _pce.pc_filedPointList = _fpList;
    _pce.pc_description = _waterStr;
    if ([@"标准" isEqualToString:_pce.pc_description]) {
        _pce.pc_status = YES;
    }else{
        _pce.pc_status = NO;
    }
    //NSLog(@"water:%@",_pce.pc_description);
    return _pce;
}

/*int*/
+(PCEntity *)calculatePC_bodyage:(float)oBodyage
                     lastbodyage:(float)lBodyage
                             age:(int)age
{
    
    PCEntity *_pce      = [[PCEntity alloc]init];
    
    _pce.pc_tp          = PCType_bodyage;
    _pce.pc_deltaValue  = oBodyage - lBodyage;
    _pce.pc_originValue = (int)oBodyage;
    
    _pce.pc_filedPointList = @[@18,[NSNumber numberWithInt:age],@80];
    _pce.pc_description = @"";
    if (oBodyage <= age) {
        _pce.pc_status = YES;
    }else{
        _pce.pc_status = NO;
    }
    //NSLog(@"bodyage:%f,age:%d",oBodyage,age);
    return _pce;
}


+(float)calculateEuropaBmrByFat:(float)fat
                         weight:(float)weight
{
    if (weight == 0 || fat == 0) {
        return 0;
    }
    
    float _lbm  = (100 - fat) * weight / 100.0;
    float _p    = 370 + (21.6 * _lbm);
    
    return _p;
}


/**
 *  计算上限值
 *
 *  @param oValue 原值
 *  @param tValue 目标值
 *  @param aValue 修正值
 *
 *  @return 结果值
 */
+(int)calculateMaxValueByOValue:(float)oValue
                         tValue:(float)tValue
                       addValue:(float)aValue
                         uValue:(int)uValue
{
    int _result = oValue;
    if (tValue + aValue > oValue) {
        int _wM = (int)(tValue / uValue);
        if (tValue > _wM * uValue) {
            _result = (_wM + 1) * uValue + aValue;
        }
        else{
            _result = _wM * uValue + aValue;
        }
    }
    
    return _result;
}



+(float)calculateMaxValueByOValue:(float)oValue
                           tValue:(float)tValue
{
    float _result = oValue;
    if (tValue > oValue) {
        //_result = ceilf(tValue);
        _result = tValue;
    }
    
    return _result;
}


+(float)calculateMinValueByOValue:(float)oValue
                           tValue:(float)tValue
{
    float _result = oValue;
    if (tValue < oValue) {
        //_result = floorf(tValue);
        _result = tValue;
    }
    
    return _result;
}



#pragma mark 体征计算 块结束




@end
