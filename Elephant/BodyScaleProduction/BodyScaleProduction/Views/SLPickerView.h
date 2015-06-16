//
//  HorizontalPickerView.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-14.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SLPickerViewType) {
    SLPickerViewTypeHorizontal,
    SLPickerViewTypeVertical
};

@class SLPickerView;

@protocol SLPickerViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInPickerView:(SLPickerView *)pickerView;

@end

@protocol SLPickerViewDelegate <NSObject>
- (void)pickerView:(SLPickerView *)pickerView indexChaged:(NSInteger)index;

@optional
- (NSString *)pickerView:(SLPickerView *)pickerView titleForItemsIndex:(NSInteger)index;

@end

@interface SLPickerView : UIView <UIScrollViewDelegate>

- (id)initWithFrame:(CGRect)frame
           delegate:(id<SLPickerViewDelegate>)delegate
         dataSource:(id<SLPickerViewDataSource>)dataSource
               type:(SLPickerViewType)type;

- (NSInteger)selectedIndex;

- (void)setCurrentIndex:(NSInteger)index;

@end
