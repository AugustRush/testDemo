//
//  SYMainViewController.m
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-18.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYMainViewController.h"
#import "SYMeasureHistoryDataOBJ.h"

@interface SYMainViewController ()

@end

@implementation SYMainViewController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didConnectPeripheral:) name:SYDidConnectPeripheral object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![SYUserDefaults objectForKey:SYUserMeasureHistoryDataKey]) {
    
        NSMutableArray *measureDatas = [NSMutableArray array];
        for (int i = 0; i < 100; i++) {
            SYMeasureHistoryDataOBJ *obj = [[SYMeasureHistoryDataOBJ alloc] init];
            obj.SBP = 90 + arc4random()%70;
            obj.DBP = 80 + arc4random()%30;
            obj.HR =  60 + arc4random()%40;
            obj.measureTime = [NSString stringWithFormat:@"%d",i];
            [measureDatas addObject:[obj parseToDictionary]];
        }
        [SYUserDefaults setObject:measureDatas forKey:SYUserMeasureHistoryDataKey];
    }
}

- (void)didConnectPeripheral:(NSNotification *)notification {
    [self showHudInWindowOnlyText:@"已连接节律仪" dismissAfterDelay:1.0f];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SYDidConnectPeripheral object:nil];
}

@end
