//
//  keyboardNumberPadReturnTextField.m
//  FFLtd
//
//  Created by 两元鱼 on 11-11-2.
//  Copyright (c) 2011年 FFLtd. All rights reserved.
//

#import "keyboardNumberPadReturnTextField.h"

@implementation keyboardNumberPadReturnTextField

@synthesize doneButton = _doneButton;

@synthesize doneButtonDelegate = _doneButtonDelegate;


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(keyboardDidShow:) object:nil];
}

- (UIButton *)doneButton
{
    if (_doneButton == nil)
    {
        _doneButton = [[UIButton alloc] init];
        
        _doneButton.frame = CGRectMake(0, 163, 106, 53);
        
        _doneButton.adjustsImageWhenHighlighted = NO;
        
        _doneButton.hidden = NO;
        
        [_doneButton setImage:[UIImage imageNamed:@"DoneUp3.png"] forState:UIControlStateNormal];
        
        [_doneButton setImage:[UIImage imageNamed:@"DoneDown3.png"] forState:UIControlStateHighlighted];
        
        [_doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (void)setup 
{
    self.keyboardType = UIKeyboardTypeNumberPad;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    [super setKeyboardType:UIKeyboardTypeNumberPad];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)addDoneButtonToKeyboard
{
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    
    for (UIView *keyboard in tempWindow.subviews)
    {
        if ([[keyboard description] hasPrefix:@"<UIPeripheral"])
        {
            for (UIView *keyView in [keyboard subviews])
            {
                if ([[keyView description] hasPrefix:@"<UIKeyboard"])
                {
                    [keyView addSubview:self.doneButton];
                    
                    return;
                }
            }
        }
        
    }
}

- (void)keyboardDidShow:(NSNotification *)note
{
    //create custom button
    if ([self isFirstResponder])
    {
        
        if (self.doneButton.superview == nil) {
            //locate keyboard view
            
            [self addDoneButtonToKeyboard];
        }
        
    }
}

- (void)doneButtonPressed:(id)sender
{
    if ([_doneButtonDelegate conformsToProtocol:@protocol(KeyboardDoneTappedDelegate)])
    {
        if ([_doneButtonDelegate respondsToSelector:@selector(doneTapped:)])
        {
            [_doneButtonDelegate doneTapped:(id)sender];
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

- (BOOL)canBecomeFirstResponder
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    
    if ([windows count] < 2) {
        
        if ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
            return [self.delegate textFieldShouldBeginEditing:self];
        }
        return YES;
    }
    
    [self performSelector:@selector(keyboardDidShow:) withObject:nil afterDelay:0.02];
//    
//    if (self.doneButton.superview == nil) {
//        [self addDoneButtonToKeyboard];
//    }
    
    if ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:self];
    }
    return YES;
}

- (BOOL)canResignFirstResponder
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(keyboardDidShow:) object:nil];
    [self.doneButton removeFromSuperview];
    
    return YES;
}





@end
