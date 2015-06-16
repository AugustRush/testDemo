//
//  JDDataEntity.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-6-5.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BaseEntity.h"

@interface JDDataEntity : BaseEntity

@property(nonatomic,strong)NSString *jdd_age;                       //int年龄
@property(nonatomic,strong)NSString *jdd_basal_metabolic_rate;      //float(Kcal/d)基础代谢率
@property(nonatomic,strong)NSString *jdd_body_fat_ratio;            //float体脂率
@property(nonatomic,strong)NSString *jdd_body_mass_index;           //float身体质量指数bmi
@property(nonatomic,strong)NSString *jdd_measure_time;              //测量时间

@property(nonatomic,strong)NSString *jdd_muscle_ratio;              //float肌肉率
@property(nonatomic,strong)NSString *jdd_protein_ratio;             //蛋白率？？
@property(nonatomic,strong)NSString *jdd_skeletal_weight;           //float(kg)骨骼重量
@property(nonatomic,strong)NSString *jdd_subcutaneous_fat_ratio;    //float皮下脂肪率
@property(nonatomic,strong)NSString *jdd_visceral_fat_index;        //float内脏脂肪指数

@property(nonatomic,strong)NSString *jdd_water_ratio;               //float水含量
@property(nonatomic,strong)NSString *jdd_weight;                    //float(kg)体重


@property(nonatomic,strong)NSString *jdd_data_type;                 //数据类型
@property(nonatomic,strong)NSString *jdd_device_id;                 //设备序列号
@property(nonatomic,strong)NSString *jdd_product_id;                //产品id
@property(nonatomic,strong)NSString *jdd_product_secret;            //产品secret
@property(nonatomic,strong)NSString *jdd_relationship;              //家庭成员关系(16个字符)

@end
