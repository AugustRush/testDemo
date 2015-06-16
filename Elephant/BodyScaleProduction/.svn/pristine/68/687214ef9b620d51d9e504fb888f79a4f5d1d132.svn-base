//
//  GuidView.m
//  BodyScaleProduction
//
//  Created by Cloud_Ding on 14-4-3.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "GuidView.h"

@implementation GuidView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {


        if ([[NSUserDefaults standardUserDefaults] objectForKey:AppNotIsFirstEnter]) {

        }else{


        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [scrollView setContentSize:CGSizeMake(1280, 0)];
        [scrollView setPagingEnabled:YES];
            scrollView.delegate = self;
            scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;


        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-128, self.scrollView.width*5, 128)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:whiteView];


        UIImage *guidImg1 = [UIImage imageNamed:@"Guid1.png"];
        UIImageView *guidImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, self.bounds.size.height)];
        guidImgView1.image = guidImg1;
        [scrollView addSubview:guidImgView1];

        UIImage *guidImg2 = [UIImage imageNamed:@"Guid2.png"];
        UIImageView *guidImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, self.bounds.size.width, self.bounds.size.height)];
        guidImgView2.image = guidImg2;
        [scrollView addSubview:guidImgView2];

        UIImage *guidImg3 = [UIImage imageNamed:@"Guid3.png"];
        UIImageView *guidImgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width*2, 0, self.bounds.size.width, self.bounds.size.height)];
        guidImgView3.image = guidImg3;
        [scrollView addSubview:guidImgView3];

        UIImage *guidImg4 = [UIImage imageNamed:@"Guid4.png"];
        UIImageView *guidImgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width*3, 0, self.bounds.size.width, self.bounds.size.height)];
        guidImgView4.image = guidImg4;
        [scrollView addSubview:guidImgView4];


        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(22+self.scrollView.width*3, self.bounds.size.height-75, 276, 40)];
        btn.backgroundColor = [UIColor clearColor];
            [btn setBackgroundImage:[UIImage imageNamed:@"ljty.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"ljty_press.png"] forState:UIControlStateHighlighted];
        [self.scrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *skipBt = [UIButton buttonWithType:UIButtonTypeCustom];
            skipBt.frame = CGRectMake(130, [[UIScreen mainScreen] bounds].size.height-100, 51, 51);
            skipBt.backgroundColor = [UIColor clearColor];
            [skipBt setBackgroundImage:[UIImage imageNamed:@"tiaoguo.png"] forState:UIControlStateNormal];
            [skipBt setBackgroundImage:[UIImage imageNamed:@"tiaoguo_press.png"] forState:UIControlStateHighlighted];
            [skipBt addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:skipBt];
            
            self.pageControl = [[SMPageControl alloc] initWithFrame:CGRectMake(20, CGRectGetMinY(skipBt.frame)-40, 280, 20)];
            self.pageControl.numberOfPages = 4;
            self.pageControl.currentPage = 0;
            self.pageControl.pageIndicatorImage = [UIImage imageNamed:@"dian.png"];
            self.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"dian_selected.png"];
            [self addSubview:self.pageControl];

        }
        

        UIImage *loadPageImg = [UIImage imageNamed:@"backGround.png"];
        UIImageView *loadPageImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        loadPageImgView.image = loadPageImg;
        [self addSubview:loadPageImgView];

        UIImage *cloudUpImg = [UIImage imageNamed:@"cloudUp"];
        UIImageView *cloudUpImgView = [[UIImageView alloc] initWithFrame:CGRectMake(290, 70, 170, 120)];
        cloudUpImgView.image = cloudUpImg;
        [loadPageImgView addSubview:cloudUpImgView];
        UIImage *cloudDownImg = [UIImage imageNamed:@"cloudDown"];
        UIImageView *cloudDownImgView = [[UIImageView alloc] initWithFrame:CGRectMake(300, self.bounds.size.height-130, 150, 120)];
        cloudDownImgView.image = cloudDownImg;
        [loadPageImgView addSubview:cloudDownImgView];
        UIImage *cloudMiddleImg = [UIImage imageNamed:@"cloudMiddle"];
        UIImageView *cloudMiddleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(-100, self.bounds.size.height/2, 170, 120)];
        cloudMiddleImgView.image = cloudMiddleImg;
        [loadPageImgView addSubview:cloudMiddleImgView];

        [UIView animateWithDuration:2.5
                              delay:.5
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             cloudUpImgView.frame = CGRectMake(-90, 70, 180, 120);
                             cloudDownImgView.frame = CGRectMake(-100, self.bounds.size.height-130, 150, 120);
                             cloudMiddleImgView.frame = CGRectMake(200, self.bounds.size.height/2, 170, 120);


                         } completion:^(BOOL finished){
                             if (finished) {
                                 
                             }
                         }];

        if ([[NSUserDefaults standardUserDefaults] objectForKey:AppNotIsFirstEnter]) {

            [UIView animateWithDuration:1 delay:2.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];

        }else{
            [UIView animateWithDuration:1 delay:2.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                loadPageImgView.alpha = 0;
            } completion:^(BOOL finished) {
                [loadPageImgView removeFromSuperview];
            }];

        }



    }
    return self;
}


- (void)pageTurn:(UIPageControl*)sender
{
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = self.scrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

- (void)btnAction
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:AppNotIsFirstEnter]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:AppNotIsFirstEnter];

    }

    [UIView animateWithDuration:1
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = CGRectMake(-320, 0, 320, self.bounds.size.height);
                     } completion:^(BOOL finished){
                         if (finished) {
                             [self removeFromSuperview];

                         }
                     }];

}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x/CGRectGetWidth(self.scrollView.frame);
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    // 渐变
//    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0);
//    CGMutablePathRef pathGradual = CGPathCreateMutable();
//    CGPathAddRect(pathGradual, NULL, self.bounds);
//    CGContextAddPath(ctx, pathGradual);
//    CGContextFillPath(ctx);
//
//    CGContextSaveGState(ctx);
//    CGContextAddPath(ctx, pathGradual);
//    CGContextEOClip(ctx);
//
//    // 绘制渐变
//    CGFloat locs[2] = { 0.0, 1.0 };
//    CGFloat colors[9] = {
//        22 / 255.0f, 221 / 255.0f, 154 / 255.0f, 1,// 开始颜色
//        4 / 255.0f, 134 / 255.0f, 236 / 255.0f, 1  // 末尾颜色
//    };
//    CGColorSpaceRef sp = CGColorSpaceCreateDeviceRGB();
//    CGGradientRef grad = CGGradientCreateWithColorComponents (sp, colors, locs, 2);
//    CGContextDrawLinearGradient(ctx, grad, CGPointMake(0,SCREEN_HEIGHT), CGPointMake(SCREEN_WIDTH ,0), 0);
//    CGColorSpaceRelease(sp);
//    CGGradientRelease(grad);
//    CGContextRestoreGState(ctx); // 完成裁剪
//
//    CGPathRelease(pathGradual);
//}


@end
