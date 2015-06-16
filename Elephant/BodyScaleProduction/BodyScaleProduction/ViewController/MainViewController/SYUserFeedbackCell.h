//
//  SYUserFeedbackCell.h
//  chatViewTest
//
//  Created by 刘平伟 on 14-3-27.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

#define SYColor(r,g,b)                  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

typedef NS_ENUM(NSInteger, SYUserFeedbackCellType)
{
    SYUserFeedbackCellTypeSend,
    SYUserFeedbackCellTypeBack
};

@interface SYUserFeedbackCell : UICollectionViewCell
{
    CGFloat _width;
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, assign) SYUserFeedbackCellType type;

-(CGSize)sizeWithString:(NSString *)string;

@end