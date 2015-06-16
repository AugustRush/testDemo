//
//  UIView+Appear.m
//  RoundedPopup
//
//  Created by Jeff Hodnett on 9/11/10.
//  Copyright 2010 Applausible. All rights reserved.
//

#import "UIView+Appear.h"

#define kSTARTING_SCALE 0.3f
#define kEND_SCALE 1.0f
#define kDURATION 0.4f

@interface UIView (Private)

@end


@implementation UIView (Appear)


- (void)appear {
	[self setTransform: CGAffineTransformMakeScale(kSTARTING_SCALE, kSTARTING_SCALE)];
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: kDURATION];
	[self setTransform: CGAffineTransformMakeScale(kEND_SCALE, kEND_SCALE)];
	[UIView commitAnimations];
}

-(void)disappearWithCallback:(SEL)aSelector {
	[self setTransform: CGAffineTransformMakeScale(kEND_SCALE, kEND_SCALE)];
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: kDURATION];
	[UIView setAnimationDelegate: self] ;
	[UIView setAnimationDidStopSelector: aSelector] ;
	[self setTransform: CGAffineTransformMakeScale(0.001, 0.001)];
	[UIView commitAnimations];
}
	

@end