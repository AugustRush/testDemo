//
//  HomeCollectionView.m
//  ARVeryCD
//
//  Created by August on 14-7-30.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "HomeCollectionView.h"
#import "HomeCollectionViewLayout.h"

@implementation HomeCollectionView

#pragma mark - init / config methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(void)initConfigs
{
//    self.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    HomeCollectionViewLayout *layout = [[HomeCollectionViewLayout alloc] init];
    self.collectionViewLayout = layout;
}

#pragma mark - Private methods

@end
