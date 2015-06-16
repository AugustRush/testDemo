//
//  SNHUDIndicatorView.h
//  FFLtd
//
//  Created by 两元鱼 on 13-4-24.
//  Copyright (c) 2013年 FFLtd. All rights reserved.
//


@interface SNHUDIndicatorView : MBRoundProgressView

@property (nonatomic, strong) UIImageView  *indicatorImgView;

- (void)startAnimation;
- (void)stopAnimation;
@end
