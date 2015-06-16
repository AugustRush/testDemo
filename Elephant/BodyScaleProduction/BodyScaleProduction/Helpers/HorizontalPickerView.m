//
//  HorizontalPickerView.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-14.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "HorizontalPickerView.h"
#import "NSArray+SLExt.h"

@interface HorizontalPickerViewItem : UIView

@property (nonatomic, strong)NSString *title;

@end

@implementation HorizontalPickerViewItem {
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
    
    CGFloat midX = self.frame.size.width / 2;
    CGContextMoveToPoint(context, midX, 0);
    CGContextAddLineToPoint(context, midX, 5);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, midX, self.frame.size.height);
    CGContextAddLineToPoint(context, midX, self.frame.size.height - 5);
    CGContextStrokePath(context);
}

@end

#define ARROW_SIDE_LENGTH   9
#define ITEM_WIDTH          51.0f
#define MIN_OPACITY         0.33f
#define CONTENT_INSET       (self.frame.size.width - ITEM_WIDTH) / 2

@implementation HorizontalPickerView {
    @private
    __weak id<HorizontalPickerViewDelegate>        _pickerViewDelegate;
    __weak id<HorizontalPickerViewDataSource>      _dataSource;
    
    NSMutableArray *_itemQueue;
    NSMutableArray *_itemDequeue;
    NSInteger _numberOfItems;
    NSRange         range;
    NSMutableArray *_tempArray;
}

- (id)initWithFrame:(CGRect)frame
           delegate:(id<HorizontalPickerViewDelegate>)delegate
         dataSource:(id<HorizontalPickerViewDataSource>)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        _pickerViewDelegate = delegate;
        _dataSource = dataSource;
        _itemQueue = [NSMutableArray array];
        _itemDequeue = [NSMutableArray array];
        _tempArray = [NSMutableArray array];
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    _numberOfItems = [_dataSource numberOfItemsInPickerView:self];
    
    /*
    CGFloat right = 0.0f;
    int index = 0;
    for (; index < _numberOfItems; index ++) {
        HorizontalPickerViewItem *view = [[HorizontalPickerViewItem alloc] initWithFrame:CGRectMake(index * ITEM_WIDTH + CONTENT_INSET,
                                                                                                    0,
                                                                                                    ITEM_WIDTH,
                                                                                                    self.frame.size.height)];
        view.title = [NSString stringWithFormat:@"%d", index];
        [self addSubview:view];
        [_itemQueue addObject:view];
        right = view.frame.origin.x + view.frame.size.width;
        if (right > self.frame.size.width) {
            break;
        }
    }
    range = NSMakeRange(0, index);
     */
    
    // 入队列
    [self addItemToQueueOnRect:CGRectMake(self.contentOffset.x, self.contentOffset.y, self.frame.size.width, self.frame.size.height)];
    
    self.contentSize = CGSizeMake(ITEM_WIDTH * (_numberOfItems - 1) + self.frame.size.width, self.frame.size.height);
    [self refreshFont];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetRGBStrokeColor(context, 199 / 255.0f, 199 / 255.0f, 199 / 255.0f, 1);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.bounds.size.width, 0);
    CGContextMoveToPoint(context, 0, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    CGContextStrokePath(context);
    
    /*
    CGContextSetRGBFillColor(context, 0, 129 / 255.0f, 237 / 255.0f, 1);
    CGMutablePathRef topTriangle = CGPathCreateMutable();
    CGPathMoveToPoint(topTriangle, NULL, self.frame.size.width / 2 - ARROW_SIDE_LENGTH / 2, 0);
    CGPathAddLineToPoint(topTriangle, NULL, self.frame.size.width / 2 + ARROW_SIDE_LENGTH / 2, 0);
    CGPathAddLineToPoint(topTriangle, NULL, self.frame.size.width / 2, ARROW_SIDE_LENGTH * sin(M_PI / 3));
    CGPathAddLineToPoint(topTriangle, NULL, self.frame.size.width / 2 - ARROW_SIDE_LENGTH / 2, 0);
    CGContextAddPath(context, topTriangle);
    CGPathRelease(topTriangle);
    CGContextFillPath(context);
    
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

#pragma mark - Getter and Setter
- (NSInteger)selectIndex {
    return (self.contentOffset.x) / ITEM_WIDTH;
}

- (void)setCurrentIndex:(NSInteger)index {
    [self setContentOffset:CGPointMake(index * ITEM_WIDTH, 0) animated:NO];
}

#pragma mark - Private Method
- (void)adjustScrollViewPosition {
    int index = (self.contentOffset.x) / ITEM_WIDTH;
    int remainder = (int)(self.contentOffset.x) % (int)ITEM_WIDTH;
    if (remainder > 25) {
        index ++;
    }
    [self setContentOffset:CGPointMake(ITEM_WIDTH * index, 0) animated:YES];
    
    if ([_pickerViewDelegate respondsToSelector:@selector(pickerView:indexChaged:)]) {
        [_pickerViewDelegate pickerView:self indexChaged:index];
    }
}

- (void)refreshFont {
    // ****************************** 字体颜色 *******************************
    for (HorizontalPickerViewItem *item in _itemQueue) {
        CGFloat
        offsetX         = self.contentOffset.x,
        positionX       = item.frame.origin.x + ITEM_WIDTH / 2 - offsetX,
        itemInCenterX   = self.frame.size.width / 2;
        
        CGFloat scale = 0.0f;
        if (positionX <= itemInCenterX) {
            scale = positionX / itemInCenterX;
        } else {
            scale = (itemInCenterX * 2 - positionX) / itemInCenterX;
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
    HorizontalPickerViewItem *item = [_itemQueue firstObject];
    NSInteger location = (item.frame.origin.x - CONTENT_INSET) / ITEM_WIDTH;
    item = [_itemQueue lastObject];
    NSInteger length = (item.frame.origin.x - CONTENT_INSET) / ITEM_WIDTH - location + 1;
    NSRange cleanedRange = NSMakeRange(location, length);
    
    NSInteger maxIndex = (displayRect.origin.x + displayRect.size.width - CONTENT_INSET) / ITEM_WIDTH + 1;
    NSInteger startIndex = (displayRect.origin.x - CONTENT_INSET) / ITEM_WIDTH;
    startIndex = startIndex < 0 ? 0 : startIndex;
    length = maxIndex - startIndex;
    length = length + startIndex > _numberOfItems ? _numberOfItems - startIndex : length;
    
    NSRange intersectionRange = NSIntersectionRange(cleanedRange, NSMakeRange(startIndex, length));
    
    for (int index = 0; index < length; index ++) {
        if (!NSLocationInRange(index + startIndex, intersectionRange)) {
            NSInteger realIndex = index + startIndex;
            CGRect frame = CGRectMake(CONTENT_INSET + realIndex * ITEM_WIDTH,
                                      0,
                                      ITEM_WIDTH,
                                      self.frame.size.height);
            HorizontalPickerViewItem *newItem = [_itemDequeue firstObject];
            if (newItem) {
                newItem.frame = frame;
                [_itemDequeue removeObject:newItem];
                newItem.hidden = NO;
            } else {
                newItem = [[HorizontalPickerViewItem alloc] initWithFrame:frame];
                [self addSubview:newItem];
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
    CGRect displayRect = CGRectMake(self.contentOffset.x, self.contentOffset.y, self.frame.size.width, self.frame.size.height);
    // 出队列
    [self removeItemFromQueueOutOfRect:displayRect];
    // 入队列
    [self addItemToQueueOnRect:displayRect];
    [self refreshFont];
}

@end
