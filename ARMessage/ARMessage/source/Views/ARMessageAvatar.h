//
//  AvartarImageView.h
//  Mindssage
//
//  Created by August on 14/10/31.
//
//

#import <UIKit/UIKit.h>

@interface ARMessageAvatar : UIImageView

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign, readonly) CGFloat cornerRadius;

-(void) addTarget:(id)target withAction:(SEL)action;

@end
