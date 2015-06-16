//
//  PBFlatSegmentedControl.m
//  FlatUIlikeiOS7
//
//  Created by Piotr Bernad on 11.06.2013.
//  Copyright (c) 2013 Piotr Bernad. All rights reserved.
//

#import "PBFlatSegmentedControl.h"

#define BORDER_COLOR    [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.4f]
#define SELECTED_COLOR  [UIColor colorWithWhite:1 alpha:0.3]
#define DIVIDER_COLOR   [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.6f]

@implementation PBFlatSegmentedControl

#pragma mark - Nib

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpLayer];
}

#pragma mark - Code

- (id)initWithItems:(NSArray *)items {
    self = [super initWithItems:items];
    if (self) {
        [self setUp];
        [self setUpLayer];
    }
    return self;
}

- (void)setUp {
    NSDictionary *normalAttributes = @{
                                       UITextAttributeFont: [UIFont fontWithName:@"HelveticaNeue-Light" size:15],
                                       UITextAttributeTextColor: [UIColor whiteColor],
                                       UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                                       UITextAttributeTextShadowColor: [UIColor clearColor]
                                       };
    NSDictionary *highlightedAttributes = @{ UITextAttributeTextColor: [UIColor whiteColor] };
    
    [self setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    [self setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    CGSize size = CGSizeMake(10.0f, 40.0f);
    
    UIImage *selectedBackgroundImage = [self imageWithColor:SELECTED_COLOR size:size andRoundSize:5.0f];
    UIImage *unselectedBackgroundImage = [self imageWithColor:[UIColor clearColor] size:size andRoundSize:5.0f];
    UIImage *dividerImage = [self imageWithColor:DIVIDER_COLOR];
    
    [self setBackgroundImage:unselectedBackgroundImage
                    forState:UIControlStateNormal
                  barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:selectedBackgroundImage
                    forState:UIControlStateSelected
                  barMetrics:UIBarMetricsDefault];
    [self setDividerImage:dividerImage
      forLeftSegmentState:UIControlStateNormal
        rightSegmentState:UIControlStateNormal
               barMetrics:UIBarMetricsDefault];
}

- (void)setUpLayer {
    self.layer.cornerRadius = 5.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = BORDER_COLOR.CGColor;
}

#pragma mark - Image

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (roundSize > 0) {
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius: roundSize];
        [color setFill];
        [roundedRectanglePath fill];
    } else {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
