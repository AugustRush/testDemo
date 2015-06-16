//
//  RemindWeightTableViewCell.m
//  BodyScaleProduction
//
//  Created by Cloud_Ding on 14-5-9.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "RemindWeightTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation RemindWeightTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)queryRemindWithUserPraise:(UserPraiseEntity *)userPraiseEntity
{
    //self.headImgView.image = [UIImage imageWithContentsOfFile:userPraiseEntity.up_photopath];
    self.remindName.text = userPraiseEntity.up_nickname;
    self.remindTime.text = userPraiseEntity.up_createtime;
    NSString *baseUrl = SERVICE_URL;
    NSString *defaultPhoto = @"default_photo_females.png";
    NSString *urlString = [baseUrl stringByAppendingString:userPraiseEntity.up_photopath];
    [self.headImgView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:defaultPhoto]];

    self.headImgView.layer.cornerRadius = CGRectGetWidth(self.headImgView.bounds)/2;
    self.headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImgView.layer.borderWidth = 1.5;

}

@end
