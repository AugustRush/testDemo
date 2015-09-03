//
//  ARGridTableViewCell.h
//  ARControlsDemo
//
//  Created by August on 15/8/7.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARGridView.h"

@interface ARGridTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ARGridView *gridView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)fill;

@end
