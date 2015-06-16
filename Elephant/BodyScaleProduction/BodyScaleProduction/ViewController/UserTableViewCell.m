//
//  UserTableViewCell.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 5/16/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "UserTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UserInfoEntity.h"

@interface UserTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyFatLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMeasureDateLabel;

@end

@implementation UserTableViewCell

- (void)fillCellWithUserInfoEntity:(UserInfoEntity *)entity {
    if (entity == nil)
        return;
    
    // 用户名
    self.nickNameLabel.text = entity.UI_nickname;
    
    // 头像
    int sex = [entity.UI_sex intValue];
    NSString *defaultPhoto = @"default_photo_males.png";
    if (sex == 0) {
        defaultPhoto = @"default_photo_females.png";
    }
    NSString *baseUrl = SERVICE_URL;
    NSString *urlString = [baseUrl stringByAppendingString:entity.UI_photoPath];
    [self.headImageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:defaultPhoto]];
    
    // 体重
    self.weightLabel.text = [NSString stringWithFormat:@"体重 %.1fkg", [entity.UI_lastUserData.UD_WEIGHT floatValue]];
    
    // 体脂
    self.bodyFatLabel.text = [NSString stringWithFormat:@"体脂 %d%%", [entity.UI_lastUserData.UD_FAT intValue]];
    
    // 测量时间
    self.lastMeasureDateLabel.text = [NSString stringWithFormat:@"上次测量 %@",entity.UI_lastCheckDate];
}

@end
