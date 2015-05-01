//
//  NSString+Calculation.m

#import "NSString+Calculation.h"

@implementation NSString (Calculation)

- (CGSize)usedSizeForMaxWidth:(CGFloat)width withFont:(UIFont *)font
{
    NSTextStorage *textStorage = [[NSTextStorage alloc]
                                  initWithString:self];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize: CGSizeMake(width, MAXFLOAT)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [textStorage addAttribute:NSFontAttributeName value:font
                        range:NSMakeRange(0, [textStorage length])];
    [textContainer setLineFragmentPadding:0.0];

    [layoutManager glyphRangeForTextContainer:textContainer];
    CGRect frame = [layoutManager usedRectForTextContainer:textContainer];
    return CGSizeMake(ceilf(frame.size.width),ceilf(frame.size.height));
}

- (CGSize)usedSizeForMaxWidth:(CGFloat)width withAttributes:(NSDictionary *)attributes
{
    NSAttributedString *attrutedString = [[NSAttributedString alloc] initWithString:self attributes:attributes];
    
    UITextView *tempTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    [tempTextView setTextContainerInset:UIEdgeInsetsZero];
    tempTextView.textContainer.lineFragmentPadding = 0;

    tempTextView.attributedText = attrutedString;
    [tempTextView.layoutManager glyphRangeForTextContainer:tempTextView.textContainer];
    
    CGRect usedFrame = [tempTextView.layoutManager usedRectForTextContainer:tempTextView.textContainer];
    
    return CGSizeMake(ceilf(usedFrame.size.width),ceilf(usedFrame.size.height));
}

@end
