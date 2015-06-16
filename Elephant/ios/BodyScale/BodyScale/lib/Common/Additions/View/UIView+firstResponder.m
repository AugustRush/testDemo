//
//  UIView+firstResponder.m
//  Color Calc
//
//  Created by Johnnie Walker on 25/01/2010.
//

#import "UIView+firstResponder.h"

@implementation UIView (firstResponder)

- (UIView *)findFirstResponder
{
	if ([self isFirstResponder]) {
		return self;
	}
	
	for (UIView *subview in [self subviews]) {
		UIView *firstResponder = [subview findFirstResponder];
		if (nil != firstResponder) {
			return firstResponder;
		}
	}
	
	return nil;
}


@end
