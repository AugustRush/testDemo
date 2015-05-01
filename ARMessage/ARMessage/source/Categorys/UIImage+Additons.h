//
//  UIImage+Additons.h
//  Mindssage
//
//  Created by August on 14-8-23.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImageType) {
    ImageTypePNG,
    ImageTypeJPG,
    ImageTypeGIF,
    ImageTypeTIFF
};

@interface UIImage (Additons)

+(UIImage *)createImageWithColor:(UIColor *) color;
+(UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

-(UIImage*)resizedImageToSize:(CGSize)dstSize;
-(UIImage*)resizedImageToSize:(CGSize)dstSize oval:(BOOL)oval;
-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;
+(CGSize) getSizeToFitInSize:(CGSize)boundingSize originalSize:(CGSize)originalSize scaleIfSmaller:(BOOL)scale;

+ (UIImage *) createRoundedRectImage:(UIImage *)image size:(CGSize)size roundRadius:(CGFloat)radius;

+(CGSize)getScaleSizeWithMaxSize:(CGSize)maxSize minSize:(CGSize)minSize originalSize:(CGSize)originalSize;

- (UIImage *)fixOrientation ;


-(void)cropImageWithSize:(CGSize)size scale:(BOOL)scale finihsed:(void(^)(UIImage *cropImage))finihsed;

+(ImageType)typeForImageData:(NSData *)data;


#define bytesPerMB 1024*1024.0f
#define pixelsPerMB ( bytesPerMB / bytesPerPixel )
- (NSData *)compress;
-(NSData *)compressWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;

-(CGFloat)totalMB;

@end
