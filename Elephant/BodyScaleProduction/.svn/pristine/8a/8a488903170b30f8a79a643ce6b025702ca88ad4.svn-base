//
//  ARLineChartView.h
//  lineChartTest
//
//  Created by 刘平伟 on 14-3-21.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLineChartCell.h"
#import "ARLineInfoView.h"
#import "ARChartViewGlobal.h"

@class ARChartView;


/////dataSource

@protocol ARLineChartViewDataSource <NSObject>

-(NSInteger)numberOfPointsInLineChart:(ARChartView *)lineChart;
-(CGFloat)pointValueInLineChart:(ARChartView *)lineChart atIndex:(NSInteger)index;
-(NSString *)pointTitleInLineChart:(ARChartView *)lineChart atIndex:(NSInteger)index;

@end

////////delegate

@protocol ARLineChartViewDelegate <NSObject>

@optional
-(UIColor *)lineChart:(ARChartView *)lineChart lineColorAtIndex:(NSInteger)index;
-(void)lineChart:(ARChartView *)lineChart didSelectPointAtIndex:(NSInteger)index;

@end

////////CHART

@interface ARChartView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet id<ARLineChartViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id<ARLineChartViewDelegate> delegate;
@property (nonatomic, assign) CGFloat maxYValue;//必须设置，代表Y轴的最大刻度
////just use as line type
@property (nonatomic, strong) UIColor *dialLineColor;

@property (nonatomic, strong) NSArray *YDialTitles;

-(void)reloadData;

-(void)selectPointAtIndex:(NSUInteger)index;

@end
