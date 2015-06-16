//
//  AQTrendingGraph.h
//  AQTrendingGraph
//
//  Created by Zhanghao on 6/6/14.
//  Copyright (c) 2014 Zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AQPointType) {
    AQPointTypeNone,    // 无点
    AQPointTypeOne,     // 单点
    AQPointTypeMore     // 多点
};

@protocol AQTrendingGraphDataSource <NSObject>

@required
- (NSDictionary *)pointsDictionary;
- (NSArray *)xTitles;
- (NSInteger)maxIndex;
- (CGFloat)minY;
- (CGFloat)maxY;


@optional
- (BOOL)needInteger;

@end

@interface AQTrendingGraph : UIView

@property (nonatomic, weak) IBOutlet id<AQTrendingGraphDataSource> dataSource;
@property (nonatomic, assign) AQPointType pointType;

- (void)reloadData;

@end
