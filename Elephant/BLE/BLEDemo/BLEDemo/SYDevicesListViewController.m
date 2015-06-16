//
//  SYDevicesListViewController.m
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-26.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYDevicesListViewController.h"

@interface SYDevicesListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SYDevicesListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return SYBLTPeriHandle.peripherals.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    if (indexPath.row < SYBLTPeriHandle.peripherals.count) {
         cell.textLabel.text = [SYBLTPeriHandle.peripherals[indexPath.row] name];
    }
    return cell;
}

#pragma mark ---- delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (SYBLTPeriHandle.curConnectPeripheral) {
        [SYBLTPeriHandle cancleConnectPeripheral:SYBLTPeriHandle.curConnectPeripheral];   
    }
    [SYBLTPeriHandle connectToPeripheral:SYBLTPeriHandle.peripherals[indexPath.row]];
}

#pragma mark - /////

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
