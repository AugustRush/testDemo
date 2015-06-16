//
//  RegisterSelectTargetViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-26.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "RegisterSelectTargetViewController.h"
#import "HorizontalPickerView.h"
#import "AppDelegate.h"
#import "BTModel.h"
#import "RegisterJurisdictionViewController.h"

@interface RegisterSelectTargetViewController ()<HorizontalPickerViewDataSource, HorizontalPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *suggestWeightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bodyImageView;

@end

@implementation RegisterSelectTargetViewController {
    HorizontalPickerView    *_pickerView;
    NSArray                 *_arrowImageViews;
    
    NSString *_lastTarget;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _lastTarget = [[GloubleProperty sharedInstance] currentUserEntity].UI_target;
        self.title = @"设置目标";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UserInfoEntity *userInfo = [GloubleProperty sharedInstance].currentUserEntity;
    
    int weight = [[InterfaceModel sharedInstance] calculateWeight:[userInfo.UI_height intValue] sex:[userInfo.UI_sex intValue]];
    
    self.suggestWeightLabel.text = [NSString stringWithFormat:@"您的合理体重是%dkg哦！", weight];
    
    BOOL isIOS7_OR_LATER = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f;
    _pickerView = [[HorizontalPickerView alloc] initWithFrame:CGRectMake(0,
                                                                         APPLICATION_HEIGHT - 79 * 2 - 44 - (isIOS7_OR_LATER ? 20 : 0),
                                                                         SCREEN_WIDTH,
                                                                         79)
                                                     delegate:self
                                                   dataSource:self];
    [self.view addSubview:_pickerView];
    [_pickerView setCurrentIndex:weight];
    
    int gender = [userInfo.UI_sex intValue];
    if (gender == 0) {
        self.bodyImageView.image = [UIImage imageNamed:@"girlbody.png"];
    } else {
        self.bodyImageView.image = [UIImage imageNamed:@"malesbodyimage.png"];
    }
    
    self.weightLabel.text = [NSString stringWithFormat:@"%d", (int)weight];
    
    
    NSString *imageName = @"triangle.png";
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image];
    [imageView1 setFrame:CGRectMake(_pickerView.frame.size.width / 2 - image.size.width / 2,
                                    _pickerView.frame.origin.y,
                                    image.size.width,
                                    image.size.height)];
    [self.view addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image];
    imageView2.transform = CGAffineTransformRotate(imageView2.transform, M_PI);
    [imageView2 setFrame:CGRectMake(_pickerView.frame.size.width / 2 - image.size.width / 2,
                                    _pickerView.frame.origin.y + _pickerView.frame.size.height - image.size.height,
                                    image.size.width,
                                    image.size.height)];
    [self.view addSubview:imageView2];
    _arrowImageViews = @[imageView1, imageView2];

}

#pragma mark - Actions
- (IBAction)nextStepButtonAction:(id)sender {
    NSString *target = [NSString stringWithFormat:@"%d", (int)_pickerView.selectIndex];
    if (![target isEqualToString:_lastTarget]) {
        [[GloubleProperty sharedInstance] currentUserEntity].UI_target = target;
        [GloubleProperty sharedInstance].currentUserSettingWillUpDate = YES;
    }
    
    RegisterJurisdictionViewController *registerJurisdictionVC = [[RegisterJurisdictionViewController alloc] initWithNibName:@"RegisterJurisdictionViewController" bundle:nil];
    [self.navigationController pushViewController:registerJurisdictionVC animated:YES];
}

- (IBAction)lastStepButtonAction:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate mainViewAppearWithUserInfo:[[GloubleProperty sharedInstance] currentUserEntity]];
}

#pragma mark - PickerView Delegate
- (NSInteger)numberOfItemsInPickerView:(id)pickerView {
    return 121;
}

- (NSString *)pickerView:(id)pickerView titleForItemsIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"%d", (int)index];
}

- (void)pickerView:(HorizontalPickerView *)pickerView indexChaged:(NSInteger)index {
    self.weightLabel.text = [NSString stringWithFormat:@"%d", (int)index];
}


@end
