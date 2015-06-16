//
//  VerticalPickerView.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-18.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VerticalPickerView;

@protocol VerticalPickerViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInPickerView:(VerticalPickerView *)pickerView;

@end

@protocol VerticalPickerViewDelegate <NSObject>
- (void)pickerView:(VerticalPickerView *)pickerView indexChaged:(NSInteger)index;

@optional
- (NSString *)pickerView:(VerticalPickerView *)pickerView titleForItemsIndex:(NSInteger)index;

@end

@interface VerticalPickerView : UIView

- (id)initWithFrame:(CGRect)frame
           delegate:(id<VerticalPickerViewDelegate>)delegate
         dataSource:(id<VerticalPickerViewDataSource>)dataSource;

- (NSInteger)selectedIndex;

- (void)setCurrentIndex:(NSInteger)index;

@end
