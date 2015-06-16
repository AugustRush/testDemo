//
//  AuthNavigationBar.m
//  FFLtd
//
//  Created by 两元鱼 on 12-4-13.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "AuthNavigationBar.h"

@implementation AuthNavigationBar

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:kNavigationBarBackgroundImage];
    [image drawInRect:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT+1)];
}


@end
