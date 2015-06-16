//
//  SYMeasureDataViewController.m
//  BLEDemo
//
//  Created by 刘平伟 on 14-3-18.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYMeasureDataViewController.h"
#import "SYMeasureHistoryDataOBJ.h"

@interface SYMeasureDataViewController ()<ARLineChartViewDataSource>

@property (nonatomic, strong) NSMutableArray *linePoints;

@property (weak, nonatomic) IBOutlet UISegmentedControl *dataTypeSegment;
- (IBAction)dataTypeSegmentSelect:(id)sender;
@property (weak, nonatomic) IBOutlet ARLineChartView *lineChart;
- (IBAction)loadDataButtonClicked:(id)sender;

@end

@implementation SYMeasureDataViewController

#pragma mark - View lifeCycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.linePoints = [NSMutableArray array];
    if ([SYUserDefaults objectForKey:SYUserMeasureHistoryDataKey]) {
        
        for (NSDictionary *dict in [SYUserDefaults objectForKey:SYUserMeasureHistoryDataKey]) {
            SYMeasureHistoryDataOBJ *obj = [SYMeasureHistoryDataOBJ parseToOBJWith:dict];
            [self.linePoints addObject:obj];
        }
        
    }
    
    self.lineChart.lineDataSource = self;
    self.lineChart.maxYValue = 200;
    self.lineChart.lineColor = [UIColor yellowColor];
}

#pragma mark - custom methods

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.linePoints.count > 100) {
        [self.linePoints removeObjectAtIndex:0];
    }
    
    NSMutableArray *measureDatas = [NSMutableArray array];
    for (SYMeasureHistoryDataOBJ *obj in self.linePoints) {
        NSDictionary *dict = [obj parseToDictionary];
        [measureDatas addObject:dict]; 
    }
    [SYUserDefaults setObject:measureDatas forKey:SYUserMeasureHistoryDataKey];

}

#pragma mark -- line data source

-(NSInteger)numberOfPointsInLineChart:(ARLineChartView *)lineChart
{
    return self.linePoints.count;
}

-(CGFloat)pointValueInLineChart:(ARLineChartView *)lineChart atIndex:(NSInteger)index
{
    NSInteger segmentSelectI = self.dataTypeSegment.selectedSegmentIndex;
    switch (segmentSelectI) {
        case 0:
            return [(SYMeasureHistoryDataOBJ *)self.linePoints[index] SBP];
            break;
        case 1:
            return [(SYMeasureHistoryDataOBJ *)self.linePoints[index] DBP];
            break;

        case 2:
            return [(SYMeasureHistoryDataOBJ *)self.linePoints[index] HR];
            break;

        default:
            return 0;
            break;
    }
}

-(NSString *)pointTitleInLineChart:(ARLineChartView *)lineChart atIndex:(NSInteger)index
{
    
    NSInteger segmentSelectI = self.dataTypeSegment.selectedSegmentIndex;
    switch (segmentSelectI) {
        case 0:
            return [NSString stringWithFormat:@"%.0f",[(SYMeasureHistoryDataOBJ *)self.linePoints[index] SBP]];
            break;
        case 1:
            return [NSString stringWithFormat:@"%.0f",[(SYMeasureHistoryDataOBJ *)self.linePoints[index] DBP]];
            break;
            
        case 2:
            return [NSString stringWithFormat:@"%.0f",[(SYMeasureHistoryDataOBJ *)self.linePoints[index] HR]];
            break;
            
        default:
            return nil;
            break;
    }
}

#pragma mark - manage memory methods

-(void)dealloc {
    
}

- (IBAction)dataTypeSegmentSelect:(id)sender {
    
    [self.lineChart reloadData];
}
- (IBAction)loadDataButtonClicked:(id)sender {
    
//    [self.linePoints removeAllObjects];
    NSLog(@"get his measure data");
    NSData *data = [@"GNA\0" dataUsingEncoding:NSUTF8StringEncoding];
    [SYBLTPeriHandle sendData:data responseBlock:^(NSString *response, NSString *UUID) {
        NSArray *resposeArr = [response componentsSeparatedByString:@"E"];
        NSLog(@"response array is %@",resposeArr);
        
        for (int i = 0; i < resposeArr.count - 1; i++) {
            SYMeasureHistoryDataOBJ *measureData = [[SYMeasureHistoryDataOBJ alloc] init];
            [measureData parseWithString:resposeArr[i]];
            [self.linePoints addObject:measureData];
        }
        
        [self.lineChart reloadData];
        
    } failedBlock:^(NSError *err) {
        NSLog(@"err is %@",err);
    }];

}

@end
