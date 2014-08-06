//
//  ChannelListViewController.h
//  ARVeryCD
//
//  Created by August on 14-8-5.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "BaseViewController.h"

@interface ChannelListViewController : BaseViewController

-(id)initWithNibName:(NSString *)nibNameOrNil
              bundle:(NSBundle *)nibBundleOrNil
           catalogId:(NSString *)catalogId;

@property (nonatomic, copy) NSString *catalogId;

@end
