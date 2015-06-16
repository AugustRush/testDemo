//
//  UIImage+ShareImage.h
//  BodyScaleProduction
//
//  Created by Cloud_Ding on 14-5-11.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ShareImage)

// 裁剪图片
- (UIImage *) imageCroppedToRect:(CGRect)rect;
// 裁减正方形区域
- (UIImage *) squareImage;

// 画水印
// 图片水印
- (UIImage *) imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect;
// 文字水印
//- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;


@end
