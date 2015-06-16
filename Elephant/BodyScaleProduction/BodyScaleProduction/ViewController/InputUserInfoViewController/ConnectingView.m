//
//  ConnectingView.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-6-8.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "ConnectingView.h"

@interface ConnectingView()

@property (weak, nonatomic) IBOutlet UIImageView *animationImage;

@end

@implementation ConnectingView

- (void)awakeFromNib {
    NSMutableArray *images = [NSMutableArray array];
    for (int index = 1; index <= 9; index ++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"dian%d.png", index]]];
    }
    
    UIImage *animationImage = [UIImage animatedImageWithImages:images duration:1];
    self.animationImage.image = animationImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
