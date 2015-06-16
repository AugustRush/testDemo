//
//  AQLoadingView.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 5/16/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "AQLoadingView.h"

@implementation AQLoadingView {
    UIActivityIndicatorView *indicator;
    UILabel *hintLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
        
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicator startAnimating];
        [self addSubview:indicator];
        
        hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        hintLabel.backgroundColor = [UIColor clearColor];
        hintLabel.textAlignment = NSTextAlignmentLeft;
        hintLabel.textColor = [UIColor darkGrayColor];
        hintLabel.font = [UIFont systemFontOfSize:17];
        hintLabel.text = @"正在载入...";
        [self addSubview:hintLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    indicator.center = CGPointMake(self.center.x - 30, self.center.y);
    hintLabel.frame = CGRectMake(146, self.center.y - 13, 140, 26);
}

@end
