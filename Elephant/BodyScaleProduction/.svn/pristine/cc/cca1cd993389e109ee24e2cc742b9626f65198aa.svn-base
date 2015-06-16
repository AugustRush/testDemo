//
//  SelectDeviceViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-6-7.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "SelectDeviceViewController.h"
#import "ScaleTableViewCell.h"
#import "BTModel.h"

@interface SelectDeviceViewController () <CBCentralManagerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SelectDeviceViewController {
    NSMutableArray          *_peripherals;
    CBCentralManager        *_manager;
    
    BOOL _selectNew;
}

- (void)dealloc {
    if (_selectNew) {
        [[BTModel sharedInstance] breakConnectPeripheral];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"切换设备";
        _peripherals = [NSMutableArray array];
        _selectNew = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    [_manager scanForPeripheralsWithServices:nil options:0];
    NSLog(@"开始搜索设备");
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"发现设备");
    if ([peripheral.name isEqualToString:@"RyFit"] || [peripheral.name isEqualToString:@"ChronoCloud"]) {
        [_peripherals addObject:peripheral];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_peripherals.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

#pragma mark - Actions
- (IBAction)searchButtonAction:(id)sender {
    [_peripherals removeAllObjects];
    [self.tableView reloadData];
    [_manager stopScan];
    [_manager scanForPeripheralsWithServices:nil options:0];
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _peripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ScaleTableViewCell";
    ScaleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ScaleTableViewCell" owner:self options:nil] lastObject];
    }
    
    NSString *uuidString = @"";
    CBPeripheral *peripheral = (CBPeripheral *)_peripherals[indexPath.row];
    if (IS_IOS7) {
        CFStringRef s = CFUUIDCreateString(NULL, [peripheral UUID]);
        uuidString = (__bridge_transfer NSString *)s;
    }
    
    [cell setBodyScaleName:peripheral.name image:nil uuid:uuidString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CBPeripheral *peripheral = _peripherals[indexPath.row];
    CFStringRef uuidRef = CFUUIDCreateString(kCFAllocatorDefault, peripheral.UUID);
    NSString *UUID = (__bridge_transfer NSString *)uuidRef;
    [userDefaults setObject:UUID forKey:kLAST_CONNECTED_DEVICE_UUID_KEY];
    _selectNew = YES;
}

@end
