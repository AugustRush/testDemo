//
//  CustomProgressView.h
//  BodyScale
//
//  Created by zhangweiwei on 15/1/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M13ProgressViewSegmentedRing.h"
@interface CustomProgressView : M13ProgressViewSegmentedRing

@property (nonatomic, strong) UIImageView *connectingImg;
@property (nonatomic, strong) UILabel *connectingLabel;

@property (nonatomic, strong) UILabel *scoreNumLb;
@property (nonatomic, strong) UILabel *scoreLb;

- (instancetype)initWithConnected:(BOOL)connectedDevice;
- (void)showHighestLabel;
- (void)showConnectImg;

@end
