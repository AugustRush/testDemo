//
//  SYViewController.m
//  lineChartTest
//
//  Created by 刘平伟 on 14-3-21.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYViewController.h"
#import "SYMeasureHistoryDataOBJ.h"

@interface SYViewController ()<ARLineChartViewDataSource,ARLineChartViewDelegate>

@property (nonatomic, strong) NSMutableArray *linePoints;

@property (weak, nonatomic) IBOutlet ARChartView *lineChart;
- (IBAction)ButtonTest:(id)sender;

@end

@implementation SYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.linePoints = [NSMutableArray array];
//    for (int i = 0; i < 200; i++) {
//        SYMeasureHistoryDataOBJ *obj = [[SYMeasureHistoryDataOBJ alloc] init];
//        obj.SBP = arc4random()%200;
//        obj.DBP = arc4random()%200;
//        obj.HR = arc4random()%200;
//        obj.measureTime = [NSString stringWithFormat:@"%dtest",i];
//        [self.linePoints addObject:obj];
//    }
    
    self.lineChart.dataSource = self;
    self.lineChart.delegate = self;
    self.lineChart.maxYValue = 200;
//    self.lineChart.YDialTitles = @[@"100",@"200",@"300"];
//    [self.lineChart reloadData];
    
}

#pragma mark -- line data source

-(NSInteger)numberOfPointsInLineChart:(ARChartView *)lineChart
{
    return self.linePoints.count;
}

-(CGFloat)pointValueInLineChart:(ARChartView *)lineChart atIndex:(NSInteger)index
{
    return [(SYMeasureHistoryDataOBJ *)self.linePoints[index] SBP];
}

-(NSString *)pointTitleInLineChart:(ARChartView *)lineChart atIndex:(NSInteger)index
{
    return [(SYMeasureHistoryDataOBJ *)self.linePoints[index] measureTime];
}

#pragma mark - delegate methods

-(UIColor *)lineChart:(ARChartView *)lineChart lineColorAtIndex:(NSInteger)index
{
    return [UIColor whiteColor];//[self randomColor];
}

-(void)lineChart:(ARChartView *)lineChart didSelectPointAtIndex:(NSInteger)index
{
    NSLog(@"did select point index is %ld",(long)index);
}


- (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark ---

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)ButtonTest:(id)sender {
    
    [self.linePoints removeAllObjects];
    for (int i = 0; i < 200; i++) {
        SYMeasureHistoryDataOBJ *obj = [[SYMeasureHistoryDataOBJ alloc] init];
        obj.SBP = arc4random()%200;
        obj.DBP = arc4random()%200;
        obj.HR = arc4random()%200;
        obj.measureTime = [NSString stringWithFormat:@"%dtest",i];
        [self.linePoints addObject:obj];
    }
    self.lineChart.dialLineColor = [UIColor whiteColor];
    self.lineChart.YDialTitles = @[@"100",@"200",@"300",@"234",@"34r3"];
    [self.lineChart reloadData];
}
@end
