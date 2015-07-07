//
//  ARPhotoBrowerCell.m
//  ARPhotoBrower
//
//  Created by August on 15/7/2.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoBrowerCell.h"
#import <AVFoundation/AVFoundation.h>

@interface ARPhotoBrowerCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ARPhotoBrowerCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setUp];
    }
    return self;
}

-(void)_setUp
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 3;
    [self.contentView addSubview:self.scrollView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.imageView];

    NSString *testImageName = [NSString stringWithFormat:@"%d.jpg",arc4random()%6];
    self.imageView.image = [UIImage imageNamed:testImageName];
    
    [self centerImageView];
}

- (void)centerImageView {
    if (self.imageView.image) {
        CGRect frame  = AVMakeRectWithAspectRatioInsideRect(self.imageView.image.size, CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height));
        
        if (self.scrollView.contentSize.width == 0 && self.scrollView.contentSize.height == 0) {
            frame = AVMakeRectWithAspectRatioInsideRect(self.imageView.image.size, self.scrollView.bounds);
        }
        
        CGSize boundsSize = self.scrollView.bounds.size;
        
        CGRect frameToCenter = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        if (frameToCenter.size.width < boundsSize.width) {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
        }
        else {
            frameToCenter.origin.x = 0;
        } if (frameToCenter.size.height < boundsSize.height) {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
        }
        else {
            frameToCenter.origin.y = 0;
        }
        self.imageView.frame = frameToCenter;
    }
}

#pragma mark - UIScrollViewDelegate methods

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerImageView];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
