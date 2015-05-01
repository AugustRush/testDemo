//
//  AvartarImageView.m
//  Mindssage
//
//  Created by August on 14/10/31.
//
//

#import "ARMessageAvatar.h"

@implementation ARMessageAvatar
{
    CAShapeLayer *_maskLayer;
    CAShapeLayer *_borderLayer;
}

#pragma mark - init methods

-(instancetype)init
{
    self = [super init];
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
    self.userInteractionEnabled = YES;
    
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.drawsAsynchronously = YES;
    _maskLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer setMask:_maskLayer];
    
    _borderLayer = [CAShapeLayer layer];
    _borderLayer.drawsAsynchronously = YES;
    _borderLayer.strokeColor = [UIColor whiteColor].CGColor;
    _borderLayer.lineWidth = 3;
    _borderLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_borderLayer];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.target respondsToSelector:self.action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector:self.action withObject:self];
#pragma clang diagnostic pop
    }else{
        [super touchesEnded:touches withEvent:event];
    }
}

#pragma mark - private methdos

-(void)layoutSubviews
{
    [super layoutSubviews];
    _maskLayer.path  = [[UIBezierPath bezierPathWithOvalInRect:self.bounds] CGPath];
    _borderLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    _cornerRadius = CGRectGetHeight(self.bounds)/2;
}

-(void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    _borderLayer.lineWidth = borderWidth;
}

-(void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    _borderLayer.strokeColor = borderColor.CGColor;
}

#pragma mark - public methods

-(void)addTarget:(id)target withAction:(SEL)action
{
    self.target = target;
    self.action = action;
}

@end
