//
//  UIAlertBlockView.m
//  MatchNet
//
//  Created by 李翰阳 on 14-11-14.
//  Copyright (c) 2014年 JSLtd. All rights reserved.
//

#import "UIAlertBlockView.h"

@implementation UIAlertBlockView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_setClickBlock) {
        self.setClickBlock(alertView,buttonIndex);
    }
}
- (void)setClickBlock:(AlertBasicBlock)block
{
    self.setClickBlock = block;
    self.delegate = self;
}
@end
