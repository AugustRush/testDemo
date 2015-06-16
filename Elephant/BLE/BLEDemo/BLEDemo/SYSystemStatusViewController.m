//
//  SYSystemStatusViewController.m
//  BLEDemo
//
//  Created by Zhanghao on 3/19/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import "SYSystemStatusViewController.h"
#import "SYStatus.h"

@implementation SYSystemStatusViewController {
    NSArray *_rowData;
    NSArray *_systemInfo;
}

#pragma mark - View lifecycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([SYBLTPeriHandle peripheralAvailable]) {
        
        [SYBLTPeriHandle sendData:[AQAPIs getSystemStatus]
                    responseBlock:^(NSString *response, NSString *UUID) {
                        [self handlingResponse:response];
                    } failedBlock:^(NSError *err) {

                    }];
    }
}

#pragma mark - Private methods

- (void)setUp {
    _rowData = @[];
    _systemInfo = @[];
}

- (void)handlingResponse:(NSString *)response {
    if ([response length] == 23) {
        
        _rowData = @[
                     @[@"当前用户", @"当前测量模式", @"已开启提示音", @"已开启连续测量"],
                     @[@"开机默认用户", @"开机默认测量模式", @"开机是否开启提示音", @"开机是否开启连续测量"],
                     @[@"当前电池电量"]];
        
        SYStatus *status = [[SYStatus alloc] initWithResponse:response];
        
        _systemInfo = @[@[
                            status.currentUser,
                            status.currentMeasureMode,
                            BoolString(status.currentBeepMode),
                            BoolString(status.currentContinuousMeasure)
                            ],
                        @[
                            status.defaultUser,
                            status.defaultMeasureMode,
                            BoolString(status.defaultBeepMode),
                            BoolString(status.defaultContinuousMeasure)
                            ],
                        @[[NSString stringWithFormat:@"%d%%", (int)status.poweLevel]]
                        ];
        
        dispatch_async(MAIN_QUEUE, ^{
            [self.tableView reloadData];
        });
    }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_rowData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_rowData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    [cell cleanUp];
    
    cell.textLabel.text = _rowData[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = _systemInfo[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
