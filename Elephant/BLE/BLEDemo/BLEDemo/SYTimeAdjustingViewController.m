//
//  SYTimeAdjustingViewController.m
//  BLEDemo
//
//  Created by Zhanghao on 3/19/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import "SYTimeAdjustingViewController.h"

@interface SYTimeAdjustingViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SYTimeAdjustingViewController {
    BOOL _pickerDidShow;
    
    NSString *_bleTime;
    NSDate *_pickDate;
    
    UIDatePicker *_datePicker;
    UIToolbar *_toolBar;
    UIView *_modalView;
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
    
    [self setUpUserInterface];
    
    if ([SYBLTPeriHandle peripheralAvailable]) {
        
        [SYBLTPeriHandle sendData:[AQAPIs getSystemTime]
                    responseBlock:^(NSString *response, NSString *UUID) {
                        if ([response length] == 13) {
                            NSString *year = [response substringFromIndex:2 length:2];
                            NSString *month = [response substringFromIndex:4 length:2];
                            NSString *day = [response substringFromIndex:6 length:2];
                            NSString *hour = [response substringFromIndex:8 length:2];
                            NSString *minite = [response substringFromIndex:10 length:2];
                            ;
                            
                            _bleTime = [NSString stringWithFormat:@"20%@-%@-%@ %@:%@", year, month, day, hour, minite];
                            [self.tableView reloadData];
                        }
                    } failedBlock:^(NSError *err) {
                        
                    }];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (!_pickerDidShow) {
        _modalView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), 320, CGRectGetHeight(_modalView.bounds));
    }
}

#pragma mark - Private methods

- (void)setUp {
    _pickerDidShow = NO;
    
    NSString *time = dateToString([NSDate date], @"yyyy-MM-dd HH:mmss");
    _bleTime = [time substringToIndex:[time length] - 2];
}

- (void)setUpUserInterface {
    _modalView = [[UIView alloc] initWithFrame:CGRectMake(0, 800, 320, 162 + 44 + 54)];
    [self.view addSubview:_modalView];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPick:)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(savePick:)];
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [_toolBar setItems:@[cancel, flexible, save]];
    
    [_modalView addSubview:_toolBar];
}

- (void)showDatePicker:(BOOL)show animated:(BOOL)animated {
    CGRect frame = _modalView.frame;
    if (show) {
        frame.origin.y -= CGRectGetHeight(_modalView.bounds);
    } else {
        frame.origin.y += CGRectGetHeight(_modalView.bounds);
    }
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            _modalView.frame = frame;
        } completion:^(BOOL finished) {
            _pickerDidShow = show;
        }];
    } else {
        _modalView.frame = frame;
    }
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 320, 162)];
        [_datePicker addTarget:self action:@selector(dateDidchange:) forControlEvents:UIControlEventValueChanged];
        [_modalView addSubview:_datePicker];
    }
//    if (_bleTime) {
//        _datePicker.date = stringToDate(_bleTime, @"yyyy-MM-dd HH:mm");
//    } else {
//        _datePicker.date = [NSDate date];
//    }
    return _datePicker;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell cleanUp];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _bleTime;
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!_pickerDidShow) {
        [self datePicker];
        [self showDatePicker:YES animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 280, 31)];
    promptLabel.backgroundColor = [UIColor clearColor];
    promptLabel.textAlignment = NSTextAlignmentLeft;
    promptLabel.text = @"点击设置节律仪的系统时间";
    promptLabel.font = [UIFont systemFontOfSize:14.0f];
    promptLabel.textColor = [UIColor darkGrayColor];
    [footerView addSubview:promptLabel];
    
    return footerView;
}

#pragma mark - Custom action methods

- (void)cancelPick:(UIBarButtonItem *)sender {
    if (_pickerDidShow) {
        [self showDatePicker:NO animated:YES];
    }
}

- (void)savePick:(UIBarButtonItem *)sender {
    if (!_pickDate) {
        _pickDate = [NSDate date];
    }
    
    if ([SYBLTPeriHandle peripheralAvailable]) {
        
        [SYBLTPeriHandle sendData:[AQAPIs setSystemTime:_pickDate]
                    responseBlock:^(NSString *response, NSString *UUID) {
                        
                        [self showSuccessHudInWindowWithText:@"设置成功" dismissAfterDelay:1.0f];
                        
                        NSString *time = dateToString(_pickDate, @"yyyy-MM-dd HH:mmss");
                        _bleTime = [time substringToIndex:[time length] - 2];
                        
                        [self.tableView reloadData];
                        
                    } failedBlock:^(NSError *err) {
                        [self showSuccessHudInWindowWithText:@"设置失败" dismissAfterDelay:1.0f];
                    }];
    } else {
        SHOW_HUD(@"未连接节律仪");
    }
    
    [self showDatePicker:NO animated:YES];
}

- (void)dateDidchange:(UIDatePicker *)picker {
    _pickDate = picker.date;
}

@end
