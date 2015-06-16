//
//  GKBarGraph.m
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

#import "GKBarGraph.h"

#import <FrameAccessor/FrameAccessor.h>
#import <MKFoundationKit/NSArray+MK.h>

#import "GKBar.h"

static CGFloat kDefaultBarHeight = 40;
static CGFloat kDefaultBarWidth = 22;
static CGFloat kDefaultBarMargin = 40;
static CGFloat kDefaultLabelWidth = 40;
static CGFloat kDefaultLabelHeight = 15;
//static NSInteger kDefaultValueLabelCount = 5;
static CGFloat kDefaultMarginBottom = 20.0;
static CGFloat kDefaultAnimationDuration = 2.0;

@interface GKBarGraph()

@property (nonatomic, strong) NSArray *valueLabels;

@end

@implementation GKBarGraph

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
        self.backgroundColor = [UIColor clearColor];
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

- (void)_init
{
    self.animationDuration = kDefaultAnimationDuration;
    self.barHeight = kDefaultBarHeight;
    self.barWidth = kDefaultBarWidth;
    self.marginBar = kDefaultBarMargin;
}

- (void)setAnimated:(BOOL)animated
{
    _animated = animated;
    [self.bars mk_each:^(GKBar *item) {
        item.animated = animated;
    }];
}

- (void)setAnimationDuration:(CFTimeInterval)animationDuration
{
    _animationDuration = animationDuration;
    [self.bars mk_each:^(GKBar *item) {
        item.animationDuration = animationDuration;
    }];
}

- (void)setBarColor:(UIColor *)color
{
    _barColor = color;
    [self.bars mk_each:^(GKBar *item) {
        item.foregroundColor = color;
    }];
}

- (void)draw
{
    [self _construct];
    [self _drawBars];
}

- (void)_construct
{
    NSAssert(self.dataSource, @"GKBarGraph : No data source is assgined.");
    NSInteger count = [self.dataSource numberOfBars];
    NSInteger width = count * (self.barWidth+self.marginBar + 20) + 10;

    if (width > self.frame.size.width - 130)
    {
        self.scrollView.contentSize = CGSizeMake(width, self.frame.size.height);
        self.scrollView.scrollEnabled = YES;
    }
    else
    {
        self.scrollView.scrollEnabled = NO;
    }
    if ([self _hasBars])
    {
        [self _removeBars];
    }
    if ([self _hasLabels])
    {
        [self _removeLabels];
    }
    if ([self _hasValueLabels])
    {
        [self _removeValueLabels];
    }
    [self _constructValueLabels];

    [self _constructBars];
    [self _constructLabels];
    
    [self _positionBars];
    [self _positionLabels];
}

- (BOOL)_hasBars
{
    return ![self.bars mk_isEmpty];
}
- (void)_constructBars
{
    NSInteger count = [self.dataSource numberOfBars];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++)
    {
        GKBar *item = [GKBar create];
        if ([self barColor])
        {
            item.foregroundColor = [self barColor];
        }
        [items addObject:item];
    }
    self.bars = items;
}

- (void)_removeBars
{
    [self.bars mk_each:^(id item) {
        [item removeFromSuperview];
    }];
}
- (void)_positionBars
{
    CGFloat y = [self _barStartY];
    __block CGFloat x = [self _barStartX];
    [self.bars mk_each:^(GKBar *item) {
        item.frame = CGRectMake(x+15, y, _barWidth, _barHeight);
        DLog(@"msg_lyywhg: ~ bar height %f", _barHeight);
        [self.scrollView addSubview:item];
        x += [self _barSpace];
    }];
}
- (BOOL)_hasValueLabels
{
    return ![self.valueLabels mk_isEmpty];
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
            DLog(@"msg_lyywhg: ~ min value %f", value);
        }
        else
        {
            value = [self _maxValue];
            DLog(@"msg_lyywhg: ~ max value %f", value);
        }
        item.centerY = 0;
        item.centerY = [self _positionYForLineValue:((CGFloat)value)];
        item.text = [@(value) stringValue];
        
        DLog(@"msg_lyywhg:~~ value ~ %f, %@", value, item.text);
        
        [items addObject:item];
        [self addSubview:item];
    }
    self.valueLabels = items;
}
- (CGFloat)_stepValueLabelY
{
    CGFloat tFloat = (([self _maxValue] - [self _minValue]) / (self.valueLabelCount - 1));
    DLog(@"msg_lyywhg:~~ value Y ~ %f", tFloat);
    return tFloat;
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
    NSInteger count = [self.dataSource numberOfBars];
    id values = [NSMutableArray array];
    for (NSInteger idx = 0; idx < count; idx++)
    {
        id item = [self.dataSource valueForBarAtIndex:idx];
        [values addObject:item];
    }
    return values;
}
- (CGFloat)_positionYForLineValue:(CGFloat)value
{
    CGFloat scale = 0;
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
- (CGFloat)_plotHeight
{
    return (self.height - (2 * kDefaultLabelHeight + kDefaultMarginBottom));
}
- (void)_removeValueLabels
{
    [self.valueLabels mk_each:^(id item) {
        [item removeFromSuperview];
    }];
    self.valueLabels = nil;
}
- (CGFloat)_barStartX
{
    CGFloat result = self.width;
    CGFloat item = [self _barSpace];
    NSInteger count = [self.dataSource numberOfBars];
    
    result = result - (item * count) + self.marginBar;
    result = (result / 2);
    DLog(@"msg_lyywhg:~~ item %f result %f", item, result);  // 不需要自适应
    return 10;
}

- (CGFloat)_barSpace
{
    return (self.barWidth + self.marginBar + 20);
}
- (CGFloat)_barStartY
{
    return (self.height - self.barHeight);
}
- (BOOL)_hasLabels
{
    return ![self.labels mk_isEmpty];
}
- (void)_constructLabels
{
    NSInteger count = [self.dataSource numberOfBars];
    id items = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger idx = 0; idx < count; idx++)
    {
        CGRect frame = CGRectMake(0, 0, kDefaultLabelWidth+10, kDefaultLabelHeight);
        UILabel *item = [[UILabel alloc] initWithFrame:frame];
        item.textAlignment = NSTextAlignmentCenter;
        item.font = [UIFont boldSystemFontOfSize:10];
        item.textColor = [UIColor lightGrayColor];
        item.text = [self.dataSource titleForBarAtIndex:idx];
        
        [items addObject:item];
    }
    self.labels = items;
}
- (void)_removeLabels
{
    [self.labels mk_each:^(id item) {
        [item removeFromSuperview];
    }];
}
- (void)_positionLabels
{
    __block NSInteger idx = 0;
    [self.bars mk_each:^(GKBar *bar) {
        
        CGFloat labelWidth = kDefaultLabelWidth;
        CGFloat labelHeight = kDefaultLabelHeight;
        CGFloat startX = bar.x - ((labelWidth - self.barWidth) / 2);
        CGFloat startY = (self.height - labelHeight);
        
        UILabel *label = [self.labels objectAtIndex:idx];
        label.x = startX;
        label.y = startY;
        
        [self.scrollView addSubview:label];
        
        bar.y -= labelHeight + 5;
        idx++;
    }];
}
- (void)_drawBars
{
    __block NSInteger idx = 0;
    id source = self.dataSource;
    [self.bars mk_each:^(GKBar *item) {
        
        if ([source respondsToSelector:@selector(animationDurationForBarAtIndex:)])
        {
            item.animationDuration = [source animationDurationForBarAtIndex:idx];
        }
        if ([source respondsToSelector:@selector(colorForBarAtIndex:)])
        {
            item.foregroundColor = [source colorForBarAtIndex:idx];
        }
        if ([source respondsToSelector:@selector(colorForBarBackgroundAtIndex:)])
        {
            item.backgroundColor = [source colorForBarBackgroundAtIndex:idx];
        }
        double tValue = [[source valueForBarAtIndex:idx] doubleValue];
        if ([self _maxValue] == [self _minValue])
        {
            item.percentage = 100.0f;
        }
        else
        {
            item.percentage = (tValue - [self _minValue]) * 100.0f / ([self _maxValue] - [self _minValue]);
        }
        DLog(@"msg_lyywhg: graph ~ %f, percentage %f", tValue, item.percentage);
        if (item.percentage < 0.01)
        {
            item.percentage = 2;
            item.foregroundColor = [UIColor lightGrayColor];
        }
        idx++;
    }];
}
- (void)reset
{
    [self.bars mk_each:^(GKBar *item) {
        [item reset];
    }];
}

@end
