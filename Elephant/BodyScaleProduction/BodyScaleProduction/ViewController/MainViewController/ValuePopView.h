//
//  ValuePopView.h
//  ViewDraw
//
//  Created by Go Salo on 14-5-11.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ValuePopView : UIView

- (void)setValueString:(NSString *)valueString popColor:(UIColor *)popColor;

- (CGSize)calculatePopRectWithValueString:(NSString *)valueString;

@end
