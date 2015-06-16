//
//  BTInterfaceModelTestCase.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-4-16.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BTInterfaceService.h"

@interface BTInterfaceModelTestCase : XCTestCase

@property (nonatomic, strong)BTInterfaceService *interface;

@end

@implementation BTInterfaceModelTestCase

- (void)setUp
{
    [super setUp];
    
    _interface = [[BTInterfaceService alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

#pragma mark - Test Case
/* 装载 */
- (void)testSetup {
    [_interface setupCompletion:^(int code, id info, id originalData) {
        XCTAssertNotEqual(code, REQUEST_SUCCESS_CODE, @"setup failure");
    }];
}
/* 搜索设备 */
- (void)testSearchPeripherals {
    [_interface searchPeripheralsCompletion:^(int code, id info, id originalData) {
        
    }];
}
/* 连接到设备 */
- (void)testConnectDevice:(CBPeripheral *)peripheral completion:(BTResponseCompletion)completion disconnectCompletion:(BTResponseCompletion)disconnectCompletion {
    
}
/* 与设备断开连接 */
- (void)testDisconnectCompletion:(BTResponseCompletion)completion {
    
}

/* 查看用户是否存在 */
- (void)testExistUser:(int)locationNo completion:(BTResponseCompletion)completion {
    
}
/* 新建用户 */
- (void)testNewUser:(int)locationNo height:(int)height age:(int)age gender:(int)gender completion:(BTResponseCompletion)completion {
    
}
/* 删除用户 */
- (void)testDeleteUser:(int)locationNo completion:(BTResponseCompletion)completion {
    
}
/* 更新用户信息 */
- (void)testUpdateUser:(int)locationNo height:(int)height age:(int)age gender:(int)gender completion:(BTResponseCompletion)completion {
    
}
/* 获取当前用户参数 */
- (void)testGetUserInfo:(int)locationNo completion:(BTResponseCompletion)completion {
    
}
/* 获取所有用户数据 */
- (void)testGetAllUserInfoRequestCompletion:(BTResponseCompletion)requestCompletion responseDataCompletion:(BTResponseCompletion)responseDataCompletion {
    
}
/* 选择用户称量 */
- (void)testSelectUserScale:(int)locationNo height:(int)height age:(int)age gender:(int)gender completion:(BTResponseCompletion)completion {
    
}
/* 读取scale内某用户存储的测量数据 */
- (void)testReadScaleData:(int)locationNo requestCompletion:(BTResponseCompletion)requestCompletion responseDataCompletion:(BTResponseCompletion)responseDataCompletion {
    
}
/* 删除scale内某用户存储的测量数据 */
- (void)testDeleteScaleData:(int)locationNo completion:(BTResponseCompletion)completion {
    
}
/* 读取BLE端编号地址 */
- (void)testReadId:(BTResponseCompletion)completion {
    
}
/* 写入BLE端编号地址 */
- (void)testWriteId:(NSString *)stringId writeCompletion:(BTResponseCompletion)completion {
    
}

@end
