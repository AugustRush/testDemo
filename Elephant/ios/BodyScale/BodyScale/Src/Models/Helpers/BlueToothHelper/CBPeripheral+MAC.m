//
//  CBPeripheral+MAC.m
//  BodyScale
//
//  Created by August on 14/12/9.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "CBPeripheral+MAC.h"
#import <objc/runtime.h>

@implementation CBPeripheral (MAC)

-(void)setMAC:(NSString *)MAC
{
    objc_setAssociatedObject(self, @selector(MAC), MAC, OBJC_ASSOCIATION_COPY);
}

-(NSString *)MAC
{
    return objc_getAssociatedObject(self, @selector(MAC));
}

@end
