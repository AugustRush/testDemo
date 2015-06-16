//
//  DataDetailViewController.h
//  BodyScale
//
//  Created by Go Salo on 14-3-4.
//  Copyright (c) 2014年 于菲. All rights reserved.
//

#import "AQBaseViewController.h"
#import "Flurry.h"

@class ScaleUserDataEntity;

@interface DataDetailViewController : AQBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
       userInfoEntity:(UserInfoEntity *)userInfoEntity
                 type:(FlowType)type;

@end
