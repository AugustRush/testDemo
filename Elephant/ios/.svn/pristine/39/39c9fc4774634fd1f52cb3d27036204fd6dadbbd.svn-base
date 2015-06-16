//
//  BBAlertView.m
//  FFLtd
//
//  Created by 两元鱼 on 12-6-21.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "BBAlertView.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)

#define kContentLabelWidth      250.0f

static CGFloat kTransitionDuration = 0.3f;
static NSMutableArray *gAlertViewStack = nil;
static UIWindow *gPreviouseKeyWindow = nil;
static UIWindow *gMaskWindow = nil;

@implementation NSObject (BBAlert)

- (void)alertCustomDlg:(NSString *)message
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:L(@"Ok")
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)dismissAllCustomAlerts
{
    for (BBAlertView *alert in gAlertViewStack)
    {
        if ([alert delegate] == self && alert.visible) {
            [alert setDelegate:nil];
            [alert dismiss];
        }
    }
}

@end

/*********************************************************************/

@interface BBAlertView()
{
    NSInteger clickedButtonIndex;
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bodyTextLabel;
@property (nonatomic, strong) UITextView *bodyTextView;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *otherButton;

//orientation
- (void)registerObservers;
- (void)removeObservers;
- (BOOL)shouldRotateToOrientation:(UIInterfaceOrientation)orientation;
- (void)sizeToFitOrientation:(BOOL)transform;
- (CGAffineTransform)transformForOrientation;

+ (BBAlertView *)getStackTopAlertView;
+ (void)pushAlertViewInStack:(BBAlertView *)alertView;
+ (void)popAlertViewFromStack;

+ (void)presentMaskWindow;
+ (void)dismissMaskWindow;

+ (void)addAlertViewOnMaskWindow:(BBAlertView *)alertView;
+ (void)removeAlertViewFormMaskWindow:(BBAlertView *)alertView;

- (void)bounce0Animation;
- (void)bounce1AnimationDidStop;
- (void)bounce2AnimationDidStop;
- (void)bounceDidStop;

- (void)dismissAlertView;


//tools
+ (CGFloat)heightOfString:(NSString *)message;
@end

/*********************************************************************/

@implementation BBAlertView

@synthesize delegate = _delegate;
@synthesize visible = _visible;
@synthesize dimBackground = _dimBackground;
@synthesize style = _style;

@synthesize titleLabel = _titleLabel;
@synthesize bodyTextLabel = _bodyTextLabel;
@synthesize bodyTextView = _bodyTextView;
@synthesize customView = _customView;
@synthesize backgroundView = _backgroundView;
@synthesize contentView = _contentView;
@synthesize cancelButton = _cancelButton;
@synthesize otherButton = _otherButton;
@synthesize shouldDismissAfterConfirm = _shouldDismissAfterConfirm;
@synthesize contentAlignment = _contentAlignment;


- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"dimBackground"];
    [self removeObserver:self forKeyPath:@"contentAlignment"];
}


- (void)initData
{
    _shouldDismissAfterConfirm = YES;
    _dimBackground = YES;
    self.backgroundColor = [UIColor clearColor];
    _contentAlignment = NSTextAlignmentLeft;
    
    [self addObserver:self
           forKeyPath:@"dimBackground"
              options:NSKeyValueObservingOptionNew
              context:NULL];
    
    [self addObserver:self
           forKeyPath:@"contentAlignment"
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"dimBackground"]) {
        [self setNeedsDisplay];
    }else if ([keyPath isEqualToString:@"contentAlignment"]){
        self.bodyTextLabel.textAlignment = self.contentAlignment;
        self.bodyTextView.textAlignment = self.contentAlignment;
    }
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message 
           delegate:(id<BBAlertViewDelegate>)delegate 
  cancelButtonTitle:(NSString *)cancelButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitle
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initData];
        _delegate = delegate;
        _style = BBAlertViewStyleDefault;
        
        //content view
        CGFloat titleHeight = 0.0f;
        CGFloat bodyHeight = 20.0f;
        if (title) {
            titleHeight = 30.0f;
        }
        if (message) {
            bodyHeight = [BBAlertView heightOfString:message];
        }
        
        BOOL isNeedUserTextView = bodyHeight > 170;
        bodyHeight = isNeedUserTextView?170:bodyHeight;
        
        CGFloat finalHeight = titleHeight+bodyHeight+70;
        
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height-20;
        self.contentView.frame = CGRectMake(20, (screenHeight-finalHeight)/2.0, 280, finalHeight);
        self.contentView.backgroundColor = RGBACOLOR(255, 255, 255, 0.6);
        //self.contentView.alpha = 0.8;
        self.contentView.layer.cornerRadius = 6.0;
        
        //background image view
        UIImageView *bgImView = [[UIImageView alloc] init];
        bgImView.frame = CGRectMake(5, 5, 270, finalHeight-10);
        bgImView.image = [UIImage imageNamed:@"alert_message_bg.png"];
        [self.contentView addSubview:bgImView];
        
        //titleLabel
        if (title) {
            self.titleLabel.text = title;
            self.titleLabel.frame = CGRectMake(5, 15, 270, 30);
            self.titleLabel.textColor = RGBCOLOR(53, 79, 138);
            self.titleLabel.font = BOLDFONT18;
            [self.contentView addSubview:self.titleLabel];
        }
        
        //bodytext label
        CGFloat posY = title?45:15;
        if (isNeedUserTextView) {
            self.bodyTextView.text = message;
            self.bodyTextView.frame = CGRectMake(15, posY, kContentLabelWidth, bodyHeight);
            self.bodyTextView.font = FONT16;
            [self.contentView addSubview:self.bodyTextView];
        }else{
            self.bodyTextLabel.text = message;
            self.bodyTextLabel.frame = CGRectMake(15, posY, kContentLabelWidth, bodyHeight);
            self.bodyTextLabel.font = FONT16;
            [self.contentView addSubview:self.bodyTextLabel];
        }        
        
        //button 1
        CGFloat btnTop = posY+bodyHeight+5;
        if (cancelButtonTitle && otherButtonTitle) {
            UIImage *image2 = [UIImage imageNamed:@"light_blue_button.png"];
            [self.cancelButton setBackgroundImage:image2 forState:UIControlStateNormal];
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [self.cancelButton setFrame:CGRectMake(15, btnTop, 120, 35)];
            [self.cancelButton setTag:0];
            
            [self.otherButton setBackgroundImage:image2 forState:UIControlStateNormal];
            [self.otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
            [self.otherButton setFrame:CGRectMake(self.cancelButton.frame.origin.x + self.cancelButton.frame.size.width+10, btnTop, 120, 35)];
            [self.otherButton setTag:1];
            
            [self.contentView addSubview:self.cancelButton];
            [self.contentView addSubview:self.otherButton];
        }else if (cancelButtonTitle){
            UIImage *image2 = [UIImage imageNamed:@"submit_blue_button.png"];
            [self.cancelButton setBackgroundImage:image2 forState:UIControlStateNormal];
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [self.cancelButton setFrame:CGRectMake(30, btnTop, 220, 35)];
            [self.cancelButton setTag:0];
            [self.contentView addSubview:self.cancelButton];
        }else if (otherButtonTitle){
            UIImage *image2 = [UIImage imageNamed:@"submit_blue_button.png"];
            [self.otherButton setBackgroundImage:image2 forState:UIControlStateNormal];
            [self.otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
            [self.otherButton setFrame:CGRectMake(30, btnTop, 220, 35)];
            [self.otherButton setTag:0];
            [self.contentView addSubview:self.otherButton];
        }
    }
    return self;
     
}

- (id)initWithContentView:(UIView *)contentView
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initData];

        self.contentView = contentView;
        self.contentView.center = self.center;
        _style = BBAlertViewStyleCustomView;
    }
    return self;
}

- (id)initWithStyle:(BBAlertViewStyle)style 
              Title:(NSString *)title 
            message:(NSString *)message 
         customView:(UIView *)customView
           delegate:(id<BBAlertViewDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitle
{
    _style = style;
    switch (style) {
        case BBAlertViewStyleDefault:
        {
            return [self initWithTitle:title 
                               message:message 
                              delegate:delegate
                     cancelButtonTitle:cancelButtonTitle
                     otherButtonTitles:otherButtonTitle];
            break;
        }
        case BBAlertViewStyle1:
        {
            self = [super initWithFrame:[UIScreen mainScreen].bounds];
            if (self) {
                [self initData];

                _delegate = delegate;
                
                //content view
                CGFloat titleHeight = 42.0f;
                CGFloat bodyHeight = [BBAlertView heightOfString:message]+20;
                CGFloat customViewHeight = 0.0f;
                if (customView) {
                    self.customView = customView;
                    customViewHeight = customView.frame.size.height;
                }
                CGFloat buttonPartHeight = 50.0f;
                
                
                BOOL isNeedUserTextView = bodyHeight > 170;
                bodyHeight = isNeedUserTextView?170:bodyHeight;
                
                CGFloat finalHeight = titleHeight+bodyHeight+customViewHeight+buttonPartHeight+10;
                
                self.contentView.backgroundColor = RGBACOLOR(255, 255, 255, 0.5);
                self.contentView.layer.cornerRadius = 6.0;
                CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height-20;
                self.contentView.frame = CGRectMake(20, (screenHeight-finalHeight)/2.0, 280, finalHeight);
                
                UIView *alertMainView = [[UIView alloc] init];
                alertMainView.frame = CGRectMake(5, 5, 270, finalHeight-10);
                alertMainView.backgroundColor = RGBCOLOR(231, 236, 239);
                alertMainView.layer.cornerRadius = 4.0;
                [self.contentView addSubview:alertMainView];
                
                
                //titleBackgroundImage
                UIImageView *titleBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270, titleHeight)];
                UIImage *image1 = [UIImage imageNamed:@"alert_title_bg.png"];
                UIImage *streImage1 = [image1 stretchableImageWithLeftCapWidth:image1.size.width/2 topCapHeight:0];
                titleBgImageView.image = streImage1;
                [alertMainView addSubview:titleBgImageView];
                
                //titleLabel
                UIImageView *titleTipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert_title_tip.png"]];
                UIFont *titleFont = BOLDFONT20;
                CGSize titleSize = [title sizeWithFont:titleFont];
                CGFloat titleWidth = titleSize.width<240?titleSize.width:240;
                self.titleLabel.text = title;
                self.titleLabel.font = titleFont;
                self.titleLabel.textColor = [UIColor whiteColor];
                self.titleLabel.adjustsFontSizeToFitWidth = YES;
                CGFloat orgionX = 5+(240-titleWidth)/2+20;
                self.titleLabel.frame = CGRectMake(orgionX, 0, titleWidth, titleHeight);
                titleTipImageView.frame = CGRectMake(self.titleLabel.frame.origin.x-22, 11, 20, 20);
                [alertMainView addSubview:titleTipImageView];
                [alertMainView addSubview:self.titleLabel];
                
                //bodyLabel
                if (isNeedUserTextView) {
                    self.bodyTextView.text = message;
                    self.bodyTextView.frame = CGRectMake(5, titleHeight, kContentLabelWidth, bodyHeight);
                    self.bodyTextView.font = FONT16;
                    [alertMainView addSubview:self.bodyTextView];
                }else{
                    self.bodyTextLabel.text = message;
                    self.bodyTextLabel.frame = CGRectMake(5, titleHeight, kContentLabelWidth, bodyHeight);
                    self.bodyTextLabel.font = FONT16;
                    [alertMainView addSubview:self.bodyTextLabel];
                }
                
                //sepLine
                UIImageView *sepLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, titleHeight+bodyHeight, 270, 1)];
                UIImage *image2 = [UIImage imageNamed:@"concave_line.png"];
                UIImage *streImage2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width/2 topCapHeight:0];
                sepLine.image = streImage2;
                [alertMainView addSubview:sepLine];
                
                //custom view
                if (customView) {
                    customView.frame = CGRectMake(0, titleHeight+bodyHeight+5, customView.frame.size.width, customView.frame.size.height);
                    [alertMainView addSubview:customView];
                }
                
                //buttons
                if (cancelButtonTitle && otherButtonTitle)
                {
                    CGFloat buttonTopPosition = titleHeight+bodyHeight+customViewHeight+10;
                    UIImage *image3 = [UIImage imageNamed:@"green_button.png"];
                    UIImage *image4 = [UIImage imageNamed:@"sliver_button.png"];
                    UIImage *streImage3 = [image3 stretchableImageWithLeftCapWidth:image3.size.width/2 topCapHeight:0];
                    UIImage *streImage4 = [image4 stretchableImageWithLeftCapWidth:image4.size.width/2 topCapHeight:0];
                    [self.cancelButton setBackgroundImage:streImage4 forState:UIControlStateNormal];
                    [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
                    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [self.cancelButton setFrame:CGRectMake(30, buttonTopPosition, 80, 33)];
                    [self.cancelButton setTag:0];
                    
                    [self.otherButton setBackgroundImage:streImage3 forState:UIControlStateNormal];
                    [self.otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
                    [self.otherButton setFrame:CGRectMake(self.cancelButton.frame.size.width + self.cancelButton.frame.origin.x+50, buttonTopPosition, 80, 33)];
                    [self.otherButton setTag:1];
                    [alertMainView addSubview:self.cancelButton];
                    [alertMainView addSubview:self.otherButton];
                }else if (cancelButtonTitle){
                    CGFloat buttonTopPosition = titleHeight+bodyHeight+customViewHeight+10;
                    UIImage *image3 = [UIImage imageNamed:@"green_button.png"];
                    UIImage *streImage3 = [image3 stretchableImageWithLeftCapWidth:image3.size.width/2 topCapHeight:0];
                    [self.cancelButton setBackgroundImage:streImage3 forState:UIControlStateNormal];
                    [self.cancelButton setTitle:cancelButtonTitle?cancelButtonTitle:otherButtonTitle forState:UIControlStateNormal];
                    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [self.cancelButton setFrame:CGRectMake(30, buttonTopPosition, 210, 33)];
                    [self.cancelButton setTag:0];
                    [alertMainView addSubview:self.cancelButton];
                }else if (otherButtonTitle){
                    CGFloat buttonTopPosition = titleHeight+bodyHeight+customViewHeight+10;
                    UIImage *image3 = [UIImage imageNamed:@"green_button.png"];
                    UIImage *streImage3 = [image3 stretchableImageWithLeftCapWidth:image3.size.width/2 topCapHeight:0];
                    [self.otherButton setBackgroundImage:streImage3 forState:UIControlStateNormal];
                    [self.otherButton setTitle:cancelButtonTitle?cancelButtonTitle:otherButtonTitle forState:UIControlStateNormal];
                    [self.otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [self.otherButton setFrame:CGRectMake(30, buttonTopPosition, 210, 33)];
                    [self.otherButton setTag:0];
                    [alertMainView addSubview:self.otherButton];
                }
            }
            return self;
            break;
        }
        case BBAlertViewStyleCustomView:
        {
            DLog(@"you should use init with initWithContentView");
            break;
        }
        default:
            break;
    }
    return [super initWithFrame:[UIScreen mainScreen].bounds];
}

- (BOOL)isVisible
{
    return _visible;
}

- (void)drawRect:(CGRect)rect
{    
    if (_dimBackground) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        size_t gradLocationsNum = 2;
        CGFloat gradLocations[2] = {0.0f, 1.0f};
        CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.75f}; 
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
        CGColorSpaceRelease(colorSpace);
        
        //Gradient center
        CGPoint gradCenter = self.contentView.center;
        //Gradient radius
        float gradRadius = 320 ;
        //Gradient draw
        CGContextDrawRadialGradient (context, gradient, gradCenter,
                                     0, gradCenter, gradRadius,
                                     kCGGradientDrawsAfterEndLocation);
        CGGradientRelease(gradient);
    }
}

#pragma mark -
#pragma mark orientation

- (void)registerObservers{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)removeObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)orientationDidChange:(NSNotification*)notify
{
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if ([self shouldRotateToOrientation:orientation]) {
        if ([_delegate respondsToSelector:@selector(didRotationToInterfaceOrientation:view:alertView:)]) {
            [_delegate didRotationToInterfaceOrientation:UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) view:_customView alertView:self];
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [self sizeToFitOrientation:YES];
        [UIView commitAnimations];
    } 
}

- (BOOL)shouldRotateToOrientation:(UIInterfaceOrientation)orientation
{
    BOOL result = NO;
    if (_orientation != orientation) {
        result = (orientation == UIInterfaceOrientationPortrait ||
                  orientation == UIInterfaceOrientationPortraitUpsideDown ||
                  orientation == UIInterfaceOrientationLandscapeLeft ||
                  orientation == UIInterfaceOrientationLandscapeRight);
    }
    
    return result;
}

- (void)sizeToFitOrientation:(BOOL)transform
{
    if (transform) {
        self.transform = CGAffineTransformIdentity;
    }
    _orientation = [UIApplication sharedApplication].statusBarOrientation;        
    [self sizeToFit];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self setCenter:CGPointMake(screenSize.width/2, screenSize.height/2)];
    if (transform) {
        self.transform = [self transformForOrientation];
    }
}

- (CGAffineTransform)transformForOrientation
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5f);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2.0f);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}


#pragma mark -
#pragma mark view getters

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

- (UILabel *)bodyTextLabel
{
    if (!_bodyTextLabel) {
        _bodyTextLabel = [[UILabel alloc] init];
        _bodyTextLabel.numberOfLines = 0;
        _bodyTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _bodyTextLabel.textAlignment = NSTextAlignmentCenter;
        _bodyTextLabel.backgroundColor = [UIColor clearColor];
    }
    return _bodyTextLabel;
}

- (UITextView *)bodyTextView
{
    if (!_bodyTextView) {
        _bodyTextView = [[UITextView alloc] init];
        _bodyTextView.textAlignment = _contentAlignment;
        _bodyTextView.bounces = NO;
        _bodyTextView.backgroundColor = [UIColor clearColor];
        _bodyTextView.editable = NO;
    }
    return _bodyTextView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIButton *)cancelButton{
    
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton setTitle:@"确定" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
    
}


- (UIButton *)otherButton{
    
    if (!_otherButton) {
        _otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_otherButton setTitle:@"确定" forState:UIControlStateNormal];
        [_otherButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _otherButton;
    
}

#pragma mark -
#pragma mark block setter

- (void)setCancelBlock:(BBBasicBlock)block
{
    _cancelBlock = [block copy];
}

- (void)setConfirmBlock:(BBBasicBlock)block
{
    _confirmBlock = [block copy];
}

#pragma mark -
#pragma mark button action

- (void)buttonTapped:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    clickedButtonIndex = tag;
    
    if ([_delegate conformsToProtocol:@protocol(BBAlertViewDelegate)]) {
        
        if ([_delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
            
            [_delegate alertView:self willDismissWithButtonIndex:tag];
        }
    }
    
    if (button == self.cancelButton) {
        if (_cancelBlock) {
            _cancelBlock();
        }
        [self dismiss];
    }
    else if (button == self.otherButton)
    {
        if (_confirmBlock) {
            _confirmBlock();
        }
        if (_shouldDismissAfterConfirm) {
            [self dismiss];
        }
    }
    
}

#pragma mark -
#pragma mark lify cycle

- (void)show
{
    if (_visible) {
        return;
    }
    _visible = YES;
    
    [self registerObservers];//添加消息，在设备发生旋转时会有相应的处理
    [self sizeToFitOrientation:NO];
    
    
    //如果栈中没有alertview,就表示maskWindow没有弹出，所以弹出maskWindow
    if (![BBAlertView getStackTopAlertView]) {
        [BBAlertView presentMaskWindow];
    }
    
    //如果有背景图片，添加背景图片
    if (nil != self.backgroundView && ![[gMaskWindow subviews] containsObject:self.backgroundView]) {
        [gMaskWindow addSubview:self.backgroundView];
    }
    //将alertView显示在window上
    [BBAlertView addAlertViewOnMaskWindow:self];
    
    self.alpha = 1.0;
    
    //alertView弹出动画
    [self bounce0Animation];
}

- (void)dismiss
{
    if (!_visible) {
        return;
    }
    _visible = NO;
    
    UIView *__bgView = self->_backgroundView;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissAlertView)];
    self.alpha = 0;
    [UIView commitAnimations];
    
    if (__bgView && [[gMaskWindow subviews] containsObject:__bgView]) {
        [__bgView removeFromSuperview];
    }
}

- (void)dismissAlertView{
    [BBAlertView removeAlertViewFormMaskWindow:self];
    
    // If there are no dialogs visible, dissmiss mask window too.
    if (![BBAlertView getStackTopAlertView]) {
        [BBAlertView dismissMaskWindow];
    }
    
    if (_style != BBAlertViewStyleCustomView) {
        if ([_delegate conformsToProtocol:@protocol(BBAlertViewDelegate)]) {
            if ([_delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
                [_delegate alertView:self didDismissWithButtonIndex:clickedButtonIndex];
            }
        }
    }
    
    [self removeObservers];
}


+ (void)presentMaskWindow{
    
    if (!gMaskWindow) {
        gMaskWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        gMaskWindow.windowLevel = UIWindowLevelStatusBar + 1;
        gMaskWindow.backgroundColor = [UIColor clearColor];
        gMaskWindow.hidden = YES;
        
        // FIXME: window at index 0 is not awalys previous key window.
        gPreviouseKeyWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
        [gMaskWindow makeKeyAndVisible];
        
        // Fade in background 
        gMaskWindow.alpha = 0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        gMaskWindow.alpha = 1;
        [UIView commitAnimations];
    }
}

+ (void)dismissMaskWindow{
    // make previouse window the key again
    if (gMaskWindow) {
        [gPreviouseKeyWindow makeKeyAndVisible];
        gPreviouseKeyWindow = nil;
        
        gMaskWindow = nil;
    }
}

+ (BBAlertView *)getStackTopAlertView{
    BBAlertView *topItem = nil;
    if (0 != [gAlertViewStack count]) {
        topItem = [gAlertViewStack lastObject];
    }
    
    return topItem;
}

+ (void)addAlertViewOnMaskWindow:(BBAlertView *)alertView{
    if (!gMaskWindow ||[gMaskWindow.subviews containsObject:alertView]) {
        return;
    }
    
    [gMaskWindow addSubview:alertView];
    alertView.hidden = NO;
    
    BBAlertView *previousAlertView = [BBAlertView getStackTopAlertView];
    if (previousAlertView) {
        previousAlertView.hidden = YES;
    }
    [BBAlertView pushAlertViewInStack:alertView];
}

+ (void)removeAlertViewFormMaskWindow:(BBAlertView *)alertView{
    if (!gMaskWindow || ![gMaskWindow.subviews containsObject:alertView]) {
        return;
    }
    
    [alertView removeFromSuperview];
    alertView.hidden = YES;
    
    [BBAlertView popAlertViewFromStack];
    BBAlertView *previousAlertView = [BBAlertView getStackTopAlertView];
    if (previousAlertView) {
        previousAlertView.hidden = NO;
        [previousAlertView bounce0Animation];
    }
}

+ (void)pushAlertViewInStack:(BBAlertView *)alertView{
    if (!gAlertViewStack) {
        gAlertViewStack = [[NSMutableArray alloc] init];
    }
    [gAlertViewStack addObject:alertView];
}


+ (void)popAlertViewFromStack{
    if (![gAlertViewStack count]) {
        return;
    }
    [gAlertViewStack removeLastObject];
    
    if ([gAlertViewStack count] == 0) {
        gAlertViewStack = nil;
    }
}


#pragma mark -
#pragma mark animation

- (void)bounce0Animation{
    self.contentView.transform = CGAffineTransformScale([self transformForOrientation], 0.001f, 0.001f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationDidStop)];
    self.contentView.transform = CGAffineTransformScale([self transformForOrientation], 1.1f, 1.1f);
    [UIView commitAnimations];
}

- (void)bounce1AnimationDidStop{  
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationDidStop)];
    self.contentView.transform = CGAffineTransformScale([self transformForOrientation], 0.9f, 0.9f);
    [UIView commitAnimations];
}
- (void)bounce2AnimationDidStop{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceDidStop)];
    self.contentView.transform = [self transformForOrientation];
    [UIView commitAnimations];
}

- (void)bounceDidStop{
    
}

#pragma mark -
#pragma mark tools

+ (CGFloat)heightOfString:(NSString *)message
{
    if (message == nil || [message isEqualToString:@""]) {
        return 20.0f;
    }
    CGSize messageSize = [message sizeWithFont:FONT16
                             constrainedToSize:CGSizeMake(kContentLabelWidth, 1000) 
                                 lineBreakMode:NSLineBreakByCharWrapping];
    
    return messageSize.height+10.0;
}

@end
