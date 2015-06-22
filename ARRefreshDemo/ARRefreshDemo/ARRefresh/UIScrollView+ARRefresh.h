//
//  UIScrollView+ARRefresh.h
//  ARRefreshDemo
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARRefreshProtocol.h"

@interface UIScrollView (ARRefresh)

//refresh header
-(void)ar_addRefreshHeaderWithTrigger:(void(^)(UIScrollView *scrollView))trigger;
-(void)ar_endRefresh;

//infinite scroll

-(void)ar_addInfinityScrollWithTrigger:(void(^)(UIScrollView *scrollView))trigger;
-(void)ar_endInfinityScroll;

@end
