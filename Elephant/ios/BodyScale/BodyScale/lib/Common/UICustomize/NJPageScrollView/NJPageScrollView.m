//
//  NJPageScrollView.m
//  FFLtd
//
//  Created by 两元鱼 on 12-4-25.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "NJPageScrollView.h"
#import "NJPageScrollViewCell.h"

@interface NJPageScrollView()


- (NJPageScrollViewCell *)loadPageAtIndex:(NSInteger)index insertIntoVisibleIndex:(NSInteger)visibleIndex;

- (void)addPageToScrollView:(NJPageScrollViewCell *)page atIndex:(NSInteger)index;
- (void)setFrameForPage:(UIView *)page atIndex:(NSInteger)index;


- (void)updateVisiblePages;

@end

/*********************************************************************/

@implementation NJPageScrollView

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
@synthesize numberOfFreshPages = _numberOfFreshPages;

@synthesize scrollView = _scrollView;
@synthesize maxWidth = _maxWidth;

- (void)dealloc
{
}

- (id)init {
    self = [super init];
    if (self) {
        self.clipsToBounds = NO;
        
        _visiblePages = [[NSMutableArray alloc] initWithCapacity:3];
        _reusablePages = [[NSMutableDictionary alloc] initWithCapacity:3]; 
        _deletedPages = [[NSMutableArray alloc] initWithCapacity:0];
        
        _numberOfPages = 1;
        
        // set initial visible indexes (page 0)
        _visibleIndexes.location = 0;
        _visibleIndexes.length = 1;
        _maxWidth = 320.0f;
        
        self.scrollView.showsVerticalScrollIndicator = NO;
		self.scrollView.showsHorizontalScrollIndicator = NO;
		self.scrollView.bounces = YES;
		self.scrollView.pagingEnabled = YES;
        self.scrollView.userInteractionEnabled = YES;
        self.scrollView.clipsToBounds = NO;
        
        [self addSubview:self.scrollView];
    }
    return self;
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.scrollView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
}

#pragma mark -
#pragma mark const views

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.decelerationRate = 1.0;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIScrollView *)contentScrollView
{
    return self.scrollView;
}

#pragma mark -
#pragma mark page scroll view data

- (NSInteger)numberOfPages
{
    return _numberOfPages;
}

- (void)setNumberOfPages:(NSInteger)number
{
    _numberOfPages = number; 
    self.scrollView.contentSize = CGSizeMake(_numberOfPages * self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);            
}

- (NJPageScrollViewCell *)pageAtIndex:(NSInteger)index;            // returns nil if page is not visible or the index is out of range
{
	if (index == NSNotFound || index < _visibleIndexes.location || index > _visibleIndexes.location + _visibleIndexes.length-1) {
		return nil;
	}
    NSInteger pageIndex = index-_visibleIndexes.location;
    if (pageIndex < 0 || pageIndex >= [_visiblePages count]) {
        return nil;
    }
	return [_visiblePages objectAtIndex:pageIndex];
}

- (NSInteger)indexForVisiblePage:(NJPageScrollViewCell *)page
{
    NSInteger index = [_visiblePages indexOfObject:page];
	if (index != NSNotFound) {
        return _visibleIndexes.location + index;
    }
    return NSNotFound;
}

- (NSInteger)numberOfFreshPages
{
    return _numberOfFreshPages;
}

#pragma mark -
#pragma mark load data

- (void)setClipsToBounds:(BOOL)clipsToBounds
{
    [super setClipsToBounds:clipsToBounds];
    if (clipsToBounds) {
        _maxWidth = VIEW_WIDTH;
    }
}

- (void)reloadData
{
    NSInteger numPages = 1;  
	if ([self.dataSource respondsToSelector:@selector(numberOfPagesInPageScrollView:)]) {
		numPages = [self.dataSource numberOfPagesInPageScrollView:self];
	}
    
    // reset visible pages array
	[_visiblePages removeAllObjects];
	// remove all subviews from scrollView
    [[self.scrollView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }]; 
    
	[self setNumberOfPages:numPages];
    
    if (numPages > 0) {
        NSInteger leftLength = numPages - _visibleIndexes.location;
        NSInteger maxLength = _maxWidth > VIEW_WIDTH ? 3 : 2;
        _visibleIndexes.length = (leftLength > maxLength) ? maxLength : leftLength;
        // reload visible pages
		for (int index = 0; index < _visibleIndexes.length; index++) {
			NJPageScrollViewCell *pageCell = [self loadPageAtIndex:_visibleIndexes.location+index insertIntoVisibleIndex:index];
            [self addPageToScrollView:pageCell atIndex:_visibleIndexes.location+index];
		}
    }
    
    _numberOfFreshPages = [_visiblePages count];
}

- (NJPageScrollViewCell *)loadPageAtIndex:(NSInteger)index insertIntoVisibleIndex:(NSInteger)visibleIndex
{
	NJPageScrollViewCell *visiblePage = [self.dataSource pageScrollView:self cellForPage:index];
	if (visiblePage.reuseIdentifier) {
		NSMutableArray *reusables = [_reusablePages objectForKey:visiblePage.reuseIdentifier];
		if (!reusables) {
			reusables = [[NSMutableArray alloc] initWithCapacity : 4];
		}
		if (![reusables containsObject:visiblePage]) {
			[reusables addObject:visiblePage];
		}
		[_reusablePages setObject:reusables forKey:visiblePage.reuseIdentifier];
	}
	
	// add the page to the visible pages array
	[_visiblePages insertObject:visiblePage atIndex:visibleIndex];
    
    return visiblePage;
}

- (void)addPageToScrollView:(NJPageScrollViewCell *)page atIndex:(NSInteger)index
{
	// configure the page frame
    [self setFrameForPage : page atIndex:index];
    
    // add the page to the scroller
	[_scrollView insertSubview:page atIndex:0];    
}

- (void)updateVisiblePages
{
	CGFloat pageWidth = VIEW_WIDTH;
    
	//get x origin of left- and right-most pages in _scrollView's superview coordinate space (i.e. self)  
	CGFloat leftViewOriginX = self.frame.origin.x - _scrollView.contentOffset.x + (_visibleIndexes.location * pageWidth);
	CGFloat rightViewOriginX = self.frame.origin.x - _scrollView.contentOffset.x + (_visibleIndexes.location+_visibleIndexes.length-1) * pageWidth;
	
	if (leftViewOriginX > 0) {
		//new page is entering the visible range from the left
		if (_visibleIndexes.location > 0) { //is it not the first page?
			_visibleIndexes.length += 1;
			_visibleIndexes.location -= 1;
			NJPageScrollViewCell *pageCell = [self loadPageAtIndex:_visibleIndexes.location insertIntoVisibleIndex:0];
            // add the page to the scroll view (to make it actually visible)
            [self addPageToScrollView:pageCell atIndex:_visibleIndexes.location];
            
		}
	}
	else if(leftViewOriginX < -pageWidth)
    {
		//left page is exiting the visible range
		UIView *page = [_visiblePages objectAtIndex:0];
        [_visiblePages removeObject:page];
        [page removeFromSuperview]; //remove from the scroll view
		_visibleIndexes.location += 1;
		_visibleIndexes.length -= 1;
	}
    
	if (rightViewOriginX > _maxWidth) {
		//right page is exiting the visible range
		UIView *page = [_visiblePages lastObject];
        [_visiblePages removeObject:page];
        [page removeFromSuperview]; //remove from the scroll view
		_visibleIndexes.length -= 1;
	}
	else if(rightViewOriginX + pageWidth < _maxWidth)
    {
		//new page is entering the visible range from the right
		if (_visibleIndexes.location + _visibleIndexes.length < _numberOfPages) { //is is not the last page?
			_visibleIndexes.length += 1;
            NSInteger index = _visibleIndexes.location+_visibleIndexes.length-1;
			NJPageScrollViewCell *pageCell = [self loadPageAtIndex:index insertIntoVisibleIndex:_visibleIndexes.length-1];
            [self addPageToScrollView:pageCell atIndex:index];
            
		}
	}
}


#pragma mark -
#pragma mark 视图 操作

- (void)setFrameForPage:(UIView *)page atIndex:(NSInteger)index
{
    /*
     两元鱼 2012-6-6修改，默认设置页面大小为scrollView的大小
     
     */
//	CGRect frame = page.frame;
//	frame.origin.x = self.scrollView.frame.size.width*index;
//	frame.origin.y = 0.0;
    CGRect frame = CGRectMake(self.scrollView.frame.size.width*index, 0.0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
	page.frame = frame;
    
}

- (void)setContentOffset:(CGPoint)offset
{
    NSInteger page = (int)(offset.x / self.scrollView.frame.size.width + 0.5);
    if (page == 0) {
        _visibleIndexes.location = 0;
    }
    else if (page >= _numberOfPages-1)
    {
        _visibleIndexes.location = _numberOfPages - 1;
    }
    else
    {
        _visibleIndexes.location = page - 1;
    }
    
    [self reloadData];
    
    [self.scrollView setContentOffset:offset];
}

- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated
{
    [self.scrollView setContentOffset:offset animated:animated];
    
}

#pragma mark -
#pragma mark scroll view delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// update the visible pages
	[self updateVisiblePages];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView 
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.delegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.delegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0){
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.delegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.delegate scrollViewWillBeginDecelerating:scrollView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.delegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.delegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.delegate viewForZoomingInScrollView:scrollView];
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_2)
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.delegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.delegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        [self.delegate scrollViewShouldScrollToTop:scrollView];
    }
    return NO;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.delegate scrollViewDidScrollToTop:scrollView];
    }
}

#pragma mark -
#pragma mark others

- (NJPageScrollViewCell *)dequeueReusablePageWithIdentifier:(NSString *)identifier;  // Used by the delegate to acquire an already allocated page, instead of allocating a new one
{
	NJPageScrollViewCell *reusablePageCell = nil;
	NSArray *reusables = [_reusablePages objectForKey:identifier];
	if (reusables){
		NSEnumerator *enumerator = [reusables objectEnumerator];
		while ((reusablePageCell = [enumerator nextObject])) {
			if(![_visiblePages containsObject:reusablePageCell]){
				[reusablePageCell prepareForReuse];
				break;
			}
		}
	}
	return reusablePageCell;
}


@end
