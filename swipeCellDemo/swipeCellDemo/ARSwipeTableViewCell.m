//
//  ARSwipeTableViewCell.m
//  swipeCellDemo
//
//  Created by August on 14-8-20.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ARSwipeTableViewCell.h"

typedef NS_ENUM(NSUInteger, _cellSwipeState) {
    _cellSwipeStateClosed = 0,
    _cellSwipeStateOpened,
};

typedef NS_ENUM(NSUInteger, _cellSwipeType) {
    _cellSwipeTypeLeft,
    _cellSwipeTypeRight,
    _cellSwipeTypeUnknow,
};

@interface ARSwipeTableViewCell ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) _cellSwipeState swipeState;
@property (nonatomic, assign) _cellSwipeType swipType;

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) NSArray *leftItems;
@property (nonatomic, strong) NSArray *rightItems;

@property (nonatomic, weak) UIPanGestureRecognizer *swipePangesture;

@end

@implementation ARSwipeTableViewCell

#pragma mark - init/config methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initConfigs];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initConfigs];
}

#pragma mark - private methods

-(void)setDataSource:(id<ARSwipeTableViewCellDataSource>)dataSource
{
    _dataSource = dataSource;
    NSAssert(_dataSource != nil, @"swipeCell dataSource should not be nil");
    if ([_dataSource respondsToSelector:@selector(leftItemsForSwipeCell:)]
        && _leftItems == nil) {
        self.leftItems = [_dataSource leftItemsForSwipeCell:self];
    }
    
    if ([_dataSource respondsToSelector:@selector(rightItemsForSwipeCell:)]
        && _rightItems == nil) {
        self.rightItems = [_dataSource rightItemsForSwipeCell:self];
    }

}

-(void)initConfigs
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.animationDuration = 0.3;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeMenuView) name:UITableViewSelectionDidChangeNotification object:nil];
    
    self.swipType = _cellSwipeTypeUnknow;
    self.swipeState = _cellSwipeStateClosed;
    self.menuItemWidth = 60;
    self.menuView = [[UIView alloc] init];
    self.menuView.backgroundColor = [UIColor clearColor];
    self.menuView.hidden = YES;
    [self insertSubview:self.menuView atIndex:0];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delaysTouchesBegan = YES;
    panGesture.delaysTouchesEnded = YES;
    panGesture.delegate = self;
    [self.contentView addGestureRecognizer:panGesture];
    self.swipePangesture = panGesture;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self configMenuBaseFrame];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //如果菜单没有显示，调用super事件，直接返回
    if (self.swipeState != _cellSwipeStateOpened) {
        [super touchesEnded:touches withEvent:event];
        return;
    }
    
    //如果菜单显示，触发菜单的方法
    __block BOOL didTrggerItem = NO;
    
    UITouch *touch = [touches anyObject];
    CGPoint touchP = [touch locationInView:self];
    
    [self.rightItems enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(view.frame, touchP)
            && _delegate
            && [_delegate respondsToSelector:@selector(swipeCell:didTriggerRightItemWithIndex:)]) {
            [_delegate swipeCell:self didTriggerRightItemWithIndex:idx];
            didTrggerItem = YES;
        }
    }];
    
    [self.leftItems enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(view.frame, touchP)
            && _delegate
            && [_delegate respondsToSelector:@selector(swipeCell:didTriggerLeftItemWithIndex:)]) {
            [_delegate swipeCell:self didTriggerLeftItemWithIndex:idx];
            didTrggerItem = YES;
        }
    }];
    
    if (didTrggerItem) {
        [self closeMenuView];
    }else{
        [super touchesEnded:touches withEvent:event];
    }
}

#pragma mark - private methods

-(void)configMenuBaseFrame
{
    self.menuView.frame = self.contentView.bounds;
    CGFloat width = CGRectGetWidth(self.menuView.bounds);
    CGFloat height = CGRectGetHeight(self.menuView.bounds)-.5;
    
    [self.leftItems enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        view.frame = CGRectMake(_menuItemWidth*idx, 0, _menuItemWidth, height);
        view.userInteractionEnabled = YES;
        [_menuView addSubview:view];
    }];
    
    [self.rightItems enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        view.frame = CGRectMake(width-_menuItemWidth*(idx+1), 0, _menuItemWidth, height);
        view.userInteractionEnabled = YES;
        [_menuView addSubview:view];
    }];
}

-(void)openMenuView
{
    if (self.swipeState == _cellSwipeStateOpened) {
        return;
    }

    CGRect openFrame ;
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat height = CGRectGetHeight(self.contentView.bounds);
    switch (_swipType) {
        case _cellSwipeTypeLeft:
            openFrame = CGRectMake(-(_rightItems.count*_menuItemWidth), 0, width, height);
            break;
        case _cellSwipeTypeRight:
            openFrame = CGRectMake(_leftItems.count*_menuItemWidth, 0, width, height);
            break;
        case _cellSwipeTypeUnknow:
        default:
            openFrame = CGRectMake(0, 0, width, height);
            break;
    }
    
    [UIView animateWithDuration:_animationDuration
                     animations:^{
                         self.contentView.frame = openFrame;
    } completion:^(BOOL finished) {
        self.swipeState = _cellSwipeStateOpened;
    }];
}

-(void)closeMenuView
{
    if (self.swipeState == _cellSwipeStateClosed) {
        return;
    }
    [UIView animateWithDuration:_animationDuration
                     animations:^{
                         self.contentView.frame = self.bounds;
                     } completion:^(BOOL finished) {
                             self.swipeState = _cellSwipeStateClosed;
                    }];
}

-(void)handlePanGesture:(UIPanGestureRecognizer *)pan
{
    //发送通知关闭菜单试图
    [[NSNotificationCenter defaultCenter] postNotificationName:UITableViewSelectionDidChangeNotification object:nil];
    
    CGPoint movePoint = [pan translationInView:self];
    CGRect frame = self.contentView.frame;
    
    //scroll tableView
    if (fabsf(movePoint.x) < fabsf(movePoint.y)) {
        return;
    }
    
    //swipe cell
    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
        {
            frame.origin.x = movePoint.x;
            NSInteger itemCount = movePoint.x > 0 ? _leftItems.count:_rightItems.count;
           if(fabsf(movePoint.x)-itemCount*_menuItemWidth < 30 ){
               self.contentView.frame = frame;
           }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            self.swipType = movePoint.x > 0 ? _cellSwipeTypeRight:_cellSwipeTypeLeft;
            switch (_swipeState) {
                case _cellSwipeStateClosed:
                {
                    [self openMenuView];
                }
                    break;
                case _cellSwipeStateOpened:
                {
                    [self closeMenuView];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case UIGestureRecognizerStateBegan:
        {
            self.menuView.hidden = NO;
        }
            break;
        default:
            self.menuView.hidden  = YES;
            break;
    }
}

#pragma mark - UIGestureRecognizerDelegate methods

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma manage memory methods

-(void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}

@end
