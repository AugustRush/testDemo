//
//  ARSegmentPageController.h
//  ARSegmentPager
//
//  Created by August on 15/3/28.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSegmentControllerDelegate.h"

@interface ARSegmentPageController : UIViewController

@property (nonatomic, assign) CGFloat segmentHeight;
@property (nonatomic, assign) CGFloat headerHeight;

-(instancetype)initWithControllers:(UIViewController<ARSegmentControllerDelegate> *)controller,... NS_DESIGNATED_INITIALIZER NS_REQUIRES_NIL_TERMINATION;

@end
