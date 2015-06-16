//
//  ThemeManager.h
//
//  Created by Zhanghao on 6/6/14.
//  Copyright (c) 2014 Zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ThemeImage(imageName)   [[ThemeManager sharedManager] themeImageNamed:imageName]

FOUNDATION_EXTERN NSString *const ThemeDidChangeNotification;

typedef NS_ENUM(NSInteger, ThemeStyle) {
    ThemeStyleClassic = 0,              // 经典
    ThemeStyleRed,                      // 魅力红
    ThemeStyleBlue,                     // 活力蓝
    ThemeStylePurple,                   // 轻悦紫
    ThemeStyleGreen,                    // 青春绿
    ThemeStyleYellow,                   // 明媚黄
};

typedef struct {
    unsigned int index;
    char *themeName;
} ThemeStyleToName;

// 不同风格对应不同主题名称，该主题名需要与具体皮肤的文件目录名相同
static const ThemeStyleToName style_to_name[] = {
    { ThemeStyleClassic, "Classic" },
    { ThemeStyleRed, "Red" },
    { ThemeStyleBlue, "Blue" },
    { ThemeStylePurple, "Purple" },
    { ThemeStyleGreen, "Green" },
    { ThemeStyleYellow, "Yellow" },
};

@interface ThemeManager : NSObject

@property (nonatomic, assign, readonly) ThemeStyle style;

/**
 *  不同主题对应的颜色
 */
@property (nonatomic, assign, readonly) UIColor *themeColor;

+ (instancetype)sharedManager;

/**
 *  主题图片用此函数获取，可以使用ThemeImage(imageName)宏，以简化操作
 *
 *  @param imageName 图片名，可不带.png后缀，默认图片格式为png格式
 *
 *  @return image对象
 */
- (UIImage *)themeImageNamed:(NSString *)imageName;

/**
 *  调用此函数更换主题
 *
 *  @param themeStyle 不同风格的主题枚举对象
 */
- (void)changeToTheme:(ThemeStyle)themeStyle;

@end
