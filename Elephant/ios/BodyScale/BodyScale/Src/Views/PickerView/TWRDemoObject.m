//
//  TWRDemoObject.m
//  TWRPickerSlider
//
//  Created by Michelangelo Chasseur on 28/08/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import "TWRDemoObject.h"

@interface TWRDemoObject ()

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *floattitle;
@end

@implementation TWRDemoObject

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (instancetype)initWithFloatTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.floattitle = title;
    }
    return self;
}

- (NSString *)twr_pickerTitle {
    return self.title;
}

- (NSString *)twr_pickerFloatTitle {
    return self.floattitle;
}
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
