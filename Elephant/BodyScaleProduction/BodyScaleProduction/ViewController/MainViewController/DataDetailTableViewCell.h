//
//  DataDetailTableViewCell.h
//  ViewDraw
//
//  Created by Go Salo on 14-5-11.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCEntity.h"

typedef void(^DataDetailCallback)();

@interface DataDetailTableViewCell : UITableViewCell

- (void)setData:(PCEntity *)dataEntity;
- (void)setIconButtonTouchUpInsideCallBack:(DataDetailCallback)callback1 historyButtonTouchUpInsideCallback:(DataDetailCallback)callback2;

@property (weak, nonatomic) IBOutlet UIButton *typeButton;

@end
