//
//  SYOptionalViewController.m
//  BLEDemo
//
//  Created by Zhanghao on 3/20/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import "SYOptionalViewController.h"

FOUNDATION_EXTERN NSString *const SYDefaultUser;
FOUNDATION_EXTERN NSString *const SYDefaultMeasureMode;

NSString *const SYCurrentUser = @"SYCurrentUser";

@implementation SYOptionalViewController {
    SYOptionType _type;
    NSArray *_rowData;
    NSIndexPath *_selectedIndexPath;
}

#pragma mark - Desinated initializer method

- (instancetype)initWithType:(SYOptionType)type parameter:(NSString *)parameter{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _type = type;
        _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        _rowData = @[];
        
        switch (type) {
            case SYOptionTypeUserType: {
                _rowData = @[kUserA, kUserB];
            }
                break;
            case SYOptionTypeMeasureMode: {
                _rowData = @[kMeasureModeNormal, kMeasureModeAngiocarpy];
            }
                break;
            case SYOptionTypeUserChange: {
                _rowData = @[kUserA, kUserB];
            }
                break;
            default:
                break;
        }
        
        if (parameter) {
            if ([parameter isEqualToString:_rowData[1]]) {
                _selectedIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            }
        }
    }
    return self;
}

#pragma mark - View lifecycle methods

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self initWithType:SYOptionTypeNone parameter:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_rowData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell cleanUp];
    
    cell.textLabel.text = _rowData[indexPath.row];
    
    if ([indexPath isEqual:_selectedIndexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([indexPath isEqual:_selectedIndexPath]) {
        return;
    }

    if (_type == SYOptionTypeUserChange) {
        if (![SYBLTPeriHandle peripheralAvailable]) {
            SHOW_HUD(@"未连接节律仪！");
            return;
        }
    }
    
    _selectedIndexPath = indexPath;
    
    NSString *cellTitle = _rowData[indexPath.row];
    
    if (self.completionHandler) {
        self.completionHandler(_type, cellTitle);
    }
    
    [tableView reloadData];
}

@end
