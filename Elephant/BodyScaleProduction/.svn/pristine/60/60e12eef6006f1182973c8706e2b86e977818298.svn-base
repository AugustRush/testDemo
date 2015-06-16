//
//  AQAlertView.h
//  BodyScaleProduction
//
//  Created by Zhanghao on 4/19/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AQAlertViewType) {
    AQAlertViewTypeDefault = 0,
    AQAlertViewTypeMessageOnly,
};

@interface AQAlertView : UIView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
           confirmButtonTitle:(NSString *)confirmTitle
                  cancelTitle:(NSString *)cancelTitle;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
           confirmButtonTitle:(NSString *)confirmTitle
                  cancelTitle:(NSString *)cancelTitle
               confirmHandler:(void (^)(AQAlertView *alertView))confirmHandler
                cancelHandler:(void (^)(AQAlertView *alertView))cancelHandler;

- (void)show;

/**
 *  Weather the alert view will dismiss after taping the background view. 
 *  Content view does not response the tap gesture by default.
 *  The default value is YES.
 */
@property (nonatomic, assign) BOOL canTapDismiss;

@property (nonatomic, assign) AQAlertViewType type;

//@property (nonatomic, assign) BOOL bounce;

@end
