//
//  SNPopoverController.h
//  FFLtd
//
//  Created by 两元鱼 on 12-8-30.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//
/*!
 @header      SNPopoverController
 @abstract    用于弹出一个可供选择的viewControler的控件
 @author      两元鱼
 @version     v1.1  12-12-10
 @discussion  12-12-10， 添加blackLayerFrame，可自由设置背景黑色区域大小。
 */


typedef enum {
    SNPopoverAnimationSlowAppear,
    SNPopoverAnimationBounce,
}SNPopoverAnimation;

@class SNPopoverCommonViewController;

@interface SNPopoverController : NSObject
{
@private
    BOOL    isVisible_;
}

@property (nonatomic, readonly) BOOL isVisible;

//黑色背景的位置和大小，父view是window
@property (nonatomic, assign) CGRect blackLayerFrame;

//显示的大小
@property (nonatomic, assign) CGSize popoverSize;

/*!
 @abstract      返回根级ViewController
 @result        nav的rootViewController
 */
- (SNPopoverCommonViewController *)contentController;

/*!
 @abstract      初始化并设定初始的ViewController
 @param         controller  popover的第一级的viewController
 @result        SNPopoverController的对象
 */
- (id)initWithContentController:(SNPopoverCommonViewController *)controller;

/*!
 @abstract      弹出Popover
 @param         contentViewController  要展示的viewController
 @param         animated  是否展示动画
 */
- (void)presentWithContentViewController:(SNPopoverCommonViewController *)contentViewController 
                                animated:(BOOL)animated;

/*!
 @abstract      弹出Popover
 @param         animated  是否展示动画
 */
- (void)presentAnimated:(BOOL)animated;

/*!
 @abstract      消失Popover
 @param         animated  是否展示动画
 */
- (void)dismissAnimated:(BOOL)animated;

/*!
 @abstract      nav返回到root
 */
- (void)popToRoot:(BOOL)animated;

@end

