//
//  JDPlusModel.m
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-5-28.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "JDPlusModel.h"
#import <CommonCrypto/CommonDigest.h>

@implementation JDPlusModel
+(NSString *)inputStr:(id)ipStr
{
    NSString *_result = @"";
    
    if (ipStr == nil || ipStr == NULL) {
        return _result = @"";
    }
    if ([ipStr isKindOfClass:[NSNull class]]) {
        return _result = @"";
    }
    
    if ([ipStr isKindOfClass:[NSString class]]) {
        _result = ipStr;
    }
    
    if ([ipStr isKindOfClass:[NSNumber class]]) {
        _result = [(NSNumber *)ipStr stringValue];
    }
    
    return _result;
}

+(NSString *)md5String:(NSString *)tStr
{
    const char *cStr = [tStr UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(NSString *)getDateStr:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:
                                    NSDayCalendarUnit |
                                    NSMonthCalendarUnit |
                                    NSYearCalendarUnit |
                                    NSHourCalendarUnit |
                                    NSMinuteCalendarUnit |
                                    NSSecondCalendarUnit
                                                                   fromDate:date ];
    
    return [NSString stringWithFormat:@"%04d-%02d-%02d %02d:%02d:%02d",
            (int)[components year],
            (int)[components month],
            (int)[components day],
            (int)[components hour],
            (int)[components minute],
            (int)[components second]
            ];
}

+(NSString *)getDateStrChinaStr:(NSString *)date
{
    NSMutableString *_chinaStr = [[NSMutableString alloc]init];
    
    if (date &&
        ![date isKindOfClass:[NSNull class]] &&
          date.length > 0)
    {
        NSArray *_ary = [date componentsSeparatedByString:@" "];
        if (_ary.count == 2) {
            [_chinaStr appendString:_ary[0]];
            [_chinaStr appendString:@"T"];
            [_chinaStr appendString:_ary[1]];
            [_chinaStr appendString:@"+0800"];
        }
    }
    
    return _chinaStr;
}

+(void)loginWithAppKey:(NSString *)appKey
             appSecret:(NSString *)appSecret
        appRedirectUrl:(NSString *)appRDURL
           navBarColor:(UIColor *)color
   targetNavController:(UIViewController *)navController
              callback:(JDLoginCallBack)callback

{
    NSDictionary *dict = @{JDOptionAppKey:appKey,
                           JDOptionAppSecret:appSecret,
                           JDOptionNavbarColor:color,
                           JDOptionAppRedirectUri:appRDURL};
    [[JD_JOS_SDK manager] SetOption:dict];
    
    
    [[JD_JOS_SDK manager] Login:navController
                          Block:^(JDUserInfo *userInfo)
     {
         if (userInfo) {
             if (callback) {
                 callback(YES,userInfo);
             }
         } else {
             if (callback) {
                 callback(NO,nil);
             }
         }
     }];
    
    
    
    
}


/**
 *  京东上传数据
 *
 *  @param data 数据对象
 *  @param user 用户信心
 */
+(NSString *)uploadData:(JDDataEntity *)data
             user:(JDUserInfoEntity *)user
{
    NSString *_resultUrl = nil;
    if (data && user)
    {
        NSString *_jsonStrkey   = @"360buy_param_json";
        
        

        
        NSMutableString *_jsonStr = [NSMutableString stringWithString:@"{\"datas\":\""];
        [_jsonStr appendString:@"{"];
        [_jsonStr appendString:@"\\\"body_fat_value\\\":"];
        
        [_jsonStr appendString:@"{"];
        
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"age\\\":\\\"%@\\\",",data.jdd_age ] ];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"basal_metabolic_rate\\\":\\\"%@\\\",",
                    data.jdd_basal_metabolic_rate ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"body_fat_ratio\\\":\\\"%@\\\",",
                    data.jdd_body_fat_ratio ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"body_mass_index\\\":\\\"%@\\\",",
                    data.jdd_body_mass_index ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"measure_time\\\":\\\"%@\\\",",data.jdd_measure_time ] ];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"muscle_ratio\\\":\\\"%@\\\",",
                                data.jdd_muscle_ratio ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"protein_ratio\\\":\\\"%@\\\",",
                                data.jdd_protein_ratio ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"skeletal_weight\\\":\\\"%@\\\",",
                                data.jdd_skeletal_weight ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"subcutaneous_fat_ratio\\\":\\\"%@\\\",",
                                data.jdd_subcutaneous_fat_ratio ] ];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"visceral_fat_index\\\":\\\"%@\\\",",
                                data.jdd_visceral_fat_index ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"water_ratio\\\":\\\"%@\\\",",
                                data.jdd_water_ratio ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"weight\\\":\\\"%@\\\"",
                                data.jdd_weight ]];
        
        [_jsonStr appendString:@"},"];
        
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"data_type\\\":\\\"%@\\\",",
                                data.jdd_data_type ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"device_id\\\":\\\"%@\\\",",
                                data.jdd_device_id ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"product_id\\\":\\\"%@\\\",",
                                data.jdd_product_id ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"product_secret\\\":\\\"%@\\\",",
                                data.jdd_product_secret ]];
        [_jsonStr appendString:
         [NSString stringWithFormat:@"\\\"relationship\\\":\\\"%@\\\"",
                                data.jdd_relationship ]];
        
        [_jsonStr appendString:@"}\""];
        [_jsonStr appendString:@"}"];
        
        
        NSString *_aTokenStrKey = @"access_token";
        NSString *_appKeyStrKey = @"app_key";
        NSString *_methodStrKey = @"method";
        NSString *_timestampKey = @"timestamp";
        NSString *_vKey         = @"v";
        NSString *_signStrKey   = @"sign";
        
        
        NSDate *_dt             = [NSDate date];
        NSString *_timeStampStr = [JDPlusModel getDateStr:_dt];
        NSString *_vStr         = @"2.0";
        NSString *_signStr      = @"";
        
        NSMutableString *_paramStr = [[NSMutableString alloc]init];
        
        [_paramStr appendString:kJingDongAppSecret];
        
        [_paramStr appendString:_jsonStrkey];
        [_paramStr appendString:_jsonStr];
        [_paramStr appendString:_aTokenStrKey];
        [_paramStr appendString:user.access_token];
        [_paramStr appendString:_appKeyStrKey];
        [_paramStr appendString:kJingDongAppKey];
        [_paramStr appendString:_methodStrKey];
        [_paramStr appendString:kJingDongMethod];
        [_paramStr appendString:_timestampKey];
        [_paramStr appendString:_timeStampStr];
        [_paramStr appendString:_vKey];
        [_paramStr appendString:_vStr];
        
        [_paramStr appendString:kJingDongAppSecret];
        
        
        
        _signStr = [[JDPlusModel md5String:_paramStr] uppercaseString];
        
        
        
        NSMutableString *_urlStr = [[NSMutableString alloc]init];
        //[_urlStr appendString:@"http://gw.api.360buy.com/routerjson?"];
        [_urlStr appendString:kJingDongProduct_Url];
        [_urlStr appendString:@"?"];
        [_urlStr appendString:_jsonStrkey];
        [_urlStr appendString:@"="];
        [_urlStr appendString:_jsonStr];
        
        [_urlStr appendString:@"&"];
        [_urlStr appendString:_aTokenStrKey];
        [_urlStr appendString:@"="];
        [_urlStr appendString:user.access_token];
        
        [_urlStr appendString:@"&"];
        [_urlStr appendString:_appKeyStrKey];
        [_urlStr appendString:@"="];
        [_urlStr appendString:kJingDongAppKey];
        
        [_urlStr appendString:@"&"];
        [_urlStr appendString:_methodStrKey];
        [_urlStr appendString:@"="];
        [_urlStr appendString:kJingDongMethod];
        
        [_urlStr appendString:@"&"];
        [_urlStr appendString:_timestampKey];
        [_urlStr appendString:@"="];
        [_urlStr appendString:_timeStampStr];
        
        [_urlStr appendString:@"&"];
        [_urlStr appendString:_vKey];
        [_urlStr appendString:@"="];
        [_urlStr appendString:_vStr];
        
        [_urlStr appendString:@"&"];
        [_urlStr appendString:_signStrKey];
        [_urlStr appendString:@"="];
        [_urlStr appendString:_signStr];
        
        NSMutableString *strURL = [NSMutableString stringWithString:
                                   [_urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSRange r = [strURL rangeOfString:@"+"];
        
        [strURL replaceCharactersInRange:r withString:@"%2b"];
        
        //NSLog(@"strURL:%@",strURL);
        _resultUrl = strURL;
        /*
        NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]
                                                                       cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
        [theRequest setHTTPMethod:@"GET"];
        [theRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        _urlC = [NSURLConnection connectionWithRequest:theRequest
                                              delegate:self];
        [_urlC start];
         */
    }
    
    
    return _resultUrl;
    
}


/**
 *  将data转换为JDdata
 *
 *  @param data UserDataEntity
 *
 *  @return JDData
 */
+(JDDataEntity *)transDataToJDData:(UserDataEntity *)data
{
    JDDataEntity *_jdD = nil;
    if (data) {
        _jdD    = [[JDDataEntity alloc]init];
        _jdD.jdd_data_type      = kJingDongProductDataType;
        _jdD.jdd_product_id     = kJingDongProductId;
        _jdD.jdd_product_secret = kJingDongProductSecret;
        _jdD.jdd_relationship   = @"";
        _jdD.jdd_device_id      = [JDPlusModel inputStr:data.UD_devcode];
        
        
        _jdD.jdd_age                    = [JDPlusModel inputStr:data.UD_BODYAGE];
        _jdD.jdd_basal_metabolic_rate   = [JDPlusModel inputStr:data.UD_METABOLISM];
        _jdD.jdd_body_fat_ratio         = [JDPlusModel inputStr:data.UD_FAT];           //float体脂率
        _jdD.jdd_body_mass_index        = [JDPlusModel inputStr:data.UD_BMI];           //float身体质量指数bmi
        _jdD.jdd_measure_time           =
            [JDPlusModel getDateStrChinaStr:[JDPlusModel inputStr:data.UD_CHECKDATE]];  //测量时间
        
        _jdD.jdd_muscle_ratio           = [JDPlusModel inputStr:data.UD_MUSCLE];        //float肌肉率
        _jdD.jdd_protein_ratio          = @"";                   //蛋白率？？
        _jdD.jdd_skeletal_weight        = [JDPlusModel inputStr:data.UD_BONE];          //float(kg)骨骼重量
        _jdD.jdd_subcutaneous_fat_ratio = [JDPlusModel inputStr:data.UD_SKINFAT];       //float皮下脂肪率
        _jdD.jdd_visceral_fat_index     = [JDPlusModel inputStr:data.UD_OFFALFAT];      //float内脏脂肪指数
        
        _jdD.jdd_water_ratio            = [JDPlusModel inputStr:data.UD_WATER];         //float水含量
        _jdD.jdd_weight                 = [JDPlusModel inputStr:data.UD_WEIGHT];        //体重kg
        
        int _badCount = 0;
        if ([@"0" isEqualToString:_jdD.jdd_age] ||
            [@"" isEqualToString:_jdD.jdd_age]
        ) {
            _badCount++;
        }
        if ([@"0" isEqualToString:_jdD.jdd_basal_metabolic_rate] ||
            [@"" isEqualToString:_jdD.jdd_basal_metabolic_rate]
            ) {
            _badCount++;
        }
        if ([@"0" isEqualToString:_jdD.jdd_body_fat_ratio] ||
            [@"" isEqualToString:_jdD.jdd_body_fat_ratio]
            ) {
            _badCount++;
        }
        if ([@"0" isEqualToString:_jdD.jdd_body_mass_index] ||
            [@"" isEqualToString:_jdD.jdd_body_mass_index]
            ) {
            _badCount++;
        }
        if ([@"0" isEqualToString:_jdD.jdd_muscle_ratio] ||
            [@"" isEqualToString:_jdD.jdd_muscle_ratio]
            ) {
            _badCount++;
        }
        if ([@"0" isEqualToString:_jdD.jdd_skeletal_weight] ||
            [@"" isEqualToString:_jdD.jdd_skeletal_weight]
            ) {
            _badCount++;
        }
        if ([@"0" isEqualToString:_jdD.jdd_subcutaneous_fat_ratio] ||
            [@"" isEqualToString:_jdD.jdd_subcutaneous_fat_ratio]
            ) {
            _badCount++;
        }
        if ([@"0" isEqualToString:_jdD.jdd_visceral_fat_index] ||
            [@"" isEqualToString:_jdD.jdd_visceral_fat_index]
            ) {
            _badCount++;
        }
        if ([@"0" isEqualToString:_jdD.jdd_visceral_fat_index] ||
            [@"" isEqualToString:_jdD.jdd_visceral_fat_index]
            ) {
            _badCount++;
        }
        if ([@"0" isEqualToString:_jdD.jdd_weight] ||
            [@"" isEqualToString:_jdD.jdd_weight]
            ) {
            _badCount++;
        }
        
        if (_badCount > 3) {
            _jdD = nil;
        }
        
    }
    
    return _jdD;
}


@end
