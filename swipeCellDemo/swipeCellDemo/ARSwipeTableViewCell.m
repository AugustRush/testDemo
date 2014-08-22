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


@end

@implementation ARSwipeTableViewCell

#pragma mark - init/config methods

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier leftItems:(NSArray *)leftItems rightItems:(NSArray *)rightItems
{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.leftItems = [NSMutableArray arrayWithCapacity:leftItems.count];
        for (int i = 0 ; i < leftItems.count; i++) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            item.backgroundColor = [UIColor orangeColor];
            [item setTitle:leftItems[i] forState:UIControlStateNormal];
//            [item addTarget:self action:@selector(menuItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.menuView addSubview:item];
            [self.leftItems addObject:item];
        }
        
        self.rightItems = [NSMutableArray arrayWithCapacity:rightItems.count];
        for (int i = 0; i < rightItems.count; i++) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            item.backgroundColor = [UIColor orangeColor];
            [item setTitle:rightItems[i] forState:UIControlStateNormal];
//            [item addTarget:self action:@selector(menuItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.menuView addSubview:item];
            [self.rightItems addObject:item];

        }
    }
    return self;
}


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

-(void)initConfigs
{
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.menuView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        [self insertSubview:view atIndex:0];
        view;
    });
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delaysTouchesBegan = YES;
    panGesture.delaysTouchesEnded = YES;
    panGesture.delegate = self;
    [self.contentView addGestureRecognizer:panGesture];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.menuView.frame = self.contentView.frame;
    for (int i = 0; i < self.leftItems.count; i++) {
        UIButton *item = self.leftItems[i];
        item.frame = CGRectMake(kMenuItemWidth*i, 0, kMenuItemWidth, CGRectGetHeight(self.menuView.bounds));
    }
    for (int i = 0; i < self.rightItems.count; i++) {
        UIButton *item = self.rightItems[i];
        item.frame = CGRectMake(CGRectGetWidth(self.menuView.bounds)-kMenuItemWidth*(i+1), 0, kMenuItemWidth, CGRectGetHeight(self.menuView.bounds));
    }
}

#pragma mark - private methods

//-(void)menuItemClicked:(id)sender
//{
//}

-(void)handlePanGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint movePoint = [pan translationInView:self];
    if (fabsf(movePoint.x) < fabsf(movePoint.y)) {
        return;
    }
    
    CGRect frame = self.contentView.frame;
    
    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
        {
            frame.origin.x = movePoint.x;
            NSInteger itemCount = movePoint.x > 0 ? _leftItems.count:_rightItems.count;
           if(fabsf(movePoint.x)-itemCount*kMenuItemWidth < 30 ){
               
               self.contentView.frame = frame;
               self.menuView.alpha = 1- fabsf(kMenuItemWidth*itemCount - fabsf(movePoint.x))/(kMenuItemWidth*itemCount);
           }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            frame.origin.x = 0;
            [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
                self.contentView.frame = frame;
                self.menuView.alpha = 1;
            } completion:^(BOOL finished) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(cell:swipeCompletedWithType:)]) {
                    [self.delegate cell:self swipeCompletedWithType:movePoint.x > 0 ? ARSwipeTableViewCellSwipeTypeRight:ARSwipeTableViewCellSwipeTypeLeft];
                }
            }];
        }
            break;
        case UIGestureRecognizerStateBegan:
        {
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
        }
            break;
        case UIGestureRecognizerStatePossible:
        {
        }
            break;
            
        default:
            break;
    }
}

-(void)setSelectionStyle:(UITableViewCellSelectionStyle)selectionStyle
{
    [super setSelectionStyle:UITableViewCellSelectionStyleNone];
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
