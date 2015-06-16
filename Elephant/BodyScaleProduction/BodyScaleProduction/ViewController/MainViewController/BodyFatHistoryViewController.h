//
//  BodyFatHistoryViewController.h
//  BodyScale
//
//  Created by Go Salo on 14-3-4.
//  Copyright (c) 2014年 于菲. All rights reserved.
//

#import "AQBaseViewController.h"

@interface BodyFatHistoryViewController : AQBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isFirstScale:(BOOL)isFirstScale;

- (void)reloadData;

@end
