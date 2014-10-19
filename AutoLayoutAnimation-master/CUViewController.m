//
//  CUViewController.m
//  AutoLayoutAnimation
//
//  Created by yuguang on 16/6/14.
//  Copyright (c) 2014 lion. All rights reserved.
//

#import "CUViewController.h"

@interface CUViewController ()

@property (nonatomic, strong) NSMutableArray *imageViewList;
@property (nonatomic, strong) NSArray *animationConstraints;
@property (nonatomic, strong) NSArray *animationContainerConstraints;

@property (weak, nonatomic) IBOutlet UIButton *animationButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) CGFloat topYPos;
@property (nonatomic, assign) CGFloat maxHeight;

@end

@implementation CUViewController
{
  BOOL _bExpand;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
  [self.scrollView addSubview:self.containerView];
  self.imageViewList = [NSMutableArray array];
  for (int i = 0; i < 5; ++i) {
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(0, 0, 20, 40);
    [self.imageViewList addObject:imageView];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.backgroundColor = [UIColor colorWithWhite:0 + 0.2 * i alpha:1.0];
    
    [self.containerView insertSubview:imageView belowSubview:self.animationButton];
  }
  
  self.scrollView.alwaysBounceVertical = YES;
}

- (void)updateViewConstraints
{
  [super updateViewConstraints];
  
  self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addConstraints:
   [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_containerView(320)]|"
                                           options:0
                                           metrics:nil
                                             views:NSDictionaryOfVariableBindings(_containerView)]
   ];
  
  for (int i = 0; i < self.imageViewList.count; ++i) {
    NSString *key = [@"imageView" stringByAppendingString:[@(i) stringValue]];
    NSString *hVFL = [NSString stringWithFormat:@"H:|-0-[%@]-0-|", key];
    NSDictionary *dictionary  =@{key : self.imageViewList[i]};
    
    NSArray *list =
    [NSLayoutConstraint constraintsWithVisualFormat:hVFL
                                            options:0
                                            metrics:nil
                                              views:dictionary];
    [self.containerView addConstraints:list];
  }

  [self reset];
}

- (IBAction)clicked:(id)sender {
  
//  [self.containerView layoutIfNeeded];
  
  if (!_bExpand) {
    _bExpand = YES;
    
    [UIView animateWithDuration:2.6f
                     animations:^{
                       
                       [self.containerView removeConstraints:_animationConstraints];
                       [self.scrollView removeConstraints:self.animationContainerConstraints];
                       
                       int animationIndex = 2;
                       
                       NSString *language = @"V:|";
                       NSMutableArray *keys = [NSMutableArray array];
                       for (int i = 0; i < self.imageViewList.count; ++i) {
                         NSString *key = [@"imageView" stringByAppendingString:[@(i) stringValue]];
                         NSString *value = [NSString stringWithFormat:@"-0-[%@(50)]", key];
                         if (i == 0) {
                           value = [NSString stringWithFormat:@"-(-%d)-[%@(50)]", 50 * animationIndex,key];
                         }
                         if (i == animationIndex) {
                           value = [NSString stringWithFormat:@"-0-[%@(%f)]", key, self.maxHeight];
                         }
                         
                         language = [language stringByAppendingString:value];
                         [keys addObject:key];
                       }
                       
                       NSDictionary *dic = [NSDictionary dictionaryWithObjects:self.imageViewList forKeys:keys];
                       
                       self.animationConstraints =
                       [NSLayoutConstraint constraintsWithVisualFormat:language
                                                               options:0
                                                               metrics:nil
                                                                 views:dic];
                       [self.containerView addConstraints:self.animationConstraints];
                       
                       self.animationContainerConstraints = self.animationContainerConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_containerView]-0-|"
                                                                                                                                         options:0
                                                                                                                                         metrics:nil
                                                                                                                                           views:NSDictionaryOfVariableBindings(_containerView)];
                       [self.scrollView addConstraints:self.animationContainerConstraints];
                       
                       [self.containerView layoutIfNeeded];
                     }];

  }
  else
  {
//    [self.containerView layoutIfNeeded];
    [UIView animateWithDuration:2.6f
                     animations:^{
                       [self.containerView removeConstraints:_animationConstraints];
                       [self.scrollView removeConstraints:self.animationContainerConstraints];
                       [self reset];
                       
                       [self.containerView layoutIfNeeded];
                     }];
    
    _bExpand = NO;
  }
}

- (void)reset
{
  NSString *language = @"V:|";
  NSMutableArray *keys = [NSMutableArray array];
  for (int i = 0; i < self.imageViewList.count; ++i) {
    NSString *key = [@"imageView" stringByAppendingString:[@(i) stringValue]];
    NSString *value = [NSString stringWithFormat:@"-0-[%@(50)]", key];
    language = [language stringByAppendingString:value];
    [keys addObject:key];
  }
  
  NSDictionary *dic = [NSDictionary dictionaryWithObjects:self.imageViewList forKeys:keys];
  
  self.animationConstraints =
  [NSLayoutConstraint constraintsWithVisualFormat:language
                                          options:0
                                          metrics:nil
                                            views:dic];
  
  [self.containerView addConstraints:self.animationConstraints];
  
  NSString *lan = [NSString stringWithFormat:@"V:|-(%f)-[_containerView]", self.topYPos];
  
  self.animationContainerConstraints = [NSLayoutConstraint constraintsWithVisualFormat:lan
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:NSDictionaryOfVariableBindings(_containerView)];
  
  [self.scrollView addConstraints:
   self.animationContainerConstraints
   ];
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  
  [self.scrollView removeConstraints:self.animationContainerConstraints];
  
  self.topYPos = self.scrollView.frame.size.height - 50 * self.imageViewList.count;
  self.maxHeight = self.scrollView.bounds.size.height;
  NSString *lan = [NSString stringWithFormat:@"V:|-(%f)-[_containerView]", self.topYPos];
  
  self.animationContainerConstraints = [NSLayoutConstraint constraintsWithVisualFormat:lan
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:NSDictionaryOfVariableBindings(_containerView)];
  [self.scrollView addConstraints:self.animationContainerConstraints];
  [self.view layoutIfNeeded];
}

@end
