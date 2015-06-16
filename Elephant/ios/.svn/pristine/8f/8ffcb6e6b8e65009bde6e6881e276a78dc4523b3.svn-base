//
//  PageRefreshTableView.m
//  FFLtd
//
//  Created by 两元鱼 on 9/23/11.
//  Copyright (c) 2011 FFLtd. All rights reserved.
//

#import "PageRefreshTableView.h"

@implementation PageRefreshTableView

@synthesize  currentPage;

@synthesize  totalPage;

@synthesize  totalCount;

@synthesize  isLastPage;


@synthesize  reloading = _reloading;

@synthesize  isFromHead = _isFromHead;

@synthesize  isLoading = _isLoading;


@synthesize  refreshHeaderView = _refreshHeaderView;



- (id)init{
	
    self = [super init];
	
    if (self) {
				
		self.currentPage = 0;
        
        self.totalPage   = 0;
        
        self.isLastPage  = YES;
		
    }
    return self;
}

- (void)dealloc {
    
	
	
	
}

-(EGORefreshTableHeaderView*)refreshHeaderView
{
    if(!_refreshHeaderView)
    {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, 320, self.tableView.bounds.size.height)];
		
		_refreshHeaderView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
		
		//[self.tableView addSubview:_refreshHeaderView];
		
		self.tableView.showsVerticalScrollIndicator = YES;
    }
    return _refreshHeaderView;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView.isDragging && _refreshHeaderView)
    {
		if (_refreshHeaderView.state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_reloading)
        {
			[_refreshHeaderView setState:EGOOPullRefreshNormal];
		}
        else if (_refreshHeaderView && _refreshHeaderView.state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_reloading)
        {
			[_refreshHeaderView setState:EGOOPullRefreshPulling];
		}
	}
	//[(TSwipeableTableView*)self.tableView hideVisibleBackView:YES];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    /*判是否下拉刷新*/
    
    if (scrollView.contentOffset.y <= - 65.0f && !_reloading && !_isLoading) {
		
        [self startRefreshLoading];
	}
        
    /*判是否加载更多*/
    CGSize contentOffset = [self.tableView contentSize];
    
    CGRect bounds = [self.tableView bounds];
    
    if (scrollView.contentOffset.y + bounds.size.height >= contentOffset.height && contentOffset.height>=(VIEW_HEIGHT-92))
    {
        if([self hasMore])
        {
             [self loadMoreData];
        }
    }
}

- (void)startMoreAnimation:(BOOL)animating
{
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:totalCount inSection:0] ;		
	
	UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
	
	if ([cell isKindOfClass:[UITableViewMoreCell class]])
    {
		UITableViewMoreCell *_cell = (UITableViewMoreCell *)cell;
		_cell.animating = animating;
	}
}

- (void)startRefreshLoading
{
	
	_reloading = YES;
	
	[self reloadTableViewDataSource];
	
	[_refreshHeaderView setState:EGOOPullRefreshLoading];
	  
    
	[UIView beginAnimations:nil context:NULL];
	
	[UIView setAnimationDuration:0.2];
	
	self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
	
	[UIView commitAnimations];
	
}

- (void)dataSourceDidFinishLoadingNewData{
	_reloading = NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[_refreshHeaderView setState:EGOOPullRefreshNormal];
	[_refreshHeaderView setCurrentDate];  //  should check if data reload was successful 
}


- (void)reloadTableViewDataSource{
	
	_isFromHead = YES ;
	
	[self refreshData];
	
}

- (BOOL)hasMore
{
    return !self.isLastPage;
}
/*子类实现*/
- (void)refreshData
{
    self.isFromHead = YES;
    self.isLoading = YES;
}

/*子类实现*/
- (void)refreshDataComplete
{
    self.isLoading = NO;
    [self dataSourceDidFinishLoadingNewData];
}
/*子类实现*/
- (void)loadMoreData
{
    self.isFromHead = NO;
    self.isLoading = YES;
}
/*子类实现*/
- (void)loadMoreDataComplete
{
    self.isLoading = NO;
    [self startMoreAnimation:NO];
}

- (void)doneLoadingTableViewData
{
	//  model should call this when its done loading
	[self dataSourceDidFinishLoadingNewData];
}

@end
