//
//  ARLineChartView.m
//  lineChartTest
//
//  Created by 刘平伟 on 14-3-21.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "ARLineChartView.h"

#define kLineCellReuseIdentifier               @"line__cell"
#define kLineCellDefaultWidth                  30
#define kLineCellDefaultLineColor     [UIColor blackColor]

@interface ARLineChartView ()

@property (nonatomic, assign) NSInteger countOfPoints;
@property (nonatomic, assign) CGFloat YUnitRealValue;
@property (nonatomic, assign) CGFloat height;

@end

@implementation ARLineChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

-(void)setMaxYValue:(CGFloat)maxYValue
{
    _maxYValue = maxYValue;
    [self initConfig];
}

-(void)initConfig
{
    self.lineColor = kLineCellDefaultLineColor;
    _height = CGRectGetHeight(self.frame);
    _YUnitRealValue = _height/_maxYValue;
    self.clipsToBounds = YES;
    [self registerClass:[ARLineChartCell class] forCellWithReuseIdentifier:kLineCellReuseIdentifier];
    self.dataSource = self;
    self.delegate = self;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(kLineCellDefaultWidth, CGRectGetHeight(self.frame));
    self.collectionViewLayout = flowLayout;
}

#pragma mark -  UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    if (self.lineDataSource) {
        _countOfPoints = [self.lineDataSource numberOfPointsInLineChart:self];
        return _countOfPoints;
    }
    return 0;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(100, 400);
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ARLineChartCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kLineCellReuseIdentifier forIndexPath:indexPath];
    cell.lineColor = self.lineColor;
    CGFloat startV = [self.lineDataSource
                      pointValueInLineChart:self
                      atIndex:indexPath.row];
    startV = _height - startV*_YUnitRealValue;
    CGFloat endV = startV;
    if (indexPath.row + 1 < _countOfPoints) {
        
       endV = [self.lineDataSource
            pointValueInLineChart:self
                    atIndex:indexPath.row + 1];
         endV = _height - endV*_YUnitRealValue;
    }
    [cell setStartValue:startV endValue:endV];
    
    NSString *title = [self.lineDataSource pointTitleInLineChart:self atIndex:indexPath.row];
    cell.title = title;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate methods

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ARLineChartCell *cell = (ARLineChartCell *)[self cellForItemAtIndexPath:indexPath];
    NSLog(@"index path is (%d  %d) %@",indexPath.row,indexPath.section,cell.title);
}

@end
