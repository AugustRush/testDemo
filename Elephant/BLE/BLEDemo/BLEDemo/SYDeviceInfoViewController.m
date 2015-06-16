//
//  SYDeviceInfoViewController.m
//  BLEDemo
//
//  Created by Zhanghao on 3/19/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import "SYDeviceInfoViewController.h"

@implementation SYDeviceInfoViewController {
    NSArray *_rowData;
    NSArray *_deviceInfo;
}

#pragma mark - View lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rowData = @[];
    _deviceInfo = @[];

    if ([SYBLTPeriHandle peripheralAvailable]) {
        [SYBLTPeriHandle sendData:[AQAPIs getDeviceInfo]
                    responseBlock:^(NSString *response, NSString *UUID) {
                        [self handlingResponse:response];
                    } failedBlock:^(NSError *err) {
                        
                    }];
    }
}

#pragma mark - Private methods

- (void)handlingResponse:(NSString *)response {
    if ([response length] == 13) {
        
        _rowData = @[@"设备名", @"版本号"];
        
        NSString *deviceName = [response substringFromIndex:4 length:4];
        NSString *version = [response substringFromIndex:10 length:2];
        _deviceInfo = @[deviceName, version];
        
        dispatch_async(MAIN_QUEUE, ^{
            [self.tableView reloadData];
        });
    }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_rowData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    [cell cleanUp];
    
    cell.textLabel.text = _rowData[indexPath.row];
    cell.detailTextLabel.text = _deviceInfo[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
