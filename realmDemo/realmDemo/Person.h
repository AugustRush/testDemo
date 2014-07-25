//
//  Person.h
//  realmDemo
//
//  Created by August on 14-7-25.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <Realm/Realm.h>


// Define your models
@interface Dog : RLMObject
@property NSString *name;
@property NSInteger age;
@end

@implementation Dog
// No need for implementation
@end

RLM_ARRAY_TYPE(Dog)

@interface Person : RLMObject
@property NSString      *name;
@property RLMArray<Dog> *dogs;
@end

@implementation Person
@end