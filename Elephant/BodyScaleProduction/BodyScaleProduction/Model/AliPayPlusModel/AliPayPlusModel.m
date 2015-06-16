//
//  AliPayPlusModel.m
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-6-9.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "AliPayPlusModel.h"
#import "Helpers.h"

@interface AliPayPlusModel ()
{
    NSString *_orderNo;
    NSString *_bodyStr;
    NSString *_totalFee;
    
    NSDictionary *_userInfo;
}

@end

@implementation AliPayPlusModel


+ (instancetype)sharedInstance {
    
    static AliPayPlusModel *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedClient           = [[AliPayPlusModel alloc] init];
        [[NSNotificationCenter defaultCenter]addObserver:_sharedClient
                                                selector:@selector(notificationCallback:)
                                                    name:kAlipayNotificationName
                                                  object:nil];
        
    });
    
    return _sharedClient;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kAlipayNotificationName
                                                  object:nil];
}

-(void)notificationCallback:(NSNotification *)aNotification
{
    NSDictionary *_info = [aNotification userInfo];
    NSString *_urlCallbackStr = _info[@"urlStr"];
    if (_urlCallbackStr) {
        [self paymentResult:_urlCallbackStr];
    }
}


-(void)pay:(NSDictionary *)dic
{
    _orderNo    = dic[@"orderNo"];
    _totalFee   = dic[@"total"];
    _bodyStr    = dic[@"body"];
    
    
    _userInfo   = dic[@"userInfo"];
    
    NSString *appScheme = kAlipayOpenUrlName;
    NSString* orderInfo = [self getOrderInfo];
    NSString* signedStr = [self doRsa:orderInfo];

    
    NSString *orderString = [NSString stringWithFormat:
                             @"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo,
                             signedStr,
                             @"RSA"];
    /*
    self.target     = target;
    self.callback   = callback;
    */
    [AlixLibService payOrder:orderString
                   AndScheme:appScheme
                     seletor:@selector(paymentResult:)
                      target:self];
}



-(void)paymentResult:(NSString *)resultd
{
    
    BOOL _f = NO;
    
    
    /*  支付宝莫名其妙的无法解析必须做以下处理 */
    NSString *_str = [Helpers URLDecodedString:resultd ];
    NSRange _range = [_str rangeOfString:@"?"];
    if (_range.length != 0) {
        _f = YES;
        resultd = [_str substringFromIndex:_range.location +1];
    }
    
    
    
    /*
    NSDictionary *_dic = [NSJSONSerialization JSONObjectWithData:[resultd dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
     */

    //结果处理
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
    int _flag = -1;
	if (result)
    {
        /*
		if (result.statusCode == 9000)
        {
			
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString
                              withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
			}
         
        }
         */
        
        switch (result.statusCode) {
            case 9000:
            {
                _flag = 1;
            }
                break;
            default:
                
                break;
        }
        
    }
    
    if (_f) {
        if (_flag == 1) {
            [[NSNotificationCenter defaultCenter]postNotificationName:kGetAlipayNotificationName
                                                               object:nil
                                                             userInfo:@{
                                                                        @"r":@"1"
                                                                        }];
        }
        else if(_flag == -1)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:kGetAlipayNotificationName
                                                               object:nil
                                                             userInfo:@{
                                                                        @"r":@"-1"
                                                                        }];
        }
        else
        {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:kGetAlipayNotificationName
                                                               object:nil
                                                             userInfo:@{
                                                                        @"r":@"0"
                                                                        }];
        }
    }
    else{
        if (_flag == 1) {
            
            NSDictionary *_dic = nil;
            if (_userInfo) {
                _dic =  @{@"r":@"11",
                          @"userInfo":_userInfo};
            }
            else{
                _dic =  @{@"r":@"11"};
            }
  
            
            [[NSNotificationCenter defaultCenter]postNotificationName:kGetAlipayNotificationName
                                                               object:nil
                                                             userInfo:_dic];
        }
        else if(_flag == -1)
        {
            NSDictionary *_dic = nil;
            if (_userInfo) {
                _dic =  @{@"r":@"-11",
                          @"userInfo":_userInfo};
            }
            else{
                _dic =  @{@"r":@"-11"};
            }
            
            [[NSNotificationCenter defaultCenter]postNotificationName:kGetAlipayNotificationName
                                                               object:nil
                                                             userInfo:_dic];
        }
        else
        {
            NSDictionary *_dic = nil;
            if (_userInfo) {
                _dic =  @{@"r":@"10",
                          @"userInfo":_userInfo};
            }
            else{
                _dic =  @{@"r":@"10"};
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:kGetAlipayNotificationName
                                                               object:nil
                                                             userInfo:_dic];
        }
    }
}


-(NSString*)getOrderInfo
{
    AlixPayOrder *order         = [[AlixPayOrder alloc] init];
    
    order.partner               = PartnerID;
    order.seller                = SellerID;
    order.tradeNO               = _orderNo;                                 //订单ID（由商家自行制定）
	order.productName           = @"时云医疗商品支付";                         //商品标题
	order.productDescription    = _bodyStr ;                                //商品描述
	order.amount                = _totalFee;                                //商品价格
	order.notifyURL             = kALiNotifyUrl;                                //回调URL
	

    
	return order.description;
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer   = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString  = [signer signString:orderInfo];
    return signedString;
}



@end
