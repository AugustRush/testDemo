//
//  GCPlaceholderTextView.m
//  GCLibrary
//
//  Created by Guillaume Campagna on 10-11-16.
//  Copyright 2010 LittleKiwi. All rights reserved.
//

#import "GCPlaceholderTextView.h"

@interface GCPlaceholderTextView () 

@property (nonatomic, strong) UIColor* realTextColor;
@property (nonatomic, readonly) NSString* realText;

- (void) beginEditing:(NSNotification*) notification;
- (void) endEditing:(NSNotification*) notification;

@end

@implementation GCPlaceholderTextView

@synthesize realTextColor;
@synthesize placeholder;

#pragma mark -
#pragma mark Initialisation

- (id) initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        
        self.realTextColor = [UIColor blackColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    }
    
    return self;
}

#pragma mark -
#pragma mark Setter/Getters

- (void) setPlaceholder:(NSString *)aPlaceholder 
{
    if ([self.realText isEqualToString:placeholder]) 
    {
        self.text = aPlaceholder;
    }
    
    placeholder = aPlaceholder;
    
    [self endEditing:nil];
}

- (NSString *) text 
{
    NSString* text = [super text];
    if ([text isEqualToString:self.placeholder]) return nil;
    return text;
}

- (void) setText:(NSString *)text
{
    if ([text isEqualToString:@""] || text == nil) 
    {
        super.text = self.placeholder;
        
        self.textColor = [UIColor lightGrayColor];
    }
    else 
    {
        super.text = text;
    }
    
    if ([text isEqualToString:self.placeholder])
    {
        self.textColor = [UIColor lightGrayColor];
    }
    else 
    {
        self.textColor = self.realTextColor;
    }
}

- (NSString *) realText
{
    return [super text];
}

- (void) beginEditing:(NSNotification*) notification
{
    
    if ([self.realText isEqualToString:self.placeholder])
    {
        
        super.text = nil;

        self.textColor = self.realTextColor;
    }
}

- (void) endEditing:(NSNotification*) notification 
{
    if ([self.realText isEqualToString:@""] || self.realText == nil) 
    {
        super.text = self.placeholder;
        self.textColor = [UIColor lightGrayColor];
    }
}

- (void) setTextColor:(UIColor *)textColor
{
    if ([self.realText isEqualToString:self.placeholder])
    {
        if ([textColor isEqual:[UIColor lightGrayColor]]) [super setTextColor:textColor];
        else self.realTextColor = textColor;
    }
    else 
    {
        self.realTextColor = textColor;
        [super setTextColor:textColor];
    }
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
