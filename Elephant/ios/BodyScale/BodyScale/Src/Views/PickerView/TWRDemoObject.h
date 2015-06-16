//
//  TWRDemoObject.h
//  TWRPickerSlider
//
//  Created by Michelangelo Chasseur on 28/08/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWRPickerSlider.h"

@interface TWRDemoObject : NSObject <TWRPickerSliderDatasource>
@property(nonatomic,strong)NSString *TWRTitle;
@property(nonatomic,strong)NSString *TWRFloatTitle;
- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithFloatTitle:(NSString *)title ;
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
