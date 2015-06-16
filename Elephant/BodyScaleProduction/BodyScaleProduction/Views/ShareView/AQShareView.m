//
//  AQShareView.m
//  AQShareSDK
//
//  Created by Zhanghao on 4/16/14.
//  Copyright (c) 2014 Zhanghao. All rights reserved.
//

#import "AQShareView.h"

@implementation AQShareObj

- (instancetype)initWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage title:(NSString *)title {
    self = [super init];
    if (self) {
        self.normalImage = normalImage;
        self.highlightImage = highlightImage;
        self.title = title;
    }
    return self;
}

@end

CGFloat const kAnimationDuration = 0.25;        // 动画持续时间
CGFloat const kImageViewWidth = 57;             // 分享按钮宽度
CGFloat const kImageViewColumnPadding = 17.3;   // 两个按钮之间的间距
CGFloat const kImageViewRowPadding = 10;        // 两行按钮之间的间距
CGFloat const kTitleLabelTopPadding = 10;       // 顶部到标题栏之间的间距
CGFloat const kTitleLabelHeight = 26;           // 标题栏高度
CGFloat const kCancelButtonHeight = 44;         // 取消按钮高度
CGFloat const kCancelButtonTopPadding = 10;     // 取消按钮到分享按钮之间的间距
CGFloat const kCancelButtonBottomPadding = 20;  // 底部到取消按钮之间的间距

@implementation AQShareView {
    UIView *contentView;
    CGFloat contentViewHeight;  // 动态调整contentView高度
}

#pragma mark - 一级初始化方法

+ (instancetype)showWithTitle:(NSString *)title delegate:(id<AQShareViewDelegate>)delegate sharedObj:(NSArray *)sharedObj {
    AQShareView *shareView = [[self alloc] initWithTitle:title sharedObj:sharedObj];
    shareView.delegate = delegate;
    [shareView show];
    return shareView;
}

- (instancetype)initWithTitle:(NSString *)title sharedObj:(NSArray *)sharedObj {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setUp];
        [self createTitleLabelWithTitle:title];
        [self createShareButtonsWithShareObj:sharedObj];
        [self createCancelButton];
    }
    return self;
}

#pragma mark - 二级初始化方法

- (id)initWithFrame:(CGRect)frame {
    return [self initWithTitle:nil sharedObj:nil];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithTitle:nil sharedObj:nil];
}

#pragma mark - 公共接口

- (void)show {
    if (!self.superview) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    }
    [UIView animateWithDuration:kAnimationDuration animations:^{
        contentView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - contentViewHeight, CGRectGetWidth([UIScreen mainScreen].bounds), contentViewHeight);
    } completion:NULL];
}

#pragma mark - 私有方法

- (void)setUp {
    self.frame = [UIScreen mainScreen].bounds;
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissShareView)];
    [self addGestureRecognizer:tap];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), 0)];
    contentView.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    [self addSubview:contentView];
}

- (void)createTitleLabelWithTitle:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleLabelTopPadding, CGRectGetWidth(self.bounds), kTitleLabelHeight)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [contentView addSubview:titleLabel];
}

- (void)createShareButtonsWithShareObj:(NSArray *)shareObj {
    CGFloat labelHeight = kTitleLabelTopPadding * 2 + kTitleLabelHeight;
    for (int i = 0; i < [shareObj count]; i++) {
        AQShareObj *share = shareObj[i];
        
        NSInteger column = i % 4;
        NSInteger row = i / 4;
        CGFloat x = 20 + column * (kImageViewWidth + kImageViewColumnPadding);
        CGFloat y = labelHeight + row * (kImageViewWidth + kTitleLabelHeight + kImageViewRowPadding);
        
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.frame = CGRectMake(x, y, kImageViewWidth, kImageViewWidth);
        shareButton.backgroundColor = [UIColor clearColor];
        shareButton.tag = i;
        
        if (share.normalImage) {
            [shareButton setImage:share.normalImage forState:UIControlStateNormal];
        }
        if (share.highlightImage) {
            [shareButton setImage:share.highlightImage forState:UIControlStateHighlighted];
        }
        [shareButton addTarget:self action:@selector(shareButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:shareButton];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(x, y + kImageViewWidth, kImageViewWidth, kTitleLabelHeight)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0f];
        lbl.font = [UIFont systemFontOfSize:14];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.text = share.title;
        [contentView addSubview:lbl];
    }
    NSInteger row = [shareObj count] / 5 + 1;
    CGFloat buttonHeight = (kImageViewWidth + kTitleLabelHeight) * row + kImageViewRowPadding * (row - 1);
    CGFloat cancelButtonHeight = kCancelButtonBottomPadding + kCancelButtonTopPadding + kCancelButtonHeight;
    contentViewHeight = labelHeight + buttonHeight + cancelButtonHeight;
}

// 是否使用图片
#define CANCEL_CUSTOM_BUTTON 0

- (void)createCancelButton {
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(20, contentViewHeight - kCancelButtonBottomPadding - kCancelButtonHeight, 280, kCancelButtonHeight);
#if CANCEL_CUSTOM_BUTTON
    [cancelButton setBackgroundColor:[UIColor whiteColor]];
    [cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
    [[cancelButton titleLabel] setFont:[UIFont boldSystemFontOfSize:20]];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
#else
    [cancelButton setImage:[UIImage imageNamed:@"shareButtonCancel"] forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:@"shareButtonCancelClick"] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
#endif
    [contentView addSubview:cancelButton];
}

#pragma mark - 响应事件

- (void)dismissShareView {
    if ([self.delegate respondsToSelector:@selector(shareViewWillDismiss:)]) {
        [self.delegate shareViewWillDismiss:self];
    }
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        contentView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), 0);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            if ([self.delegate respondsToSelector:@selector(shareViewDidDismiss:)]) {
                [self.delegate shareViewDidDismiss:self];
            }
            [self removeFromSuperview];
        }
    }];
}

- (void)cancelButtonTapped:(UIButton *)button {
    [self dismissShareView];
}

- (void)shareButtonTapped:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(shareButtonTappedAtIndex:)]) {
        [self.delegate shareButtonTappedAtIndex:button.tag];
    }
    [self dismissShareView];
}

@end
