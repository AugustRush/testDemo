//
//  SYMeasureViewController.m
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-18.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYMeasureViewController.h"
#import "SYDevicesListViewController.h"

@import QuartzCore;

@interface SYMeasureViewController ()

@property (weak, nonatomic) IBOutlet UIButton *stopMeasureButton;
@property (weak, nonatomic) IBOutlet UIButton *startMeasureButton;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *hyperpiesiaView;
@property (weak, nonatomic) IBOutlet UIView *hypotensionView;
@property (weak, nonatomic) IBOutlet UIView *heartRateView;
@property (weak, nonatomic) IBOutlet UILabel *hyperpiesiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *hypotensionLabel;
@property (weak, nonatomic) IBOutlet UILabel *heartRateLabel;

@end

@implementation SYMeasureViewController {
    UIView *_loadingView;
    UIActivityIndicatorView *_indicator;
    BOOL _isMeasuring;
}

#pragma mark - View lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isMeasuring = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshDevice:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(selectDevice:)];
    
    _hyperpiesiaView.layer.cornerRadius = CGRectGetWidth(_hyperpiesiaView.bounds) / 2;
    _hyperpiesiaView.layer.borderColor = [SYColor(189, 247, 68) CGColor];
    _hyperpiesiaView.layer.borderWidth = 2.0f;
    
    _hypotensionView.layer.cornerRadius = CGRectGetWidth(_hypotensionView.bounds) / 2;
    _hypotensionView.layer.borderColor = [SYColor(95, 248, 251) CGColor];
    _hypotensionView.layer.borderWidth = 2.0f;
    
    _heartRateView.layer.cornerRadius = CGRectGetWidth(_heartRateView.bounds) / 2;
    _heartRateView.layer.borderColor = [SYColor(98, 94, 135) CGColor];
    _heartRateView.layer.borderWidth = 2.0f;

    _startMeasureButton.layer.cornerRadius = CGRectGetWidth(_startMeasureButton.bounds) / 2;
    _startMeasureButton.layer.borderColor = [MEASUER_BUTTON_NORMAL_TEXT_COLOR CGColor];
    _startMeasureButton.layer.borderWidth = 1.0f;
    
    _stopMeasureButton.layer.cornerRadius = CGRectGetWidth(_stopMeasureButton.bounds) / 2;
    _stopMeasureButton.layer.borderColor = [MEASUER_BUTTON_SELECTED_TEXT_COLOR CGColor];
    _stopMeasureButton.layer.borderWidth = 1.0f;
    
    _loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.center = CGPointMake(30 + CGRectGetMidX(_indicator.bounds), CGRectGetMidY(_loadingView.frame));
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_indicator.bounds) + 40, 9, 100, 26)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"测量中...";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    _loadingView.backgroundColor = [UIColor clearColor];
    [_loadingView addSubview:_indicator];
    [_loadingView addSubview:titleLabel];
}

#pragma mark - Private methods

- (void)showMeasureInfo:(NSString *)info {
    NSString *hyperpiesia = [info substringWithRange:NSMakeRange(10, 3)];
    NSString *hypotension = [info substringWithRange:NSMakeRange(13, 3)];
    NSString *heartRate = [info substringWithRange:NSMakeRange(16, 3)];
    
    _hyperpiesiaLabel.text = IntString((int)[hyperpiesia integerValue]);
    _hypotensionLabel.text = IntString((int)[hypotension integerValue]);
    _heartRateLabel.text = IntString((int)[heartRate integerValue]);
}

- (void)showMeasureIndicator {
    _isMeasuring = YES;
    
    [_indicator startAnimating];
    self.navigationItem.titleView = _loadingView;
    
    _hyperpiesiaLabel.text = @"0";
    _hypotensionLabel.text = @"0";
    _heartRateLabel.text = @"0";
}

- (void)stopMeasureIndicator {
    _isMeasuring = NO;
    _startMeasureButton.enabled = YES;
    _startMeasureButton.layer.borderColor = [MEASUER_BUTTON_NORMAL_TEXT_COLOR CGColor];
    
    if (_indicator.isAnimating) {
        [_indicator stopAnimating];
    }
    
    self.navigationItem.titleView = nil;
    self.navigationItem.title = @"测量";
}

- (void)startMeasure {
    if (!_isMeasuring) {
        if ([SYBLTPeriHandle peripheralAvailable]) {
            [self showMeasureIndicator];
            _startMeasureButton.enabled = NO;
            _startMeasureButton.layer.borderColor = [[UIColor darkGrayColor] CGColor];
            
            [SYBLTPeriHandle sendData:[AQAPIs measureImmediately]
                        responseBlock:^(NSString *response, NSString *UUID) {
                            [self stopMeasureIndicator];
                            [self showMeasureInfo:response];
                            
                            if ([response isEqualToString:@"0000000000000000000\0"]) {
                                SHOW_HUD(@"测量失败");
                            }
                            
                        } failedBlock:^(NSError *err) {
                            [self stopMeasureIndicator];
                        }];
        } else {
            SHOW_HUD(@"未连接节律仪");
        }
    }
}

- (void)stopMeasure {
    if ([SYBLTPeriHandle peripheralAvailable]) {
        [SYBLTPeriHandle sendData:[AQAPIs stopMeasuring] responseBlock:^(NSString *response, NSString *UUID) {
            
        } failedBlock:^(NSError *err) {
            
        }];
    } else {
        SHOW_HUD(@"未连接节律仪");
    }
}

#pragma mark - Custom action methods

-(void)selectDevice:(id)sender {
    SYDevicesListViewController *devicesListCtr = [[SYDevicesListViewController alloc] init];
    devicesListCtr.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:devicesListCtr animated:YES];
}

- (IBAction)measureImmediately:(UIButton *)sender {
    [self startMeasure];
}

- (IBAction)stopMeasure:(UIButton *)sender {
    [self stopMeasure];
    [self stopMeasureIndicator];
}

- (void)refreshDevice:(UIBarButtonItem *)button {
    [SYBLTPeriHandle refreshScanPeripherals];
}

@end
