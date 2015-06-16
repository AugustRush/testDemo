//
//  RegisterJurisdictionViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-5-30.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "RegisterJurisdictionViewController.h"
#import "AppDelegate.h"

@interface RegisterJurisdictionViewController ()
@property (weak, nonatomic) IBOutlet UIButton *onlymeButton;
@property (weak, nonatomic) IBOutlet UIButton *allattentionButton;

@end

@implementation RegisterJurisdictionViewController {
    int _privacy;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"设置权限";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _privacy = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)nextStepButton:(id)sender {
    [[GloubleProperty sharedInstance] currentUserEntity].UI_privacy = [NSString stringWithFormat:@"%d", _privacy];
    //隐私策略/权限 0:仅自己可见 1：关注人可
    [[InterfaceModel sharedInstance] updateUserSettingWithCallBack:nil];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate mainViewAppearWithUserInfo:[[GloubleProperty sharedInstance] currentUserEntity]];
}

- (IBAction)skipButtonAction:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate mainViewAppearWithUserInfo:[[GloubleProperty sharedInstance] currentUserEntity]];
}

- (IBAction)onlyMeButtonAction:(UIButton *)sender {
    self.onlymeButton.selected = YES;
    self.allattentionButton.selected = NO;
    _privacy = 0;
}

- (IBAction)myAttentionButtonAction:(UIButton *)sender {
    self.onlymeButton.selected = NO;
    self.allattentionButton.selected = YES;
    _privacy = 1;
}


@end
