//
//  AQShareView.h
//  AQShareSDK
//
//  Created by Zhanghao on 4/16/14.
//  Copyright (c) 2014 Zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  该类暂不支持横屏模式分享
 */

@protocol AQShareViewDelegate;

@interface AQShareView : UIView

@property (nonatomic, weak) id<AQShareViewDelegate> delegate;

/**
 *  创建share view
 *
 *  @param title     顶部标题栏标题
 *  @param delegate  代理对象
 *  @param sharedObj AQShareObj对象组成的数组
 *
 */
+ (instancetype)showWithTitle:(NSString *)title delegate:(id<AQShareViewDelegate>)delegate sharedObj:(NSArray *)sharedObj;

/**
 *  创建share view
 *
 *  @param title     顶部标题栏标题
 *  @param sharedObj AQShareObj对象组成的数组
 *
 */
- (instancetype)initWithTitle:(NSString *)title sharedObj:(NSArray *)sharedObj;


/**
 *  显示在keyWindow之上
 */
- (void)show;

@end

@protocol AQShareViewDelegate <NSObject>

@optional


/**
 *  share view将要消失，动画开始前调用
 */
- (void)shareViewWillDismiss:(AQShareView *)shareView;

/**
 *  share view已经消失，动画结束后调用
 */
- (void)shareViewDidDismiss:(AQShareView *)shareView;

/**
 *  当前点击按钮的index，从0开始计算
 */
- (void)shareButtonTappedAtIndex:(NSUInteger)index;

@end


@interface AQShareObj : NSObject

@property (nonatomic, strong) UIImage *normalImage;         // 正常图片
@property (nonatomic, strong) UIImage *highlightImage;      // 高亮图片
@property (nonatomic, copy) NSString *title;                // 图片对应的文本

- (instancetype)initWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage title:(NSString *)title;

@end
