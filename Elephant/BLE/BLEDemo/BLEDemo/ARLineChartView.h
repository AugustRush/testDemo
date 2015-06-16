//
//  ARLineChartView.h
//  lineChartTest
//
//  Created by 刘平伟 on 14-3-21.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLineChartCell.h"

@class ARLineChartView;


/////dataSource

@protocol ARLineChartViewDataSource <NSObject>

-(NSInteger)numberOfPointsInLineChart:(ARLineChartView *)lineChart;
-(CGFloat)pointValueInLineChart:(ARLineChartView *)lineChart atIndex:(NSInteger)index;
-(NSString *)pointTitleInLineChart:(ARLineChartView *)lineChart atIndex:(NSInteger)index;

@end

////////CHART

@interface ARLineChartView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, assign) id<ARLineChartViewDataSource> lineDataSource;
@property (nonatomic, assign) CGFloat maxYValue;//必须设置，代表Y轴的最大刻度
@property (nonatomic, strong) UIColor *lineColor;

@end
