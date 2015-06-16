//
//  NeedInheritViewController.m
//  FFLtd
//
//  Created by lyywhg on 10-10-11.
//  Copyright 2010 FFLtd. All rights reserved.
//

#import "TPKeyboardAvoidingTableView.h"
#import "NeedInheritViewController.h"
#import "MBProgressHUD.h"
#import "AuthManagerNavViewController.h"
#import "WordConstant.h"


#define DefaultRedColor        [UIColor colorWithRed:220.0/255.0f green:43.0/255.0f blue:30.0/255.0f alpha:1.0f]
#define DefaultGreenColor      UIColorFromRGB(0x34d018)


@implementation NeedInheritViewController


+ (id)controller
{
    return [[self alloc] init];
}
- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}
- (void)dealloc
{
}

#pragma mark
#pragma mark View Action
- (void)loadView
{
    [super loadView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithRed:232.0/255.0f green:232.0/255.0f blue:232.0/255.0f alpha:1.0f];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}
#pragma mark
#pragma mark - Other Action
/*
 设置TopView
 默认 没有右边按钮
 背景色统一 DefaultColor
 */
- (void)setTopViewWithTitle:(NSString*)title
{
    self.topTitleView.userInteractionEnabled = YES;
    //    self.topTitleView.backgroundColor = [UIColor whiteColor];
    
    [self.topTitleView addSubview:self.backBtn];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    self.topTitleLabel.text = title;
}
/*
 设置TopView
 WithRightImage :右侧按钮图片(默认显示)
 */
- (void)setTopViewWithTitle:(NSString*)title
             WithRightImage:(NSString*)imgName
{
    [self setTopViewWithTitle:title];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [self.topTitleView addSubview:self.rightBtn];
}
/*
 设置TopView
 WithRightText :右侧文字
 */
- (void)setTopViewWithTitle:(NSString*)title
              WithRightText:(NSString*)text
{
    [self setTopViewWithTitle:title];
    CGFloat width = [GetStringWidthAndHeight getStringWidth:text height:34 font:FONT15].width;
    if (width < 34)
    {
        width = 34;
    }
    self.rightBtn.frame = CGRectMake(self.view.frame.size.width-width-20, 25, width, 34);
    [self.rightBtn setTitle:text forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = FONT14;
    [self.topTitleView addSubview:self.rightBtn];
}
/*
 设置TopView
 WithLeftText :左侧文字
 WithRightText :右侧文字
 */
- (void)setTopViewWithTitle:(NSString*)title
               WithLeftText:(NSString *)leftText
              WithRightText:(NSString*)rightText
{
    [self setTopViewWithTitle:title];
    {
        CGFloat width = [GetStringWidthAndHeight getStringWidth:rightText height:34 font:FONT15].width;
        if (width < 34)
        {
            width = 34;
        }
        self.rightBtn.frame = CGRectMake(self.view.frame.size.width-width-20, 25, width, 34);
        [self.rightBtn setTitle:rightText forState:UIControlStateNormal];
        self.rightBtn.titleLabel.font = FONT14;
    }
    {
        CGFloat width = [GetStringWidthAndHeight getStringWidth:leftText height:34 font:FONT15].width;
        if (width < 34)
        {
            width = 34;
        }
        self.backBtn.frame = CGRectMake(5, 25, width, 34);
        [self.backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.backBtn setTitle:leftText forState:UIControlStateNormal];
        self.backBtn.titleLabel.font = FONT14;
    }
    [self.topTitleView addSubview:self.rightBtn];
}
/*
 设置TopView
 WithLeftImage :左侧按钮图片
 */
- (void)setTopViewWithTitle:(NSString*)title
              WithLeftImage:(NSString*)imgName
{
    [self setTopViewWithTitle:title];
    [self.backBtn setImage:[UIImage imageNamed:imgName]
                  forState:UIControlStateNormal];
}

- (void)setTopViewWithTitle:(NSString*)title
              WithLeftImage:(NSString*)leftimgName
             WithRightImage:(NSString*)rightimgName
{
    [self setTopViewWithTitle:title WithRightImage:rightimgName];
    [self.backBtn setImage:[UIImage imageNamed:leftimgName]
                  forState:UIControlStateNormal];
}
- (void)setTopViewWithTitle:(NSString*)title
              WithLeftImage:(NSString*)leftimgName
             WithRightText:(NSString*)rightimgName
{
    [self setTopViewWithTitle:title WithRightText:rightimgName];
    [self.backBtn setImage:[UIImage imageNamed:leftimgName]
                  forState:UIControlStateNormal];
}
/*
 设置TopView
 color : TopView背景色
 */
- (void)setTopViewWithTitle:(NSString*)title
                  WithColor:(UIColor*)bgColor
{
    [self setTopViewWithTitle:title];
    _topTitleView.backgroundColor = bgColor;
}
/*
 设置TopView
 WithRightImage :右侧按钮图片
 bgColor : TopView背景色
 */
- (void)setTopViewWithTitle:(NSString*)title
             WithRightImage:(NSString*)imgName
                  WithColor:(UIColor*)bgColor
{
    [self setTopViewWithTitle:title WithRightImage:imgName];
    _topTitleView.backgroundColor = bgColor;
}
//左侧按钮
- (void)leftBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
//右侧按钮
- (void)rightBtnAction
{
    
}
#pragma mark
#pragma mark Init & Add
- (UIScrollView*)hdScrollView
{
    if (!_hdScrollView)
    {
        _hdScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _hdScrollView.showsHorizontalScrollIndicator = NO;
        _hdScrollView.showsVerticalScrollIndicator = NO;
        _hdScrollView.delegate = self;
        [self.view addSubview:_hdScrollView];
    }
    return _hdScrollView;
}

- (UIImageView *)topTitleView
{
    if (!_topTitleView)
    {
        _topTitleView = [[UIImageView alloc] init];
        _topTitleView.userInteractionEnabled = YES;
        _topTitleView.backgroundColor = DefaultRedColor;
        _topTitleView.frame = CGRectMake(0, 0, CONTROLLERVIEW_WIDTH, 64);
        [_topTitleView addSubview:self.topTitleLabel];
        [self.view addSubview:_topTitleView];
    }
    return _topTitleView;
}
- (UILabel *)topTitleLabel
{
    if (!_topTitleLabel)
    {
        _topTitleLabel = [[UILabel alloc] init];
        _topTitleLabel.textAlignment = NSTextAlignmentCenter;
        _topTitleLabel.textColor = [UIColor whiteColor];
        _topTitleLabel.font = BOLDFONT20;
        _topTitleLabel.frame = CGRectMake(40, 20, CONTROLLERVIEW_WIDTH-80, 44);
    }
    return _topTitleLabel;
}
- (UIButton *)backBtn
{
    if (!_backBtn)
    {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.frame = CGRectMake(5, 25, 34, 34);
    }
    return _backBtn;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(self.view.frame.size.width-50, 25, 34, 34);
        _rightBtn.titleLabel.font = FONT18;
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}


#pragma mark
#pragma mark - TableView Delegate & Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    DLog(@"Commmon didReceiveMemoryWarning \n");
    // Release any cached data, images, etc. that aren't in use.
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
    {
        [super presentViewController:modalViewController animated:animated completion:NULL];
    }
    else
    {
        [super presentModalViewController:modalViewController animated:animated];
    }
}
@end