//
//  BuyRyFitInfo.h
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-6-7.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, BuyRyFitMainSectionType)
{
    BuyRyFitMainSectionTypeProduct      = 0,    //商品区
    BuyRyFitMainSectionTypeInfo         = 1,    //买家信息区
    BuyRyFitMainSectionTypePaybox       = 2,    //支付确认区
};

#define kBR_sectionCount 3
#define kBR_buyerInfoCellCount 1
#define kBR_payCellCount 1

#define kBR_main_productCellHeight 110
#define kBR_main_buyerInfoCellHeight 176
#define kBR_main_payCellHeight 180

@interface BR_ProductEntity : NSObject

@property(nonatomic,strong)NSString *pt_sn;                 //货号
@property(nonatomic,strong)NSString *pt_name;               //商品名称
@property(nonatomic,strong)NSString *pt_img;                //商品图片
@property(nonatomic,strong)NSString *pt_price;              //商品价格
@property(nonatomic,strong)NSString *pt_description;        //商品描述
@property(nonatomic,strong)NSString *pt_norm;               //商品规格


@property(nonatomic)int pt_countOfBuy;                      //本次购买数量
@property(nonatomic)int pt_store;                           //商品库存数量
@property(nonatomic)int pt_freezeStore;                     //被占用库存数

+(BR_ProductEntity *)createProduct:(NSDictionary *)info;

@end


@interface BR_BuyerEntity : NSObject

@property(nonatomic,strong)NSString         *b_member;                  //loginName
@property(nonatomic,strong)NSString         *b_password;                //ts3YYgbfb6E=",
@property(nonatomic,strong)NSString         *b_shipName;                //@"张诚亮",
@property(nonatomic,strong)NSString         *b_shipAreaPath;            //@"上海市,黄浦区",
@property(nonatomic,strong)NSString         *b_shipAddress;             //@"啊路2号",
@property(nonatomic,strong)NSString         *b_shipMobile;              //手机号@"13816980564",
@property(nonatomic,strong)NSString         *b_system;                  //@"ios",

@property(nonatomic,strong)NSString         *b_menberType;              //用户类型  普通：0，JD：1


@property(nonatomic,strong)NSMutableArray   *b_dataList;
/*
 @[
  @{@"productSn":@"6926443800028",
@"productName":@"体脂分析仪",
@"productPrice":@"469",
@"productQuantity":@"1"
}
 ]
 */

@end



@interface BR_Area : NSObject

@property(nonatomic,strong)NSString         *a_id;
@property(nonatomic,strong)NSString         *a_pid;
@property(nonatomic,strong)NSString         *a_name;

@end





