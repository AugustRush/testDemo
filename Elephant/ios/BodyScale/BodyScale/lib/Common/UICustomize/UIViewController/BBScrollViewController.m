//
//  BBScrollViewController.m
//  FFLtd
//
//  Created by  两元鱼 on 12-12-21.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "BBScrollViewController.h"
#import "objc/runtime.h"

@interface BBScrollViewController()

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIView *pageControlBG;

- (void)registKVO;
- (void)unRegistKVO;

- (void)didScrollFromPage:(NSInteger)oldPage toPage:(NSInteger)page;

@end

/*********************************************************************/

@implementation BBScrollViewController

@synthesize pageControl = _pageControl;
@synthesize pageControlBG = _pageControlBG;

@synthesize currentPage = _currentPage;
@synthesize viewControllers = _viewControllers;

- (void)dealloc
{
    self.viewControllers = nil;
    [self unRegistKVO];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self registKVO];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    if(!_scrollView){
        _scrollView = [[NJPageScrollView alloc] init];
        CGRect frame = self.view.bounds;
        frame.origin.x = 0;
        frame.size.height = frame.size.height - 49;
        _scrollView.frame = frame;
		_scrollView.delegate = self;
        _scrollView.dataSource = self;
		_scrollView.scrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
		_scrollView.userInteractionEnabled = YES;
        _scrollView.clipsToBounds = YES;
	}
    [self.view addSubview:_scrollView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.view addSubview:self.pageControl];
    [self.view bringSubviewToFront:self.pageControl];
    [self.view insertSubview:self.pageControlBG belowSubview:self.pageControl];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.viewControllers count] > _currentPage)
    {
        id<BBScrollContentApperace> controller = [self.viewControllers objectAtIndex:_currentPage];
        [controller viewAppear];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.viewControllers count] > _currentPage)
    {
        id<BBScrollContentApperace> controller = [self.viewControllers objectAtIndex:_currentPage];
        [controller viewDisappear];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark views

- (CGRect)pageControlFrame
{
    CGSize size = [self.pageControl sizeForNumberOfPages:[self.viewControllers count]];
    CGRect appFrame = [UIScreen mainScreen].bounds;
    CGFloat x = (320-size.width)/2;
    CGFloat y = appFrame.size.height - STATUSBAR_HEIGHT - UITABBAR_HEIGHT - 12;
    return CGRectMake(x, y, size.width, 10);
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = [self pageControlFrame];
        self.pageControl.numberOfPages = [self.viewControllers count];
        self.pageControl.currentPage = 0;
    }
    return _pageControl;
    
}

- (UIView *)pageControlBG
{
    if (!_pageControlBG) {
        _pageControlBG = [[UIView alloc] init];
        _pageControlBG.backgroundColor = [UIColor blackColor];
        _pageControlBG.layer.cornerRadius = 5.0;
        _pageControlBG.alpha = 0.5;
    }
    return _pageControlBG;
}

#pragma mark -
#pragma mark KVO


- (NSArray *)observeKeyPathList
{
    return [NSArray arrayWithObjects:@"currentPage", @"viewControllers", nil];
}

- (void)registKVO
{
    
    [self addObserver:self
           forKeyPath:@"currentPage"
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
              context:NULL];
    
    [self addObserver:self
           forKeyPath:@"viewControllers"
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

- (void)unRegistKVO
{
    for (NSString *keyPath in [self observeKeyPathList])
    {
        [self removeObserver:self
                  forKeyPath:keyPath];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"currentPage"])
    {
        NSInteger oldPage = [[change objectForKey:NSKeyValueChangeOldKey] integerValue];
        [self didScrollFromPage:oldPage toPage:_currentPage];

        self.pageControl.currentPage = self.currentPage;
        
        CGFloat pageWidth = [[UIScreen mainScreen] bounds].size.width;
        [_scrollView setContentOffset:CGPointMake(pageWidth*_currentPage, 0) animated:YES];
    }
    else if ([keyPath isEqualToString:@"viewControllers"])
    {
        [self reloadViewControllers];
    }
}

#pragma mark -
#pragma mark reload view Controllers

- (void)reloadViewControllers
{
    NSInteger pageCount = [self.viewControllers count];
    
    self.pageControl.numberOfPages = pageCount;
    self.pageControl.frame = [self pageControlFrame];
//    self.pageControlBG.frame = CGRectMake(_pageControl.left -10, _pageControl.top, _pageControl.width+20, _pageControl.height);
    [_scrollView reloadData];
}

#pragma mark -
#pragma mark NJPageScrollView Delegate And Datasource

- (id)findControllerOfView:(UIView *)view {
    // convenience function for casting and to "mask" the recursive function
    return [self traverseResponderChainForUIViewController:view];
}

- (id)traverseResponderChainForUIViewController:(id)view
{
    id nextResponder = [view nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [self traverseResponderChainForUIViewController:nextResponder];
    } else {
        return nil;
    }
}

- (NSInteger)numberOfPagesInPageScrollView:(NJPageScrollView *)pageScrollView
{
    return [self.viewControllers count];
}

- (NJPageScrollViewCell *)pageScrollView:(NJPageScrollView *)pageScrollView
                             cellForPage:(NSInteger)page
{
    const int tag = 657;
    static NSString *scrollPageIdentifier = @"scrollPageIdentifier";
    
    NJPageScrollViewCell *cell = [pageScrollView dequeueReusablePageWithIdentifier:scrollPageIdentifier];
    
    if (cell == nil) {
        cell = [[NJPageScrollViewCell alloc] initWithReuseIdentifier:scrollPageIdentifier];
        cell.frame = pageScrollView.bounds;
        cell.backgroundColor = [UIColor clearColor];
        cell.clipsToBounds = YES;
    }
    else
    {
        if (!IOS5_OR_LATER) {
            UIView *view = [cell viewWithTag:tag];
            UIViewController *controller = [self findControllerOfView:view];
            [controller viewWillDisappear:NO];
            [view removeFromSuperview];
            [controller viewDidDisappear:NO];
        }
        else
        {
//            [cell removeAllSubviews];
        }
        
        
    }
    
    UIViewController *controller = [self.viewControllers objectAtIndex:page];
//    controller.view.frame = CGRectMake(0, 0, controller.view.width, controller.view.height);
    controller.view.tag = tag;
    if (!IOS5_OR_LATER) {
        [controller viewWillAppear:NO];
    }
    [cell addSubview:controller.view];
    if (!IOS5_OR_LATER) {
        [controller viewDidAppear:NO];
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = [[UIScreen mainScreen] bounds].size.width;
    
    CGFloat content =  scrollView.contentOffset.x - _currentPage * pageWidth;
    
    if ((content / pageWidth == (int)(content / pageWidth)) && content != 0)
    {
        int page = scrollView.contentOffset.x / pageWidth;
        
        if (_currentPage != page)
        {
            NSInteger oldPage = _currentPage;
            _currentPage = page;
            [self didScrollFromPage:oldPage toPage:_currentPage];
            self.pageControl.currentPage = _currentPage;
        }
    }
    
}

#pragma mark -
#pragma mark BBScrollPage

- (void)didScrollFromPage:(NSInteger)oldPage toPage:(NSInteger)page
{
    
    if ([self.viewControllers count] > oldPage)
    {
        id<BBScrollContentApperace> oldControl = [self.viewControllers objectAtIndex:oldPage];
        [oldControl viewDisappear];
    }
    
    if ([self.viewControllers count] > page)
    {
        id<BBScrollContentApperace> control = [self.viewControllers objectAtIndex:page];
        [control viewAppear];
    }
    
}

@end



/*********************************************************************/


@implementation UIViewController(BBScroll)

@dynamic bbScrollController;

- (void)setBbScrollController:(BBScrollViewController *)bbScrollController
{
    objc_setAssociatedObject(self, "BBScroll", bbScrollController, OBJC_ASSOCIATION_ASSIGN);
}

- (BBScrollViewController *)bbScrollController
{
    return objc_getAssociatedObject(self, "BBScroll");
}

@end
