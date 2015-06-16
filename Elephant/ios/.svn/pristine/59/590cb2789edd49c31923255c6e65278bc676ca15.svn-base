//
//  ToolBarTextField.h
//  FFLtd
//
//  Created by 两元鱼 on 11-11-2.
//  Copyright (c) 2011年 FFLtd. All rights reserved.
//


@protocol ToolBarTextFieldDelegate <UITextFieldDelegate>

- (void)doneButtonClicked:(id)sender;

- (void)cancelButtonClicked:(id)sender;



@end

@interface ToolBarTextField : UITextField
{
    UIToolbar  *_keyboardDoneButtonBar;
}

@property (nonatomic, strong) UIToolbar *keyboardDoneButtonBar;

@property (nonatomic, assign) id <ToolBarTextFieldDelegate> toolBarDelegate;

@end
