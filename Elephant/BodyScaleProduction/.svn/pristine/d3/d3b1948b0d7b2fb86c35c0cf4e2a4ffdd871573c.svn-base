//
//  DataDetailTableViewCell.m
//  ViewDraw
//
//  Created by Go Salo on 14-5-11.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "DataDetailTableViewCell.h"
#import "ValuePopView.h"
#import "ColorPickerUtil.h"
#import "ThemeManager.h"

#define POPPOSITION_RATE_DEFAULT - 9999

@interface DataDetailTableViewCellBackgroundView : UIView

@end

@implementation DataDetailTableViewCellBackgroundView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0.8, 0.8, 0.8, 1);
    CGContextSetLineWidth(ctx, 0.5);
    
    /* 竖线
    CGContextMoveToPoint(ctx, 71, 0);
    CGContextAddLineToPoint(ctx, 71, 60);

    CGContextMoveToPoint(ctx, [[UIScreen mainScreen] bounds].size.width - 49, 0);
    CGContextAddLineToPoint(ctx, [[UIScreen mainScreen] bounds].size.width - 49, 60);
     */
    
    CGContextMoveToPoint(ctx, 0, 59.5);
    CGContextAddLineToPoint(ctx, [[UIScreen mainScreen] bounds].size.width, 59.5);
    
    CGContextStrokePath(ctx);
}

@end

@interface DataDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *sliderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *upOrDownImageView;
@property (weak, nonatomic) IBOutlet UILabel *valueChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyAgeLabel;

@property (weak, nonatomic) IBOutlet UILabel *nodeValue1Label;
@property (weak, nonatomic) IBOutlet UILabel *nodeValue2Label;
@property (weak, nonatomic) IBOutlet UILabel *nodeValue3Label;

@property (weak, nonatomic) IBOutlet UILabel *interval1Label;
@property (weak, nonatomic) IBOutlet UILabel *interval2Label;
@property (weak, nonatomic) IBOutlet UILabel *interval3Label;
@property (weak, nonatomic) IBOutlet UILabel *interval4Label;

@end

@implementation DataDetailTableViewCell {
    ValuePopView *_valuePopView;
    ColorPickerUtil *_colorPicker;
    
    NSArray *_colors;
    
    DataDetailCallback _typeButtonCallback;
    DataDetailCallback _rightAreaButtonCallback;
}

- (void)awakeFromNib
{
    _colorPicker = [[ColorPickerUtil alloc] init];
    [_colorPicker setImage:self.sliderImageView.image];
    
    _valuePopView = [[ValuePopView alloc] initWithFrame:CGRectMake(70, 5, 0, 22)];
    [self.contentView addSubview:_valuePopView];
    
    DataDetailTableViewCellBackgroundView *backgroundView = [[DataDetailTableViewCellBackgroundView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 60)];
    self.backgroundView = backgroundView;
    
    UIColor *yellowColor = [UIColor colorWithRed:1 green:192 / 255.0f blue:0 alpha:1];
    UIColor *greenColor = [UIColor colorWithRed:67 / 255.0f green:157 / 255.0f blue:18 / 255.0f alpha:1];
    UIColor *redColor = [UIColor colorWithRed:252 / 255.0f green:70 / 255.0f blue:70 / 255.0f alpha:1];
    UIColor *deepRedColor = [UIColor colorWithRed:220 / 255.0f green:10 / 255.0f blue:10 / 255.0f alpha:1];
    
    _colors = @[yellowColor, greenColor, redColor, deepRedColor];
}

- (void)prepareForReuse {
    self.interval1Label.textColor = [UIColor lightGrayColor];
    self.interval2Label.textColor = [UIColor lightGrayColor];
    self.interval3Label.textColor = [UIColor lightGrayColor];
    self.interval4Label.textColor = [UIColor lightGrayColor];
}

#pragma mark - Actions
- (IBAction)rightButtonAction:(id)sender {
    if (_rightAreaButtonCallback) {
        _rightAreaButtonCallback();
    }
}

- (IBAction)typeButtonAction:(id)sender {
    if (_typeButtonCallback) {
        _typeButtonCallback();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIconButtonTouchUpInsideCallBack:(DataDetailCallback)callback1 historyButtonTouchUpInsideCallback:(DataDetailCallback)callback2 {
    _typeButtonCallback =  callback1;
    _rightAreaButtonCallback = callback2;
}

- (void)setData:(PCEntity *)dataEntity {
    float upValue = dataEntity.pc_deltaValue;
    PCType type = dataEntity.pc_tp;
    float value = dataEntity.pc_originValue;
    
    // ========= 特例排除 变化数值取绝对值 ============
    float absoluteUpValue = (upValue < 0 ? - upValue : upValue);
    NSString *stringValue = nil;
    NSString *stringUpValue = nil;
    if (type == PCType_bmr || type == PCType_bodyage || type == PCType_eBmr) { // 变整数的类型
        stringValue = [NSString stringWithFormat:@"%.0f", value];
        if (upValue == 0) {
            stringUpValue = @"持平";
        } else {
            stringUpValue = [NSString stringWithFormat:@"%.0f", absoluteUpValue];
        }
    } else {
        stringValue = [NSString stringWithFormat:@"%.1f", value];
        if (upValue == 0) {
            stringUpValue = @"持平";
        } else {
            stringUpValue = [NSString stringWithFormat:@"%.1f", absoluteUpValue];
        }
    }
    
    // 身体年龄特例
    if (type == PCType_bodyage) {
        self.bodyAgeLabel.text = [NSString stringWithFormat:@"实际年龄 %d", [dataEntity.pc_filedPointList[1] intValue]];
    }
    // ============================================
    
    // ================  节点Label赋值  ==============
    float popPositionRate = POPPOSITION_RATE_DEFAULT; // 初始值判断是否赋值过
    NSInteger popLocation = - 1;
    
    // 计算区间-区间位置百分比
    // 大于最大值
    if (value > [[dataEntity.pc_filedPointList lastObject] floatValue]) {
        popPositionRate = 1;
        popLocation = dataEntity.pc_filedPointList.count - 2;
    }
    
    // 小于最小值
    if (value < [[dataEntity.pc_filedPointList firstObject] floatValue]) {
        popPositionRate = 0;
        popLocation = 0;
    }
    
    for (int index = 1; index < dataEntity.pc_filedPointList.count; index ++) {
        NSNumber *number = dataEntity.pc_filedPointList[index];
        if (index < dataEntity.pc_filedPointList.count - 1) {
            // 读取节点值 从数组中第二个对象 到 数组中倒数第二个对象
            if ([number isKindOfClass:[NSNumber class]]) {
                NSString *keyPath = [NSString stringWithFormat:@"nodeValue%dLabel.text", index];
                if (type == PCType_bmr || type == PCType_bodyage || type == PCType_eBmr) {
                    [self setValue:[NSString stringWithFormat:@"%.0f", [number floatValue]] forKeyPath:keyPath];
                } else {
                    [self setValue:[NSString stringWithFormat:@"%.1f", [number floatValue]] forKeyPath:keyPath];
                }
            } else {
                NSLog(@"传入对象数据有误");
            }
        }
        
        // 计算区间-区间位置百分比 中间值
        if ([number floatValue] >= value && popPositionRate == POPPOSITION_RATE_DEFAULT) {
            popLocation = index - 1;
            
            float lastNodeValue = [dataEntity.pc_filedPointList[index - 1] floatValue];
            float nodeValue = [dataEntity.pc_filedPointList[index] floatValue];
            popPositionRate = (value - lastNodeValue) / (nodeValue - lastNodeValue);
        }
    }
    // ================  节点Label赋值End ============

    
    // 改变高亮区域文字颜色
    if (type == PCType_weight || type == PCType_bmi || type == PCType_fat) {
        [self setValue:_colors[popLocation] forKeyPath:[NSString stringWithFormat:@"interval%dLabel.textColor", (int)popLocation + 1]];
    } else if (type == PCType_bmr || type == PCType_eBmr) {
        int index = popLocation == 0 ? 2 : 1;
        [self setValue:_colors[index] forKeyPath:[NSString stringWithFormat:@"interval%dLabel.textColor", (int)popLocation + 1]];
    } else if (type == PCType_offal) {
        [self setValue:_colors[popLocation + 1] forKeyPath:[NSString stringWithFormat:@"interval%dLabel.textColor", (int)popLocation + 1]];
    } else {
        [self setValue:_colors[popLocation] forKeyPath:[NSString stringWithFormat:@"interval%dLabel.textColor", (int)popLocation + 1]];
    }

    // ==================== 计算位置 ==================== (只和 几个区间有关)
    // 计算位置百分比
    CGFloat popOffset = 0;
    CGSize size = [_valuePopView calculatePopRectWithValueString:stringValue];
    
    if (type == PCType_weight || type == PCType_bmi || type == PCType_fat) {
        if (popLocation == 3) {
            popOffset = 50 * (popLocation - 1) +  (50 - size.width / 2) * popPositionRate + 50 - (size.width / 2);
        } else {
            popOffset = 50 * popLocation +  (50 - size.width / 2) * popPositionRate;
        }
    } else if (type == PCType_bmr || type == PCType_bodyage ||  type == PCType_eBmr) {
        if (popLocation == 0) {
            popOffset = (100 - size.width / 2) * popPositionRate;
        } else {
            popOffset = (100 - size.width / 2) + (100 - size.width / 2) * popPositionRate;
        }
    } else {
        switch (popLocation) {
            case 0:
                popOffset = (65 - (size.width / 2)) * popPositionRate;
                break;
            case 1:
                popOffset = (65 - (size.width / 2)) + 70 * popPositionRate;
                break;
            case 2:
                popOffset = (65 - (size.width / 2)) + 70 + (65 - size.width / 2) * popPositionRate;
                break;
            default:
                break;
        }
    }
    [_valuePopView setFrame:CGRectMake(popOffset + 71, 5, 0, 22)];
    // ==================== 计算位置 end ====================
    
    CGFloat colorPositionX = popOffset + size.width / 2;
    UIColor *popColor = [_colorPicker getPixelColorAtLocation:CGPointMake(colorPositionX * 2, 0)]; // 0 - 399
    [_valuePopView setValueString:stringValue popColor:popColor];
    
    if (upValue > 0) {
        self.upOrDownImageView.image = [UIImage imageNamed:@"chpup.png"];
    } else if (upValue < 0) {
        self.upOrDownImageView.image = [UIImage imageNamed:@"chpdown.png"];
    } else {
        self.upOrDownImageView.image = [UIImage imageNamed:@"chp.png"];
    }
    self.upOrDownImageView.backgroundColor = popColor;
    
//    // 类型图标
//    NSString *imageNormalName = [NSString stringWithFormat:@"datadetailtbcelllisticon_normal_%d", (int)type];
//    UIImage *typeImageNormal = ThemeImage(imageNormalName);
//    
//    NSString *imageHighlight = [NSString stringWithFormat:@"datadetailtbcelllisticon_highlight_%d", (int)type];
//    UIImage *typeImageHighlight = ThemeImage(imageHighlight);
//    
//    [self.typeButton setImage:typeImageNormal forState:UIControlStateNormal];
//    [self.typeButton setImage:typeImageHighlight forState:UIControlStateHighlighted];
    
    // 差值

    self.valueChangeLabel.font = [UIFont systemFontOfSize:14];
    if ([stringUpValue isEqualToString:@"持平"]) {
        self.valueChangeLabel.font = [UIFont systemFontOfSize:12];
    }
    
    self.valueChangeLabel.text = stringUpValue;
}

@end
