//
//  ExampleClassSpec.m
//  TDDBDDDemo
//
//  Created by August on 14-9-4.
//  Copyright 2014年 August. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ExampleClass.h"


SPEC_BEGIN(ExampleClassSpec)

describe(@"ExampleClass", ^{
    context(@"when creat", ^{
        __block ExampleClass *example = nil;
        beforeEach(^{
            example = [ExampleClass new];
        });
        
        afterEach(^{
            example = nil;
        });
        
        it(@"should hava the class ExampleClass", ^{
            [[[ExampleClass class] shouldNot] beNil];
        });
        
        it(@"should exist", ^{
            [[example shouldNot] beNil];
        });
        
    });
});

SPEC_END
