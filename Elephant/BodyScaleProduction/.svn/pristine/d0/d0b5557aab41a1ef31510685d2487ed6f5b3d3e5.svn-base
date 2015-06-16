//
//  CalculateTool.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-4-21.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoEntity.h"


typedef enum{
    PCTp_ryFit        = 0,    //tyFit指数
    PCTp_weight       = 1,    //体重
    PCTp_bmi          = 2,    //BMI
    PCTp_fat          = 3,    //脂肪率
    PCTp_water        = 4,    //水含量
    
    PCTp_muscle       = 5,    //肌肉率
    PCTp_boneWeight   = 6,    //骨骼重量
    
    
    PCTp_bmr          = 7,    //基础代谢率
    PCTp_eBmr         = 8,    //基础代谢率 （欧洲）
    
    PCTp_skin         = 9,    //皮下脂肪率
    PCTp_offal        = 10,   //内脏脂肪率
    PCTp_bodyage      = 11    //身体年龄
}PCTp;

@interface CalculateParam : NSObject

@property(nonatomic) float dataCount  ;        //数据计数
@property(nonatomic,strong)NSString *dateStr;  //时间字符串

@property(nonatomic) float ryFit      ;        // ryFit指数
@property(nonatomic) float w          ;        // 体重
@property(nonatomic) float f          ;        // 体脂率
@property(nonatomic) float o          ;        // 内脏脂肪
@property(nonatomic) float s          ;        // 皮下脂肪
@property(nonatomic) float water      ;        // 水含量
@property(nonatomic) float bmi        ;        //BMI
@property(nonatomic) float bone       ;        //骨骼重量
@property(nonatomic) float mu         ;        //肌肉比例
@property(nonatomic) float bmr        ;        //基础代谢
@property(nonatomic) float bAge       ;        //身体年龄
@property(nonatomic) float eBmr       ;        //基础代谢(欧洲)

@property(nonatomic) float ryFitT      ;        // ryFit指数
@property(nonatomic) float wT          ;
@property(nonatomic) float fT          ;
@property(nonatomic) float oT          ;
@property(nonatomic) float sT          ;
@property(nonatomic) float waterT      ;
@property(nonatomic) float bmiT        ;        //BMI
@property(nonatomic) float boneT       ;        //骨骼重量
@property(nonatomic) float muT         ;        //肌肉比例
@property(nonatomic) float bmrT        ;        //基础代谢
@property(nonatomic) float bAgeT       ;        //身体年龄
@property(nonatomic) float eBmrT       ;



@property(nonatomic) int wC          ;
@property(nonatomic) int fC          ;
@property(nonatomic) int oC          ;
@property(nonatomic) int sC          ;
@property(nonatomic) int waterC      ;
@property(nonatomic) int bmiC        ;        //BMI
@property(nonatomic) int boneC       ;        //骨骼重量
@property(nonatomic) int muC         ;        //肌肉比例
@property(nonatomic) int bmrC        ;        //基础代谢
@property(nonatomic) int bAgeC       ;        //身体年龄
@property(nonatomic) int eBmrC       ;


@property(nonatomic,strong)NSString *ymd;   //年月日



-(void)addData:(UserDataEntity *)data
      userInfo:(UserInfoEntity *)user;

-(void)addData:(id)data
           age:(int)age;


-(UserDataEntity *)getDataMax:(NSMutableArray *)maxList
                          min:(NSMutableArray *)minList;

-(CalculateParam *)getCPData;


@end


@interface CalculateTool : NSObject

+ (int)convertToInt:(NSString *)strtemp;


/**
 *  输入参数矫正
 *
 *  @param ipStr 输入参数字符串
 *
 *  @return 矫正后字符串
 */
+(NSString *)inputStr:(id)ipStr;

/**
 *  校验data是否合法
 *
 *  @param data data对象
 *
 *  @return yes 合法；no 非法
 */
+(BOOL)calculateDataIsValid:(UserDataEntity *)data;

/**
 *  修正最大，最小值
 *
 *  @param maxList 最大值数组
 *  @param minList 最小值数组
 *
 */
+(void)calculateFixMaxList:(NSMutableArray *)maxList
                   minList:(NSMutableArray *)minList;



/**
 *  计算BMI
 *
 *  @param weight 体重 单位kg
 *  @param height 身高 单位m
 *
 *  @return BMI值 若 height <= 0   BMI为 0
 */
+(float)calculateBMIWith:(float)weight
                  height:(float)height;


/**
 *  计算BMI
 *
 *  @param user 用户信息对象
 *
 *  @return BMI值 若 height <= 0   BMI为 0
 */
+(float)calculateBMIWithUserInfo:(UserInfoEntity *)user;


/**
 *  计算BMR (欧洲标准)
 *
 *  @param user 用户信息对象
 *
 *  @return BMI值
 */

+(float)calculateBMRWithUserInfo:(UserInfoEntity *)user;


/**
 *  计算BMR (亚洲标准)
 *
 *  @param user 用户信息对象
 *
 *  @return BMI值
 */

+(float)calculateAsiaBMRWithUserInfo:(UserInfoEntity *)user;

/**
 *  计算欧标BMR
 *
 *  @param fat    体脂率
 *  @param weight 体重
 *
 *  @return 欧标BMR
 */
+(float)calculateEuropaBmrByFat:(float)fat
                         weight:(float)weight;




/**
 *  计算上限值
 *
 *  @param oValue 原值
 *  @param tValue 目标值
 *
 *  @return 结果值
 */
+(float)calculateMaxValueByOValue:(float)oValue
                           tValue:(float)tValue;

/**
 *  计算下限值
 *
 *  @param oValue 原值
 *  @param tValue 目标值
 *
 *  @return 结果值
 */
+(float)calculateMinValueByOValue:(float)oValue
                           tValue:(float)tValue;

/**
 *  计算上限值
 *
 *  @param oValue 原值
 *  @param tValue 目标值
 *  @param aValue 修正值
 *  @param uValue 单位界限
 *
 *  @return 结果值
 */
+(int)calculateMaxValueByOValue:(float)oValue
                         tValue:(float)tValue
                       addValue:(float)aValue
                         uValue:(int)uValue;


/**
 *  计算RyFit指数
 *
 *  @param user 目标用户对象
 *  @param data 测量数据
 *
 *  @return RyFit指数   -1为异常(不再0～100之间）
 */
+(float)calculateRyFitWithUserInfo:(UserInfoEntity *)user
                              data:(UserDataEntity *)data;

/**
 *  计算RyFit指数
 *
 *  @param age  实际年龄
 *  @param bAge 身体年龄
 *  @param off  内脏脂肪
 *  @param bmi  bmi
 *
 *  @return 0～100 之间参数   返回－1  代表数据异常
 */
+(float)calculateRyFitWithAge:(float)age
                      bodyAge:(float)bAge
                       offFat:(float)off
                          bmi:(float)bmi;



/**
 *  计算体征数据
 *
 *  @param userData 测量数据        若为nil 则return @[]
 *  @param height   用户身高        单位cm
 *  @param age      用户真实年龄
 *  @param sex      用户性别        1男，0女
 *  @param uid      用户uid
 *
 *  @return PCEntity对象元素数组 11项体征，11个元素 若没有前一次数据，则和自己比较
 */
+(NSArray *)calculatePhysicalCharacteristics:(UserDataEntity *)userData
                                      height:(float)height
                                         age:(int)age
                                         sex:(int)sex
                                         uid:(NSString *)uid;
/**
 *  计算体征数据  根据数据
 *
 *  @param userData 测量数据        若为nil 则return @[]
 *
 *  @return PCEntity对象元素数组 11项体征，11个元素
 */
+(NSArray *)calculatePhysicalCharacteristicsByData:(UserDataEntity *)userData;

+(NSArray *)calculatePhysicalCharacteristicsByData:(UserDataEntity *)userData withUserEnitty:(UserInfoEntity *)userInfo;
@end
