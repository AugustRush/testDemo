//
//  ARMessageInputTextView.h
//  Mindssage
//
//  Created by August on 14/11/2.
//
//

#import <UIKit/UIKit.h>

@interface ARTextView : UITextView

/**
 *  The text to be displayed when the text view is empty. The default value is `nil`.
 */
@property (copy, nonatomic) NSString *placeHolder;

/**
 *  The color of the place holder text. The default value is `[UIColor lightGrayColor]`.
 */
@property (strong, nonatomic) UIColor *placeHolderTextColor;

/**
 *  number of text's lines
 */
@property (nonatomic, assign) NSUInteger numberOfLines;

/**
 *  Determines whether or not the text view contains text after trimming white space
 *  from the front and back of its string.
 *
 *  @return `YES` if the text view contains text, `NO` otherwise.
 */

- (BOOL)hasText;

@end
