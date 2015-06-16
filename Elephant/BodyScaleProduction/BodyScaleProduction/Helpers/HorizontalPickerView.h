//
//  HorizontalPickerView.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-14.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalPickerView;

@protocol HorizontalPickerViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInPickerView:(HorizontalPickerView *)pickerView;

@end

@protocol HorizontalPickerViewDelegate <NSObject>
- (void)pickerView:(HorizontalPickerView *)pickerView indexChaged:(NSInteger)index;

@optional
- (NSString *)pickerView:(HorizontalPickerView *)pickerView titleForItemsIndex:(NSInteger)index;

@end

@interface HorizontalPickerView : UIScrollView<UIScrollViewDelegate>

- (id)initWithFrame:(CGRect)frame
           delegate:(id<HorizontalPickerViewDelegate>)delegate
         dataSource:(id<HorizontalPickerViewDataSource>)dataSource;

- (NSInteger)selectIndex;

- (void)setCurrentIndex:(NSInteger)index;

@end
