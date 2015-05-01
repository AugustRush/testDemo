//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Calculation)

- (CGSize)usedSizeForMaxWidth:(CGFloat)width withFont:(UIFont *)font;
- (CGSize)usedSizeForMaxWidth:(CGFloat)width withAttributes:(NSDictionary *)attributes;

@end
