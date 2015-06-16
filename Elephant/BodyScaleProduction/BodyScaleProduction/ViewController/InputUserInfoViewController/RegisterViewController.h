//
//  RegisterViewController.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-21.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "AQBaseViewController.h"

@class UserInfoEntity;

@interface RegisterViewController : AQBaseViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userInfoEntity:(UserInfoEntity *)userInfoEntity isForgetPassword:(BOOL)isForgetPassword type:(FlowType)type;

@end
