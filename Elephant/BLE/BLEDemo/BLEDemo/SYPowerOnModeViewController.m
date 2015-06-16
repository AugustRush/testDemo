//
//  SYPowerOnModeViewController.m
//  BLEDemo
//
//  Created by Zhanghao on 3/20/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import "SYPowerOnModeViewController.h"
#import "SYOptionalViewController.h"
#import "SYStatus.h"

NSString *const SYDefaultUser = @"SYDefaultUser";
NSString *const SYDefaultMeasureMode = @"SYDefaultMeasureMode";

@implementation SYPowerOnModeViewController {
    UISwitch *_beepSwith;
    UISwitch *_continuousMeasureSwith;
    
    NSArray *_rowTitles;
    NSMutableArray *_rowData;
}

#pragma mark - View lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveData:)];
    
    _beepSwith = [[UISwitch alloc] init];
    _continuousMeasureSwith = [[UISwitch alloc] init];
    
    _rowTitles = @[@[@"开机用户"], @[@"开机测量模式"], @[@"开机提示音", @"开机连续测量"]];

    NSMutableArray *section1 = [NSMutableArray arrayWithObject:kUserA];
    NSMutableArray *section2 = [NSMutableArray arrayWithObject:kMeasureModeNormal];
    NSMutableArray *section3 = [NSMutableArray arrayWithObjects:@(YES), @(YES), nil];
    _rowData = [NSMutableArray arrayWithObjects:section1, section2, section3, nil];
    
    [self setUpSystemInfo];
}

#pragma mark - Private methods

- (void)setUpSystemInfo {
    
    if ([SYBLTPeriHandle peripheralAvailable]) {

        [SYBLTPeriHandle sendData:[AQAPIs getSystemStatus]
                    responseBlock:^(NSString *response, NSString *UUID) {
                        if ([response length] == 23) {
                            SYStatus *status = [[SYStatus alloc] initWithResponse:response];
                            
                            NSMutableArray *section1 = [NSMutableArray arrayWithObject:status.defaultUser];
                            NSMutableArray *section2 = [NSMutableArray arrayWithObject:status.defaultMeasureMode];
                            NSMutableArray *section3 = [NSMutableArray arrayWithObjects:@(status.defaultBeepMode), @(status.defaultContinuousMeasure), nil];
                            
                            _rowData = [NSMutableArray arrayWithObjects:section1, section2, section3, nil];
                            [self.tableView reloadData];
                        }
                    } failedBlock:^(NSError *err) {
                        
                    }];
    }
}

#pragma mark - Custom action methods

- (void)saveData:(UIBarButtonItem *)barButton {
    if ([SYBLTPeriHandle peripheralAvailable]) {
    
        AQPickMode beep = AQPickModeKeepIntact;
        AQUserType user = AQUserTypeA;
        AQMeasuerMode mearsure = AQMeasuerModeKeepIntact;
        AQPickMode continuous = AQPickModeKeepIntact;
    
    UITableViewCell *userCell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *measureCell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
        if ([userCell.detailTextLabel.text isEqualToString:kUserA]) {
            user = AQUserTypeA;
        } else if ([userCell.detailTextLabel.text isEqualToString:kUserB]) {
            user = AQUserTypeB;
        }
        
        if ([measureCell.detailTextLabel.text isEqualToString:kMeasureModeNormal]) {
            mearsure = AQMeasuerModeNormal;
        } else if ([measureCell.detailTextLabel.text isEqualToString:kMeasureModeAngiocarpy]) {
            mearsure = AQMeasuerModeAngiocarpy;
        }
        
        if (_beepSwith.isOn) {
            beep = AQPickModeTurnOn;
        } else {
            beep = AQPickModeTurnOff;
        }
        
        if (_continuousMeasureSwith.isOn) {
            continuous = AQPickModeTurnOn;
        } else {
            continuous = AQPickModeTurnOff;
        }

        NSData *instruction = [AQAPIs setDefaultPowerOnModeNeededBeep:beep
                                                             userName:user
                                                          measureMode:mearsure
                                                    continuousMeasure:continuous];
        
        [SYBLTPeriHandle sendData:instruction
                    responseBlock:^(NSString *response, NSString *UUID) {
                        if ([[response substringFromIndex:response.length - 4 length:3] isEqualToString:@"Suc"]) {
                            [self showSuccessHudInWindowWithText:@"设置成功" dismissAfterDelay:1.0f];
                        } else {
                            [self showSuccessHudInWindowWithText:@"设置失败" dismissAfterDelay:1.0f];
                        }
                    } failedBlock:^(NSError *err) {
                        [self showSuccessHudInWindowWithText:@"设置失败" dismissAfterDelay:1.0f];
                    }];
    } else {
        SHOW_HUD(@"未连接节律仪");
    }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_rowTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_rowTitles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    [cell cleanUp];
    
    cell.textLabel.text = _rowTitles[indexPath.section][indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == [_rowTitles count] - 1) {
        NSArray *info = _rowData[indexPath.section];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row == 0) {
            cell.accessoryView = _beepSwith;
            [_beepSwith setOn:[info[indexPath.row] boolValue]];
        } else if (indexPath.row == 1) {
            cell.accessoryView = _continuousMeasureSwith;
            [_continuousMeasureSwith setOn:[info[indexPath.row] boolValue]];
        }
    } else  {
        cell.detailTextLabel.text = _rowData[indexPath.section][indexPath.row];
    }
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSString *parameter = _rowData[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        
        SYOptionalViewController *vc = [[SYOptionalViewController alloc] initWithType:SYOptionTypeUserType parameter:parameter];
        vc.navigationItem.title = @"选择用户";
        vc.completionHandler = ^(SYOptionType type, NSString *value) {
            cell.detailTextLabel.text = value;
            [_rowData[indexPath.section] replaceObjectAtIndex:0 withObject:value];
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.section == 1) {
        SYOptionalViewController *vc = [[SYOptionalViewController alloc] initWithType:SYOptionTypeMeasureMode parameter:parameter];
        vc.navigationItem.title = @"测量模式";
        vc.completionHandler = ^(SYOptionType type, NSString *value) {
            cell.detailTextLabel.text = value;
            [_rowData[indexPath.section] replaceObjectAtIndex:0 withObject:value];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
