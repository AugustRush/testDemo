//
//  LeftSideViewController.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "AQBaseViewController.h"

extern NSString *const AQHasNewMessageNotification;

@interface LeftSideViewController : AQBaseViewController

- (void)refreshPhoto;

- (void)hackViewWillAppearAfterDismissViewController;

@end
