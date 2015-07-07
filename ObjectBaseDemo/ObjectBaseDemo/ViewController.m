//
//  ViewController.m
//  ObjectBaseDemo
//
//  Created by August on 15/6/26.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController
@dynamic name;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.name = @"some";
    
    objc_msgSend(self,@selector(TEST));
}

void aMethodForSetName(id self,SEL _cmd){
    NSLog(@"self is %@, cmd is %p",self,_cmd);
}

+(BOOL)resolveInstanceMethod:(SEL)sel
{
    SEL setName = NSSelectorFromString(@"setName:");
    if (sel == setName) {
        class_addMethod(self, sel, (IMP)aMethodForSetName,"v@:");
        return NO;
    }
    return [super resolveInstanceMethod:sel];
}

-(void)TEST
{
    NSLog(@"some test methods");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
