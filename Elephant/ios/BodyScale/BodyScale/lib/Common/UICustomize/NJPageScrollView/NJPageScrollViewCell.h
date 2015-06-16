//
//  NJPageScrollViewCell.h
//  FFLtd
//
//  Created by 两元鱼 on 12-4-25.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//


@interface NJPageScrollViewCell : UIView
{
    @private
    NSString    *_reuseIdentifier;
}


@property (nonatomic, readwrite, strong) NSString *reuseIdentifier;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (void)prepareForReuse;

@end
