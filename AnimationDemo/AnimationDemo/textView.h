//
//  textView.h
//  AnimationDemo
//
//  Created by August on 15/6/5.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface textView : UIView
@property (weak, nonatomic) IBOutlet UIView *leftTop;
@property (weak, nonatomic) IBOutlet UIView *leftBottom;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *rightTop;
@property (weak, nonatomic) IBOutlet UIView *rightBottom;

@end


@interface testLayer : CALayer

@property (nonatomic, strong) UIColor *whatColor;

@end