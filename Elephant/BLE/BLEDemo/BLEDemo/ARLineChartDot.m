//
//  ARLineChartDot.m
//  lineChartTest
//
//  Created by 刘平伟 on 14-3-21.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "ARLineChartDot.h"

@implementation ARLineChartDot

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = CGRectGetWidth(frame)/2;
        self.layer.borderColor = [UIColor yellowColor].CGColor;
        self.layer.borderWidth = 2;
    }
    return self;
}

@end
