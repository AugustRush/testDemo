//
//  ARLabelView.m
//  testNib
//
//  Created by 刘平伟 on 14-3-29.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "ARLabelView.h"

@implementation ARLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

-(void)initConfig
{
    self.textAlignment = ARLabelViewTextAlignmentLeft;//default
}

-(void)setTextValues:(NSArray *)textValues
{
    _textValues = textValues;
    if (_textValues) {
        [self setNeedsDisplay];
    }
}

-(void)setTextAlignment:(ARLabelViewTextAlignment)textAlignment
{
    if (textAlignment != _textAlignment) {
        _textAlignment = textAlignment;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGFloat originalX = 0;
    for (int i = 0; i < _textValues.count; i++) {
        ARLabelViewText *tObj = _textValues[i];
        [tObj.color setFill];
        CGSize size = [tObj.text sizeWithFont:tObj.font constrainedToSize:self.frame.size];
        CGFloat origiY = (CGRectGetHeight(self.frame)-size.height)/2;
        if (_textAlignment == ARLabelViewTextAlignmentLeft) {
            [tObj.text drawAtPoint:CGPointMake(originalX, origiY) withFont:tObj.font];
            originalX = originalX + size.width;
        }else{
            originalX = originalX + size.width;
            [tObj.text drawAtPoint:CGPointMake(CGRectGetWidth(self.frame)-originalX, origiY) withFont:tObj.font];
        }
    }
}

@end

////////////////
@implementation ARLabelViewText

+(id)ViewTextWithText:(NSString *)text color:(UIColor *)color Font:(UIFont *)font
{
    ARLabelViewText *textOBJ = [[ARLabelViewText alloc] init];
    textOBJ.text = text;
    textOBJ.color = color;
    textOBJ.font = font;
    return textOBJ;
}

@end