//
//  AQTrendingGraph.m
//  AQTrendingGraph
//
//  Created by Zhanghao on 6/6/14.
//  Copyright (c) 2014 Zhanghao. All rights reserved.
//

#import "AQTrendingGraph.h"

#define Pop_View_Background_Color               [UIColor colorWithWhite:0 alpha:0.7]

static const CGFloat kPopViewWidth = 40;
static const CGFloat kLeftPadding = 40;
static const CGFloat kRightPadding = 20;
static const CGFloat kTopPadding = kPopViewWidth / 2;
static const CGFloat kBottomPadding = kTopPadding;

typedef NS_ENUM(NSUInteger, AQArrowDirection) {
    AQArrowDirectionUp,
    AQArrowDirectionDown,
    AQArrowDirectionLeft,
    AQArrowDirectionRight
};

@interface AQIndicatorView : UIView

@end

@implementation AQIndicatorView

- (void)drawRect:(CGRect)rect {
    CGFloat height = CGRectGetHeight(rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, height);
    CGContextStrokePath(context);
}

@end

@interface AQArrowView : UIView

@property (nonatomic, assign) AQArrowDirection direction;

@end

@implementation AQArrowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _direction = AQArrowDirectionUp;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, Pop_View_Background_Color.CGColor);
    
    switch (self.direction) {
        case AQArrowDirectionUp: {
            CGContextMoveToPoint(context, 0, height);
            CGContextAddLineToPoint(context, width / 2, 0);
            CGContextAddLineToPoint(context, width, height);
            CGContextMoveToPoint(context, 0, height);
        }
            break;
        case AQArrowDirectionDown: {
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, width / 2, height);
            CGContextAddLineToPoint(context, width, 0);
            CGContextAddLineToPoint(context, 0, 0);
        }
            break;
        case AQArrowDirectionLeft: {
            CGContextMoveToPoint(context, width, 0);
            CGContextAddLineToPoint(context, 0, height / 2);
            CGContextAddLineToPoint(context, width, height);
            CGContextAddLineToPoint(context, width, 0);
        }
            break;
        case AQArrowDirectionRight: {
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, width, height / 2);
            CGContextAddLineToPoint(context, 0, height);
            CGContextAddLineToPoint(context, 0, 0);
        }
            break;
        default:
            break;
    }
    CGContextClosePath(context);
    CGContextFillPath(context);
}

- (void)setDirection:(AQArrowDirection)direction {
    _direction = direction;
    [self setNeedsDisplay];
}

@end


@interface AQPopView : UIView

@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *indexLabel;

- (void)setValue:(NSString *)value index:(NSString *)index;

@end

@implementation AQPopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.backgroundColor = Pop_View_Background_Color;
    self.layer.cornerRadius = 3;
    
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.valueLabel.textAlignment = NSTextAlignmentCenter;
    self.valueLabel.backgroundColor = [UIColor clearColor];
    self.valueLabel.textColor = [UIColor whiteColor];
    self.valueLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.valueLabel];
    
    self.indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.indexLabel.textAlignment = NSTextAlignmentCenter;
    self.indexLabel.backgroundColor = [UIColor clearColor];
    self.indexLabel.textColor = [UIColor whiteColor];
    self.indexLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.indexLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.valueLabel.text && self.indexLabel.text) {
        [self.valueLabel sizeToFit];
        [self.indexLabel sizeToFit];
        
        CGSize valueSize = self.valueLabel.bounds.size;
        CGSize indexSize = self.indexLabel.bounds.size;
        
        CGFloat width = valueSize.width;
        width = (width < indexSize.width) ? indexSize.width : width;
        
        CGFloat leftPadding = 5;
        CGFloat topPadding = 2;
        CGFloat middlePadding = 2;
        
        self.valueLabel.frame = CGRectMake(leftPadding, topPadding, width, valueSize.height);
        self.indexLabel.frame = CGRectMake(leftPadding, valueSize.height + middlePadding, width, indexSize.height);
        
        CGRect frame = self.frame;
        frame.size.width = width + leftPadding * 2;
        frame.size.height = valueSize.height + indexSize.height + middlePadding + 2 * topPadding;
        self.frame = frame;
    }
}

- (void)setValue:(NSString *)value index:(NSString *)index {
    self.valueLabel.text = value;
    self.indexLabel.text = index;
    [self setNeedsLayout];
}

@end

@interface AQTrendingGraph ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *minLabel;
@property (nonatomic, strong) UILabel *maxLabel;
@property (nonatomic, strong) AQIndicatorView *indicatorView;
@property (nonatomic, strong) AQPopView *popView;
@property (nonatomic, strong) AQArrowView *arrowView;
@property (nonatomic, strong) UIImageView *pointImageView;
@property (nonatomic, strong) CAShapeLayer *trendingLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, assign) CGFloat startX;
@property (nonatomic, assign) CGFloat endX;
@property (nonatomic, assign) CGFloat segWidth;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, strong) NSDictionary *pointsDic;
@property (nonatomic, strong) NSArray *xTitles;
@property (nonatomic, assign) BOOL needInteger;
@property (nonatomic, assign) BOOL isOnePoint;  // 单点

@end

@implementation AQTrendingGraph

#pragma mark - View Lifecycle Methods

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
        [self initViews];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    // 画直线
    CGContextMoveToPoint(context, kLeftPadding, height);
    CGContextAddLineToPoint(context, width - kRightPadding, height);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1 alpha:0.6].CGColor);
    float lengths[] = {5, 5};
    CGContextSetLineDash(context, 0, lengths, 2);
    
    switch (self.pointType) {
        case AQPointTypeNone: {
            // 单点不绘制虚线
        }
            break;
        case AQPointTypeOne: {
            // 只画值虚线
            CGContextMoveToPoint(context, kLeftPadding, height / 2);
            CGContextAddLineToPoint(context, width - kRightPadding, height / 2);
            CGContextStrokePath(context);
        }
            break;
        case AQPointTypeMore: {
            // 画最小值虚线
            CGContextMoveToPoint(context, kLeftPadding, height - kBottomPadding);
            CGContextAddLineToPoint(context, width - kRightPadding, height - kBottomPadding);
            
            // 画最大值虚线
            CGContextMoveToPoint(context, kLeftPadding, kTopPadding);
            CGContextAddLineToPoint(context, width - kRightPadding, kTopPadding);
            CGContextStrokePath(context);
        }
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchBeganOrMove:[touches anyObject]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchBeganOrMove:[touches anyObject]];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchEndOrCancel:[touches anyObject]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchEndOrCancel:[touches anyObject]];
}

#pragma mark - Public Methods

- (void)reloadData {
    self.minLabel.hidden = YES;
    self.maxLabel.hidden = YES;
    self.pointImageView.hidden = YES;
    
    self.contentView.layer.sublayers = nil;
    
    [self drawTrendingLine];
}

#pragma mark - Private Methods

- (void)initData {
    self.pointType = AQPointTypeOne;
    self.needInteger = NO;
    self.isOnePoint = NO;
}

- (void)initViews {
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.contentView];
    [self addSubview:self.indicatorView];
    [self addSubview:self.popView];
    [self addSubview:self.arrowView];
    [self addSubview:self.pointImageView];
    [self addSubview:self.minLabel];
    [self addSubview:self.maxLabel];
}

- (void)drawTrendingLine {
    // X轴标题
    NSArray *xTitles = nil;
    if ([self.dataSource respondsToSelector:@selector(xTitles)]) {
        xTitles = [self.dataSource xTitles];
    }
    self.xTitles = xTitles;
    
    NSDictionary *pointsDic = nil;
    if ([self.dataSource respondsToSelector:@selector(pointsDictionary)]) {
        pointsDic = [self.dataSource pointsDictionary];
    }
    self.pointsDic = pointsDic;
    
    self.isOnePoint = NO;
    
    if (self.pointsDic) {
        // 利用maxIndex将X轴分段
        NSInteger maxIndex = 0;
        if ([self.dataSource respondsToSelector:@selector(maxIndex)]) {
            maxIndex = [self.dataSource maxIndex];
        }

        // 最大值
        CGFloat maxY = 0;
        if ([self.dataSource respondsToSelector:@selector(maxY)]) {
            maxY = [self.dataSource maxY];
        }
        self.maxY = maxY;
        
        // 最小值
        CGFloat minY = 0;
        if ([self.dataSource respondsToSelector:@selector(minY)]) {
            minY = [self.dataSource minY];
        }
        self.minY = minY;
        
        // 是否需要显示整数
        if ([self.dataSource respondsToSelector:@selector(needInteger)]) {
            self.needInteger = [self.dataSource needInteger];
        }
        
        CGFloat contentWidth = CGRectGetWidth(self.contentView.bounds);
        // 计算数据点位置时使用的实际有效高度
        CGFloat validContentHeight = CGRectGetHeight(self.contentView.bounds) - kBottomPadding;
        
        if (maxIndex <= 1) {
            return;
        }
        
        // 根据最大index计算出每一段宽度
        CGFloat segWidth = contentWidth / (maxIndex - 1);
        self.segWidth = segWidth;

        UIBezierPath *linePath = [UIBezierPath bezierPath];
        UIBezierPath *maskPath = [UIBezierPath bezierPath];
        
        NSArray *keys = [pointsDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
        NSInteger count = keys.count;
        
        // 无点
        if (count == 0) {
            // 无点，不绘制任何渐变和曲线
            self.pointType = AQPointTypeNone;
        } else if (count == 1) { // 单点
            
            self.maxLabel.hidden = NO;
            if (self.needInteger) {
                self.maxLabel.text = [NSString stringWithFormat:@"%d", (int)maxY];
            } else {
                self.maxLabel.text = [NSString stringWithFormat:@"%.1f", maxY];
            }
            
            [self.maxLabel sizeToFit];
            self.maxLabel.center = CGPointMake(kLeftPadding / 2, CGRectGetMidY(self.bounds));
            
            self.pointType = AQPointTypeOne;
            self.startX = self.endX = segWidth * [keys.lastObject integerValue];
            
            self.isOnePoint = YES;
            self.pointImageView.hidden = NO;
            self.pointImageView.center = CGPointMake(self.startX + kLeftPadding, CGRectGetMidY(self.bounds));
        } else {
            // 多点
            BOOL equalValue = self.minY == self.maxY;
            
            // 当最大值和最小值相等时作为单点处理
            if (equalValue) {
                self.maxLabel.hidden = NO;
                if (self.needInteger) {
                    self.maxLabel.text = [NSString stringWithFormat:@"%d", (int)maxY];
                } else {
                    self.maxLabel.text = [NSString stringWithFormat:@"%.1f", maxY];
                }
                
                [self.maxLabel sizeToFit];
                self.maxLabel.center = CGPointMake(kLeftPadding / 2, CGRectGetMidY(self.bounds));
                
                self.pointType = AQPointTypeOne;
            } else {
                self.pointType = AQPointTypeMore;
                
                self.maxLabel.hidden = NO;
                
                if (self.needInteger) {
                    self.maxLabel.text = [NSString stringWithFormat:@"%d", (int)maxY];
                } else {
                    self.maxLabel.text = [NSString stringWithFormat:@"%.1f", maxY];
                }
                
                [self.maxLabel sizeToFit];
                self.maxLabel.center = CGPointMake(kLeftPadding / 2, kTopPadding);
                
                self.minLabel.hidden = NO;
                
                if (self.needInteger) {
                    self.minLabel.text = [NSString stringWithFormat:@"%d", (int)minY];
                } else {
                    self.minLabel.text = [NSString stringWithFormat:@"%.1f", minY];
                }
                
                [self.minLabel sizeToFit];
                self.minLabel.center = CGPointMake(kLeftPadding / 2, CGRectGetHeight(self.bounds) -  kBottomPadding);
            }
            
            
            for (int i = 0; i < count; i++) {
                NSNumber *key = keys[i];
                NSInteger index = [key integerValue];
                CGFloat value = [pointsDic[key] floatValue];
                CGFloat x = segWidth * index;
                
                // 计算y坐标
                CGFloat valueDelta = value - minY;
                CGFloat totalDelta = maxY - minY;
                
                CGFloat y = 0;
                if (equalValue) {
                    y = validContentHeight / 2;
                } else {
                    y = validContentHeight - valueDelta / totalDelta * validContentHeight;
                }

                CGPoint point = CGPointMake(x, y);
                if (i == 0) {
                    self.startX = x;
                    [linePath moveToPoint:point];
                    [maskPath moveToPoint:point];
                } else {
                    if (i == count - 1) {
                        self.endX = x;
                    }
                    [linePath addLineToPoint:point];
                    [maskPath addLineToPoint:point];
                }
            }
        }

        self.trendingLayer.path = linePath.CGPath;
        [self.contentView.layer addSublayer:self.trendingLayer];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.contentsScale = [UIScreen mainScreen].scale;
        if (keys.count > 1) {
            CGFloat lastY = CGRectGetHeight(self.contentView.bounds);
            [maskPath addLineToPoint:CGPointMake(self.endX, lastY)];
            [maskPath addLineToPoint:CGPointMake(self.startX, lastY)];
        }
        maskLayer.path = maskPath.CGPath;
        
        self.gradientLayer.mask = maskLayer;
        [self.contentView.layer insertSublayer:self.gradientLayer below:self.trendingLayer];
    }
}

- (void)touchBeganOrMove:(UITouch *)touch {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat midY = CGRectGetHeight(self.bounds) / 2;
    CGFloat leftX = kLeftPadding;
    CGFloat rightX = width - kRightPadding;
    
    // 超出content view范围，不处理触摸事件
    CGPoint point = [touch locationInView:self];
    if (point.x < leftX || point.x > rightX) {
        return;
    }

    // 根据位置计算出index
    NSInteger index = (point.x - kLeftPadding) / self.segWidth;
    
    CGFloat semi = kLeftPadding + index * self.segWidth + self.segWidth / 2;
    if (point.x > semi) {
        index++;
    }
    
    CGFloat x = index * self.segWidth + kLeftPadding;
    
    // 根据index拿到值
    CGFloat value = 0;
    if (self.pointsDic) {
        if ([self.pointsDic.allKeys containsObject:@(index)]) {
            value = [self.pointsDic[@(index)] floatValue];
        }
    }

    // 显示文本值
    NSString *title = nil;
    if (index < self.xTitles.count) {
        title = self.xTitles[index];
    }

    NSString *valueString = nil;
    if (self.needInteger) {
        valueString = [NSString stringWithFormat:@"%d", (int)value];
    } else {
        valueString = [NSString stringWithFormat:@"%.1f", value];
    }
    
    NSString *indexString = [NSString stringWithFormat:@"%@", title];
    [self.popView setValue:valueString index:indexString];
    
    // 处理游标frame
    self.indicatorView.hidden = NO;
    self.indicatorView.center = CGPointMake(point.x, midY);
    
    // 处理popView frame
    CGFloat padding = 6;
    CGFloat popViewX = point.x + padding + CGRectGetMidX(self.popView.bounds);
    CGFloat contentHeight = CGRectGetHeight(self.contentView.bounds) - kBottomPadding;
    CGFloat y = 0;

    // 当无值时隐藏popView
    if (value - 0.0 <= 0.001) {
        self.popView.hidden = YES;
        self.arrowView.hidden = YES;
        if (!self.isOnePoint) {
            self.pointImageView.hidden = YES;
        }
    } else {
        self.popView.hidden = NO;
        self.arrowView.hidden = NO;
        self.pointImageView.hidden = NO;
        
        if (self.maxY == self.minY) {
            y = contentHeight / 2 + kTopPadding;
        } else {
            y = contentHeight - (value - self.minY) * contentHeight / (self.maxY - self.minY) + kTopPadding;
        }
    }
    self.popView.center = CGPointMake(popViewX, y);
    self.arrowView.center = CGPointMake(popViewX - CGRectGetMidX(self.popView.bounds) - CGRectGetMidX(self.arrowView.bounds), y);
    if (!self.isOnePoint) {
        self.pointImageView.center = CGPointMake(x, y);
    }
    
    // 滑到最右边，保证popView不超出屏幕范围
    CGPoint center = self.popView.center;
    CGFloat maxX = width - CGRectGetMidX(self.popView.bounds);
    if (center.x > maxX) {
        center.x = maxX;
        self.popView.center = center;
        self.arrowView.center = CGPointMake(center.x - CGRectGetMidX(self.popView.bounds) - CGRectGetMidX(self.arrowView.bounds), center.y);
        if (!self.isOnePoint) {
            self.pointImageView.center = CGPointMake(x, y);
        }
    }
    
//    // 滑到最右边，调转箭头方向
//    if (point.x >= CGRectGetWidth(self.bounds) - 51) {
//        self.arrowView.direction = AQArrowDirectionRight;
//        self.arrowView.frame = CGRectZero;
//    }
//    CGPoint center = self.popView.center;
//    CGFloat maxX = width - CGRectGetMidX(self.popView.bounds);
//    if (center.x > maxX) {
//        center.x = maxX;
//        self.popView.center = center;
//        self.arrowView.center = CGPointMake(center.x - CGRectGetMidX(self.popView.bounds) - CGRectGetMidX(self.arrowView.bounds), center.y);
//        self.pointImageView.center = CGPointMake(x, y);
//    }
    
    // 滑出渐变范围隐藏popView
    if (self.startX == self.endX) {
        // startX是contentView的坐标系，而point是self的坐标系，需要转化一下
        if (point.x < (self.startX + kLeftPadding - 20) || point.x > (self.endX + kLeftPadding + 20)) {
            [self beyondGradientArea];
        }
    } else {
        if (point.x < (self.startX + kLeftPadding - 20) || point.x > (self.endX + kLeftPadding + 20)) {
            [self beyondGradientArea];
        }
    }
}

- (void)touchEndOrCancel:(UITouch *)touch {
    self.indicatorView.hidden = YES;
    self.popView.hidden = YES;
    self.arrowView.hidden = YES;
    
    if (!self.isOnePoint) {
        self.pointImageView.hidden = YES;
    }
//    self.pointImageView.hidden = YES;
}

// 已经滑出渐变区域，处理文本框
- (void)beyondGradientArea {
    self.popView.hidden = YES;
    self.arrowView.hidden = YES;
    
    if (!self.isOnePoint) {
        self.pointImageView.hidden = YES;
    }
//    self.pointImageView.hidden = YES;
}

#pragma mark - Getter And Setter

- (UIView *)contentView {
    if (!_contentView) {
        CGFloat contentWidth = CGRectGetWidth(self.bounds) - kLeftPadding - kRightPadding;
        CGFloat contentHeight = CGRectGetHeight(self.bounds) - kTopPadding;
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(kLeftPadding, kTopPadding, contentWidth, contentHeight)];
    }
    return _contentView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[AQIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 1, CGRectGetHeight(self.bounds))];
        _indicatorView.backgroundColor = [UIColor clearColor];
        _indicatorView.hidden = YES;
    }
    return _indicatorView;
}

- (UIView *)popView {
    if (!_popView) {
        _popView = [[AQPopView alloc] initWithFrame:CGRectMake(0, 0, kPopViewWidth, kPopViewWidth)];
        _popView.hidden = YES;
    }
    return _popView;
}

- (AQArrowView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[AQArrowView alloc] initWithFrame:CGRectMake(0, 0, 5, 12)];
        _arrowView.direction = AQArrowDirectionLeft;
        _arrowView.hidden = YES;
    }
    return _arrowView;
}

- (CAShapeLayer *)trendingLayer {
    if (!_trendingLayer) {
        _trendingLayer = [CAShapeLayer layer];
        _trendingLayer.contentsScale = [UIScreen mainScreen].scale;
        _trendingLayer.fillColor = [UIColor clearColor].CGColor;
        _trendingLayer.strokeColor = [UIColor whiteColor].CGColor;
        _trendingLayer.frame = self.contentView.bounds;
        _trendingLayer.lineJoin = kCALineJoinRound;
        _trendingLayer.lineCap = kCALineCapRound;
        _trendingLayer.lineWidth = 3;
    }
    return _trendingLayer;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.contentView.bounds;
        _gradientLayer.startPoint = CGPointMake(0.5, 0);
        _gradientLayer.endPoint = CGPointMake(0.5, 1);
        UIColor *startColor = [UIColor colorWithWhite:1 alpha:0.5];
        UIColor *endColor = [UIColor colorWithWhite:1 alpha:0.1];
        _gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    }
    return _gradientLayer;
}

- (UILabel *)maxLabel {
    if (!_maxLabel) {
        _maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kLeftPadding, 10)];
        _maxLabel.backgroundColor = [UIColor clearColor];
        _maxLabel.textAlignment = NSTextAlignmentCenter;
        _maxLabel.textColor = [UIColor whiteColor];
        _maxLabel.font = [UIFont systemFontOfSize:12];
    }
    return _maxLabel;
}

- (UILabel *)minLabel {
    if (!_minLabel) {
        _minLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kLeftPadding, 10)];
        _minLabel.backgroundColor = [UIColor clearColor];
        _minLabel.textAlignment = NSTextAlignmentCenter;
        _minLabel.textColor = [UIColor whiteColor];
        _minLabel.font = [UIFont systemFontOfSize:12];
    }
    return _minLabel;
}

- (UIImageView *)pointImageView {
    if (!_pointImageView) {
        _pointImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 9)];
        _pointImageView.image = [UIImage imageNamed:@"yuandian.png"];
        _pointImageView.hidden = YES;
    }
    return _pointImageView;
}

- (void)setPointType:(AQPointType)pointType {
    _pointType = pointType;
    [self setNeedsDisplay];
}

@end
