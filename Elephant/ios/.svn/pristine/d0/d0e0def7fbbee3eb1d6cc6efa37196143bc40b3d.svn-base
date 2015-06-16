//
//  UITextField+LeftPadding.h
//  FFLtd
//
//  Created by 两元鱼 on 11/1/11.
//  Copyright 2011 FFLtd. All rights reserved.
//


@protocol LeftPaddingTextFieldDelegate;

@interface LeftPaddingField : UITextField

@property (nonatomic, strong)  UIToolbar        *keyboardDoneButtonView;

@property (nonatomic, assign)  id<LeftPaddingTextFieldDelegate> leftPaddingDelegate;

- (CGRect)textRectForBounds:(CGRect)bounds;

- (CGRect)editingRectForBounds:(CGRect)bounds;

- (void)displayBorder:(BOOL)visible;

- (void)displayToolBar:(BOOL)visible;

@end

@protocol LeftPaddingTextFieldDelegate <NSObject>

- (void)doneButtonClicked:(id)sender;

- (void)cancelButtonClicked:(id)sender;

@end
