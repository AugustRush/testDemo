//
//  HealthMeTableViewCell.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 5/16/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "HealthMeTableViewCell.h"
#import "FriendInfoEntity.h"
#import "UIImageView+WebCache.h"

@interface HealthMeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyFatLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMeasureDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UIButton *notifyWeightButton;
@property (weak, nonatomic) IBOutlet UIView *likeView;
@property (weak, nonatomic) IBOutlet UIView *notifyWeightView;

@end

@implementation HealthMeTableViewCell

- (IBAction)likeButtonAction:(UIButton *)sender {
    if (self.userLikeBlock) {
        self.userLikeBlock();
    }
}

- (IBAction)notifyWeightButtonAction:(UIButton *)sender {
    if (self.notifyWeightBlock) {
        self.notifyWeightBlock();
    }
}

- (void)fillCellWithFriendInfoEntity:(FriendInfoEntity *)entity {
    if (entity == nil)
        return;
    
    // 用户名
    self.nickNameLabel.text = entity.FI_nickName;
    
    // 头像
    int sex = [entity.FI_sex intValue];
    NSString *defaultPhoto = @"default_photo_males.png";
    if (sex == 0) {
        defaultPhoto = @"default_photo_females.png";
    }
    NSString *baseUrl = SERVICE_URL;
    NSString *urlString = [baseUrl stringByAppendingString:entity.FI_photopath];
    [self.headImageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:defaultPhoto]];
    
    // 体重
    self.weightLabel.text = [NSString stringWithFormat:@"体重 %.1fkg", [entity.FI_weight floatValue]];
    
    // 体脂
    self.bodyFatLabel.text = [NSString stringWithFormat:@"体脂 %d%%", [entity.FI_fat intValue]];
    
    // 测量时间
    self.lastMeasureDateLabel.text = [NSString stringWithFormat:@"上次测量 %@",entity.FI_checkdate];
    
    // 点赞数量
    self.likeLabel.text = [NSString stringWithFormat:@"赞 (%@)", entity.FI_countpraise ? entity.FI_countpraise : @"0"];
    
    int permission = entity.FI_mright.intValue;
    if (permission == 0) {
        // 无权限
        self.weightLabel.hidden = YES;
        self.bodyFatLabel.hidden = YES;
        self.lastMeasureDateLabel.hidden = YES;
        
        self.nickNameLabel.frame = CGRectMake(0, 10, 242, 21);
        self.likeView.frame = CGRectMake(85, 39, 100, 300);
        self.notifyWeightView.frame = CGRectMake(193, 39, 100, 300);
    } else if (permission == 1) {
        // 查看权限
        self.weightLabel.hidden = NO;
        self.bodyFatLabel.hidden = NO;
        self.lastMeasureDateLabel.hidden = NO;
        
        self.nickNameLabel.frame = CGRectMake(0, 6, 242, 21);
        self.likeView.frame = CGRectMake(85, 79, 100, 300);
        self.notifyWeightView.frame = CGRectMake(193, 79, 100, 300);
    }
}

+ (CGFloat)cellHeightByPermission:(BOOL)hasPermission {
    if (hasPermission) {
        return 120;
    } else {
        return 80;
    }
}

@end
