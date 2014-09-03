//
//  ARSwipeTableViewCell.m
//  swipeCellDemo
//
//  Created by August on 14-8-20.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ARSwipeTableViewCell.h"

#define kMenuItemWidth 60.0
#define kDefaultAnimationDuration .3

@interface ARSwipeTableViewCell ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) NSMutableArray *leftItems;
@property (nonatomic, strong) NSMutableArray *rightItems;

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

- (void)awakeFromNib
{
    [self initConfigs];
}

#pragma mark - private methods

-(void)setDataSource:(id<ARSwipeTableViewCellDataSource>)dataSource
{
    _dataSource = dataSource;
    if (_dataSource
        && [_dataSource respondsToSelector:@selector(leftItemsWithSwipeCell:)]
        && _leftItems == nil) {
        NSLog(@"menu items is %@",_menuView.subviews);
        NSArray *leftItems = [dataSource leftItemsWithSwipeCell:self];
        self.leftItems = [NSMutableArray arrayWithArray:leftItems];
        for (UIView *item in self.leftItems) {
            [self.menuView addSubview:item];
        }
    }
    
    if (_dataSource
        && [_dataSource respondsToSelector:@selector(rightItemsWithSwipeCell:)]
        && _rightItems == nil) {
        
        NSArray *rightItems = [dataSource rightItemsWithSwipeCell:self];
        self.rightItems = [NSMutableArray arrayWithArray:rightItems];
        for (UIView *item in self.rightItems) {
            [self.menuView addSubview:item];
        }
    }

}

-(void)initConfigs
{
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.menuView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        view.hidden = YES;
        UIView *contentSuperView = [self.contentView superview];
        NSAssert(contentSuperView != nil, @"cell contentView's superView should not be nil.");
        [contentSuperView insertSubview:view atIndex:0];
        view;
    });
    
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
    self.menuView.frame = self.contentView.frame;
    self.menuView.hidden = YES;
    for (int i = 0; i < self.leftItems.count; i++) {
        UIView *item = self.leftItems[i];
        item.frame = CGRectMake(kMenuItemWidth*i, 0, kMenuItemWidth, CGRectGetHeight(self.menuView.bounds));
    }
    for (int i = 0; i < self.rightItems.count; i++) {
        UIView *item = self.rightItems[i];
        item.frame = CGRectMake(CGRectGetWidth(self.menuView.bounds)-kMenuItemWidth*(i+1), 0, kMenuItemWidth, CGRectGetHeight(self.menuView.bounds));
    }
}

-(void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [self.swipePangesture removeTarget:self action:@selector(handlePanGesture:)];
    }else{
        [self.swipePangesture addTarget:self action:@selector(handlePanGesture:)];
    }
}

#pragma mark - private methods

-(void)handlePanGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint movePoint = [pan translationInView:self];
    CGRect frame = self.contentView.frame;
    
    //scroll tableView
    if (fabsf(movePoint.x) < fabsf(movePoint.y)) {
        if (frame.origin.x != 0) {
            frame.origin.x = 0;
            self.contentView.frame = frame;
        }
        return;
    }
    
    //swipe cell
    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
        {
            frame.origin.x = movePoint.x;
            NSInteger itemCount = movePoint.x > 0 ? _leftItems.count:_rightItems.count;
           if(fabsf(movePoint.x)-itemCount*kMenuItemWidth < 30 ){
               self.contentView.frame = frame;
           }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
            frame.origin.x = 0;
            [UIView animateWithDuration:.2
                                  delay:0.1
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 
                self.contentView.frame = frame;

            } completion:^(BOOL finished) {
                
                self.menuView.hidden = YES;
                NSInteger itemCount = movePoint.x > 0 ? _leftItems.count:_rightItems.count;
                if (self.delegate &&
                    [self.delegate respondsToSelector:@selector(swipeCell:swipeCompletedWithType:)] &&
                    fabsf(movePoint.x) > itemCount*kMenuItemWidth) {
                    
                    [self.delegate swipeCell:self swipeCompletedWithType:movePoint.x > 0 ? ARSwipeTableViewCellSwipeTypeRight:ARSwipeTableViewCellSwipeTypeLeft];
                    
                }

            }];
        }
            break;
        case UIGestureRecognizerStateBegan:
        {
            self.menuView.hidden = NO;
        }
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStatePossible:
        {
            self.menuView.hidden = YES;
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
