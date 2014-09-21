//
//  ICViewController.m
//  AutoLayoutProgrammingDemo
//
//  Created by 刘平伟 on 14-5-14.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "ICViewController.h"

@interface ICViewController ()
@property (retain, nonatomic) UIView *redView;
@property (retain, nonatomic) UIView *blueView;

@end

@implementation ICViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.redView = [[UIView alloc] init];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];

    self.blueView = [[UIView alloc] init];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];

    
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    self.blueView.translatesAutoresizingMaskIntoConstraints = NO;

    
//    [self testAutoLayout1];
    
//    [self testAutoLayout2];
    
//    [self testAutoLayout3];
//    [self testAutoLayout4];
//    [self testAutoLayout5];
    [self testAutolayout6];
}

-(void)testAutoLayout1
{
    NSString *redK = @"redView";
    NSString *blueK = @"blueView";
    
    NSDictionary *viewConstraints = @{redK:self.redView,blueK:self.blueView};
    NSDictionary *metrics = @{@"redW":@100,
                              @"redH":@100,
                              @"blueW":@200,
                              @"blueH":@250,
                              @"topMargin":@30,
                              @"leftMargin": @20,
                              @"viewSpacing":@10};
    
    NSArray *red_Constrants_H = [NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:[redView(redH)]"
                                 options:0
                                 metrics:metrics
                                 views:viewConstraints];
    NSArray *red_constranits_V = [NSLayoutConstraint
                                  constraintsWithVisualFormat:@"H:[redView(redW)]"
                                  options:0
                                  metrics:metrics views:viewConstraints];
    
    [self.redView addConstraints:red_Constrants_H];
    [self.redView addConstraints:red_constranits_V];

    
    NSArray *b_Constrants_H = [NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:[blueView(blueH)]"
                                 options:0
                                 metrics:metrics
                                 views:viewConstraints];
    NSArray *b_constranits_V = [NSLayoutConstraint
                                  constraintsWithVisualFormat:@"H:[blueView(blueW)]"
                                  options:0
                                  metrics:metrics views:viewConstraints];
    
    [self.blueView addConstraints:b_Constrants_H];
    [self.blueView addConstraints:b_constranits_V];
    
    NSArray *all_C = [NSLayoutConstraint
                      constraintsWithVisualFormat:@"H:|-topMargin-[redView]"
                      options:0
                      metrics:metrics
                      views:viewConstraints];
    
    NSArray *all_C0 = [NSLayoutConstraint
                      constraintsWithVisualFormat:@"H:|-topMargin-[blueView]"
                      options:0
                      metrics:metrics
                      views:viewConstraints];

    NSArray *all_C1 = [NSLayoutConstraint
                      constraintsWithVisualFormat:@"V:|-leftMargin-[redView]-viewSpacing-[blueView]"
                      options:0
                      metrics:metrics
                       views:viewConstraints];

    
    [self.view addConstraints:all_C];
    [self.view addConstraints:all_C0];
    [self.view addConstraints:all_C1];

}

-(void)testAutoLayout2
{
    NSString *redK = @"redView";
    NSString *blueK = @"blueView";
    NSDictionary *viewsDict = @{redK:self.redView,blueK:self.blueView};
    
    NSDictionary *metrics = @{@"VSp":@30,@"HSp":@20};
    
    NSArray *constrants_Pos_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-VSp-[redView]-VSp-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewsDict];
    NSArray *constrants_Pos_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-HSp-[redView]-HSp-|"
                                                                        options:0
                                                                        metrics:metrics
                                                                          views:viewsDict];
    [self.view addConstraints:constrants_Pos_H];
    [self.view addConstraints:constrants_Pos_V];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.redView
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:.5
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.redView
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:0.5
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.redView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.redView
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:1]];
    
}

-(void)testAutoLayout3
{
//    ICAutoLayoutMargin margin = {10,10,20,100};
//    [self.redView ICAutoLayout_RelativeSuperViewMargin:margin];
//    
//    [self.blueView ICAutoLayout_RelativeView:self.redView Margin:margin];
    
    ICAutoLayoutMargin margin1 = {10,10,30,50};
    
//    [self.button1 ICAutoLayout_RelativeSuperViewMargin:margin1];
    [self.button1 ICAutoLayout_RelativeSuperViewMargin:margin1 type:ICAutoLayoutTypeFirmHeightToTop];
        ICAutoLayoutMargin margin2 = {10,10,50,10};
    [self.button2 ICAutoLayout_RelativeSuperViewMargin:margin2 type:ICAutoLayoutTypeFirmHeightToBottom];
    
    ICAutoLayoutMargin margin3 = {20,200,100,100};
    [self.label1 ICAutoLayout_RelativeSuperViewMargin:margin3 type:ICAutoLayoutTypeFirmWidthToLeft];
    
    ICAutoLayoutMargin margin4 = {50,10 ,100,100};
    [self.label2 ICAutoLayout_RelativeSuperViewMargin:margin4 type:ICAutoLayoutTypeFirmWidthToRight];
    
//    ICAutoLayoutMargin margin5 = {120,120,100,100};
//    [self.redView ICAutoLayout_RelativeSuperViewMargin:margin5];
//    
//    ICAutoLayoutMargin margin6 = {10,100,30,100};
//    [self.blueView ICAutoLayout_RelativeSuperViewMargin:margin6 type:ICAutoLayoutMarginAllFirmToLeftTop];
}

-(void)testAutoLayout4
{
    ICAutoLayoutMargin margin = {10,100,100,10};
    [self.redView ICAutoLayout_RelativeSuperViewMargin:margin type:ICAutoLayoutMarginAllFirmToLeftBottom];
    
    ICAutoLayoutMargin margin1 = {10,100,30,100};
    [self.blueView ICAutoLayout_RelativeSuperViewMargin:margin1 type:ICAutoLayoutMarginAllFirmToLeftTop];
    
    ICAutoLayoutMargin margin2 = {100,10,30,100};
    [self.label1 ICAutoLayout_RelativeSuperViewMargin:margin2 type:ICAutoLayoutMarginAllFirmToRightTop];
    ICAutoLayoutMargin margin3 = {100,10,100,10};
    [self.label2 ICAutoLayout_RelativeSuperViewMargin:margin3 type:ICAutoLayoutMarginAllFirmToRightBottom];
    
    [self.button1
     ICAutoLayout_RelativeSuperViewMargin:ICAutoLayoutMarginMake(10, 10, 100, 0) type:ICAutoLayoutTypeFirmHeightLocationCenterY];
    
    [self.button2 ICAutoLayout_RelativeSuperViewMargin:ICAutoLayoutMarginMake(200, 0, 200, 200) type:ICAutoLayoutTypeFirmWidthLocationCenterX];

}

-(void)testAutoLayout5{
    
    [self.redView ICAutoLayout_RelativeSuperViewMargin:ICAutoLayoutMarginMake(10, 10, 50, 0) type:ICAutoLayoutTypeFirmHeightLocationCenterY];
    
    [self.label1 ICAutoLayout_RelativeView:self.redView Margin:ICAutoLayoutMarginMake(120,0, 10, 50) Type:ICAutoLayoutRelativeTypeFirmHeightBottom];
    
    [self.label2 ICAutoLayout_RelativeView:self.redView Margin:ICAutoLayoutMarginMake(0, -120, -10, 50) Type:ICAutoLayoutRelativeTypeFirmHeightTop];
    
//    self.button1.backgroundColor = [UIColor orangeColor];
    [self.button1 ICAutoLayout_RelativeView:self.label1 Margin:ICAutoLayoutMarginMake(100, -10, 10, -10) Type:ICAutoLayoutRelativeTypeFirmWidthLeft];
    
    [self.button2 ICAutoLayout_RelativeView:self.label2 Margin:ICAutoLayoutMarginMake(10, 100, 10, -10) Type:ICAutoLayoutRelativeTypeFirmWidthRight];
    
}

-(void)testAutolayout6
{
    [self.redView ICAutoLayout_RelativeSuperViewMargin:ICAutoLayoutMarginMake(100, 0, 100, 0) type:ICAutoLayoutTypeAllFirmLocationCenterXY];
    
    [self.blueView ICAutoLayout_RelativeView:self.redView Margin:ICAutoLayoutMarginMake(100, -10, 100, -10) Type:ICAutoLayoutRelativeTypeAllFirmLeftTop];
    
    [self.label1 ICAutoLayout_RelativeView:self.redView Margin:ICAutoLayoutMarginMake(100, -10, -10, 100) Type:ICAutoLayoutRelativeTypeAllFirmLeftBottom];
    [self.label2 ICAutoLayout_RelativeView:self.redView Margin:ICAutoLayoutMarginMake(100, -10, -10, 100) Type:ICAutoLayoutRelativeTypeAllFirmRightTop];
    
    [self.button1 ICAutoLayout_RelativeView:self.redView Margin:ICAutoLayoutMarginMake(10, 100, 10, 100) Type:ICAutoLayoutRelativeTypeAllFirmRightBottom];
    
    [self.button2 ICAutoLayout_RelativeView:self.redView Margin:ICAutoLayoutMarginMake(-10, 10, -10, 10) Type:ICAutoLayoutRelativeTypeInnerAllUnfirm];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
