//
//  keyboardNumberPadReturnTextField.h
//  FFLtd
//
//  Created by 两元鱼 on 11-11-2.
//  Copyright (c) 2011年 FFLtd. All rights reserved.
//


@protocol KeyboardDoneTappedDelegate <NSObject>

@optional
- (void)doneTapped:(id)sender;

@end

@interface keyboardNumberPadReturnTextField : UITextField
{
    UIButton *_doneButton;
}

@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, assign) id <KeyboardDoneTappedDelegate> doneButtonDelegate;

@end

