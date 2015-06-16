//
//  TWRPickerSlider.h
//  TWRPickerSlider
//
//  Created by Michelangelo Chasseur on 28/08/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#define PICKER_DEFAULT_VISIBLE_HEIGHT 44

typedef NS_ENUM(NSUInteger, TWRPickerSliderType) {
    TWRPickerSliderTypeCustomObjects,
    TWRPickerSliderTypeDatePicker
};

typedef NS_ENUM(NSUInteger, TWRPickerSliderPosition) {
    TWRPickerSliderPositionBottom,
    TWRPickerSliderPositionTop
};

#import <UIKit/UIKit.h>
@class TWRPickerSlider;

@protocol TWRPickerSliderDatasource <NSObject>
//@property(nonatomic, strong)NSString *twr_pickerTitle;
//@property(nonatomic, strong)NSString *twr_pickerFloatTitle;

- (NSString *)twr_pickerTitle;
- (NSString *)twr_pickerFloatTitle;
@end

@protocol TWRPickerSliderDelegate <NSObject>
//- (void)objectSelected:(id<TWRPickerSliderDatasource>)selectedObject sender:(TWRPickerSlider *)sender;
- (void)objectSelected:(id<TWRPickerSliderDatasource>)selectedObject WithCmSelectedObject:(id<TWRPickerSliderDatasource>)cmSelectedObject sender:(TWRPickerSlider *)sender;
- (void)dateSelected:(NSDate *)selectedDate sender:(TWRPickerSlider *)sender;
@end
typedef void (^removeBlackView)();
@interface TWRPickerSlider : UIView

// Objects for the data picker that should conform to TWRPickerSliderDataDelegate
@property (strong, nonatomic) NSArray *pickerObjects;
@property (strong, nonatomic) NSArray *cmObjects;
@property (strong, nonatomic) UIColor *mainColor;
@property (strong, nonatomic) UIColor *secondaryColor;
@property (strong, nonatomic) id<TWRPickerSliderDelegate> delegate;

// Strings for header view
@property (strong, nonatomic) NSString *leftText;
@property (strong, nonatomic) NSString *rightText;

// Text color
@property (strong, nonatomic) UIColor *leftTextColor;
@property (strong, nonatomic) UIColor *rightTextColor;

// Picker position
@property (assign, nonatomic) TWRPickerSliderPosition position;
@property (assign, nonatomic) TWRPickerSliderType type;
@property (strong, nonatomic) UIButton *button;

@property (strong, nonatomic) removeBlackView removeBlackView;


- (instancetype)initWithFrame:(CGRect)frame visibleHeight:(NSUInteger)visibleHeight;
- (instancetype)initWithType:(TWRPickerSliderType)type;
//- (void)showAndHide;
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
