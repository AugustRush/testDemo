//
//  CircleFormView.m
//  BodyScale
//
//  Created by Go Salo on 14-3-4.
//  Copyright (c) 2014年 于菲. All rights reserved.
//

#import "CircleFormView.h"

#define toRadians(x) ((x)*M_PI / 180.0)
#define toDegrees(x) ((x)*180.0 / M_PI)
#define innerRadius    92.0f
#define outerRadius    102.0f
#define sectorRadius   83.0f

@interface CircleFormView()

@property (nonatomic, strong)UILabel *integerLabel;
@property (nonatomic, strong)UILabel *decimalsLabel;
@property (nonatomic, strong)UILabel *paramLabel;
@property (nonatomic, strong)CALayer *pointerLayer;

@end

@implementation CircleFormView {
    @private
    float _maxinum;
    float _minimum;
    float _currentValue;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self initView];
        [self initGloubleVariable];
    }
    return self;
}

#pragma mark - 
- (void)initView {
    UILabel *integerLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 118, 85, 55)];
    integerLabel.backgroundColor = [UIColor clearColor];
    integerLabel.adjustsFontSizeToFitWidth = YES;
    integerLabel.minimumScaleFactor = 0.2f;
    integerLabel.font = [UIFont systemFontOfSize:70.0f];
    integerLabel.numberOfLines = 1;
    integerLabel.textColor = [UIColor whiteColor];
    integerLabel.text = @"00";
    integerLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:integerLabel];
    self.integerLabel = integerLabel;
    
    UILabel *decimalsLabel = [[UILabel alloc] initWithFrame:CGRectMake(178, integerLabel.frame.origin.y + 20, 63, 35)];
    decimalsLabel.backgroundColor = [UIColor clearColor];
    decimalsLabel.textColor = [UIColor whiteColor];
    decimalsLabel.font = [UIFont systemFontOfSize:40.0f];
    decimalsLabel.text = @" . 0";
    [self addSubview:decimalsLabel];
    self.decimalsLabel = decimalsLabel;
    
    UILabel *paramLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 228, self.bounds.size.width, 18)];
    paramLabel.backgroundColor = [UIColor clearColor];
    [paramLabel setTextAlignment:NSTextAlignmentCenter];
    [paramLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [paramLabel setTextColor:[UIColor whiteColor]];
    paramLabel.text = @"BMI";
    [self addSubview:paramLabel];
    self.paramLabel = paramLabel;
    
    /*
    UIImage *image = [UIImage imageNamed:@"pointer.png"];
    CALayer *imageLayer =[CALayer layer];
    CGPoint center = CGPointMake(self.frame.size.width / (2),
                                 self.frame.size.height / (2));
    imageLayer.frame = CGRectMake(center.x - image.size.width / 2,
                                  center.y - image.size.height / 2,
                                  image.size.width,
                                  image.size.height);
    imageLayer.contents =(id)image.CGImage;
    imageLayer.anchorPoint = CGPointMake(0.5, (1 - image.size.width / 2 / image.size.height));
    imageLayer.masksToBounds =YES;
    imageLayer.transform = CATransform3DMakeRotation(toRadians(-150), 0, 0, 1);
    [self.layer addSublayer:imageLayer];
    self.pointerLayer = imageLayer;
     */
    
    /*
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, self.height / 2 - 5, 30, 15)];
    label.text = @"标准";
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    label.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake((self.width - 30) / 2, 22 - 5, 30, 15)];
    label.text = @"适中";
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    label.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 30, self.height / 2 - 5, 30, 15)];
    label.text = @"超标";
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    label.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:label];
     */
}

- (void)initGloubleVariable {
    _maxinum = 1;
    _minimum = 0;
    _currentValue = 0;
}

- (void)drawRect:(CGRect)rect
{
    // prepare and init
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 255 / 255.0f, 255 / 255.0f, 255 / 255.0f, 1);
    CGContextSetLineWidth(context, 1);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGPoint center = CGPointMake(self.frame.size.width / (2), self.frame.size.height / (2));

    _minimum = 0;
    _maxinum = 100;
    
    float valuePercent = (_currentValue - _minimum) / (_maxinum - _minimum);
    
    // 整体裁剪
    CGMutablePathRef circleMaskPath = CGPathCreateMutable();
    CGPathAddRelativeArc(circleMaskPath, NULL, center.x, center.y, outerRadius, toRadians(-235), toRadians(290));
    // 圆角
    CGFloat circleRadius = (outerRadius - innerRadius) / 2;
    CGPoint circleCenterPoint = CGPointMake(center.x + (outerRadius + innerRadius) / 2 * sin(toRadians(35)), center.y + (outerRadius + innerRadius) / 2 * cos(toRadians(35)));
    CGPathAddRelativeArc(circleMaskPath, NULL, circleCenterPoint.x, circleCenterPoint.y, circleRadius, toRadians(55), M_PI);
    // 圆角 end
    
    CGPathAddRelativeArc(circleMaskPath, NULL, center.x, center.y, innerRadius, toRadians(55), -toRadians(290));
    
    // 圆角
    circleCenterPoint = CGPointMake(center.x - (outerRadius + innerRadius) / 2 * sin(toRadians(35)), center.y + (outerRadius + innerRadius) / 2 * cos(toRadians(35)));
    CGPathAddRelativeArc(circleMaskPath, NULL, circleCenterPoint.x, circleCenterPoint.y, -circleRadius, toRadians(-235), M_PI);
    // 圆角 end
    
    CGContextFillPath(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, circleMaskPath);
    CGContextEOClip(context);
    {
        // C1 蓝色环形（底）
        CGFloat delta = -toRadians(360 * (5.0f / 6) * (1 - valuePercent));
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRelativeArc(path, NULL, center.x, center.y, (outerRadius+innerRadius)/2-1, toRadians(60), delta);
        CGPathAddRelativeArc(path, NULL, center.x, center.y, (outerRadius+innerRadius)/2+1, toRadians(300 * valuePercent - 240), -delta);
        
        CGContextAddPath(context, path);
        CGContextFillPath(context);
        
        CFRelease(path);
        
        // C2 渐变环形
        CGContextSetRGBFillColor(context, 225 / 255.0f, 237 / 255.0f, 84 / 255.0f, 1);
        
        delta = toRadians(360 * (5.0f / 6) * (valuePercent));
        CGMutablePathRef path2 = CGPathCreateMutable();
        CGPathAddRelativeArc(path2, NULL, center.x, center.y, outerRadius, toRadians(-240), delta);
        CGPathAddRelativeArc(path2, NULL, center.x, center.y, innerRadius, toRadians(300 * valuePercent - 240), -delta);
        
        CGContextFillPath(context);
        
        CGContextSaveGState(context);
        CGContextAddPath(context, path2);
        CGContextEOClip(context);
        
        CGImageRef imageRef = [UIImage imageNamed:@"yuanpan.png"].CGImage;
        
        //做CTM变换
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextTranslateCTM(context, self.bounds.size.width, 0);
        CGContextScaleCTM(context, -1.0, 1.0);
        
        CGContextDrawImage(context, CGRectMake(45, 30, self.bounds.size.width - 90, self.bounds.size.height - 60), imageRef);
        CGContextRestoreGState(context); // 完成裁剪
        CGPathRelease(path2);
    }
    
    CGContextRestoreGState(context); // 完成裁剪
    CGPathRelease(circleMaskPath);
    // 整体裁剪 end

    /*
    // sector 扇形
    CGContextSetLineWidth(context, 1);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetAllowsAntialiasing(context, YES);
    
    delta = toRadians(360 * (5.0f / 6) * valuePercent);
    CGMutablePathRef path3 = CGPathCreateMutable();
    CGContextSetRGBFillColor(context, 255 / 255.0f, 254 / 255.0f, 245 / 255.0f, 0.3);
    CGPathAddRelativeArc(path3, NULL, center.x, center.y, sectorRadius, M_PI / 180 * 120, delta);
    CGPathAddLineToPoint(path3, NULL, center.x, center.y);
    
    CGContextAddPath(context, path3);
    CGContextFillPath(context);
    CFRelease(path3);
    
    // 调整pointer 角度
    self.pointerLayer.transform = CATransform3DMakeRotation(toRadians(-150 + 300 * valuePercent), 0, 0, 1);
     */
    
    // 四个点
    CGContextMoveToPoint(context, 70, 70);
    CGContextSetRGBFillColor(context, 1, 1, 1, 0.6);
    CGContextAddArc(context, 70, 70, 2, 0, 2 * M_PI, 1);
    CGContextFillPath(context);
    
    CGContextSetRGBFillColor(context, 1, 1, 1, 0.6);
    CGContextAddArc(context, 250, 70, 2, 0, 2 * M_PI, 1);
    CGContextFillPath(context);
    
    CGContextSetRGBFillColor(context, 1, 1, 1, 0.6);
    CGContextAddArc(context, 70, 220, 2, 0, 2 * M_PI, 1);
    CGContextFillPath(context);
    
    CGContextSetRGBFillColor(context, 1, 1, 1, 0.6);
    CGContextAddArc(context, 250, 220, 2, 0, 2 * M_PI, 1);
    CGContextFillPath(context);
}

#pragma mark - Private Method
- (void)reloadCircleForm:(float)num {
    _currentValue = num;
    [self setNeedsDisplay];
}

- (void)setMaximum:(float)maxinum minimum:(float)minimum {
    _maxinum = maxinum;
    _minimum = minimum;
}

#pragma mark - Public Method
- (void)setItemName:(NSString *)name dataNum:(float)num percentage:(float)percentage {
    if (num == -1) {
        self.integerLabel.hidden = YES;
        self.decimalsLabel.hidden = YES;
    } else {
        self.integerLabel.hidden = NO;
        self.decimalsLabel.hidden = NO;
    }
    self.paramLabel.text = name;
    self.integerLabel.text = [NSString stringWithFormat:@"%02d", (int)num];
    self.decimalsLabel.text = [NSString stringWithFormat:@" . %d", (int)(num * 10) % 10];
    
    [self reloadCircleForm:percentage];
}

@end
