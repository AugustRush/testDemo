//
//  PraiseMeTableViewCell.m
//  BodyScaleProduction
//
//  Created by Cloud_Ding on 14-4-25.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "PraiseMeTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation PraiseMeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)Praise:(id)sender
{
    if (self.userPraiseBlock) {
        self.userPraiseBlock();
    }
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    self.praiseHerBtn = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillCellWithUserPraise:(UserPraiseEntity *)userPraise
{
    //self.imageView.image = [UIImage imageWithContentsOfFile:userPraise.up_photopath];
    self.nameLabel.text = userPraise.up_nickname;
    self.timeLabel.text = userPraise.up_createtime;

    NSString *baseUrl = SERVICE_URL;
    NSString *defaultPhoto = @"default_photo_females.png";
    NSString *urlString = [baseUrl stringByAppendingString:userPraise.up_photopath];
    [self.headImgView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:defaultPhoto]];

    self.headImgView.layer.cornerRadius = CGRectGetWidth(self.headImgView.bounds)/2;
    self.headImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImgView.layer.borderWidth = 1.5;

}

@end
