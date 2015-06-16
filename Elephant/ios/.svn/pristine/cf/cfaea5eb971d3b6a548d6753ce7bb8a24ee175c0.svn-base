//
//  GetStringWidthAndHeight.m
//  FFLtd
//
//  Created by 两元鱼 on 14-8-6.
//  Copyright (c) 2014年 FFLtd. All rights reserved.
//

#import "GetStringWidthAndHeight.h"

@implementation GetStringWidthAndHeight

+ (CGSize)getStringHeight:(NSString *)stringText width:(NSInteger)sWidth font:(UIFont *)theFont
{
    if (theFont == nil)
    {
        theFont = FONT15;
    }
    if ([stringText respondsToSelector:@selector(sizeWithFont:constrainedToSize:lineBreakMode:)])
    {
        CGSize sizeName = [stringText sizeWithFont:theFont constrainedToSize:CGSizeMake(sWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        return sizeName;
    }
    if ([stringText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        NSDictionary *attribute = @{NSFontAttributeName:theFont};

        CGRect rectName = [stringText boundingRectWithSize:CGSizeMake(sWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        CGSize sizeName = rectName.size;
        return sizeName;
    }
    return CGSizeZero;
}
+ (CGSize)getStringWidth:(NSString *)stringText height:(NSInteger)sHeight font:(UIFont *)theFont
{
    if (theFont == nil)
    {
        theFont = FONT15;
    }
    if ([stringText respondsToSelector:@selector(sizeWithFont:constrainedToSize:lineBreakMode:)])
    {
        CGSize sizeName = [stringText sizeWithFont:theFont constrainedToSize:CGSizeMake(MAXFLOAT, sHeight) lineBreakMode:NSLineBreakByWordWrapping];
        return sizeName;
    }
    if ([stringText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        NSDictionary *attribute = @{NSFontAttributeName:theFont};
        
        CGRect rectName = [stringText boundingRectWithSize:CGSizeMake(MAXFLOAT, sHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        CGSize sizeName = rectName.size;
        return sizeName;
    }
    return CGSizeZero;
}
@end
