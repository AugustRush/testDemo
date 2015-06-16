//
//  VerticalPickerView.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-18.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "VerticalPickerView.h"
#import "NSArray+SLExt.h"

#define ARROW_SIDE_LENGTH   9

@interface ArrowView : UIView

@end

@implementation ArrowView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetRGBFillColor(context, 0, 129 / 255.0f, 237 / 255.0f, 1);
    CGMutablePathRef topTriangle = CGPathCreateMutable();
    CGPathMoveToPoint(topTriangle, NULL, 0, 0);
    CGPathAddLineToPoint(topTriangle, NULL, 0, self.frame.size.height);
    CGPathAddLineToPoint(topTriangle, NULL, ARROW_SIDE_LENGTH * sin(M_PI / 3),self.frame.size.height / 2);
    CGPathAddLineToPoint(topTriangle, NULL, 0, 0);
    CGContextAddPath(context, topTriangle);
    CGPathRelease(topTriangle);
    CGContextFillPath(context);

    /*
    CGMutablePathRef bottomTriangle = CGPathCreateMutable();
    CGPathMoveToPoint(bottomTriangle, NULL, self.frame.size.width / 2 - ARROW_SIDE_LENGTH / 2, self.frame.size.height);
    CGPathAddLineToPoint(bottomTriangle, NULL, self.frame.size.width / 2 + ARROW_SIDE_LENGTH / 2, self.frame.size.height);
    CGPathAddLineToPoint(bottomTriangle, NULL, self.frame.size.width / 2, self.frame.size.height - ARROW_SIDE_LENGTH * sin(M_PI / 3));
    CGPathAddLineToPoint(bottomTriangle, NULL, self.frame.size.width / 2 - ARROW_SIDE_LENGTH / 2, self.frame.size.height);
    CGContextAddPath(context, bottomTriangle);
    CGPathRelease(bottomTriangle);
    CGContextFillPath(context);
     */
}

@end

@interface VerticalPickerViewItem : UIView

@property (nonatomic, strong)NSString *title;

@end

@implementation VerticalPickerViewItem {
    UILabel *_titleLabel;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        [self initView];
    }
    return self;
}

- (void)initView {
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30.0f];
    label.textColor = [UIColor colorWithWhite:121 / 255.0f alpha:1];
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
    _titleLabel = label;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
    _title = title;
}

- (void)setScale:(CGFloat)scale {
    _titleLabel.transform = CGAffineTransformMakeScale(scale, scale);
    _titleLabel.textColor = [UIColor colorWithWhite:121 / 255.0f alpha:scale];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetRGBStrokeColor(context, 222 / 255.0f, 222 / 255.0f, 222 / 255.0f, 1);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGFloat midY = self.frame.size.height / 2;
    CGContextMoveToPoint(context, 0, midY);
    CGContextAddLineToPoint(context, 5, midY);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, self.frame.size.width - 5, midY);
    CGContextAddLineToPoint(context, self.frame.size.width, midY);
    CGContextStrokePath(context);
}

@end

#define ARROW_SIDE_LENGTH   9
#define ITEM_HEIGHT         56.0f
#define MIN_OPACITY         0.33f
#define CONTENT_INSET       (self.frame.size.height - ITEM_HEIGHT) / 2

@interface VerticalPickerView()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;

@end

@implementation VerticalPickerView {
@private
    id<VerticalPickerViewDelegate>        _pickerViewDelegate;
    id<VerticalPickerViewDataSource>      _dataSource;
    
    NSMutableArray *_itemQueue;
    NSMutableArray *_itemDequeue;
    NSInteger _numberOfItems;
    NSRange         range;
    NSMutableArray *_tempArray;
}

- (id)initWithFrame:(CGRect)frame
           delegate:(id<VerticalPickerViewDelegate>)delegate
         dataSource:(id<VerticalPickerViewDataSource>)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        ArrowView *arrowView = [[ArrowView alloc] initWithFrame:CGRectMake(0, frame.size.height / 2 - ARROW_SIDE_LENGTH / 2, ARROW_SIDE_LENGTH, ARROW_SIDE_LENGTH)];
        [self addSubview:arrowView];
        
        arrowView = [[ArrowView alloc] initWithFrame:CGRectMake(frame.size.width - ARROW_SIDE_LENGTH, frame.size.height / 2 - ARROW_SIDE_LENGTH / 2, ARROW_SIDE_LENGTH, ARROW_SIDE_LENGTH)];
        arrowView.transform = CGAffineTransformMakeRotation(M_PI);
        [self addSubview:arrowView];
        
        _pickerViewDelegate = delegate;
        _dataSource = dataSource;
        _itemQueue = [NSMutableArray array];
        _itemDequeue = [NSMutableArray array];
        _tempArray = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor colorWithWhite:199 / 255.0f alpha:1].CGColor;
        self.layer.borderWidth = 1;
        [self initView];
    }
    return self;
}

- (void)initView {
    _numberOfItems = [_dataSource numberOfItemsInPickerView:self];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, ITEM_HEIGHT * (_numberOfItems - 1) + self.frame.size.height);
    
    // 入队列
    [self addItemToQueueOnRect:CGRectMake(self.scrollView.contentOffset.x,
                                          self.scrollView.contentOffset.y,
                                          self.scrollView.frame.size.width,
                                          self.scrollView.frame.size.height)];
    [self refreshFont];
}

#pragma mark - Getter
- (NSInteger)selectedIndex {
    return (self.scrollView.contentOffset.y) / ITEM_HEIGHT;
}

- (void)setCurrentIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(0, index * ITEM_HEIGHT) animated:NO];
}

#pragma mark - Private Method
- (void)adjustScrollViewPosition {
    int index = (self.scrollView.contentOffset.y) / ITEM_HEIGHT;
    int remainder = (int)(self.scrollView.contentOffset.y) % (int)ITEM_HEIGHT;
    if (remainder > 25) {
        index ++;
    }
    [self.scrollView setContentOffset:CGPointMake(0, ITEM_HEIGHT * index) animated:YES];
    
    if ([_pickerViewDelegate respondsToSelector:@selector(pickerView:indexChaged:)]) {
        [_pickerViewDelegate pickerView:self indexChaged:index];
    }
}

- (void)refreshFont {
    // ****************************** 字体颜色 *******************************
    for (VerticalPickerViewItem *item in _itemQueue) {
        CGFloat
        offsetY         = self.scrollView.contentOffset.y,
        positionY       = item.frame.origin.y + ITEM_HEIGHT / 2 - offsetY,
        itemInCenterY   = self.scrollView.frame.size.height / 2;
        
        CGFloat scale = 0.0f;
        if (positionY <= itemInCenterY) {
            scale = positionY / itemInCenterY;
        } else {
            scale = (itemInCenterY * 2 - positionY) / itemInCenterY;
        }
        
        [item setScale:(1 - MIN_OPACITY) * scale + MIN_OPACITY];
    }
    // ****************************** 字体颜色 end *******************************
}

- (void)removeItemFromQueueOutOfRect:(CGRect)displayRect {
    int count = (int)_itemQueue.count;
    for (int index = count - 1; index >= 0; index --) {
        UIView *view = _itemQueue[index];
        CGRect intersectionRect = CGRectIntersection(view.frame, displayRect);
        if (CGRectIsEmpty(intersectionRect)) {
            [_itemQueue removeObject:view];
            [_itemDequeue addObject:view];
            view.hidden = YES;
        }
    }
}

- (void)addItemToQueueOnRect:(CGRect)displayRect {
    VerticalPickerViewItem *item = [_itemQueue firstObject];
    NSInteger location = (item.frame.origin.y - CONTENT_INSET) / ITEM_HEIGHT;
    item = [_itemQueue lastObject];
    NSInteger length = (item.frame.origin.y - CONTENT_INSET) / ITEM_HEIGHT - location + 1;
    NSRange cleanedRange = NSMakeRange(location, length);
    
    NSInteger maxIndex = (displayRect.origin.y + displayRect.size.height - CONTENT_INSET) / ITEM_HEIGHT + 1;
    NSInteger startIndex = (displayRect.origin.y - CONTENT_INSET) / ITEM_HEIGHT;
    startIndex = startIndex < 0 ? 0 : startIndex;
    length = maxIndex - startIndex;
    length = length + startIndex > _numberOfItems ? _numberOfItems - startIndex : length;
    
    NSRange intersectionRange = NSIntersectionRange(cleanedRange, NSMakeRange(startIndex, length));
    
    for (int index = 0; index < length; index ++) {
        if (!NSLocationInRange(index + startIndex, intersectionRange)) {
            NSInteger realIndex = index + startIndex;
            CGRect frame = CGRectMake(0, // CONTENT_INSET + realIndex * ITEM_WIDTH
                                      CONTENT_INSET + realIndex * ITEM_HEIGHT,
                                      self.frame.size.width, // ITEM_WIDTH
                                      ITEM_HEIGHT);
            VerticalPickerViewItem *newItem = [_itemDequeue firstObject];
            if (newItem) {
                newItem.frame = frame;
                [_itemDequeue removeObject:newItem];
                newItem.hidden = NO;
            } else {
                newItem = [[VerticalPickerViewItem alloc] initWithFrame:frame];
                [self.scrollView addSubview:newItem];
            }
            
            [_tempArray addObject:newItem];
            newItem.title = [_pickerViewDelegate pickerView:self titleForItemsIndex:realIndex];
        }
    }
    
    if (_tempArray.count) {
        if (range.location <= startIndex) { // 确定相比上次是左平移还是右平移
            [_itemQueue addObjectsFromArray:_tempArray];
        } else {
            [_itemQueue insertObjects:_tempArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, _tempArray.count)]];
        }
    }
    range = NSMakeRange(startIndex, length);
    [_tempArray removeAllObjects];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self adjustScrollViewPosition];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self adjustScrollViewPosition];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect displayRect = CGRectMake(scrollView.contentOffset.x,
                                    scrollView.contentOffset.y,
                                    scrollView.frame.size.width,
                                    scrollView.frame.size.height);
    // 出队列
    [self removeItemFromQueueOutOfRect:displayRect];
    // 入队列
    [self addItemToQueueOnRect:displayRect];
    [self refreshFont];
}

@end
