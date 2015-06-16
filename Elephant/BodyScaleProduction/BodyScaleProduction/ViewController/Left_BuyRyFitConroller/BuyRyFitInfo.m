//
//  BuyRyFitInfo.m
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-6-7.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BuyRyFitInfo.h"


#define kNormList @[@"时尚白",@"炫酷黑"]
#define kNormImgList @[@"pt_White.png",@"pt_Black.png"]

@interface BR_ProductEntity ()


@end

@implementation BR_ProductEntity
-(NSString *)inputStr:(id)ipStr
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

+(BR_ProductEntity *)createProduct:(NSDictionary *)info
{
    BR_ProductEntity *_product  = [[BR_ProductEntity alloc]init];
    _product.pt_sn              = [_product inputStr:info[@"productSn"]];
    _product.pt_name            = [_product inputStr:info[@"name"]];
    _product.pt_norm            = [_product inputStr:info[@"norm"]];
    _product.pt_price           = [_product inputStr:info[@"price"]];
    _product.pt_description     = [_product inputStr:info[@"description"]];
    NSString *_urlStr = [_product inputStr:info[@"imgSrc"]];
    NSLog(@"%@",_urlStr);
    NSArray *_ary = [_urlStr componentsSeparatedByString:@"/"];
    if (_ary.count > 0) {
        _urlStr = _ary[_ary.count - 1];
    }
    
    _product.pt_img             = [kALiProdutImgHeadUrl stringByAppendingString:_urlStr];
    
    
    NSLog(@"-----------%@",_product.pt_img);
    
    /*
    if ([kNormList containsObject:_product.pt_norm]) {
        int _index              = [kNormList indexOfObject:_product.pt_norm];
        
        _product.pt_img         = kNormImgList[_index];
        
    }
    */
    
    
    _product.pt_countOfBuy      = 1;
    _product.pt_store           = [[_product inputStr:info[@"store"]] intValue];
    _product.pt_freezeStore     = [[_product inputStr:info[@"freezeStore"]] intValue];
    
    return _product;
}


@end


@implementation BR_BuyerEntity
-(NSString *)inputStr:(id)ipStr
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
/*
+(BR_ProductEntity *)createProduct:(NSDictionary *)info
{

    BR_ProductEntity *_product  = [[BR_ProductEntity alloc]init];
    _product.pt_sn              = [_product inputStr:info[@"productSn"]];
    _product.pt_name            = [_product inputStr:info[@"name"]];
    _product.pt_norm            = [_product inputStr:info[@"norm"]];
    _product.pt_price           = [_product inputStr:info[@"price"]];
    _product.pt_description     = [_product inputStr:info[@"description"]];
    
    int _index                  = [kNormList indexOfObject:_product.pt_norm];
    if (_index != -1) {
        _product.pt_img         = kNormImgList[_index];
    }
    
    _product.pt_countOfBuy      = 0;
    _product.pt_store           = [[_product inputStr:info[@"store"]] intValue];
    _product.pt_freezeStore     = [[_product inputStr:info[@"freezeStore"]] intValue];
    
    return _product;
}
*/

@end


@implementation BR_Area


@end



