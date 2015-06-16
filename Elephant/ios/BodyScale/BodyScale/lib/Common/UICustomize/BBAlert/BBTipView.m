//
//  BBTipView.m
//  FFLtd
//
//  Created by 两元鱼 on 12-7-28.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "BBTipView.h"

@interface BBTipView(){
    BOOL __hasLogo;
    
    CGFloat  __messageFont;
    CGFloat  __tipViewWidth;
    
}

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *fatherView;
@property (nonatomic, strong) NSTimer *dlgTimer;
@property (nonatomic, strong) NSString *labelText;
@property (nonatomic, strong) UIImage  *logoImage;
@end

/*********************************************************************/

@implementation BBTipView
@synthesize label = _label;
@synthesize fatherView = _fatherView;
@synthesize dlgTimer = _dlgTimer;
@synthesize labelText = _labelText;
@synthesize showTime = _showTime;
@synthesize dimBackground = _dimBackground;

- (void)dealloc
{
}

#pragma mark -
#pragma mark tools

- (CGFloat)heightWithMessage:(NSString *)message{
    
    CGSize messageSize = [message sizeWithFont:FONT16
                             constrainedToSize:CGSizeMake(__tipViewWidth-20, 1000)
                                 lineBreakMode:NSLineBreakByCharWrapping];
    
    return messageSize.height+10.0;
    
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) { // 1
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context); // 2
    CGContextTranslateCTM (context, CGRectGetMinX(rect), // 3
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight); // 4
    fw = CGRectGetWidth (rect) / ovalWidth; // 5
    fh = CGRectGetHeight (rect) / ovalHeight; // 6
    CGContextMoveToPoint(context, fw, fh/2); // 7
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1); // 8
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // 9
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // 10
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // 11
    CGContextClosePath(context); // 12
    CGContextRestoreGState(context); // 13
}

- (id)initWithView:(UIView *)view message:(NSString *)message posY:(CGFloat)posY
{
    self = [super initWithFrame:view.bounds];
    if (self) {
        self.fatherView = view;
        self.labelText = message;
        _posY = posY;
        _dimBackground = YES;
        __hasLogo = NO;
        __tipViewWidth = 260;
        __messageFont = 16;
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat contentHeight = [self heightWithMessage:message];
        int textlineNumber = (int)((contentHeight-10.0)/20.0);
        switch (textlineNumber) {
            case 1:
                _showTime = 3.0f;
                break;
            case 2:
                _showTime = 5.0f;
                break;
            case 3:
                _showTime = 8.0f;
                break;
            case 4:
                _showTime = 12.0f;
                break;
            default:
                _showTime = 20.0f;
                break;
        }
    }
    return self;
}

- (id)initWithView:(UIView *)view message:(NSString *)message
          logoView:(UIImage *)logoImage posY:(CGFloat)posY{

    self = [self initWithView:view message:message posY:posY];
    if (self) {
        self.logoImage = logoImage;
        __hasLogo = YES;
        __tipViewWidth = 180;
        __messageFont = 16;
        
    }
    return self;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.numberOfLines = 0;
        _label.lineBreakMode = NSLineBreakByCharWrapping;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont boldSystemFontOfSize:__messageFont];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (void)show 
{
    [self.fatherView addSubview:self];
    self.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.alpha = 1;
    [UIView commitAnimations];
    
    self.dlgTimer = [NSTimer scheduledTimerWithTimeInterval:_showTime
                                                     target:self 
                                                   selector:@selector(dismiss)
                                                   userInfo:nil 
                                                    repeats:NO];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.2f
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         TT_INVALIDATE_TIMER(_dlgTimer);
                         [self removeFromSuperview];
                     }];
}

- (void)dismiss:(BOOL)animation
{
    if (animation) {
        [UIView animateWithDuration:0.2f
                         animations:^{
                             self.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             TT_INVALIDATE_TIMER(_dlgTimer);
                             [self removeFromSuperview];
                         }];
    }else{
        [_dlgTimer invalidate];
        [self removeFromSuperview];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat labelHeight = [self heightWithMessage:_labelText];
    if (!__hasLogo) {
        if (labelHeight < 90) {
            labelHeight = 90;
        }
    }
    CGFloat viewHeight = labelHeight;
    if (__hasLogo) {
        viewHeight = labelHeight + 57.5 + 15;
    }
    
    if (_dimBackground) {
        
        size_t gradLocationsNum = 2;
        CGFloat gradLocations[2] = {0.0f, 1.0f};
        CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.6f}; 
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
        CGColorSpaceRelease(colorSpace);
        
        //Gradient center
        CGPoint gradCenter = CGPointMake(160,  _posY+(viewHeight+10)/2);
        //Gradient radius
        //float gradRadius =  (self.bounds.size.height-_posY)*2;
        float gradRadius = 350;
        //Gradient draw
        CGContextDrawRadialGradient (context, gradient, gradCenter,
                                     0, gradCenter, gradRadius,
                                     kCGGradientDrawsAfterEndLocation);
        CGGradientRelease(gradient);
    }
        
    addRoundedRectToPath(context, CGRectMake((320 - __tipViewWidth)/2,
                                             _posY, __tipViewWidth, viewHeight+10.0f),
                         6.0f, 6.0f);
    CGFloat color[4] = {0, 0, 0, 0.6f};
    CGContextSetFillColor(context, color);
    CGContextFillPath(context);
    
      
    UIImageView *bgImView = [[UIImageView alloc] init];
    bgImView.frame = CGRectMake((320 - __tipViewWidth)/2, _posY+5, __tipViewWidth, viewHeight);
    bgImView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgImView];
        
    UIImageView *logoView = nil;
    if (__hasLogo) {
        logoView = [[UIImageView alloc] initWithImage:self.logoImage];
        logoView.frame = CGRectMake((bgImView.frame.size.width - 35)/2, 15, 35, 35);
        [bgImView addSubview:logoView];
    }
    //background image view
    if (__hasLogo) {
        self.label.frame = CGRectMake(10, logoView.frame.size.width+10, bgImView.frame.size.width - 20, labelHeight);
    }else{
        self.label.frame = CGRectMake(10,0, bgImView.frame.size.width - 20, labelHeight);
    }
    self.label.text = _labelText;
    [bgImView addSubview:self.label];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
@end
