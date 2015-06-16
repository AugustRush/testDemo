//
//  CoreTextView.h
//  CoreTextDemo
//
//  Created by August on 15/6/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreTextView : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign, readonly) CGFloat textHeight;

@end
