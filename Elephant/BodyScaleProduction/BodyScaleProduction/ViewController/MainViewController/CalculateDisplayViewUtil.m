//
//  CalculateDisplayViewUtil.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-5-28.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "CalculateDisplayViewUtil.h"
#import "PCEntity.h"
#import "UserInfoEntity.h"
#import "CalculateTool.h"

typedef NS_ENUM(NSInteger, BMRImageViewType) {
    BMRImageViewTypeEurope,
    BMRImageViewTypeAsia
};

@interface BMRImageView : UIImageView

- (id)initWithBMR:(int)bmr isStandards:(BOOL)isStandards type:(BMRImageViewType)type;

@end

@implementation BMRImageView

- (id)initWithBMR:(int)bmr isStandards:(BOOL)isStandards type:(BMRImageViewType)type {
    UIImage *image = nil;
    if (type == BMRImageViewTypeAsia) {
        image = [UIImage imageNamed:@"bmr_asi.png"];
    } else {
        image = [UIImage imageNamed:@"bmr_eur.png"];
    }
    
    self = [super initWithImage:image];
    if (self) {
        UIColor *redColor = [UIColor colorWithRed:220 / 255.0f green:81 / 255.0f blue:81 / 255.0f alpha:1];
        UIColor *greenColor = [UIColor colorWithRed:78 / 255.0f green:224 / 255.0f blue:78 / 255.0f alpha:1];
        UIColor *textColor = isStandards ? greenColor : redColor;
        
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 17, self.width, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = [NSString stringWithFormat:@"%d卡路里/天", bmr];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = greenColor;
        [self addSubview:label];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 36, self.width, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.0f];
        label.textColor = textColor;
        label.text = isStandards ? @"已经达标了，继续努力哦。" : @"还未达标，请多运动哦。";
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
    }
    return self;
}

@end

@implementation CalculateDisplayViewUtil

+ (UIView *)calculateDisplayViewWithType:(PCType)type userInfo:(UserInfoEntity *)userInfoEntity {
    switch (type) {
        case PCType_bmi: {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bmi.png"]];
            return imageView;
        }
            break;
        case PCType_fat: {
            if ([userInfoEntity.UI_sex intValue] == 0) {
                if ([userInfoEntity.UI_age intValue] > 30) {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bodyfatup30famales.png"]];
                    return imageView;
                } else {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bodyfatunder30famales.png"]];
                    return imageView;
                }
            } else {
                if ([userInfoEntity.UI_age intValue] > 30) {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bodyfatup30males.png"]];
                    return imageView;
                } else {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bodyfatunder30malse.png"]];
                    return imageView;
                }
            }
        }
            break;
        case PCType_skin: {
            if ([userInfoEntity.UI_sex intValue] == 0) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"skinfatfemales.png"]];
                return imageView;
            } else {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"skinfatmales.png"]];
                return imageView;
            }
        }
            break;
        case PCType_boneWeight: {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"boom.png"]];
            return imageView;
        }
            break;
        case PCType_muscle: {
            if ([userInfoEntity.UI_sex intValue] == 0) {
                if ([userInfoEntity.UI_height intValue] < 150) {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mumalesunder150.png"]];
                    return imageView;
                } else if ([userInfoEntity.UI_height intValue] <= 160) {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mumalesunder160.png"]];
                    return imageView;
                } else {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mumalesup160.png"]];
                    return imageView;
                }
            } else {
                if ([userInfoEntity.UI_height intValue] < 160) {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mufemalesunder160.png"]];
                    return imageView;
                } else if ([userInfoEntity.UI_height intValue] <= 170) {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mufemalesunder170.png"]];
                    return imageView;
                } else {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mufemalesup170.png"]];
                    return imageView;
                }
            }
        }
            break;
        case PCType_water: {
            if ([userInfoEntity.UI_sex intValue] == 0) {
                if ([userInfoEntity.UI_age intValue] > 30) {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waterup30females.png"]];
                    return imageView;
                } else {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waterunder30females.png"]];
                    return imageView;
                }
            } else {
                if ([userInfoEntity.UI_age intValue] > 30) {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waterup30males.png"]];
                    return imageView;
                } else {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waterunder30males.png"]];
                    return imageView;
                }
            }
        }
            break;
        case PCType_bmr: {
            int bmr = [userInfoEntity.UI_lastUserData.UD_METABOLISM intValue];
            int standardsBMR = roundf([CalculateTool calculateAsiaBMRWithUserInfo:userInfoEntity]);
            
            BMRImageView *bmrImageView = [[BMRImageView alloc] initWithBMR:standardsBMR isStandards:(bmr >= standardsBMR) type:BMRImageViewTypeAsia];
            return bmrImageView;
        }
            break;
        case PCType_eBmr: {
            int bmr = [userInfoEntity.UI_lastUserData.UD_eBMR intValue];
            int standardsBMR = roundf([CalculateTool calculateBMRWithUserInfo:userInfoEntity]);
            
            BMRImageView *bmrImageView = [[BMRImageView alloc] initWithBMR:standardsBMR isStandards:(bmr >= standardsBMR) type:BMRImageViewTypeEurope];
            return bmrImageView;
        }
            break;
        case PCType_offal: {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"infat.png"]];
            return imageView;
        }
            break;
        case PCType_bodyage: {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bodyage.png"]];
            return imageView;
        }
            break;
        default:
            return nil;
            break;
    }
}

@end
