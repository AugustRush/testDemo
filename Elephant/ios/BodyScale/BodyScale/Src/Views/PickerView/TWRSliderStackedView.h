//
//  TWRSliderStackedView.h
//  TWRPickerSlider
//
//  Created by Michelangelo Chasseur on 28/08/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWRPickerSlider.h"


@interface TWRSliderStackedView : UIView

// Picker position
@property (assign, nonatomic) TWRPickerSliderType type;

@property (strong, nonatomic) NSArray *sliders;

- (instancetype)initWithPosition:(TWRPickerSliderPosition)position;
- (instancetype)initWithPosition:(TWRPickerSliderPosition)position bottomPadding:(NSUInteger)padding;
- (instancetype)initWithPosition:(TWRPickerSliderPosition)position topPadding:(NSUInteger)padding;
- (instancetype)initWithTabBar;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
