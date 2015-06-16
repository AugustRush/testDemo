//
//  SNPopoverCommonViewController.m
//  FFLtd
//
//  Created by 两元鱼 on 12-8-30.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "SNPopoverCommonViewController.h"
#import "SNPopoverController.h"

@implementation SNPopoverCommonViewController

@synthesize snpopoverController = _snpopoverController;
@synthesize tableView = _tableView;
@synthesize titleLabel = _titleLabel;

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}

- (void)loadView
{    
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, 230, 250);
}

- (void)dismissPopover:(BOOL)animated
{
    if (_snpopoverController && [_snpopoverController isKindOfClass:[SNPopoverController class]])
    {
        if ([_snpopoverController isVisible])
        {
            [_snpopoverController dismissAnimated:animated];
        }
    }
}

- (UITableView *)tableView
{
	if(!_tableView){
		
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero
												  style:UITableViewStylePlain];    
        
		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		
		[_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tableView.scrollEnabled = YES;
		
		_tableView.userInteractionEnabled = YES;
		
		_tableView.delegate =self;
		
		_tableView.dataSource =self;
		
		_tableView.backgroundColor =[UIColor clearColor];
	}
	
	return _tableView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = BOLDFONT18;
        self.navigationItem.titleView = _titleLabel;
    }
    return _titleLabel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}

@end
