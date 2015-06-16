//
//  SYSettingViewController.m
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-18.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYSettingViewController.h"
#import "SYSetContinuesTimeViewController.h"
#import "SYTimeAdjustingViewController.h"
#import "SYDeviceInfoViewController.h"
#import "SYSystemStatusViewController.h"
#import "SYPowerOnModeViewController.h"
#import "SYOptionalViewController.h"
#import "SYStatus.h"

@import QuartzCore;

typedef enum
{
    kDeviceSetTypeSystemContinuesMeasureSwitch,
    kDeviceSetTypeSystemNoticeMusic,
    
    kDeviceSetTypeSystemContinuesMeasureTime,
    kDeviceSetTypeSystemDefaultModel,
    kDeviceSetTypeSystemTime,
    
    kDeviceSetTypeSystemInfo,
    kDeviceSetTypeSystemStatus,
    
    kDeviceSetTypeSystemUserChange,
    
    kDeviceSetTypeSystemTurnOff
} kDeviceSetType;

typedef struct
{
    kDeviceSetType setType;
    char *info;
} kDeviceSetTypeInfo;

static const kDeviceSetTypeInfo __setTypeInfo[] = {
    {kDeviceSetTypeSystemContinuesMeasureSwitch, "连续测量"},
    {kDeviceSetTypeSystemNoticeMusic , "用户切换提示音"},
    
    {kDeviceSetTypeSystemContinuesMeasureTime , "连续测量时间段"},
    {kDeviceSetTypeSystemDefaultModel , "开机默认模式"},
    {kDeviceSetTypeSystemTime , "节律仪时间"},
    
    {kDeviceSetTypeSystemInfo , "节律仪信息"},
    {kDeviceSetTypeSystemStatus , "节律仪系统状态"},
    
    {kDeviceSetTypeSystemUserChange ,"切换用户"}
};

NSString *typeInfo(kDeviceSetType type) {
    const char *info = __setTypeInfo[type].info;
    return [NSString stringWithCString:info encoding:NSUTF8StringEncoding];
}

FOUNDATION_EXTERN NSString *const SYCurrentUser;

@interface SYSettingViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SYSettingViewController {
    UISwitch *_beepSwith;
    UISwitch *_continuousMeasureSwith;
    
    NSArray *_rowTitles;
    
    SYStatus *_status;
}

#pragma mark - View lifeCycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableFooterView];
    [self setUpSwitch];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([SYBLTPeriHandle peripheralAvailable]) {

        [SYBLTPeriHandle sendData:[AQAPIs getSystemStatus]
                    responseBlock:^(NSString *response, NSString *UUID) {
                        if (response.length == 23) {
                            _status = [[SYStatus alloc] initWithResponse:response];
                            
                            [[NSUserDefaults standardUserDefaults] setValue:_status.currentUser forKey:SYCurrentUser];
                            _beepSwith.on = _status.currentBeepMode;
                            _continuousMeasureSwith.on = _status.currentContinuousMeasure;

                            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[_rowTitles count] - 1] withRowAnimation:UITableViewRowAnimationAutomatic];
                        }

                    } failedBlock:^(NSError *err) {
                        
                    }];
    }
}

#pragma mark - Private methods

- (void)setUp {
    NSArray *turnOnSettings = @[typeInfo(kDeviceSetTypeSystemContinuesMeasureSwitch), typeInfo(kDeviceSetTypeSystemNoticeMusic)];
    
    NSArray *timeSettings = @[typeInfo(kDeviceSetTypeSystemContinuesMeasureTime),
                              typeInfo(kDeviceSetTypeSystemDefaultModel),
                              typeInfo(kDeviceSetTypeSystemTime)];
    
    NSArray *systemInfo = @[typeInfo(kDeviceSetTypeSystemInfo),
                            typeInfo(kDeviceSetTypeSystemStatus)];
    
    NSArray *switchUser = @[typeInfo(kDeviceSetTypeSystemUserChange)];
    
    _rowTitles = @[turnOnSettings, timeSettings, systemInfo, switchUser];
    
    _status = [[SYStatus alloc] init];
    _status.currentUser = kUserA;
    _status.currentBeepMode = YES;
    _status.currentContinuousMeasure = YES;
}

- (void)setUpTableFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    footerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footerView;
    
    UIButton *powerOff = [UIButton buttonWithType:UIButtonTypeCustom];
    powerOff.frame = CGRectMake(10, 10, 300, 44);
    powerOff.adjustsImageWhenHighlighted = YES;
    [powerOff setTitle:@"关闭节律仪" forState:UIControlStateNormal];
    UIImage *backgroundImage = [UIImage imageNamed:@"power_off.png"];
    UIImage *sBackgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)
                                                                resizingMode:UIImageResizingModeStretch];
    [powerOff setBackgroundImage:sBackgroundImage forState:UIControlStateNormal];
    [powerOff setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [powerOff addTarget:self action:@selector(powerOff:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:powerOff];
}

- (void)setUpSwitch {
    _beepSwith = [[UISwitch alloc] init];
    [_beepSwith addTarget:self action:@selector(beepChange:) forControlEvents:UIControlEventValueChanged];
    _continuousMeasureSwith = [[UISwitch alloc] init];
    [_continuousMeasureSwith addTarget:self action:@selector(continuousMeasureChange:) forControlEvents:UIControlEventValueChanged];
    _beepSwith.on = _status.currentBeepMode;
    _continuousMeasureSwith.on = _status.currentContinuousMeasure;
}

#pragma mark - Custom action methods

- (void)powerOff:(UIButton *)button {
    [UIAlertView showWithTitle:@"提示" message:@"确定关闭节律仪？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        if ([title isEqualToString:@"确定"]) {
            if ([SYBLTPeriHandle peripheralAvailable]) {
                [SYBLTPeriHandle sendData:[AQAPIs powerOff]
                            responseBlock:^(NSString *response, NSString *UUID) {
                    
                } failedBlock:^(NSError *err) {
                    
                }];
            } else {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    SHOW_HUD(@"未连接节律仪");
                });
                
            }
        }
    }];
}

- (void)beepChange:(UISwitch *)beep {

    if ([SYBLTPeriHandle peripheralAvailable]) {
        AQPickMode beepMode = AQPickModeKeepIntact;
        
        if (beep.isOn) {
            beepMode = AQPickModeTurnOn;
        } else {
            beepMode = AQPickModeTurnOff;
        }
        
        [SYBLTPeriHandle sendData:[AQAPIs switchBeepMode:beepMode]
                    responseBlock:^(NSString *response, NSString *UUID) {

        } failedBlock:^(NSError *err) {

        }];
    } else {
        SHOW_HUD(@"未连接节律仪");
    }
}

- (void)continuousMeasureChange:(UISwitch *)continuous {
    if ([SYBLTPeriHandle peripheralAvailable]) {
        AQPickMode continuousMode = AQPickModeKeepIntact;
        
        if (continuous.isOn) {
            continuousMode = AQPickModeTurnOn;
        } else {
            continuousMode = AQPickModeTurnOff;
        }
        
        [SYBLTPeriHandle sendData:[AQAPIs switchContinuousMeasureMode:continuousMode]
                    responseBlock:^(NSString *response, NSString *UUID) {

        } failedBlock:^(NSError *err) {
            
        }];
    } else {
        SHOW_HUD(@"未连接节律仪");
    }
}

#pragma mark - UITableViewDataSouce methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_rowTitles count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_rowTitles[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }

    [cell cleanUp];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _rowTitles[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row == 1) {
            cell.accessoryView = _beepSwith;
        } else if (indexPath.row == 0) {
            cell.accessoryView = _continuousMeasureSwith;
        }
    } else if (indexPath.section == [_rowTitles count] - 1) {
        if (_status.currentUser) {
            cell.detailTextLabel.text = _status.currentUser;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    if (section == 0) {
        title = @"设备设置";
    } else if (section == 1) {
        title = @"测量设置";
    } else if (section == 2) {
        title = @"设备信息";
    } else if (section == 3) {
        title = @"用户切换";
    }
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellTitle = cell.textLabel.text;
    
    UIViewController *viewController = nil;

    if ([cellTitle isEqualToString:typeInfo(kDeviceSetTypeSystemContinuesMeasureTime)]) {
        // 设置连续测量时间段
        SYSetContinuesTimeViewController *continusMeasureTimeViewController = [[SYSetContinuesTimeViewController alloc] init];
        viewController = continusMeasureTimeViewController;
        continusMeasureTimeViewController.navigationItem.title = @"连续测量";
        viewController.hidesBottomBarWhenPushed = YES;
        
    } else if ([cellTitle isEqualToString:typeInfo(kDeviceSetTypeSystemTime)]) {
        // 设置节律仪时间
        SYTimeAdjustingViewController *timeAdjusting = [[SYTimeAdjustingViewController alloc] init];
        timeAdjusting.navigationItem.title = @"时间";
        viewController = timeAdjusting;
        viewController.hidesBottomBarWhenPushed = YES;
        
    } else if ([cellTitle isEqualToString:typeInfo(kDeviceSetTypeSystemDefaultModel)]) {
        // 设置开机默认模式
        SYPowerOnModeViewController *powerOnMode = [[SYPowerOnModeViewController alloc] init];
        powerOnMode.navigationItem.title = @"开机设置";
        viewController = powerOnMode;
        viewController.hidesBottomBarWhenPushed = YES;
    } else if ([cellTitle isEqualToString:typeInfo(kDeviceSetTypeSystemInfo)]) {
        // 节律仪信息
        SYDeviceInfoViewController *deviceInfo = [[SYDeviceInfoViewController alloc] init];
        deviceInfo.navigationItem.title = @"信息";
        viewController = deviceInfo;
        viewController.hidesBottomBarWhenPushed = YES;
        
    } else if ([cellTitle isEqualToString:typeInfo(kDeviceSetTypeSystemStatus)]) {
        // 节律仪系统状态
        SYSystemStatusViewController *systemStatus = [[SYSystemStatusViewController alloc] init];
        systemStatus.navigationItem.title = @"系统状态";
        viewController = systemStatus;
        viewController.hidesBottomBarWhenPushed = YES;
        
    } else if ([cellTitle isEqualToString:typeInfo(kDeviceSetTypeSystemUserChange)]) {
        // 用户切换
        SYOptionalViewController *userChange = [[SYOptionalViewController alloc] initWithType:SYOptionTypeUserChange parameter:_status.currentUser];
        userChange.navigationItem.title = @"用户切换";
        userChange.completionHandler = ^(SYOptionType type, NSString *value) {
            cell.detailTextLabel.text = value;
            
            if (![_status.currentUser isEqualToString:value]) {
                _status.currentUser = value;
                
                AQUserType userType = AQUserTypeA;
                
                if ([value isEqualToString:kUserB]) {
                    userType = AQUserTypeB;
                }
                
                if ([SYBLTPeriHandle peripheralAvailable]) {
                    
                    [SYBLTPeriHandle sendData:[AQAPIs switchUser:userType]
                                responseBlock:^(NSString *response, NSString *UUID) {
                                    
                                    
                                } failedBlock:^(NSError *err) {
                                    
                                }];
                    
                } else {
                    SHOW_HUD(@"未连接节律仪");
                }
            }
        };
        viewController = userChange;
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
