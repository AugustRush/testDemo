//
//  ToolBarButton.m
//  FFLtd
//
//  Created by 两元鱼 on 11/3/11.
//  Copyright 2011 FFLtd. All rights reserved.
//

#import "ToolBarButton.h"

@implementation ToolBarButton
@synthesize inputView = _inputView;
@synthesize inputAccessoryView = _inputAccessoryView;
@synthesize aboveViewToolBar = _aboveViewToolBar;
@synthesize delegate = _delegate;

@synthesize nomalBgColor = _nomalBgColor;
@synthesize activeBgColor = _activeBgColor;

- (void)dealloc
{
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.inputAccessoryView = self.aboveViewToolBar;
        
        [self addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.inputAccessoryView = self.aboveViewToolBar;
        
        [self addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

+ (id)buttonWithType:(UIButtonType)buttonType
{
    id newInstance = [self buttonWithType:buttonType];
    
    [newInstance setInputAccessoryView:[newInstance aboveViewToolBar]];
    
    [newInstance addTarget:newInstance action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    return newInstance;
}

- (UIToolbar *)aboveViewToolBar
{
    if (!_aboveViewToolBar)
    {
        _aboveViewToolBar = [[UIToolbar alloc] init];
        _aboveViewToolBar.barStyle = UIBarStyleBlack;
        _aboveViewToolBar.translucent = YES;
        
        [_aboveViewToolBar sizeToFit];
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        
        
        UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Cancel") style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClicked:)];
        
//        cancelButton.tintColor = RGBCOLOR(33, 95, 221);
        
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Ok") style:UIBarButtonItemStyleBordered target:self action:@selector(doneClicked:)];
        
//        doneButton.tintColor = RGBCOLOR(33, 95, 221);
        
        [_aboveViewToolBar setItems:[NSArray arrayWithObjects:cancelButton,flexItem,doneButton, nil]];
    }
    
    return _aboveViewToolBar;
}

- (void)cancelClicked:(id)sender
{
    if ([_delegate respondsToSelector:@selector(cancelButtonClicked:)]) 
    {
        [_delegate cancelButtonClicked:sender];
    }
    
    [self resignFirstResponder];
}

- (void)doneClicked:(id)sender
{
    if ([_delegate respondsToSelector:@selector(doneButtonClicked:)])
    {
        [_delegate doneButtonClicked:sender];
    }
    
    [self resignFirstResponder];
}

- (void)buttonTapped:(id)sender
{
    
    if ([_delegate respondsToSelector:@selector(singleClickButton:)]) 
    {
        [_delegate singleClickButton:sender];
    }
    else
    {
        [self becomeFirstResponder];
    }
}

- (void)setNomalBgColor:(UIColor *)nomalBgColor
{
    if (nomalBgColor != _nomalBgColor)
    {
        _nomalBgColor = nomalBgColor;
        self.backgroundColor = _nomalBgColor;
    }
}

- (BOOL)canBecomeFirstResponder
{
    if (_activeBgColor)
    {
        self.backgroundColor = _activeBgColor;
    }
    return YES;
}

- (BOOL)canResignFirstResponder
{
    if (_nomalBgColor) {
        self.backgroundColor = _nomalBgColor;
    }
    return YES;
}

@end
