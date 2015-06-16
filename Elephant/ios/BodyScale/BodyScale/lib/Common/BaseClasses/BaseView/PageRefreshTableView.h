//
//  PageRefreshTableView.h
//  FFLtd
//
//  Created by 两元鱼 on 9/23/11.
//  Copyright (c) 2011 FFLtd. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"
#import "UITableViewMoreCell.h"
#import "CommonView.h"

@interface PageRefreshTableView : CommonView {
    
    NSInteger				currentPage;
    
	NSInteger				totalPage;
    
    NSInteger				totalCount;
    
	BOOL					isLastPage;
    
    BOOL                    _reloading;
    
    BOOL                    _isFromHead;
    
    BOOL                    _isLoading;
    
    EGORefreshTableHeaderView *_refreshHeaderView;

}

@property(nonatomic,assign)   NSInteger				currentPage;

@property(nonatomic,assign)   NSInteger				totalPage;

@property(nonatomic,assign)   NSInteger				totalCount;

@property(nonatomic,assign)   BOOL				    isLastPage;

@property(nonatomic,assign)   BOOL				    reloading;

@property(nonatomic,assign)   BOOL				    isLoading;

@property(nonatomic,assign)   BOOL				    isFromHead;

@property(nonatomic,strong)   EGORefreshTableHeaderView *refreshHeaderView;

- (void)startRefreshLoading;

- (void)startMoreAnimation:(BOOL)animating;

- (void)dataSourceDidFinishLoadingNewData;

- (void)reloadTableViewDataSource;

- (BOOL)hasMore;


- (void)refreshData;

- (void)refreshDataComplete;

- (void)loadMoreData;

- (void)loadMoreDataComplete;

@end
