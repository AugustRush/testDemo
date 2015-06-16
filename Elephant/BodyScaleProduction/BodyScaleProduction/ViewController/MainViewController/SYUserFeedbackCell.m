//
//  SYUserFeedbackCell.m
//  chatViewTest
//
//  Created by 刘平伟 on 14-3-27.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYUserFeedbackCell.h"

#define kdefaultHeadImageWidth          60
#define kDefaultCellContentTextFont     [UIFont systemFontOfSize:12]
#define kDefaultCellDateTextFont        [UIFont systemFontOfSize:10]

@implementation SYUserFeedbackCell

#pragma mark - init /config methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(void)initConfig
{
    _width = CGRectGetWidth(self.frame);
    self.imageView = [[UIImageView alloc] init];
    self.imageView.layer.cornerRadius = kdefaultHeadImageWidth/2;
    self.imageView.layer.borderWidth = 2;
    self.clipsToBounds = YES;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.contentView addSubview:self.imageView];
    
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.layer.cornerRadius = 4;
    self.contentLabel.clipsToBounds = YES;
    self.contentLabel.textColor = [UIColor grayColor];
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.font = kDefaultCellContentTextFont;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textAlignment = 0;
    [self.contentView addSubview:self.contentLabel];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.backgroundColor = [UIColor clearColor];
    self.dateLabel.textAlignment = 1;
    self.dateLabel.font = kDefaultCellDateTextFont;
    self.dateLabel.textColor = [UIColor grayColor];
    self.dateLabel.text = @"3月15日  17:50";
    [self.contentView addSubview:self.dateLabel];
}

#pragma mark - custom methods

-(void)setType:(SYUserFeedbackCellType)type
{
    _type = type;
    if (_type == SYUserFeedbackCellTypeSend) {
        self.imageView.clipsToBounds = YES;
        self.imageView.image = [UIImage imageNamed:@"head1"];
        self.contentLabel.backgroundColor = [UIColor whiteColor];
        self.imageView.frame = CGRectMake(10,
                                          10,
                                          kdefaultHeadImageWidth,
                                          kdefaultHeadImageWidth);
        
        self.contentLabel.frame = CGRectMake(kdefaultHeadImageWidth + 20,
                                             10,
                                             CGRectGetWidth(self.frame) - kdefaultHeadImageWidth - 30, CGRectGetHeight(self.frame)-40);
       
        self.dateLabel.frame = CGRectMake(10,
                                          CGRectGetMaxY(self.contentLabel.frame) + 10, CGRectGetWidth(self.frame)-20,
                                          15);
        
        
    }else if (_type == SYUserFeedbackCellTypeBack){
        self.imageView.clipsToBounds = YES;
        NSString *imageUrl = [[[GloubleProperty sharedInstance] currentUserEntity] UI_photoPath];
        if (imageUrl.length) {
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",SERVICE_URL,imageUrl];
            
            [self.imageView setImageWithURL:[NSURL URLWithString:urlStr]];
        }else{
            if ([[[[GloubleProperty sharedInstance] currentUserEntity] UI_sex] isEqualToString:@"0"]) {
                self.imageView.image = [UIImage imageNamed:@"default_photo_females.png"];
            }else{
                self.imageView.image = [UIImage imageNamed:@"default_photo_males.png"];
            }

        }
        
        self.contentLabel.backgroundColor = SYColor(219, 234, 242);
        self.imageView.frame = CGRectMake(CGRectGetWidth(self.frame)-kdefaultHeadImageWidth-10,
                                          10,
                                          kdefaultHeadImageWidth,
                                          kdefaultHeadImageWidth);

        self.contentLabel.frame = CGRectMake(10,
                                             10,
                                             CGRectGetWidth(self.frame)-kdefaultHeadImageWidth-30,
                                             CGRectGetHeight(self.frame)-40);
        
        self.dateLabel.frame = CGRectMake(10,
                                          CGRectGetMaxY(self.contentLabel.frame) + 10, CGRectGetWidth(self.frame) - 20,
                                          15);
    }else{}
}

-(CGSize)sizeWithString:(NSString *)string
{
    CGSize size = [string sizeWithFont:kDefaultCellContentTextFont
                     constrainedToSize:CGSizeMake(_width-kdefaultHeadImageWidth-30, 10000)
                         lineBreakMode:0];
    return CGSizeMake(_width, size.height + 40 > kdefaultHeadImageWidth ? size.height + 50:kdefaultHeadImageWidth + 10);
}

@end