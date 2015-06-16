//
//  CommonView.m
//  FFLtd
//
//  Created by 两元鱼 on 12-8-17.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "CommonView.h"
#import "BBTipView.h"
#import "UIView+ActivityIndicator.h"

@interface CommonView()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation CommonView
#pragma mark
#pragma mark - Init & Dealloc
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
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
#pragma mark - Init & Add
- (UIViewController *)viewController
{
    if (!_viewController)
    {
        _viewController = [[UIViewController alloc] init];
    }
    return _viewController;
}
- (UIImageView *)hImageView
{
    if (!_hImageView)
    {
        _hImageView = [[UIImageView alloc] init];
        _hImageView.frame = CGRectMake(self.viewController.view.frame.size.width/2-15, self.viewController.view.frame.size.height/2-80, 30, 30);
        _hImageView.animationImages=[NSArray arrayWithObjects:
                                     [UIImage imageNamed:@"More1.png"],
                                     [UIImage imageNamed:@"More2.png"],
                                     [UIImage imageNamed:@"More3.png"],
                                     [UIImage imageNamed:@"More4.png"],
                                     [UIImage imageNamed:@"More5.png"],
                                     [UIImage imageNamed:@"More6.png"],
                                     [UIImage imageNamed:@"More6.png"],
                                     [UIImage imageNamed:@"More7.png"],nil ];
        
        _hImageView.animationDuration=1.2;
        _hImageView.animationRepeatCount=0;
        [_hImageView startAnimating];
        _hImageView.alpha = 1.0f;
        [self.viewController.view addSubview:_hImageView];
    }
    return _hImageView;
}

- (UITableView *)tableView
{
	if(!_tableView)
    {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		_tableView.scrollEnabled = YES;
		_tableView.userInteractionEnabled = YES;
		_tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
	}
	return _tableView;
}

- (UITableView *)groupTableView
{
	if(!_groupTableView)
    {
        _groupTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		[_groupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[_groupTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		_groupTableView.scrollEnabled = YES;
		_groupTableView.userInteractionEnabled = YES;
		_groupTableView.backgroundColor = [UIColor clearColor];
        _groupTableView.backgroundView = nil;
        _groupTableView.delegate = self;
        _groupTableView.dataSource = self;
	}
	return _groupTableView;
}

- (TPKeyboardAvoidingTableView *)tpTableView
{
    if(!_tpTableView)
    {
		_tpTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		[_tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[_tpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		_tpTableView.scrollEnabled = YES;
		_tpTableView.userInteractionEnabled = YES;
		_tpTableView.backgroundColor = [UIColor clearColor];
        _tpTableView.backgroundView = nil;
        _tpTableView.delegate = self;
        _tpTableView.dataSource = self;
	}
	return _tpTableView;
}
- (void)presentSheet:(NSString*)indiTitle
{
    [self showTipViewAtCenter:indiTitle];
}
- (void)showTipViewAtCenter:(NSString*)indiTitle
{
	BBTipView *activityView = [self getTipView];
    if (activityView)
    {
        [activityView dismiss:NO];
    }
    activityView = [[BBTipView alloc] initWithView:self message:indiTitle posY:80];
    activityView.tag = toolViewTag;
    [activityView show];
}

- (void)displayOverFlowActivityView
{
    self.hImageView.alpha = 1.0f;
}
- (void)removeOverFlowActivityView
{
    self.hImageView.alpha = 0.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
