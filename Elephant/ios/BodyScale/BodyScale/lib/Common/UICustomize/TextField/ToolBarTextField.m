//
//  ToolBarTextField.m
//  FFLtd
//
//  Created by 两元鱼 on 11-11-2.
//  Copyright (c) 2011年 FFLtd. All rights reserved.
//

#import "ToolBarTextField.h"

@implementation ToolBarTextField

@synthesize keyboardDoneButtonBar = _keyboardDoneButtonBar;

@synthesize toolBarDelegate = toolBarDelegate_;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.inputAccessoryView = self.keyboardDoneButtonBar;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.inputAccessoryView = self.keyboardDoneButtonBar;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.inputAccessoryView = self.keyboardDoneButtonBar;
    }
    return self;
}

- (void)dealloc
{
}

-(UIToolbar*)keyboardDoneButtonBar{
    
    if(!_keyboardDoneButtonBar){
        
        _keyboardDoneButtonBar= [[UIToolbar alloc] init];
        
        _keyboardDoneButtonBar.barStyle = UIBarStyleBlackTranslucent;
        
        _keyboardDoneButtonBar.tintColor = nil;
        
        [_keyboardDoneButtonBar sizeToFit];
        
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
        
        
        
        UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Cancel")
                                                                          style:UIBarButtonItemStyleBordered target:self
                                                                         action:@selector(CancelClicked:)];
        
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Ok")
                                                                        style:UIBarButtonItemStyleBordered target:self
                                                                       action:@selector(DoneClicked:)];
        
        [_keyboardDoneButtonBar setItems:[NSArray arrayWithObjects:cancelButton,flexItem,doneButton, nil]];
        
    }
    
    return _keyboardDoneButtonBar;
}

- (void)DoneClicked:(id)sender
{
    if ([toolBarDelegate_ conformsToProtocol:@protocol(ToolBarTextFieldDelegate)])
    {
        if ([toolBarDelegate_ respondsToSelector:@selector(doneButtonClicked:)])
        {
            [toolBarDelegate_ doneButtonClicked:(id)sender];
        }
        else
        {
            [self resignFirstResponder];
        }
    }
    else
    {
        [self resignFirstResponder];
    }
}

- (void)CancelClicked:(id)sender
{
    if ([toolBarDelegate_ conformsToProtocol:@protocol(ToolBarTextFieldDelegate)])
    {
        if ([toolBarDelegate_ respondsToSelector:@selector(cancelButtonClicked:)])
        {
            [toolBarDelegate_ cancelButtonClicked:(id)sender];
        }
    }
    [self resignFirstResponder];
    
}


@end
