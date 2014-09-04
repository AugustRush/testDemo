//
//  ViewControllerSpec.m
//  TDDBDDDemo
//
//  Created by August on 14-9-4.
//  Copyright 2014年 August. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ViewController.h"


SPEC_BEGIN(ViewControllerSpec)

describe(@"ViewController", ^{
    __block ViewController *viewController = nil;
    beforeEach(^{
        viewController = [[ViewController alloc] init];
    });
    
    afterEach(^{
        viewController = nil;
    });
    
    it(@"ViewController class should exist", ^{
        [[[ViewController class] shouldNot] beNil];
    });
    
    it(@"the entity is should exist", ^{
        [[ViewController shouldNot] beNil];
    });
    
    it(@"backGoudColor should be nil", ^{
        [[viewController.view shouldNot] beNil];
        [[viewController.view.backgroundColor should] beNil];
    });
    
    it(@"should had change color after set backgoudcolor", ^{
        viewController.view.backgroundColor = [UIColor redColor];
        [[viewController.view.backgroundColor shouldNot] beNil];
        [[viewController.view.backgroundColor should] equal:[UIColor redColor]];
    });
    
    it(@"should push to a controller", ^{
        UINavigationController *navCtr = [UINavigationController mock];
        [viewController stub:@selector(navigationController) andReturn:navCtr];
        
        [[navCtr should] receive:@selector(pushViewController:animated:)];
        KWCaptureSpy *spy = [navCtr captureArgument:@selector(pushViewController:animated:) atIndex:0];
        KWCaptureSpy *spy1 = [navCtr captureArgument:@selector(pushViewController:animated:) atIndex:1];
        
        [viewController pushToTestController];
        
        [[spy shouldNot] beNil];
        [[[spy.argument class] should] equal:[UIViewController class]];
        
        [[spy1.argument shouldNot] beNil];
        [[spy1.argument should] equal:@(YES)];
    });
    
});

SPEC_END
