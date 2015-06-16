//
//  RegisterSelectPlanViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-26.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "RegisterSelectPlanViewController.h"
#import "RegisterSelectTargetViewController.h"
#import "AppDelegate.h"

@interface RegisterSelectPlanViewController ()

@property (weak, nonatomic) IBOutlet UIButton *fitnessModelButton;
@property (weak, nonatomic) IBOutlet UIButton *fatModelButton;
@property (weak, nonatomic) IBOutlet UIButton *healthModelButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation RegisterSelectPlanViewController {
    NSInteger _mode;
    NSArray   *_modeButtons;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"请选择提醒类型";
        _mode = [[[GloubleProperty sharedInstance] currentUserEntity].UI_plan integerValue];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _modeButtons = @[self.fitnessModelButton, self.fatModelButton, self.healthModelButton];

    for (UIButton *button in _modeButtons) {
        if (button.tag == _mode) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
//称重计划 0：健身达人1：减肥达人 2：健康达人
- (IBAction)buttonActions:(id)sender {
    UIButton *senderView = sender;
    if (senderView.selected != YES) {
        for (UIButton *button in _modeButtons) {
            if (button == senderView) {
                button.selected = YES;
            } else {
                button.selected = NO;
            }
        }
        
        _mode = senderView.tag;
    }
}

- (IBAction)nextStepButton:(id)sender {
    [[GloubleProperty sharedInstance] currentUserEntity].UI_plan = [NSString stringWithFormat:@"%d", (int)_mode];
    
    //测量模式 0：常规模式 1：智能模式
    [[GloubleProperty sharedInstance] currentUserEntity].UI_mode = [NSString stringWithFormat:@"1"];
    [GloubleProperty sharedInstance].currentUserSettingWillUpDate = YES;
    
    RegisterSelectTargetViewController *selectTargetVC = [[RegisterSelectTargetViewController alloc] initWithNibName:@"RegisterSelectTargetViewController" bundle:nil];
    [self.navigationController pushViewController:selectTargetVC animated:YES];
}

- (IBAction)lastStepButtonAction:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate mainViewAppearWithUserInfo:[[GloubleProperty sharedInstance] currentUserEntity]];
}

@end
