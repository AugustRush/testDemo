//
//  ToolBarCell.m
//  FFLtd
//
//  Created by 两元鱼 on 11-11-3.
//  Copyright (c) 2011年 FFLtd. All rights reserved.
//

#import "ToolBarCell.h"

@implementation ToolBarCell

@synthesize toolBarDelegate = _toolBarDelegate;

@synthesize inputView = _inputView;

@synthesize inputAccessoryView = _inputAccessoryView;

@synthesize keyboardDoneButtonBar = _keyboardDoneButtonBar;

@synthesize canBecomeFirstRes = canBecomeFirstRes_;

@synthesize customLabel = _customLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier inputView:(UIView *)aInputView
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.inputView = aInputView;
        
        self.inputAccessoryView = self.keyboardDoneButtonBar;
        
        self.canBecomeFirstRes = YES;
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.inputAccessoryView = self.keyboardDoneButtonBar;
        
        self.canBecomeFirstRes = YES;
    }
    return self;
}

- (void)dealloc
{
}

- (UIToolbar*)keyboardDoneButtonBar{
    
    if(!_keyboardDoneButtonBar){
        
        _keyboardDoneButtonBar= [[UIToolbar alloc] init];
        
        _keyboardDoneButtonBar.barStyle = UIBarStyleBlackTranslucent;
        
        _keyboardDoneButtonBar.tintColor = nil;
        
        [_keyboardDoneButtonBar sizeToFit];
        
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                      target:nil
                                      action:nil];
        
        
        
        UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc]
                                          initWithTitle:L(@"Cancel")
                                          style:UIBarButtonItemStyleBordered 
                                          target:self
                                          action:@selector(cancelButtonClicked:)];
        
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc]
                                        initWithTitle:L(@"Ok")
                                        style:UIBarButtonItemStyleBordered 
                                        target:self
                                        action:@selector(doneButtonClicked:)];
        
        [_keyboardDoneButtonBar setItems:[NSArray arrayWithObjects:cancelButton,flexItem,doneButton, nil]];
        
    }
    
    return _keyboardDoneButtonBar;
}

- (UILabel *)customLabel
{
    if (!_customLabel) {
        _customLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 4, 100, 36)];
        _customLabel.font = FONT16;
        _customLabel.textColor = [UIColor darkGrayColor];
        _customLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_customLabel];
    }
    return _customLabel;
}

- (BOOL)canBecomeFirstResponder
{
    return self.canBecomeFirstRes;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (canBecomeFirstRes_)
    {
        [self becomeFirstResponder];
    }
    else
    {
        if ([_toolBarDelegate conformsToProtocol:@protocol(ToolBarCellDelegate)])
        {
            if ([_toolBarDelegate respondsToSelector:@selector(singleSelectCell:)])
            {
                [_toolBarDelegate singleSelectCell:self];
            }
        }
    }
    
}


#pragma mark -
#pragma mark Tool Bar Button Delegate Methods

- (void)doneButtonClicked:(id)sender
{
    if ([_toolBarDelegate conformsToProtocol:@protocol(ToolBarCellDelegate)])
    {
        if ([_toolBarDelegate respondsToSelector:@selector(doneClicked:)])
        {
            [_toolBarDelegate doneClicked:self];
        }
    }else{
        [self resignFirstResponder];
    }
}

- (void)cancelButtonClicked:(id)sender
{
    if ([_toolBarDelegate conformsToProtocol:@protocol(ToolBarCellDelegate)])
    {
        if ([_toolBarDelegate respondsToSelector:@selector(cancelClicked:)])
        {
            [_toolBarDelegate cancelClicked:(id)sender];
        }
    }
    [self resignFirstResponder];
}


@end
