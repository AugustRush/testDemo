//
//  ScaleTableViewCell.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-21.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "ScaleTableViewCell.h"

@interface ScaleTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *scaleImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;

@end

@implementation ScaleTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    self.selectedImage.hidden = !selected;
}

#pragma mark - Setter
- (void)setBodyScaleName:(NSString *)name image:(UIImage *)image uuid:(NSString *)uuid {
    self.nameLabel.text = @"RyFit";
    self.uuidLabel.text = uuid;
}

@end
