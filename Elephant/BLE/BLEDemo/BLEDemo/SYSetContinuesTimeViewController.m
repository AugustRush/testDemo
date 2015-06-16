//
//  SYSetContinuesTimeViewController.m
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-19.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYSetContinuesTimeViewController.h"
#import "CPPickerViewCell.h"
#import "CPPickerView.h"
#import "SYMeasureTimeSectionOBJ.h"

@interface SYSetContinuesTimeViewController ()

@property (nonatomic, strong) NSMutableArray *allTimeSectionData;
@property (nonatomic, assign) NSInteger startTime;
@property (nonatomic, assign) NSInteger measureFrequecy;
@property (nonatomic, assign) NSInteger measureTimes;
@property (weak, nonatomic) IBOutlet UIStepper *frequecyStepper;

@property (weak, nonatomic) IBOutlet UIStepper *measureTimesStepper;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeSectionLab;
@property (weak, nonatomic) IBOutlet UIStepper *startTimeStepper;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *measureFrequecyLad;
@property (weak, nonatomic) IBOutlet UILabel *measureTimesLad;

- (IBAction)nextTimeSectionBt:(id)sender;
- (IBAction)completeBt:(id)sender;
- (IBAction)startTimeStepper:(id)sender;
- (IBAction)measureFrequecySteper:(id)sender;
- (IBAction)measureTimeStepper:(id)sender;
- (IBAction)returnToPretimeSectionBt:(id)sender;


@end

@implementation SYSetContinuesTimeViewController

#pragma mark - View lifeCycle methods

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
    
    //init data
    self.allTimeSectionData = [NSMutableArray array];
    self.startTime = 0;
    self.measureFrequecy = 5;
    self.measureTimes = 5;
}

#pragma mark - custom event methods

-(void)setStartTime:(NSInteger)startTime
{
    _startTime = startTime;
    self.startTimeLab.text = [NSString stringWithFormat:@"%02d:00",_startTime];
}

-(void)setMeasureFrequecy:(NSInteger)measureFrequecy
{
    _measureFrequecy = measureFrequecy;
    self.measureFrequecyLad.text = [NSString stringWithFormat:@"%d 分钟",_measureFrequecy];
}

-(void)setMeasureTimes:(NSInteger)measureTimes
{
    _measureTimes = measureTimes;
    self.measureTimesLad.text = [NSString stringWithFormat:@"%d 次",_measureTimes];
}

#pragma mark - manage memory methods

-(void)dealloc
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)nextTimeSectionBt:(id)sender {
    
    if (self.allTimeSectionData.count >= 8) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您最多可以设置8个测量时间段" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    SYMeasureTimeSectionOBJ *timeSection = [[SYMeasureTimeSectionOBJ alloc] init];
    timeSection.startTime = self.startTime;
    timeSection.measureFrequecy = self.measureFrequecy;
    timeSection.measureTimes = self.measureTimes;
    [timeSection calculateEndTime];
    [self.allTimeSectionData addObject:timeSection];
    
    NSLog(@"time section end is %d  timesection count is %d",timeSection.endTime,self.allTimeSectionData.count);
    
    [self refreshSetSection];
}

-(void)refreshSetSection
{
    self.currentTimeSectionLab.text = [NSString stringWithFormat:@"已设置好的测量时间段：%d",self.allTimeSectionData.count];
    SYMeasureTimeSectionOBJ *timeSection = [self.allTimeSectionData lastObject];
    self.startTime = timeSection.endTime;
    self.startTimeStepper.minimumValue = self.startTime;
    self.measureTimesStepper.value = 1;
    self.frequecyStepper.value = 1;
    
    self.measureFrequecy = 5;
    self.measureTimes = 5;

}

- (IBAction)completeBt:(id)sender {
    
    if (self.allTimeSectionData.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"还没有设置时间段"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                            otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    NSMutableArray *inputArr = [NSMutableArray array];
    NSMutableArray *showArr = [NSMutableArray array];
    for (int i = 0; i < self.allTimeSectionData.count; i++) {
        SYMeasureTimeSectionOBJ *timeSection = _allTimeSectionData[i];
        [inputArr addObject:[NSString stringWithFormat:@"%02d00%02d%02d",timeSection.startTime,timeSection.measureFrequecy,timeSection.measureTimes]];
        [showArr addObject:[NSString stringWithFormat:@"%02d00/%02d/%02d",timeSection.startTime,timeSection.measureFrequecy,timeSection.measureTimes]];
        NSLog(@"%02d00%02d%02d\n",timeSection.startTime,timeSection.measureFrequecy,timeSection.measureTimes);
    }
    SYLog(@"%@", inputArr);
    NSData *data = [AQAPIs setContinuousMeasureSegmentsWithContents:inputArr user:AQUserTypeA];
    [SYBLTPeriHandle sendData:data responseBlock:^(NSString *response, NSString *UUID) {
        SYLog(@"RESPONSE IS %@",response);
        
        if ([response hasSuffix:@"Suc\0"]) {
            [UIAlertView showWithTitle:nil message:[NSString stringWithFormat:@"已设置好测量时间段\n%@",showArr]
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                [self.navigationController popViewControllerAnimated:YES];
            }];

        }else{
        
        
        }
        
    } failedBlock:^(NSError *err) {
        SYLog(@"ERR IS %@",err);
    }];
}

- (IBAction)startTimeStepper:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    self.startTime = stepper.value;
}

- (IBAction)measureFrequecySteper:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    self.measureFrequecy = stepper.value*5;
}

- (IBAction)measureTimeStepper:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    self.measureTimes = stepper.value*5;
}

- (IBAction)returnToPretimeSectionBt:(id)sender {
    [self.allTimeSectionData removeLastObject];
    [self refreshSetSection];
}
@end