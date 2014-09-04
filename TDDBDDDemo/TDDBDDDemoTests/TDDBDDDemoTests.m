//
//  TDDBDDDemoTests.m
//  TDDBDDDemoTests
//
//  Created by August on 14-9-4.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ExampleClass.h"

@interface TDDBDDDemoTests : XCTestCase

@end

@implementation TDDBDDDemoTests

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
    XCTAssert([ExampleClass class], @"example classs is exist");
    XCTAssert([ExampleClass new], @"example can be creat");
}

@end
