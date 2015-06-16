//
//  BodyScaleBTInterface.m
//  BlueToothDemo
//
//  Created by August on 14/12/4.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "BodyScaleBTInterface.h"

#define intToString(a) [NSString stringWithFormat:@"%d",a]

static BodyScaleBTInterface *_interface = nil;

@implementation BodyScaleBTInterface
{
    BlueToothHelper *_BTHelper;
    NSMutableDictionary *_responseBlocks;
}

//
+(void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _interface = [[BodyScaleBTInterface alloc] init];
    });
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(void)initConfigs
{
    _BTHelper = [BlueToothHelper shareInstance];
    _responseBlocks = [NSMutableDictionary dictionary];
    [_BTHelper centralManagerDidRecieveDataWithBlock:^(MeasureActionType type, id value, CBPeripheral *peripheral, NSError *error) {
        DLog(@"value is %@ type is %d",value,type);
        VarargsBlock block = _responseBlocks[intToString(type)];
        switch (type) {
            case GetBodyScaleBlueToothVersion:
            {
                if (block) {
                    block(error,value);
                }
            }
                break;
            case GetBodyScaleSoftVersion:
            {
                if (block) {
                    block(error,value);
                }
            }
                break;
            case ResetBodyScale:
            {
                if (block) {
                    block(value);
                }
            }
                break;
            case DeleteUserMeasureData:
            {
                if (block) {
                    block(value);
                }
            }
                break;
            case GetAllUserInfos:
            {
                if (block) {
                    block(error,value);
                }
            }
                break;
            case UpdateExistUserInfo:
            {
                if (block) {
                    block(error,[value[@"status"] integerValue]);
                }
            }
                break;
            case DeleteExistUser:
            {
                if (block) {
                    block([value[@"status"] integerValue]);
                }
            }
                break;
            case CreateNewUser:
            {
                if (block) {
                    block(error,[value[@"location"] integerValue]);
                }
            }
                break;
            case selectUserMesureComplpeteExtra:
            {
                if (block) {
                    block(error,value);
                }
            }
                break;
            case selectUserMesureAck:
            {
                if (block) {
                    block(error);
                }

            }
                break;
            case selectUserMesureComplpete:
            {
                if (block) {
                    block(error, value);
                }

            }
                break;
            case InstanceWeight:
            {
                if (block) {
                    block(error, value);
                }
            }
                break;
                break;
                
            default:
                break;
        }
        
    }];
}

+(void)instanceWeightDataWithHandler:(void (^)(NSError *, NSNumber *))handler
{
    [_interface->_responseBlocks setObject:handler forKey:intToString(InstanceWeight)];
}

+(void)selectUserMeasureWithLocation:(NSInteger)location
                              height:(NSInteger)height
                                 age:(NSInteger)age
                                 sex:(NSInteger)sex
                          ackHandler:(void (^)(NSError *))ackHandler
                   completionHandler:(void (^)(NSError *, NSDictionary *))handler
                    extraDataHandler:(void (^)(NSError *, NSDictionary *))extraHandler
{
    [_interface->_responseBlocks setObject:ackHandler forKey:intToString(selectUserMesureAck)];
    [_interface->_responseBlocks setObject:handler forKey:intToString(selectUserMesureComplpete)];
    [_interface->_responseBlocks setObject:extraHandler forKey:intToString(selectUserMesureComplpeteExtra)];
    
    NSMutableString *string = [NSMutableString stringWithFormat:@"090f06a5000000000000"];
    [string appendString:hexStringWithInteger(location)];
    [string appendString:hexStringWithInteger(height)];
    [string appendString:hexStringWithInteger(age)];
    [string appendString:hexStringWithInteger(sex)];
    [string appendString:hexStringWithInteger(1)];
    
    
    NSData *data = hexToBytes(string);
    [self sendData:data];
}

+(void)createNewUserInBodyScaleWithBodyHeight:(NSUInteger)height
                                          age:(NSUInteger)age
                                          sex:(NSUInteger)sex
                            completionHandler:(void (^)(NSError *, NSInteger))handler
{
    [_interface->_responseBlocks setObject:handler forKey:intToString(CreateNewUser)];
    
    NSMutableString *string = [NSMutableString stringWithString:@"090e06a000000000000000"];
    [string appendString:hexStringWithInteger(height)];
    [string appendString:hexStringWithInteger(age)];
    [string appendString:hexStringWithInteger(sex)];
    NSData *data = hexToBytes(string);
    [self sendData:data];
}

+(void)deleteUserInBodyScaleWithLocation:(NSUInteger)location completeHandler:(void(^)(NSInteger))handler
{
    [_interface->_responseBlocks setObject:handler forKey:intToString(DeleteExistUser)];
    
    NSMutableString *string = [NSMutableString stringWithString:@"090b06a1000000000000"];
    [string appendString:hexStringWithInteger(location)];
    NSData *data = hexToBytes(string);
    [self sendData:data];
}

+(void)updateUserInfoInBodyScaleWithLocation:(NSUInteger)location
                                      Height:(NSUInteger)height
                                         age:(NSUInteger)age
                                         sex:(NSUInteger)sex
                             completeHandler:(void (^)(NSError *, NSInteger))handler
{
    [_interface->_responseBlocks setObject:handler forKey:intToString(UpdateExistUserInfo)];
    NSMutableString *string = [NSMutableString stringWithString:@"090e06a2000000000000"];
    [string appendString:hexStringWithInteger(location)];
    [string appendString:hexStringWithInteger(height)];
    [string appendString:hexStringWithInteger(age)];
    [string appendString:hexStringWithInteger(sex)];
    NSData *data = hexToBytes(string);
    [self sendData:data];
}

+(void)getAllUserInfosInBodyScaleWithCompleteHandler:(void (^)(NSError *, NSArray *))handler
{
    [_interface->_responseBlocks setObject:handler forKey:intToString(GetAllUserInfos)];
    NSString *string = @"090a06a3000000000000";
    NSData *data = hexToBytes(string);
    [self sendData:data];

}

+(void)deleteUserMesureDataWithLocation:(NSUInteger)location completeHandler:(void (^)(NSError *))handler
{
    [_interface->_responseBlocks setObject:handler forKey:intToString(DeleteUserMeasureData)];
    NSMutableString *string = [NSMutableString stringWithString:@"090b06a7000000000000"];
    [string appendString:hexStringWithInteger(location)];
    NSData *data = hexToBytes(string);
    [self sendData:data];
}

+(void)resetBodyScaleWithCompleteHandler:(void (^)(NSError *))handler
{
    [_interface->_responseBlocks setObject:handler forKey:intToString(ResetBodyScale)];
    NSString *string = @"090406af";
    NSData *data = hexToBytes(string);
    [self sendData:data];

}

+(void)getBodyScaleSoftVersionWithCompleteHandler:(void (^)(NSError *, NSNumber *))handler
{
    [_interface->_responseBlocks setObject:handler forKey:intToString(GetBodyScaleSoftVersion)];
    NSString *string = @"090406ae";
    NSData *data = hexToBytes(string);
    [self sendData:data];

}

+(void)getBodyScaleBlueToothVersionWithCompleteHandler:(void (^)(NSError *, NSNumber *))handler
{
    [_interface->_responseBlocks setObject:handler forKey:intToString(GetBodyScaleBlueToothVersion)];
    NSString *string = @"070406a0";
    NSData *data = hexToBytes(string);
    [self sendData:data];
    
}

+(void)sendData:(NSData *)data
{
    [_interface->_BTHelper centralManagerSendData:data ToPeripheral:_interface->_BTHelper.connectedPeripheral];
}



@end
