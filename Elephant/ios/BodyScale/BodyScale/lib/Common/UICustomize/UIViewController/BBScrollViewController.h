/*!
 @header      BBScrollViewController.h
 @abstract    可横向滑动的类似与淘宝首页的选项卡控制器
 @author      两元鱼
 @version     12-12-21
 @discussion  设置viewControllers的值即可自动进行刷新，
              viewControllers使用KVO监听机制， 对数组更改时需要用如下方法：
            [[self mutableArrayValueForKey:@"viewControllers"] addObject:addedController];
 
 */

#import "NJPageScrollView.h"
#import "NJPageScrollViewCell.h"

//加入其中的viewController需要服从的协议
//取缔viewWillAppear和viewWillDisappear
@protocol BBScrollContentApperace <NSObject>

@required
- (void)viewAppear;
- (void)viewDisappear;

@end


@interface BBScrollViewController : UIViewController
<NJPageScrollViewDataSource, NJPageScrollViewDelegate>
{
@protected
    NJPageScrollView *_scrollView;
    NSInteger        _currentPage;
    NSMutableArray   *_viewControllers;
}

@property (nonatomic, strong) NSMutableArray *viewControllers;

@property (nonatomic, assign) NSInteger currentPage;


- (void)reloadViewControllers;


@end

/*********************************************************************/
//暂时未启用
@interface UIViewController(BBScroll)

@property (nonatomic, assign) BBScrollViewController *bbScrollController;

@end

