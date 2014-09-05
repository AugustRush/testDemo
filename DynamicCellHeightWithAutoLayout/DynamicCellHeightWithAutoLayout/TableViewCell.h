//
//  TableViewCell.h
//  DynamicCellHeightWithAutoLayout
//
//  Created by August on 14-9-5.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *botLabel;

@property (weak, nonatomic) IBOutlet UILabel *toplabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@end
