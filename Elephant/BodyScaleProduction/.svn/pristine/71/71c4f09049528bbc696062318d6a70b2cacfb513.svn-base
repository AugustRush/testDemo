//
//  ARLabelView.h
//  testNib
//
//  Created by 刘平伟 on 14-3-29.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ARLabelViewTextAlignment) {
    ARLabelViewTextAlignmentLeft,
    ARLabelViewTextAlignmentRight
};

@class ARLabelViewText;

@interface ARLabelView : UIView

@property (nonatomic, strong) NSArray *textValues;
@property (nonatomic, assign) ARLabelViewTextAlignment textAlignment;


@end

@interface ARLabelViewText : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIFont *font;

+(id)ViewTextWithText:(NSString *)text color:(UIColor *)color Font:(UIFont *)font;

@end