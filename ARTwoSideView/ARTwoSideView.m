//
//  ARTwoSideView.m
//  Mindssage
//
//  Created by August on 14-9-8.
//
//

#import "ARTwoSideView.h"

@implementation ARTwoSideView

#pragma mark - init methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(void)initConfigs
{
    self.pauseDuration = 2;
    self.animationDuration = .5;
    _isPrimary = YES;
    self.userInteractionEnabled = YES;
}

-(void)setPrimaryView:(UIView *)primaryView
{
    _primaryView = primaryView;
    [self addSubview:_primaryView];
}

-(void)setSecondaryView:(UIView *)secondaryView
{
    _secondaryView = secondaryView;
    [self addSubview:_secondaryView];
    [self sendSubviewToBack:_secondaryView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.primaryView.frame = self.bounds;
    self.secondaryView.frame = self.bounds;
}

#pragma mark - private methods

-(void)startRotaion
{
    [UIView transitionFromView:_isPrimary?self.primaryView:self.secondaryView
                        toView:_isPrimary?self.secondaryView:self.primaryView
                      duration:self.animationDuration
                       options:UIViewAnimationOptionTransitionFlipFromTop+UIViewAnimationOptionCurveEaseInOut
                    completion:^(BOOL finished) {
                        _isPrimary = !_isPrimary;
                        [self performSelector:@selector(startRotaion) withObject:nil afterDelay:self.pauseDuration];
    }];
}

@end
