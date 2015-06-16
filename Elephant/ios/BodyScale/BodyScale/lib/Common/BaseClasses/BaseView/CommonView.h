//
//  CommonView.h
//  FFLtd
//
//  Created by 两元鱼 on 12-8-17.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "TPKeyboardAvoidingTableView.h"

@interface CommonView : UIView

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *groupTableView;
@property (nonatomic, strong) TPKeyboardAvoidingTableView *tpTableView;

@property (nonatomic, strong) UIImageView *hImageView;


- (void)presentSheet:(NSString*)indiTitle;
- (void)displayOverFlowActivityView;
- (void)removeOverFlowActivityView;

@end
