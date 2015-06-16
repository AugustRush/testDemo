//
//  MessageViewTableViewCell.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 5/9/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "MessageViewTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MSGFocusMeEntity.h"

typedef NS_ENUM(NSUInteger, AQMessageStutas) {
    AQMessageStutasAgreed = 0,      // 已同意
    AQMessageStutasRefused = 1,     // 拒绝
    AQMessageStutasToBeConfirmed = 2// 待确认
};

@implementation MessageViewTableViewCell {
    MSGFocusMeEntity *msgEntity;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.agreeBlock = nil;
    self.headImageView.image = nil;
    self.nickNameLabel.text = @"";
    self.titleLabel.text = @"";
}

- (IBAction)agreeMessage:(UIButton *)sender {
    if (self.agreeBlock) {
        self.agreeBlock(msgEntity.msgFm_mId);
    }
}

- (void)fillCellWithEntity:(MSGFocusMeEntity *)entity {
    msgEntity = entity;
    
    int sex = [entity.msgFm_sex intValue];
    NSString *defaultPhoto = @"default_photo_males.png";
    if (sex == 0) {
        defaultPhoto = @"default_photo_females.png";
    }
    NSString *baseUrl = SERVICE_URL;
    
    NSString *urlString = [baseUrl stringByAppendingString:entity.msgFm_photopath];
    [self.headImageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:defaultPhoto]];
    
    self.nickNameLabel.text = entity.msgFm_nickName;
    self.titleLabel.text = @"请求添加你为好友";
    
    AQMessageStutas status = [entity.msgFm_status intValue];
    
    switch (status) {
        case AQMessageStutasAgreed: {
            self.agreeButton.enabled = NO;
            [self.agreeButton setImage:[UIImage imageNamed:@"agreed"] forState:UIControlStateNormal];
        }
            break;
            
        case AQMessageStutasRefused: {
            
        }
            break;
        case AQMessageStutasToBeConfirmed: {
            self.agreeButton.enabled = YES;
            [self.agreeButton setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
            [self.agreeButton setImage:[UIImage imageNamed:@"agree_press"] forState:UIControlStateHighlighted];
        }
            break;
            
        default:
            break;
    }
}

@end
