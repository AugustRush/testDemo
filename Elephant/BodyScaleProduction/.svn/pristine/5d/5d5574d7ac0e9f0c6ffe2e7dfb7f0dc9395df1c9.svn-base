//
//  PraiseMeTableViewCell.h
//  BodyScaleProduction
//
//  Created by Cloud_Ding on 14-4-25.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserPraiseEntity.h"

@interface PraiseMeTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *headImgView;

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *praiseHerBtn;
@property (nonatomic, copy) void (^userPraiseBlock)(void);


-(void)fillCellWithUserPraise:(UserPraiseEntity *)userPraise;


@end
