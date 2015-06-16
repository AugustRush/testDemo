//
//  DeleteDataTipsView.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-6-6.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeleteDataTipsView;

typedef void(^DeleteDataTipsViewCancelCallBack)(DeleteDataTipsView *tipsView);
typedef void(^DeleteDataTipsViewSureCallBack)(DeleteDataTipsView *tipsView, NSInteger selectedIndex);

@interface DeleteDataTipsView : UIView

+ (void)showDeleteDataTipsViewWithConfirmHandler:(DeleteDataTipsViewSureCallBack)aConfirmHandler cancelHandler:(DeleteDataTipsViewCancelCallBack)aCancelHandler;

@end
