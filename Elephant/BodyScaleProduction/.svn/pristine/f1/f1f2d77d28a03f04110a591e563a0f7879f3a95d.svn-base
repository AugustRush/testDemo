//
//  ARLineChartView.m
//  lineChartTest
//
//  Created by 刘平伟 on 14-3-21.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "ARChartView.h"

@interface ARChartView ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger countOfPoints;
@property (nonatomic, assign) CGFloat YUnitRealValue;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) ARLineInfoView *infoView;

@property (nonatomic, assign) BOOL notFirstConfig;

@end

@implementation ARChartView

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

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
}

#pragma mark - custom /////

-(void)setMaxYValue:(CGFloat)maxYValue
{
    _maxYValue = maxYValue;
    if (_notFirstConfig) {
        _height = CGRectGetHeight(self.frame)- kDefaultXDialTitleHeight;
        _YUnitRealValue = _height/_maxYValue;
        return;
    }
    [self initConfig];
}

-(void)initConfig
{
    self.notFirstConfig = YES;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 0);
    flowLayout.itemSize = CGSizeMake(kLineCellDefaultWidth, CGRectGetHeight(self.frame));

    
    self.collectionView = [[UICollectionView alloc]
                           initWithFrame:CGRectMake(kDefauletYDialTitleWidth, 0, CGRectGetWidth(self.frame)-kDefauletYDialTitleWidth, CGRectGetHeight(self.frame))
                           collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[ARLineChartCell class] forCellWithReuseIdentifier:kLineCellReuseIdentifier];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    
    ARLineInfoView *infoView = [[ARLineInfoView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    [self.collectionView addSubview:infoView];
    self.infoView = infoView;

    _height = CGRectGetHeight(self.frame)- kDefaultXDialTitleHeight;
    _YUnitRealValue = _height/_maxYValue;
    self.clipsToBounds = YES;
}

-(void)setYDialTitles:(NSArray *)YDialTitles
{
    _YDialTitles = YDialTitles;
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect
{
    if (!self.YDialTitles) {
        return;
    }
    
    //x轴
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, self.dialLineColor.CGColor);
    CGContextMoveToPoint(line, kDefauletYDialTitleWidth,  0);    //开始画线
    CGContextSetLineWidth(line, 2);
    CGContextAddLineToPoint(line, kDefauletYDialTitleWidth, CGRectGetHeight(self.frame)-kDefaultXDialTitleHeight);
    CGContextStrokePath(line);
    
    //y轴
    CGContextMoveToPoint(line, kDefauletYDialTitleWidth,  CGRectGetHeight(self.frame)-kDefaultXDialTitleHeight);    //开始画线
    CGContextSetLineWidth(line, 2);
    CGContextAddLineToPoint(line, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-kDefaultXDialTitleHeight);
    CGContextStrokePath(line);

    
    CGFloat lengths[] = {3,8};
    CGFloat yUnitHeight = _height/self.YDialTitles.count;
    for (int i = 0; i < self.YDialTitles.count; i++) {
        
        [[UIColor grayColor] setFill];
        CGPoint startP = CGPointMake(0, i*yUnitHeight);
        NSString *title = self.YDialTitles[i];
        [title drawAtPoint:startP withFont:kDefaultDialTitleFont];
        
//        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, self.dialLineColor.CGColor);
        CGContextSetLineDash(line, kDefauletYDialTitleWidth, lengths, 2);  //画虚线
        CGContextMoveToPoint(line, kDefauletYDialTitleWidth,  i*yUnitHeight+1);    //开始画线
        CGContextAddLineToPoint(line, CGRectGetWidth(self.frame), i*yUnitHeight+1);
        CGContextStrokePath(line);
    }
    
}

-(void)reloadData
{
    _countOfPoints = 0;
    self.infoView.hidden = YES;
    [self.collectionView reloadData];
//    [self.collectionView setContentOffset:CGPointMake(0, 0)];
}

-(void)selectPointAtIndex:(NSUInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    
//    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
//    [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//
//    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

#pragma mark -  UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    if (self.dataSource) {
        _countOfPoints = [self.dataSource numberOfPointsInLineChart:self];
        return _countOfPoints;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ARLineChartCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kLineCellReuseIdentifier forIndexPath:indexPath];
    cell.selectLineColor = self.dialLineColor;
    if ([self.delegate respondsToSelector:@selector(lineChart:lineColorAtIndex:)]) {
        cell.lineColor = [self.delegate lineChart:self lineColorAtIndex:indexPath.row];
    }
    
    /**
     *  去掉最后一根线的颜色
     */
    if (indexPath.row == _countOfPoints-1) {
        cell.lineColor = [UIColor clearColor];
    }
    
    
    CGFloat startV = [self.dataSource
                      pointValueInLineChart:self
                      atIndex:indexPath.row];
    cell.infoTitle = [NSString stringWithFormat:@"%.1f",startV];
    startV = _height - startV*_YUnitRealValue;
    CGFloat endV = startV;
    if (indexPath.row + 1 < _countOfPoints) {
        
       endV = [self.dataSource
            pointValueInLineChart:self
                    atIndex:indexPath.row + 1];
         endV = _height - endV*_YUnitRealValue;
    }
    [cell setStartValue:startV endValue:endV];
    
    NSString *title = [self.dataSource pointTitleInLineChart:self atIndex:indexPath.row];
    cell.title = title;
    return cell;
}

#pragma mark - UICollectionViewDelegate methods

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ARLineChartCell *cell = (ARLineChartCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame;
    NSLog(@"cell is %@,\n point is %f",cell,cell.Point.y );
    self.infoView.hidden = NO;
    if (cell.Point.y > kDefaultInfoViewHeight + 10) {
        
       if (CGRectGetMinX(cell.frame) < kDefaultInfoViewWidth/2){
        
            frame = CGRectMake(CGRectGetMinX(cell.frame)+2,
                               cell.Point.y - kDefaultInfoViewHeight - 12,
                               kDefaultInfoViewWidth,
                               kDefaultInfoViewHeight);
            self.infoView.frame = frame;
            self.infoView.arrowDirection = ARLineInfoViewArrowDirectionLeftBottom;
        }else if (CGRectGetMaxX(cell.frame) > self.collectionView.contentSize.width - kDefaultInfoViewWidth/2 ){
            frame = CGRectMake(CGRectGetMinX(cell.frame)-kDefaultInfoViewWidth-2,
                               cell.Point.y-kDefaultInfoViewHeight - 10,
                               kDefaultInfoViewWidth,
                               kDefaultInfoViewHeight);
            self.infoView.frame = frame;
            self.infoView.arrowDirection = ARLineInfoViewArrowDirectionRightBottom;
        }else{
            frame = CGRectMake(CGRectGetMinX(cell.frame)-kDefaultInfoViewWidth/2,
                               cell.Point.y - kDefaultInfoViewHeight - 12,
                               kDefaultInfoViewWidth,
                               kDefaultInfoViewHeight);
            self.infoView.frame = frame;
            self.infoView.arrowDirection = ARLineInfoViewArrowDirectionBottom;
        }
        
        
    }else{
        
        if (CGRectGetMinX(cell.frame) < kDefaultInfoViewWidth/2){
            
            frame = CGRectMake(CGRectGetMinX(cell.frame)+2,
                               cell.Point.y + kDefaultInfoViewHeight/2 ,
                               kDefaultInfoViewWidth,
                               kDefaultInfoViewHeight);
            self.infoView.frame = frame;
            self.infoView.arrowDirection = ARLineInfoViewArrowDirectionLeftTop;
        }else if (CGRectGetMaxX(cell.frame) > self.collectionView.contentSize.width - kDefaultInfoViewWidth/2 ){
            frame = CGRectMake(CGRectGetMinX(cell.frame)-kDefaultInfoViewWidth-2,
                               cell.Point.y+kDefaultInfoViewHeight/2,
                               kDefaultInfoViewWidth,
                               kDefaultInfoViewHeight);
            self.infoView.frame = frame;
            self.infoView.arrowDirection = ARLineInfoViewArrowDirectionRightTop;
        }else{
            frame = CGRectMake(CGRectGetMinX(cell.frame)-kDefaultInfoViewWidth/2,
                               cell.Point.y + kDefaultInfoViewHeight/2,
                               kDefaultInfoViewWidth,
                               kDefaultInfoViewHeight);
            self.infoView.frame = frame;
            self.infoView.arrowDirection = ARLineInfoViewArrowDirectionTop;
        }

    }
    
    self.infoView.titleLabel.text = cell.infoTitle;
    [self.collectionView bringSubviewToFront:self.infoView];
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(lineChart:didSelectPointAtIndex:)]) {
        [self.delegate lineChart:self didSelectPointAtIndex:indexPath.row];
    }
}

@end
