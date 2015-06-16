//
//  GKLineGraph.m
//  GraphKit
//
//  Copyright (c) 2014 Michal Konturek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "GKLineGraph.h"

#import <FrameAccessor/FrameAccessor.h>
#import <MKFoundationKit/NSArray+MK.h>

static CGFloat kDefaultLabelWidth = 40.0;
static CGFloat kDefaultLabelHeight = 12.0;
static NSInteger kDefaultValueLabelCount = 5;

static CGFloat kDefaultLineWidth = 3.0;
static CGFloat kDefaultMargin = 10.0;
static CGFloat kDefaultMarginBottom = 20.0;

static CGFloat kAxisMargin = 10.0;

@interface GKLineGraph ()

@property (nonatomic, strong) UIView *layView;
@property (nonatomic, strong) NSArray *titleLabels;
@property (nonatomic, strong) NSArray *valueLabels;

@end

@implementation GKLineGraph

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _init];
    }
    return self;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(50, 0, self.frame.size.width - 80, self.frame.size.height);
        _scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}
- (UIView *)layView
{
    if (!_layView)
    {
        _layView = [[UIView alloc] init];
        _layView.userInteractionEnabled = YES;
        _layView.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:_layView];
    }
    return _layView;
}
- (void)_init
{
    self.animated = YES;
    self.animationDuration = 1;
    self.lineWidth = kDefaultLineWidth;
    self.margin = kDefaultMargin;
    self.valueLabelCount = kDefaultValueLabelCount;
    self.clipsToBounds = YES;
}
- (void)draw
{
    NSAssert(self.dataSource, @"GKLineGraph : No data source is assgined.");
    NSInteger count = [self.dataSource numberOfLines];
    NSInteger width = count * kDefaultLabelWidth;
    if (width > self.frame.size.width - 130)
    {
        self.scrollView.contentSize = CGSizeMake(width, self.frame.size.height);
        self.layView.frame = CGRectMake(0, 0, width, self.scrollView.frame.size.height);
        self.scrollView.scrollEnabled = YES;
    }
    else
    {
        self.scrollView.scrollEnabled = NO;
        self.layView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }
    self.layView.layer.sublayers = nil;
    if ([self _hasTitleLabels])
    {
        [self _removeTitleLabels];
    }
    [self _constructTitleLabels];
    [self _positionTitleLabels];

    if ([self _hasValueLabels])
    {
        [self _removeValueLabels];
    }
    [self _constructValueLabels];
    [self _drawLines];
}
- (BOOL)_hasTitleLabels
{
    return ![self.titleLabels mk_isEmpty];
}
- (BOOL)_hasValueLabels
{
    return ![self.valueLabels mk_isEmpty];
}
- (void)_constructTitleLabels
{
    NSInteger count = [[self.dataSource valuesForLineAtIndex:0] count];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++)
    {
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth+10, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentCenter;
        item.font = [UIFont boldSystemFontOfSize:10];
        item.textColor = [UIColor lightGrayColor];
        item.text = [self.dataSource titleForLineAtIndex:idx];
        [items addObject:item];
    }
    self.titleLabels = items;
}
- (void)_removeTitleLabels
{
    [self.titleLabels mk_each:^(id item) {
        if (item == nil || ![item isKindOfClass:[UIView class]])
        {
        }
        else
        {
            [item removeFromSuperview];
        }
    }];
    self.titleLabels = nil;
}
- (void)_positionTitleLabels
{
    __block NSInteger idx = 0;
    id values = [self.dataSource valuesForLineAtIndex:0];
    [values mk_each:^(id value) {
        
        CGFloat labelWidth = kDefaultLabelWidth;
        CGFloat labelHeight = kDefaultLabelHeight;
        CGFloat startX = [self _pointXForIndex:idx] - (labelWidth / 2);
        CGFloat startY = (self.height - labelHeight);
        
        UILabel *label = [self.titleLabels objectAtIndex:idx];
        label.x = startX;
        label.y = startY;
        
        [self.layView addSubview:label];

        idx++;
    }];
}

- (CGFloat)_pointXForIndex:(NSInteger)index
{
    return kAxisMargin + self.margin + (index * [self _stepX]);
}

- (CGFloat)_stepX
{
    id values = [self.dataSource valuesForLineAtIndex:0];
    CGFloat result = ([self _plotWidth] / [values count]);
    return kDefaultLabelWidth;
}

- (void)_constructValueLabels
{
    NSInteger count = self.valueLabelCount;
    id items = [NSMutableArray arrayWithCapacity:count];
    
    for (NSInteger idx = 0; idx < 2; idx++)
    {
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentRight;
        item.font = [UIFont boldSystemFontOfSize:12];
        item.textColor = [UIColor lightGrayColor];
    
        CGFloat value = 0;
        if (idx == 0)
        {
            value = [self _minValue];
            if (value == [self _maxValue])
            {
                value = 0;
            }
        }
        else
        {
            value = [self _maxValue];
        }
        item.centerY = [self _positionYForLineValue:value];
        item.text = [@(value) stringValue];
        
        DLog(@"msg_lyywhg:~~ value ~ %f, %@", value, item.text);

        [items addObject:item];
        [self addSubview:item];
    }
    self.valueLabels = items;
}
- (CGFloat)_stepValueLabelY
{
    return (([self _maxValue] - [self _minValue]) / (self.valueLabelCount - 1));
}
- (CGFloat)_maxValue
{
    id values = [self _allValues];
    return [[values mk_max] floatValue];
}
- (CGFloat)_minValue
{
    if (self.startFromZero)
    {
        return 0;
    }
    id values = [self _allValues];
    return [[values mk_min] floatValue];
}
- (NSArray *)_allValues
{
    NSInteger count = [self.dataSource numberOfLines];
    id values = [NSMutableArray array];
    for (NSInteger idx = 0; idx < count; idx++)
    {
        id item = [self.dataSource valuesForLineAtIndex:idx];
        [values addObjectsFromArray:item];
    }
    return values;
}
- (void)_removeValueLabels
{
    [self.valueLabels mk_each:^(id item) {
        [item removeFromSuperview];
    }];
    self.valueLabels = nil;
}

- (CGFloat)_plotWidth
{
    return (self.width - (2 * self.margin) - kAxisMargin);
}

- (CGFloat)_plotHeight
{
    return (self.height - (2 * kDefaultLabelHeight + kDefaultMarginBottom));
}

- (void)_drawLines
{
    [self _drawLineAtIndex:0];
}

- (void)_drawLineAtIndex:(NSInteger)index
{
    // http://stackoverflow.com/questions/19599266/invalid-context-0x0-under-ios-7-0-and-system-degradation
    UIGraphicsBeginImageContext(self.frame.size);
    
    UIBezierPath *path = [self _bezierPathWith:0];
    CAShapeLayer *layer = [self _layerWithPath:path];
    
    layer.strokeColor = [UIColorRef(253, 132, 46) CGColor];
    
    [self.layView.layer addSublayer:layer];
    
    NSInteger idx = 0;
    id values = [self.dataSource valuesForLineAtIndex:index];
    for (id item in values)
    {
        CGFloat x = [self _pointXForIndex:idx];
        CGFloat y = [self _positionYForLineValue:[item floatValue]];
        CGPoint point = CGPointMake(x, y);
        
        if (idx != 0) [path addLineToPoint:point];
        [path moveToPoint:point];
        
        idx++;
    }
    
    layer.path = path.CGPath;
    
    if (self.animated)
    {
        CABasicAnimation *animation = [self _animationWithKeyPath:@"strokeEnd"];
        if ([self.dataSource respondsToSelector:@selector(animationDurationForLineAtIndex:)])
        {
            animation.duration = [self.dataSource animationDurationForLineAtIndex:index];
        }
        [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
    UIGraphicsEndImageContext();
}
- (void)_drawLine
{
    UIGraphicsBeginImageContext(self.frame.size);
    
    UIBezierPath *path = [self _bezierPathWith:0];
    path.lineWidth = 0.01;
    CAShapeLayer *layer = [self _layerWithPath:path];
    
    layer.strokeColor = [UIColor grayColor].CGColor;
    
    [self.layView.layer addSublayer:layer];
    
    NSInteger idx = 0;
 
    CGFloat x = [self _pointXForIndex:idx];
    CGFloat y = [self _positionYForLineValue:0];
    CGPoint point = CGPointMake(x, y);
    [path moveToPoint:point];
    [path addLineToPoint:CGPointMake((self.frame.size.width-x/2), y)];
    [path moveToPoint:point];
    [path addLineToPoint:CGPointMake(x, -(self.frame.size.height ))];
    layer.path = path.CGPath;
    UIGraphicsEndImageContext();
}
- (CGFloat)_positionYForLineValue:(CGFloat)value
{
    
    CGFloat scale = 1;
    if ([self _maxValue] == [self _minValue])
    {
        if (value == [self _minValue])
        {
            scale = 1;
        }
        else
        {
            scale = 0;
        }
    }
    else
    {
        scale = (value - [self _minValue]) / ([self _maxValue] - [self _minValue]);
    }
    CGFloat result = [self _plotHeight] * scale;
    result = ([self _plotHeight] -  result);
    result += kDefaultLabelHeight;
    DLog(@"msg_lyywhg: value %f scale %f and result %f height %f", value, scale, result, [self _plotHeight]);

    return result;
}
- (UIBezierPath *)_bezierPathWith:(CGFloat)value
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = self.lineWidth;
    return path;
}
- (CAShapeLayer *)_layerWithPath:(UIBezierPath *)path
{
    CAShapeLayer *item = [CAShapeLayer layer];
    item.fillColor = [[UIColor blackColor] CGColor];
    item.lineCap = kCALineCapRound;
    item.lineJoin  = kCALineJoinRound;
    item.lineWidth = self.lineWidth;
//    item.strokeColor = [self.foregroundColor CGColor];
    item.strokeColor = [[UIColor redColor] CGColor];
    item.strokeEnd = 1;
    return item;
}
- (CABasicAnimation *)_animationWithKeyPath:(NSString *)keyPath
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = self.animationDuration;
    animation.fromValue = @(0);
    animation.toValue = @(1);
//    animation.delegate = self;
    return animation;
}
- (void)reset
{
    self.layView.layer.sublayers = nil;
    [self _removeTitleLabels];
    [self _removeValueLabels];
}

@end
