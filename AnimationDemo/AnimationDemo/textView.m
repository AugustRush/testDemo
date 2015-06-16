//
//  textView.m
//  AnimationDemo
//
//  Created by August on 15/6/5.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "textView.h"

@interface textView ()<UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic) UIGravityBehavior *gravity;
@property (nonatomic) UICollisionBehavior *collision;

@property (nonatomic) UIAttachmentBehavior *attach1;
@property (nonatomic) UIAttachmentBehavior *attach2;
@property (nonatomic) UIAttachmentBehavior *attach3;
@property (nonatomic) UIAttachmentBehavior *attach4;

@property (nonatomic) CAShapeLayer *shapLayer;

@end

@implementation textView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)awakeFromNib
{
    [self setUp];
}

-(void)setUp
{
    self.shapLayer = [CAShapeLayer layer];
    self.shapLayer.fillColor = [UIColor orangeColor].CGColor;
    self.shapLayer.strokeColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:self.shapLayer];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[self.leftTop,self.rightTop,self.leftBottom,self.rightBottom,self.centerView]];
    [self.animator addBehavior:self.gravity];
    
    self.collision = [[UICollisionBehavior alloc] initWithItems:@[self.leftTop,self.rightTop,self.leftBottom,self.rightBottom,self.centerView]];
    self.collision.collisionDelegate = self;
    self.collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:self.collision];
    
    self.attach1 = [[UIAttachmentBehavior alloc] initWithItem:self.leftTop attachedToItem:self.centerView];
    self.attach2 = [[UIAttachmentBehavior alloc] initWithItem:self.leftBottom attachedToItem:self.centerView];
    self.attach3 = [[UIAttachmentBehavior alloc] initWithItem:self.rightTop attachedToItem:self.centerView];
    self.attach4 = [[UIAttachmentBehavior alloc] initWithItem:self.rightBottom attachedToItem:self.centerView];
    
    
    
    [self.animator addBehavior:self.attach1];
    [self.animator addBehavior:self.attach2];
    [self.animator addBehavior:self.attach3];
    [self.animator addBehavior:self.attach4];
    
    
    UIAttachmentBehavior *attach1 = [[UIAttachmentBehavior alloc] initWithItem:self.leftTop attachedToItem:self.leftBottom];
    UIAttachmentBehavior *attach2 = [[UIAttachmentBehavior alloc] initWithItem:self.leftBottom attachedToItem:self.rightBottom];
    UIAttachmentBehavior *attach3 = [[UIAttachmentBehavior alloc] initWithItem:self.rightBottom attachedToItem:self.rightTop];
    UIAttachmentBehavior *attach4 = [[UIAttachmentBehavior alloc] initWithItem:self.rightTop attachedToItem:self.leftTop];
    

    [self.animator addBehavior:attach1];
    [self.animator addBehavior:attach2];
    [self.animator addBehavior:attach3];
    [self.animator addBehavior:attach4];
    
    UIDynamicItemBehavior *itemBehavior1 = [[UIDynamicItemBehavior alloc] initWithItems:@[self.leftTop]];
    itemBehavior1.elasticity = 0.4; // 改变弹性
    itemBehavior1.allowsRotation = YES; // 允许旋转
    
    [self.animator addBehavior:itemBehavior1];
    
    UIDynamicItemBehavior *itemBehavior2 = [[UIDynamicItemBehavior alloc] initWithItems:@[self.rightTop]];
    itemBehavior2.elasticity = 0.6; // 改变弹性
    itemBehavior2.allowsRotation = YES; // 允许旋转
    
    [self.animator addBehavior:itemBehavior2];
    
    UIDynamicItemBehavior *itemBehavior3 = [[UIDynamicItemBehavior alloc] initWithItems:@[self.leftBottom]];
    itemBehavior3.elasticity = 0.8; // 改变弹性
    itemBehavior3.allowsRotation = YES; // 允许旋转
    
    [self.animator addBehavior:itemBehavior3];
    
    UIDynamicItemBehavior *itemBehavior4 = [[UIDynamicItemBehavior alloc] initWithItems:@[self.rightBottom]];
    itemBehavior4.elasticity = 1; // 改变弹性
    itemBehavior4.allowsRotation = YES; // 允许旋转
    
    [self.animator addBehavior:itemBehavior4];
    
    UIDynamicItemBehavior *itemBehavior5 = [[UIDynamicItemBehavior alloc] initWithItems:@[self.centerView]];
    itemBehavior5.elasticity = 0.2; // 改变弹性
    itemBehavior5.allowsRotation = YES; // 允许旋转
    
    [self.animator addBehavior:itemBehavior5];

    __weak typeof(self) wself = self;
    self.gravity.action = ^{
        UIBezierPath *beizerPath = [UIBezierPath bezierPath];
        [beizerPath moveToPoint:wself.leftTop.center];
        [beizerPath addQuadCurveToPoint:wself.rightTop.center controlPoint:wself.centerView.center];
        [beizerPath addLineToPoint:wself.rightBottom.center];
        [beizerPath addLineToPoint:wself.leftBottom.center];
        [beizerPath closePath];
        
        wself.shapLayer.path = beizerPath.CGPath;
    };
    
}

+(Class)layerClass
{
    return [testLayer class];
}

//-(void)setBackgroundColor:(UIColor *)backgroundColor
//{
//    [super setBackgroundColor:backgroundColor];
//    NSLog(@"view backgoud color is %@",backgroundColor);
//    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"whatColor"];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.fromValue = (id)[UIColor whiteColor].CGColor;
//    animation.toValue = (id)backgroundColor.CGColor;
//    animation.duration = 0.5;
//    [self.layer addAnimation:animation forKey:@"testWhat"];
//}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender {
    
    CGPoint location = [sender locationInView:self];
//    UIOffset offset = UIOffsetMake(location.x - CGRectGetMidX(self.bounds), location.y - CGRectGetMidY(self.bounds));

    
    
    self.gravity.gravityDirection = CGVectorMake((location.x - CGRectGetMidX(self.bounds))/CGRectGetMidX(self.bounds), (location.y-CGRectGetMidY(self.bounds))/CGRectGetMidY(self.bounds));
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:{
            
            break;
        }
            
        case UIGestureRecognizerStateChanged:{
            break;
        }
            
        case UIGestureRecognizerStateEnded:{
            break;
        }
            
        default:
            break;
    }
    
}

@end


@implementation testLayer

@dynamic whatColor;

//+(BOOL)needsDisplayForKey:(NSString *)key
//{
//    if ([key isEqualToString:@"whatColor"]) {
//        return YES;
//    }
//    return [super needsDisplayForKey:key];
//}
//
//-(void)display
//{
//    [super display];
//    NSLog(@"display what value is %@",[[self presentationLayer] valueForKey:@"whatColor"]);
//}
//

@end