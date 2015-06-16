//
//  ColorPickerUtil.m
//  ImageParseUtil
//
//  Created by Go Salo on 14-4-6.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "ColorPickerUtil.h"

@implementation ColorPickerUtil {
    CGContextRef    _bitmapContext;
    CGImageRef      _image;
    unsigned char   *_imageData;
    
    size_t  _w;
    size_t  _h;
}

- (void)dealloc {
    if (_imageData) { free(_imageData); }
}

- (void)setImage:(UIImage *)image {
    _bitmapContext = [self createARGBBitmapContextFromImage:image.CGImage];
    _image = image.CGImage;
    [self getImageData];
}

#pragma mark - Public Method
- (UIColor *)getPixelColorAtLocation:(CGPoint)point {
    if (!_bitmapContext || point.x < 0 || point.y < 0) {
        return nil;
    }
    
    UIColor* color = nil;
    if (_imageData != NULL) {
        @try {
            int offset = 4 * ((_w * round(point.y)) + round(point.x));
            int alpha =  _imageData[offset];
            int red = _imageData[offset + 1];
            int green = _imageData[offset + 2];
            int blue = _imageData[offset + 3];
//            NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
            color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
        }
        @catch (NSException * e) {
            NSLog(@"%@",[e reason]);
        }
        @finally {
        }
    }
    return color;
}

// 获取图片中单个点的颜色
- (unsigned char *)getImageData {
    if (!_bitmapContext) {
        NSLog(@"没有获取到context");
        return nil;
    }
    
    CGImageRef inImage = _image;
    // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
    CGContextRef cgctx = _bitmapContext;
    if (cgctx == NULL) { return nil;  }
    
    _w = CGImageGetWidth(inImage);
    _h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{_w,_h}};
    
    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    CGContextDrawImage(cgctx, rect, inImage);
    
    // Now we can get a pointer to the image data associated with the bitmap
    // context.
    _imageData = CGBitmapContextGetData (cgctx);
    
    // When finished, release the context
    CGContextRelease(cgctx);
    
    return _imageData;
}

// 创建取点图片工作域
- (CGContextRef)createARGBBitmapContextFromImage:(CGImageRef)inImage {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (int)(pixelsWide * 4);
    bitmapByteCount     = (int)(bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Big);
    
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    
    return context;
}

@end
