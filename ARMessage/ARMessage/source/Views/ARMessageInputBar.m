//
//  ARMessageInputBar.m
//  Mindssage
//
//  Created by August on 14/10/31.
//
//

#import "ARMessageInputBar.h"
#import "ARMessageUIConfigs.h"
#import "UIView+autolayout.h"

void *ARMessageTextViewContentSizeChangedContext = &ARMessageTextViewContentSizeChangedContext;

@implementation ARMessageInputBar
{
    NSLayoutConstraint *_textHeightConstraint;
}

#pragma mark - init method

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self buildSubViews];
        [self configSubviewsLayoutConstrinsts];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self buildSubViews];
        [self configSubviewsLayoutConstrinsts];
    }
    return self;
}

-(CGSize)intrinsicContentSize
{
    return CGSizeMake(320, 45);
}

#pragma mark - private methdos

-(void)buildSubViews
{
    self.backgroundColor = ARRGB(248, 248, 248);
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.maxNumberOfLines = 6;
    
    self.userInteractionEnabled = YES;
    self.textView = [[ARTextView alloc] init];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderColor = ARRGB(208, 208, 208).CGColor;
    self.textView.font = [UIFont systemFontOfSize:15.0];
    self.textView.delegate = self;
    self.textView.keyboardAppearance = UIKeyboardAppearanceLight;
    self.textView.keyboardType = UIKeyboardTypeDefault;
    self.textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.textView.returnKeyType = UIReturnKeySend;
//    self.textView.placeHolder = NSLocalizedString(@"Message", nil);
    self.textView.placeHolderTextColor = ARRGB(208, 208, 208);
    [self addSubview:self.textView];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.backgroundColor = [UIColor clearColor];
    [self.addButton setImageEdgeInsets:UIEdgeInsetsMake(10, 11, 10, 11)];
    [self.addButton setImage:[UIImage imageNamed:@"camera_icon_input_bar"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addButton];
    
    //observer size changed
    [self.textView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) options:NSKeyValueObservingOptionNew context:ARMessageTextViewContentSizeChangedContext];
    
}

-(void)configSubviewsLayoutConstrinsts
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.addButton pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeRight inset:0];
    [self.addButton pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeBottom inset:0];
    [self.addButton addConstraint:[NSLayoutConstraint constraintWithItem:self.addButton
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:0
                                                              multiplier:1
                                                                constant:44]];
    
    [self.addButton addConstraint:[NSLayoutConstraint constraintWithItem:self.addButton
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:0
                                                              multiplier:1
                                                                constant:44]];
    
    [self.textView pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeLeft inset:8];
    [self.textView pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeTop inset:7];
    [self.textView pinchToSuperViewEdgeWithEdgeType:NSLayoutAttributeBottom inset:-7];
    
    _textHeightConstraint = [NSLayoutConstraint constraintWithItem:self.textView
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:0
                                                        multiplier:1
                                                          constant:30];
    
    [self.textView addConstraint:_textHeightConstraint];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.textView
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.addButton
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:0]];
    
}

#pragma mark - observe methods

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"change is %@",change);
    if (context == ARMessageTextViewContentSizeChangedContext) {
        CGSize contentSize = [change[NSKeyValueChangeNewKey] CGSizeValue];
        if (self.textView.numberOfLines <= self.maxNumberOfLines) {
            _textHeightConstraint.constant = contentSize.height;
            [self.superview setNeedsLayout];
            [UIView animateWithDuration:0.2
                             animations:^{
                                 [self.superview layoutIfNeeded];
                             }];
        }
    }
}

#pragma mark - custom event methods

-(void)addButtonClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(ar_MessageInputBar:didTriggerRightButton:)]) {
        [self.delegate ar_MessageInputBar:self didTriggerRightButton:button];
    }
}

#pragma mark - UITextFiledDelegate methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if ([self.delegate respondsToSelector:@selector(ar_MessageInputBar:didSendText:)] && [self.textView hasText]) {
            [self.delegate ar_MessageInputBar:self didSendText:self.textView.text];
        }
        self.textView.text = nil;
        return NO;
    }
    return YES;
}

-(void)dealloc
{
    [self.textView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize))];
}

@end


NSString * const ARMessageInputKeyBoardFrameChangedNotification = @"_ARMessageInputKeyBoardFrameChangedNotification";

@implementation ARMessageInputAccessoryView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (self.superview) {
        [self.superview removeObserver:self forKeyPath:NSStringFromSelector(@selector(center))];
    }
    
    [newSuperview addObserver:self forKeyPath:NSStringFromSelector(@selector(center)) options:0 context:NULL];
    
    [super willMoveToSuperview:newSuperview];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isEqual:self.superview] && [keyPath isEqualToString:NSStringFromSelector(@selector(center))])
    {
        NSDictionary *userInfo = @{UIKeyboardFrameEndUserInfoKey:[NSValue valueWithCGRect:[object frame]]};
        [[NSNotificationCenter defaultCenter] postNotificationName:ARMessageInputKeyBoardFrameChangedNotification object:nil userInfo:userInfo];
    }
}

- (void)dealloc
{
    if (self.superview) {
        [self.superview removeObserver:self forKeyPath:NSStringFromSelector(@selector(center))];
    }
}

@end
