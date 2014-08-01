//
//  HomeCollectionVIewHeader.m
//  ARVeryCD
//
//  Created by August on 14-7-31.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "HomeCollectionVIewHeader.h"

@implementation HomeCollectionVIewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)awakeFromNib
{
    [self.toolbar setTintColor:FlatGray];
}

@end
