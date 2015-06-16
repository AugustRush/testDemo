//
//  BTModelTestCase.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-4-16.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTModel.h"

@interface BTModelTestCase : XCTestCase

@end

@implementation BTModelTestCase

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
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

#pragma mark - Cases
/* 搜索设备 */
- (void)testSearchPeripheralsCompletion:(BTModelResponseCompletion)completion {

}
/* 连接到设备 */
- (void)testConnectDevice:(CBPeripheral *)peripheral completion:(BTModelResponseCompletion)completion disconnectCompletion:(BTModelResponseCompletion)disconnectCompletion {
    
}
/* 自动连接到设备 */
- (void)testAutoConnectPeripheralCompletion:(BTModelResponseCompletion)completion disconnectionCallBack:(BTModelResponseCompletion)disconnectionCallBack {
    
}
/* 断开连接 */
- (void)testBreakConnectPeripheralCompletion:(BTModelResponseCompletion)completion {
    
}
/* 初始化蓝牙系统 */
- (void)testPrepareDeviceForScale {
    
}
/* 设置测量数据 */
- (BOOL)testSetUserInfo:(UserInfoEntity *)userInfo {
    return YES;
}
/* 删除所有用户 */
- (void)testDeleteAllUserCompletion:(BTModelResponseCompletion)completion {
    
}

@end
