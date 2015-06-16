//
//  DeleteDataTipsTableViewCell.m
//  Views
//
//  Created by Go Salo on 14-6-6.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "DeleteDataTipsTableViewCell.h"

@implementation DeleteDataTipsTableViewCell {
    
    __weak IBOutlet UIImageView *selectedIcon;
}

- (void)awakeFromNib
{
    self.textLabel.textColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    selectedIcon.hidden = !selected;
}

@end
