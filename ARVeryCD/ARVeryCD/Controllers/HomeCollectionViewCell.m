//
//  HomeCollectionViewCell.m
//  ARVeryCD
//
//  Created by August on 14-7-30.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell
{
    UIDynamicAnimator *_animator;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initConfigs];
}

-(void)initConfigs
{
    self.titleLabel.textColor = FlatWhite;
}

#pragma mark - private methods

-(void)prepareForReuse
{
    self.thumbImageView.image = nil;
    self.titleLabel.text = nil;
}

-(void)buildCellWithEntry:(VCHomeEntry *)entry
{
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:entry.thumbImageUrl]];
    self.titleLabel.text = entry.videoName;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [UIView animateWithDuration:.1 animations:^{
        self.transform = CGAffineTransformMakeScale(0.9, .9);
        self.alpha = .8;
    }];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [UIView animateWithDuration:.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1;
    }];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [UIView animateWithDuration:.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1;
    }];
}

@end
