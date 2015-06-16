/**
 * Copyright (c) 2012－3－21 MatchNet 两元鱼
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

#import "UIImageTransformation.h"

@implementation UIImageTransformation

-(id)init{
    self = [super init];    
    return self;
}


- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage*)image
{
    //    DLog(@"the image width is :%f", image.size.width);
    //    DLog(@"the image height is :%f", image.size.height);
    
    //UIImage 压缩后的图片
    UIImage *newImage = nil;
    
    //原图片大小
    CGSize imageSize = image.size;
    //原图片宽度
    CGFloat width = imageSize.width;
    //原图片高度
    CGFloat height = imageSize.height;
    
    
    //欲压缩宽度
    CGFloat targetWidth = targetSize.width;
    //欲压缩高度
    CGFloat targetHeight = targetSize.height;    
    //压缩比例系数（初始化为0）
    CGFloat scaleFactor = 0.0;
    //图片的宽度和高度小于欲压缩的宽度和高度，不需要压缩
    if (width <= targetWidth && height <= targetHeight) {  
        return image;  
    }  
    //图片的宽度和高度都等于0，不需要压缩
    if (width == 0 || height == 0) {  
        
        return image;  
    } 
    
    //宽度比例
    CGFloat scaledWidth = targetWidth;
    //高度比例
    CGFloat scaledHeight = targetHeight;
    //压缩点
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    /*
     如果 原图片大小跟欲压缩大小相同，则不执行压缩动作，否则执行压缩动作
     执行：
     */
    if ((CGSizeEqualToSize(imageSize, targetSize) == NO)&&(imageSize.width!=0)&&(imageSize.height!=0))
    {
        //宽度系数，格式 50／100＝0.5
        CGFloat widthFactor = targetWidth / width;
        //高度系数 格式 50／100＝0.5
        CGFloat heightFactor = targetHeight / height;
        
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        
        
        //压缩后的宽度＝原宽度＊宽度压缩系数
        scaledWidth  = width * scaleFactor;
        //压缩后的宽度＝原高度＊高度压缩系数
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }      
    //以下执行压缩动作
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [image drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    DLog(@"new  width is :%f", newImage.size.width);
    DLog(@"new height is :%f", newImage.size.height);
    if(newImage == nil)
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
@end
