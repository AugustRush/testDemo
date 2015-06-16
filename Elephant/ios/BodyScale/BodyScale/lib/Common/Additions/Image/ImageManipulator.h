//
//  ImageManipulator.h
//
//  Class for manipulating images.
//
//  Created by Björn Sållarp on 2008-09-11.
//  Copyright 2008 Björn Sållarp. All rights reserved.
//
//  Read my blog @ http://blog.sallarp.com
//
// Updated on 2009-04-05



@interface ImageManipulator : NSObject {

}

+(UIImage *)makeRoundCornerImage:(UIImage*)img :(int) cornerWidth :(int) cornerHeight;
+(UIImage*)imageWithBorderFromImage:(UIImage*)source;
@end
