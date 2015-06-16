//
//  SelectHeightPage.m
//  BodyScaleProduction
//
//  Created by 刘平伟 on 14-4-18.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "SelectHeightPage.h"

@implementation SelectHeightPage
{
    VerticalPickerView *_heightPickerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews
{
    _heightPickerView = [[VerticalPickerView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 69 - 30,
                                                                             self.bodyImageView.top,
                                                                             69,
                                                                             self.bodyImageView.height - 15)
                                                         delegate:self
                                                       dataSource:self];
//    _heightPickerView.alpha = 0;
    [_heightPickerView setCurrentIndex:60];
    [self addSubview:_heightPickerView];
}

#pragma mark - Picker delegate

-(void)pickerView:(VerticalPickerView *)pickerView indexChaged:(NSInteger)index
{
    self.heightLabel.text = [NSString stringWithFormat:@"%d", (int)index + 100];
}

#pragma mark - Picker dataSource

-(NSInteger)numberOfItemsInPickerView:(VerticalPickerView *)pickerView
{
    return 121;
}

-(NSString *)pickerView:(VerticalPickerView *)pickerView titleForItemsIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%d", (int)index + 100];
}

@end
