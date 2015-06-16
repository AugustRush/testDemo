//
//  PCEntity.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-5-12.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PCType){
    PCType_weight       = 0,    //体重
    PCType_bmi          = 1,    //BMI
    PCType_fat          = 2,    //脂肪率
    PCType_water        = 3,    //水含量
    PCType_muscle       = 4,    //肌肉率
    PCType_boneWeight   = 5,    //骨骼重量
    PCType_bmr          = 6,    //基础代谢率
    PCType_eBmr         = 7,    //基础代谢率 （欧洲）
    PCType_skin         = 8,    //皮下脂肪率
    PCType_offal        = 9,    //内脏脂肪率
    PCType_bodyage      = 10    //身体年龄
};

@interface PCEntity : NSObject

@property(nonatomic)PCType              pc_tp;                  //体征类型
@property(nonatomic)float               pc_originValue;         //原始数值
@property(nonatomic)float               pc_deltaValue;          //差值
@property(nonatomic)int                 pc_filed;               //所在区间
@property(nonatomic)float               pc_fliedRate;           //所在区间位置百分比
@property(nonatomic,strong)NSArray      *pc_filedPointList;     //体征区间节点列表
@property(nonatomic,strong)NSString     *pc_description;        //体征描述内容

@property(nonatomic)bool                pc_status;              //数据检测状态

@end
