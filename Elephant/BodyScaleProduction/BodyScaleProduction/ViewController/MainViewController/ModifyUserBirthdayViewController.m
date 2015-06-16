//
//  ModifyUserBirthdayViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-6-10.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "ModifyUserBirthdayViewController.h"
#import "AQPickerView.h"

@interface ModifyUserBirthdayViewController () <AQPickerViewDelegate>

@end

@implementation ModifyUserBirthdayViewController {
    AQPickerView *_pickerView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"修改生日";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UserInfoEntity *userInfo = [[InterfaceModel sharedInstance] getHostUser];
    
    NSInteger initialYear = 25;
    NSInteger initialMonth = 1;
    NSInteger initialDay = 1;
    
    if (userInfo.UI_age) {
        initialYear = [userInfo.UI_age intValue] + 1;
    }
    
    if (userInfo.UI_birthday.length >= 10) {
        initialMonth = [[userInfo.UI_birthday substringWithRange:NSMakeRange(5, 2)] intValue];
        initialDay = [[userInfo.UI_birthday substringWithRange:NSMakeRange(8, 2)] intValue];
    }
    
    _pickerView = [[AQPickerView alloc] initWithFrame:CGRectZero
                                           initialAge:initialYear
                                         initialMonth:initialMonth
                                           initialDay:initialDay];
    _pickerView.delegate = self;
    [self.view addSubview:_pickerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    if (!_pickerView.didShow) {
        [_pickerView show];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (_pickerView.didShow) {
        [_pickerView dismiss];
        
        NSString *birthday = [NSString stringWithFormat:@"%04d-%02d-%02d", _pickerView.cYear, _pickerView.cMonth, _pickerView.cDay];
        [[GloubleProperty sharedInstance] currentUserEntity].UI_birthday = birthday;
        [GloubleProperty sharedInstance].currentUserInfoWillUpDate = YES;
        
        if (self.userBirthdayBlock) {
            self.userBirthdayBlock(birthday);
        }
    }
}

#pragma mark - PickerView Delegate

- (void)cancelButtonTapped:(AQPickerView *)pickerView {
    
}

- (void)savedWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
}

- (void)pickerViewWillDismiss:(AQPickerView *)pickerView {
    
}

- (void)pickerViewDidDismiss:(AQPickerView *)pickerView {
    
}

@end
