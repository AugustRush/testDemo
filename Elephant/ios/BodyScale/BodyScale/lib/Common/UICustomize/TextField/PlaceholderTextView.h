//
//  PlaceholderTextView.h
//  FFLtd
//
//  Created by 两元鱼 on 11-12-10.
//  Copyright (c) 2011年 FFLtd. All rights reserved.
//


@interface PlaceholderTextView : UITextView 
{
    NSString    *_placeholder;
    
    UIColor     *_placeholderColor;
    
    UILabel     *_placeHolderLabel;
}

@property(nonatomic,strong) UILabel     *placeHolderLabel;
@property(nonatomic,strong) NSString    *placeholder;
@property(nonatomic,strong) UIColor     *placeholderColor;

- (void)textChanged:(NSNotification*)notification;

@end
