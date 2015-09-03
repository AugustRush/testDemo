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
    
//    self.copiedArray = [NSMutableArray array];
//    self.strongArray = [NSMutableArray array];
//    NSLog(@"copied array class is %@ strong array class is %@",[self.copiedArray class],[self.strongArray class]);
//    [self.strongArray addObject:@"test"];
//    [self.copiedArray addObject:@"test"];//exception
//    NSLog(@"copied array class is %@ strong array class is %@",self.copiedArray,self.strongArray);

    __weak NSString *string = @"what".lowercaseString;
    __weak NSString *string2;
    string2 = @"what".lowercaseString;
    NSLog(@"string is %@, string2 is %@",string,string2);
    
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
