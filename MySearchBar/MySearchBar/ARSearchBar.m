//
//  ARSearchBar.m
//  MySearchBar
//
//  Created by August on 14-7-28.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ARSearchBar.h"

#define _SYSTERVERSION_  [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation ARSearchBar
{
    UITextField *_searchTextField;
    UIImageView *_clearButtonImageView;
}

#pragma mark - init/Config methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self inintConfig];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self inintConfig];
    }
    return self;
}

-(void)inintConfig
{
    self.tintColor = [UIColor whiteColor];
    //    self.backgroundColor = [UIColor colorWithRed:5/255.0 green:196/255.0 blue:245/255.0 alpha:1];
    
    UIView *filterView = self;
    if (_SYSTERVERSION_ > 7.0) {
        filterView = self.subviews[0];
    }
    
    for (UIView *view in [filterView subviews]) {
        if ([NSStringFromClass([view class]) isEqualToString:@"UISearchBarBackground"]) {
            _SYSTERVERSION_ > 7.0 ?[view removeFromSuperview]:NULL;
        }else if ([NSStringFromClass([view class]) isEqualToString:@"UISearchBarTextField"]){
            UITextField *TF = (UITextField *)view;
            TF.layer.cornerRadius = 6;
            _searchTextField = TF;
            UIButton *clearButton = [_searchTextField valueForKey:@"_clearButton"];
            clearButton.imageEdgeInsets = UIEdgeInsetsMake(100, 100, 0, 0);
            [clearButton setBackgroundImage:nil forState:UIControlStateNormal];
            [clearButton setBackgroundImage:nil forState:UIControlStateHighlighted];
            _clearButtonImageView = [[UIImageView alloc] initWithFrame:clearButton.bounds];
            _clearButtonImageView.backgroundColor = [UIColor clearColor];
            [clearButton addSubview:_clearButtonImageView];
            
        }
        
    }
}

#pragma mark - custom methods

-(void)setLeftImage:(UIImage *)leftImage
{
    _leftImage = leftImage;
    
    UIImageView *leftImgView = (UIImageView *)_searchTextField.leftView;
    leftImgView.image = _leftImage;
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _searchTextField.textColor = _textColor;
    self.tintColor = _textColor;//光标的颜色
    [self setLeftImage:self.leftImage];
}

-(void)setSearchTextFieldBackgoudColor:(UIColor *)searchTextFieldBackgoudColor
{
    _searchTextFieldBackgoudColor = searchTextFieldBackgoudColor;
    if (_SYSTERVERSION_ < 7.0) {
        [self setSearchFieldBackgroundImage:[self sepImageFromColor:searchTextFieldBackgoudColor withRect:CGRectMake(0, 0, 100, 30)] forState:UIControlStateNormal];
    }else{
        _searchTextField.backgroundColor = _searchTextFieldBackgoudColor;
    }
}

-(void)setClearButtonImage:(UIImage *)clearButtonImage
{
    _clearButtonImage = clearButtonImage;
    _clearButtonImageView.image = _clearButtonImage;
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    _searchTextField.font = _font;
}


-(void)setPlaceholder:(NSString *)placeholder withColor:(UIColor *)color
{
    if ([_searchTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        [_searchTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: color}]];//ios 6
    }else{
        
    }
    
}

-(UIImage *)sepImageFromColor:(UIColor*)color withRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [color CGColor]);
    
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
