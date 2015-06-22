//
//  UIScrollView+ARRefresh.m
//  ARRefreshDemo
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "UIScrollView+ARRefresh.h"
#import "ARDefaultRefreshView.h"

@interface ARRefreshInfoModel : NSObject

@property (nonatomic, weak) UIView *refreshView;
@property (nonatomic, assign) UIEdgeInsets originalInset;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) ARRefreshState refreshState;
@property (nonatomic, weak) NSLayoutConstraint * infinityScollTopConstraint;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, copy) void(^refreshTrigger)(UIScrollView *scrollView);

@end

@implementation ARRefreshInfoModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self addObserver:self forKeyPath:@"refreshState" options:NSKeyValueObservingOptionNew context:NULL];
        self.refreshState = ARRefreshStateNone;
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    ARRefreshState state = [change[NSKeyValueChangeNewKey] integerValue];
    switch (state) {
        case ARRefreshStateNone: {
            self.enabled = YES;
            break;
        }
        case ARRefreshStateDoing: {
            self.enabled = NO;
            break;
        }
        case ARRefreshStateEnd: {
            self.enabled = YES;
            break;
        }
        default: {
            break;
        }
    }
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"refreshState"];
}

@end

void *ARRefreshScrollContentOffsetObseverContext = &ARRefreshScrollContentOffsetObseverContext;
void *ARRefreshScrollContentSizeObserverContext = &ARRefreshScrollContentSizeObserverContext;
void *ARInfinityScrollContentOffsetObserverContext = &ARInfinityScrollContentOffsetObserverContext;

NSString *const ARRefreshInfoModelKey = @"ARRefreshInfoModelKey";
NSString *const ARInfinityInfoModelKey = @"ARInfinityInfoModelKey";

@implementation UIScrollView (ARRefresh)

#pragma mark - public methods

-(void)ar_addRefreshHeaderWithTrigger:(void (^)(UIScrollView *))trigger
{
    ARDefaultRefreshView *refreshView = [[ARDefaultRefreshView alloc] init];
    [self addSubview:refreshView];
    
    //init value
    ARRefreshInfoModel *headerValue = [[ARRefreshInfoModel alloc] init];
    CGFloat refreshHeaderHeight = 60;
    headerValue.headerHeight = refreshHeaderHeight;
    headerValue.originalInset = self.contentInset;
    headerValue.refreshView = refreshView;
    headerValue.refreshTrigger = trigger;
    [self.layer setValue:headerValue forKey:ARRefreshInfoModelKey];
    //constrants
    refreshView.translatesAutoresizingMaskIntoConstraints = NO;
    [refreshView addConstraint:[NSLayoutConstraint constraintWithItem:refreshView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:0
                                                          multiplier:1
                                                             constant:refreshHeaderHeight]];
    [self addConstraintForView:refreshView attribute:NSLayoutAttributeWidth constant:0];
    [self addConstraintForView:refreshView attribute:NSLayoutAttributeLeft constant:0];
    [self addConstraintForView:refreshView attribute:NSLayoutAttributeTop constant:refreshHeaderHeight];
    [self addConstraintForView:refreshView attribute:NSLayoutAttributeRight constant:0];
    
    //observer
    
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew context:ARRefreshScrollContentOffsetObseverContext];
}

-(void)ar_endRefresh
{
    ARRefreshInfoModel *headerValue = [self.layer valueForKey:ARRefreshInfoModelKey];
    [self setRefreshState:ARRefreshStateEnd withHeaderValue:headerValue];
}

-(void)ar_addInfinityScrollWithTrigger:(void (^)(UIScrollView *))trigger
{
    ARDefaultRefreshView *infinityView = [[ARDefaultRefreshView alloc] init];
    [self addSubview:infinityView];
    
    //constraints
    infinityView.translatesAutoresizingMaskIntoConstraints = NO;
    [infinityView addConstraint:[NSLayoutConstraint constraintWithItem:infinityView
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:0
                                                           multiplier:1
                                                             constant:60]];
    [self addConstraintForView:infinityView attribute:NSLayoutAttributeWidth constant:0];
    [self addConstraintForView:infinityView attribute:NSLayoutAttributeLeft constant:0];
    [self addConstraintForView:infinityView attribute:NSLayoutAttributeRight constant:0];
    
    CGFloat bottom = [self bottom];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:infinityView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:-bottom];
    [self addConstraint:topConstraint];
    
    //init value
    ARRefreshInfoModel *infinityModel = [[ARRefreshInfoModel alloc] init];
    infinityModel.refreshView = infinityView;
    infinityModel.headerHeight = 60;
    infinityModel.originalInset = self.contentInset;
    infinityModel.refreshTrigger = trigger;
    infinityModel.infinityScollTopConstraint = topConstraint;
    [self.layer setValue:infinityModel forKey:ARInfinityInfoModelKey];
    
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew context:ARInfinityScrollContentOffsetObserverContext];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) options:NSKeyValueObservingOptionNew context:ARRefreshScrollContentSizeObserverContext];
}

-(void)ar_endInfinityScroll
{
    ARRefreshInfoModel *infinityModel = [self.layer valueForKey:ARInfinityInfoModelKey];
    [self setInfinityScrollState:ARRefreshStateEnd withInfinityValue:infinityModel];
}

#pragma mark - observer methods

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == ARRefreshScrollContentOffsetObseverContext) {
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        ARRefreshInfoModel *headerValue = [self.layer valueForKey:ARRefreshInfoModelKey];
        CGFloat headerHeight = headerValue.headerHeight;
        UIEdgeInsets originalInset = headerValue.originalInset;
        CGFloat threshold = offset.y + originalInset.top;
        //refresh header
        if (threshold < 0 && headerValue.enabled) {
            CGFloat progress = fabs(threshold/headerHeight);
            if (progress > 1) {
                progress = 1;
            }
            if ([headerValue.refreshView respondsToSelector:@selector(scrollView:didChangeProgress:)]) {
                [((id)headerValue.refreshView) scrollView:self didChangeProgress:progress];
            }
            
            if (threshold < -headerHeight && !self.isTracking) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setRefreshState:ARRefreshStateDoing withHeaderValue:headerValue];
                });
            }
        }
    }else if (context == ARRefreshScrollContentSizeObserverContext){
        //update infinity scroll layout
        CGFloat bottom = [self bottom];
        ARRefreshInfoModel *infinityModel = [self.layer valueForKey:ARInfinityInfoModelKey];
        NSLayoutConstraint *topConstraint = infinityModel.infinityScollTopConstraint;
        topConstraint.constant = -bottom;

    }else if (context == ARInfinityScrollContentOffsetObserverContext){
        //infinity scroll
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        ARRefreshInfoModel *infinityModel = [self.layer valueForKey:ARInfinityInfoModelKey];
        CGFloat headerHeight = infinityModel.headerHeight;
        CGFloat threshold = offset.y + CGRectGetHeight(self.bounds) - [self bottom];
        if (threshold > 0 && infinityModel.enabled) {
            if (threshold > headerHeight && !self.isTracking) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setInfinityScrollState:ARRefreshStateDoing withInfinityValue:infinityModel];
                });
            }
            
        }
    }
}

#pragma mark - private methods

-(void)setRefreshState:(ARRefreshState)refreshState withHeaderValue:(ARRefreshInfoModel *)headerValue
{
    if (headerValue.refreshState != refreshState) {
        
        headerValue.refreshState = refreshState;
        [self.layer setValue:headerValue forKey:ARRefreshInfoModelKey];
        
        CGFloat headerHeight = headerValue.headerHeight;
        UIEdgeInsets originalInset = headerValue.originalInset;
        switch (refreshState) {
            case ARRefreshStateNone: {
                
                break;
            }
            case ARRefreshStateDoing: {
                originalInset.top += headerHeight;
                [UIView animateWithDuration:0.4
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self setContentInset:originalInset];
                                     [self setContentOffset:CGPointMake(0, -originalInset.top) animated:NO];
                                 } completion:^(BOOL finished) {
                                     if (headerValue.refreshTrigger) {
                                         headerValue.refreshTrigger(self);
                                     }
                                     
                                     if ([headerValue.refreshView respondsToSelector:@selector(scrollView:didChangeState:)]) {
                                         [((id)headerValue.refreshView) scrollView:self didChangeState:ARRefreshStateDoing];
                                     }
                                 }];
                break;
            }
            case ARRefreshStateEnd: {
                [UIView animateWithDuration:0.4
                                      delay:0.3
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self setContentInset:originalInset];
                                 } completion:^(BOOL finished) {
                                     if ([headerValue.refreshView respondsToSelector:@selector(scrollView:didChangeState:)]) {
                                         [((id)headerValue.refreshView) scrollView:self didChangeState:ARRefreshStateEnd];
                                     }
                                 }];
                break;
            }
            default: {
                break;
            }
        }
    }
    
}

-(void)setInfinityScrollState:(ARRefreshState)state withInfinityValue:(ARRefreshInfoModel *)infinityValue
{
    if (infinityValue.refreshState != state) {
        infinityValue.refreshState = state;
        [self.layer setValue:infinityValue forKey:ARInfinityInfoModelKey];
        
        CGFloat headerHeight = infinityValue.headerHeight;
        UIEdgeInsets originalInset = infinityValue.originalInset;
        switch (state) {
            case ARRefreshStateNone: {
                
                break;
            }
            case ARRefreshStateDoing: {
                originalInset.bottom += headerHeight;
                [UIView animateWithDuration:0.4
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self setContentInset:originalInset];
                                 } completion:^(BOOL finished) {
                                     if (infinityValue.refreshTrigger) {
                                         infinityValue.refreshTrigger(self);
                                     }
                                     
                                     if ([infinityValue.refreshView respondsToSelector:@selector(scrollView:didChangeState:)]) {
                                         [((id)infinityValue.refreshView) scrollView:self didChangeState:ARRefreshStateDoing];
                                     }
                                 }];

                break;
            }
            case ARRefreshStateEnd: {
                [UIView animateWithDuration:0.4
                                      delay:0.3
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [self setContentInset:originalInset];
                                 } completion:^(BOOL finished) {
                                     if ([infinityValue.refreshView respondsToSelector:@selector(scrollView:didChangeState:)]) {
                                         [((id)infinityValue.refreshView) scrollView:self didChangeState:ARRefreshStateEnd];
                                     }
                                 }];
                break;
            }
            default: {
                break;
            }
        }
    }
}

-(CGFloat)bottom
{
    return MAX(self.contentSize.height, self.bounds.size.height);
}

#pragma mark - constrants methods

-(void)addConstraintForView:(UIView *)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:attribute
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:attribute
                                                    multiplier:1
                                                      constant:constant]];
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) context:ARRefreshScrollContentOffsetObseverContext];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) context:ARRefreshScrollContentSizeObserverContext];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) context:ARInfinityScrollContentOffsetObserverContext];
}

@end
