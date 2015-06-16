//
//  HistoryDetailDeleteTableViewCell.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-6-5.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "HistoryDetailDeleteTableViewCell.h"

@implementation HistoryDetailDeleteTableViewCell {
    DeleteData _deleteData;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDeleteBlock:(DeleteData)action {
    _deleteData = action;
}

#pragma mark - Actions
- (IBAction)deleteButtonAction:(id)sender {
    if (_deleteData) {
        _deleteData();
    }
}

@end
