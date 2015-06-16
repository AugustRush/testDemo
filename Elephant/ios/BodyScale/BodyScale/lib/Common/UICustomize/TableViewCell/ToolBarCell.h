//
//  ToolBarCell.h
//  FFLtd
//
//  Created by 两元鱼 on 11-11-3.
//  Copyright (c) 2011年 FFLtd. All rights reserved.
//

#import "ToolBarButton.h"

@protocol ToolBarCellDelegate <NSObject>

@optional
- (void)doneClicked:(UITableViewCell *)cell;

- (void)cancelClicked:(UITableViewCell *)cell;

- (void)singleSelectCell:(UITableViewCell *)cell;

@end

@interface ToolBarCell : UITableViewCell
{
    UIView    *_inputView;
    
    UIView    *_inputAccessoryView;
    
    UIToolbar *_keyboardDoneButtonBar;
    
    BOOL    canBecomeFirstRes_;
}

@property (nonatomic, assign) id <ToolBarCellDelegate> toolBarDelegate;

@property (readwrite, strong) UIView *inputView;

@property (readwrite, strong) UIView *inputAccessoryView;

@property (nonatomic, strong) UIToolbar *keyboardDoneButtonBar;

@property (nonatomic, assign) BOOL canBecomeFirstRes;   //default is YES

@property (nonatomic, strong) UILabel *customLabel;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier 
          inputView:(UIView *)aInputView;

@end
