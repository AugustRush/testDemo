//
//  NJPageScrollView.h
//  FFLtd
//
//  Created by 两元鱼 on 12-4-25.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//


/*!
 @header      NJPageScrollView.h
 @abstract    用于横向滚屏翻页的可重用的Scroll View
 @author      两元鱼
 */

@protocol NJPageScrollViewDataSource;
@class NJPageScrollView;
@class NJPageScrollViewCell;

@protocol NJPageScrollViewDelegate <NSObject, UIScrollViewDelegate>

@optional
// Called before the page scrolls into the center of the view.
- (void)pageScrollView:(NJPageScrollView *)scrollView willScrollToPage:(NJPageScrollViewCell *)page atIndex:(NSInteger)index;

// Called after the page scrolls into the center of the view.
- (void)pageScrollView:(NJPageScrollView *)scrollView didScrollToPage:(NJPageScrollViewCell *)page atIndex:(NSInteger)index;

@optional


@end

// ------------------------------------------------------------------------------------------------------------------------------------------------------

@interface NJPageScrollView : UIView <UIScrollViewDelegate>
{
@private
    
    UIScrollView            *_scrollView;
    
    NSInteger				 _numberOfPages;
    NSInteger                _numberOfFreshPages;
	NSRange                  _visibleIndexes;
    NSMutableArray          *_visiblePages;
    NSMutableArray          *_deletedPages;
    NSMutableDictionary     *_reusablePages;
        
    CGFloat                 _maxWidth;
}

@property (nonatomic, weak)   id <NJPageScrollViewDataSource> dataSource;
@property (nonatomic, weak)   id <NJPageScrollViewDelegate>   delegate;
@property (nonatomic, readonly) NSInteger numberOfFreshPages;

/*可显示的最大宽度，默认为iphone宽度320*/
@property (nonatomic, assign) CGFloat maxWidth;

@property (nonatomic, readonly, strong) UIScrollView *scrollView;

- (NSInteger)numberOfPages;

- (NJPageScrollViewCell *)pageAtIndex:(NSInteger)index;

- (NSInteger)indexForVisiblePage:(NJPageScrollViewCell *)page;  


- (NJPageScrollViewCell *)dequeueReusablePageWithIdentifier:(NSString *)identifier;


- (void)reloadData;


- (void)setContentOffset:(CGPoint)offset;

- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated;

@end



// ------------------------------------------------------------------------------------------------------------------------------------------------------

@protocol NJPageScrollViewDataSource <NSObject>

@required

- (NSInteger)numberOfPagesInPageScrollView:(NJPageScrollView *)pageScrollView;


- (NJPageScrollViewCell *)pageScrollView:(NJPageScrollView *)pageScrollView cellForPage:(NSInteger)page;

@end

// ------------------------------------------------------------------------------------------------------------------------------------------------------

