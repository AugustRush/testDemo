//
//  AQAlertView.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 4/19/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "AQAlertView.h"

@interface AQButton : UIButton

@end

@implementation AQButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//        self.layer.borderColor = [UIColor redColor].CGColor;
        self.backgroundColor = [UIColor darkGrayColor];
    } else {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.backgroundColor = [UIColor clearColor];
    }
}

@end

// Macros
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

// Height
CGFloat const kMaxContentViewHeight = 200;
CGFloat const kMaxTitleLabelHeight = 26;
CGFloat const kMaxMessageLabelHeight = 100;
CGFloat const kDefaultButtonHeight = 30;

// Horizontal padding
CGFloat const kTitleLeftPadding = 20;
CGFloat const kContentViewLeftPadding = 20;

// Vertical Padding
CGFloat const kDefaultTopPadding = 20;
CGFloat const kMessageOnlyTopPadding = 10;
CGFloat const kTitleAndMessagePadding = 5;
CGFloat const kMessageAndCustomViewPadding = 20;
CGFloat const kDefaultBottomPadding = 20;
CGFloat const kMessageOnlyBottomPadding = 10;

@interface AQAlertView () <UIGestureRecognizerDelegate>

@end

@implementation AQAlertView {
    // Block
    void (^confirmHandler)(AQAlertView *);
    void (^cancelHandler)(AQAlertView *);
    
    // User interface
    UIView *backgroundView;
    UIView *contentView;
    UIView *customView;
    
    UILabel *titleLabel;
    UILabel *messageLabel;
    
    AQButton *confirmButton;
    AQButton *cancelButton;
    
    // Data
    CGFloat contentViewHeight;
    
    // Interactive
    UIGestureRecognizer *tapGesture;
    
    // Control variables
    struct {
        unsigned int hasTitle : 1;
        unsigned int hasMessage : 1;
        unsigned int hasCustomView : 1;
        unsigned int hasConfirmButton : 1;
        unsigned int hasCancelButton : 1;
        unsigned int shouldShow: 1;
        unsigned int canTapDismiss : 1;
        unsigned int supportLandscapeLayout : 1;
    }flags;
}

#pragma mark - Designated Initial Methods

- (instancetype)initWithMessage:(NSString *)message {
    return [self initWithTitle:nil message:message confirmButtonTitle:nil cancelTitle:nil confirmHandler:nil cancelHandler:nil];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message confirmButtonTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle {
    return [self initWithTitle:title message:message confirmButtonTitle:confirmTitle cancelTitle:cancelTitle confirmHandler:nil cancelHandler:nil];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message confirmButtonTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmHandler:(void (^)(AQAlertView *))aConfirmHandler cancelHandler:(void (^)(AQAlertView *))aCancelHandler {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self commonInit];
        
        if ((!title && !message) || (title.length == 0 && message.length == 0)) {
            flags.shouldShow = 0;
        }
        
        confirmHandler = [aConfirmHandler copy];
        cancelHandler = [aCancelHandler copy];
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.contentView];
        
        if (title && title.length > 0) {
            flags.hasTitle = 1;
            self.titleLabel.text = title;
            [contentView addSubview:titleLabel];
        }
        
        if (message && message.length > 0) {
            flags.hasMessage = 1;
            self.messageLabel.text = message;
            [contentView addSubview:messageLabel];
        }
        
        if (confirmTitle && confirmTitle.length > 0) {
            flags.hasConfirmButton = 1;
            [self.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
            [self.customView addSubview:confirmButton];
        }
        
        if (cancelTitle && cancelTitle.length > 0) {
            flags.hasCancelButton = 1;
            [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
            [self.customView addSubview:cancelButton];
        }
        
        if (flags.hasConfirmButton || flags.hasCancelButton) {
            flags.hasCustomView = 1;
            [contentView addSubview:customView];
        }
        
        if (!flags.hasTitle && flags.hasMessage && !flags.hasCustomView) {
            _type = AQAlertViewTypeMessageOnly;
        }
        
        [self layoutContentView];
    }
    return self;
}

#pragma mark - Private Methods

- (void)commonInit {
    flags.shouldShow = 1;
    flags.canTapDismiss = 1;
    flags.hasTitle = 0;
    flags.hasMessage = 0;
    flags.hasCustomView = 0;
    flags.hasConfirmButton = 0;
    flags.hasCancelButton = 0;
    flags.supportLandscapeLayout = 0;
    
    _type = AQAlertViewTypeDefault;
    
    contentViewHeight = 0.0f;
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor clearColor];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlertView)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
}

- (void)layoutContentView {
    CGFloat contentViewWidth = SCREEN_WIDTH - kContentViewLeftPadding * 2;
    CGFloat titleLabelWidth = contentViewWidth - 2 * kTitleLeftPadding;
    
    if (_type == AQAlertViewTypeDefault) {
        contentViewHeight = kDefaultTopPadding;
    } else if (_type == AQAlertViewTypeMessageOnly) {
        contentViewHeight = kMessageOnlyTopPadding;
    }

    if (flags.hasTitle) {
        // Adjsut title label frame
        titleLabel.frame = CGRectMake(kTitleLeftPadding, kDefaultTopPadding, titleLabelWidth, kMaxTitleLabelHeight);
        [titleLabel sizeToFit];
        CGFloat sizeToFitWidth = CGRectGetWidth(titleLabel.bounds);
        CGFloat sizeToFitHeight = CGRectGetHeight(titleLabel.bounds);
        sizeToFitWidth = (sizeToFitWidth > titleLabelWidth) ? titleLabelWidth : sizeToFitWidth;
        sizeToFitHeight = (sizeToFitHeight > kMaxTitleLabelHeight) ? kMaxTitleLabelHeight : sizeToFitHeight;
        titleLabel.frame = CGRectMake(0, 0, sizeToFitWidth, sizeToFitHeight);
        titleLabel.center = CGPointMake(contentViewWidth / 2, kDefaultTopPadding + sizeToFitHeight / 2);;
        
        contentViewHeight += sizeToFitHeight;
    }
    
    if (flags.hasMessage) {
        if (flags.hasTitle) {
            contentViewHeight += kTitleAndMessagePadding;
        }
        
        // Adjsut message label frame
        messageLabel.frame = CGRectMake(kTitleLeftPadding, contentViewHeight, titleLabelWidth, 0);
        [messageLabel sizeToFit];
        CGFloat sizeToFitWidth = CGRectGetWidth(messageLabel.bounds);
        CGFloat sizeToFitHeight = CGRectGetHeight(messageLabel.bounds);
        sizeToFitWidth = (sizeToFitWidth > titleLabelWidth) ? titleLabelWidth : sizeToFitWidth;
        sizeToFitHeight = (sizeToFitHeight > kMaxMessageLabelHeight) ? kMaxMessageLabelHeight : sizeToFitHeight;
        messageLabel.frame = CGRectMake(0, 0, sizeToFitWidth, sizeToFitHeight);
        messageLabel.center = CGPointMake(contentViewWidth / 2, contentViewHeight + sizeToFitHeight / 2);;
        contentViewHeight += sizeToFitHeight;
    }
    
    if (flags.hasCustomView) {
        contentViewHeight += kMessageAndCustomViewPadding;
        customView.frame = CGRectMake(kTitleLeftPadding, contentViewHeight, titleLabelWidth, kDefaultButtonHeight);
        contentViewHeight += kDefaultButtonHeight;
    }
    
    if (flags.hasConfirmButton && !flags.hasCancelButton) {
        confirmButton.frame = CGRectMake(0, 0, titleLabelWidth, kDefaultButtonHeight);
        
    } else if (!flags.hasConfirmButton && flags.hasCancelButton) {
        
        cancelButton.frame = CGRectMake(0, 0, titleLabelWidth, kDefaultButtonHeight);
    } else if (flags.hasConfirmButton && flags.hasCancelButton) {
        CGFloat buttonPadding = kTitleLeftPadding;
        CGFloat buttonWidth = (titleLabelWidth - buttonPadding) / 2;
        
        confirmButton.frame = CGRectMake(0, 0, buttonWidth, kDefaultButtonHeight);
        cancelButton.frame = CGRectMake(buttonWidth + buttonPadding, 0, buttonWidth, kDefaultButtonHeight);
    }

    if (_type == AQAlertViewTypeDefault) {
        contentViewHeight += kDefaultBottomPadding;
    } else if (_type == AQAlertViewTypeMessageOnly) {
        contentViewHeight += kMessageOnlyBottomPadding;
    }
    
    contentViewHeight = (contentViewHeight > kMaxContentViewHeight) ? kMaxContentViewHeight : contentViewHeight;
    
    contentView.frame = CGRectMake(kContentViewLeftPadding,
                                   (SCREEN_HEIGHT- contentViewHeight) / 2,
                                   SCREEN_WIDTH - 2 * kContentViewLeftPadding,
                                   contentViewHeight);
}

- (UIView *)backgroundView {
    if (!backgroundView) {
        backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return backgroundView;
}

- (UIView *)contentView {
    if (!contentView) {
        contentView = [UIView new];
        contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        contentView.layer.cornerRadius = 10;
    }
    return contentView;
}

- (UILabel *)titleLabel {
    if (!titleLabel) {
        titleLabel = [UILabel new];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
//        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];;
    }
    return titleLabel;
}

- (UILabel *)messageLabel {
    if (!messageLabel) {
        messageLabel = [UILabel new];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = [UIColor darkGrayColor];
//        messageLabel.font = [UIFont systemFontOfSize:20];
        messageLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        messageLabel.numberOfLines = 0;
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return messageLabel;
}

- (UIView *)customView {
    if (!customView) {
        customView = [UIView new];
        customView.backgroundColor = [UIColor clearColor];
    }
    return customView;
}

- (UIButton *)confirmButton {
    if (!confirmButton) {
        confirmButton = [AQButton buttonWithType:UIButtonTypeCustom];
        confirmButton.layer.cornerRadius = 15;
        confirmButton.layer.borderWidth = 1;
        confirmButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        confirmButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        [confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return confirmButton;
}
    
- (UIButton *)cancelButton {
    if (!cancelButton) {
        cancelButton = [AQButton buttonWithType:UIButtonTypeCustom];
        cancelButton.layer.cornerRadius = 15;
        cancelButton.layer.borderWidth = 1;
        cancelButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cancelButton;
}

- (void)setCanTapDismiss:(BOOL)canTapDismiss {
    flags.canTapDismiss = canTapDismiss;
}

#pragma mark - Notification

- (void)registerObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)deviceDidRotate:(NSNotification *)notification {
    
}

#pragma mark - Public Methods

- (void)show {
    [self showInView:[[UIApplication sharedApplication] keyWindow]];
}

- (void)showInView:(UIView *)view {
    if (flags.shouldShow) {
        tapGesture.enabled = NO;
        
        CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        popAnimation.duration = 0.4f;
        popAnimation.delegate = self;
        popAnimation.values = @[
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95f, 0.95f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
        popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [contentView.layer addAnimation:popAnimation forKey:@"popAnimation"];
        
        [view addSubview:self];
    }
}

- (void)dismiss {
    [self dismissAfterDelay:0.0f];
}

- (void)dismissAfterDelay:(CFTimeInterval)delay {
    [self performSelector:@selector(dismissAlertView) withObject:nil afterDelay:delay];
}

#pragma mark - Actions

- (void)dismissAlertView {
    confirmHandler = nil;
    cancelHandler = nil;
    
    [UIView animateWithDuration:0.25 animations:^{
        backgroundView.alpha = 0;
        contentView.alpha = 0;
    } completion:^(BOOL finished) {
       [self removeFromSuperview];
    }];
}

- (void)confirmAction:(UIButton *)button {
    if (confirmHandler) {
        confirmHandler(self);
    }
    [self dismissAlertView];
}

- (void)cancelAction:(UIButton *)button {
    if (cancelHandler) {
        cancelHandler(self);
    }
    [self dismissAlertView];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self];
    if (CGRectContainsPoint(contentView.frame, location)) {
        return NO;
    }
    return YES;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    tapGesture.enabled = flags.canTapDismiss;
}

@end
