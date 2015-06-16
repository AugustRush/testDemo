//
//  LoginViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "BlockUI.h"
#import "NSDate+SLExtend.h"
#import "BTModel.h"
#import "APService.h"

// 临时
#import "RegisterViewController.h"

#import "ThirdSideInfoInputViewController.h"

@interface LoginViewController ()
{
    CGPoint _thirdSideBoxStartCenter;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;


@property (weak, nonatomic) IBOutlet UIView *thirdSideBox;
@property (weak, nonatomic) IBOutlet UIControl *thirdSideBoxButton;

@end

@implementation LoginViewController {
    FlowType _type;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(FlowType)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _type = type;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    
    _thirdSideBoxStartCenter = CGPointMake(-10, -10);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tipsLabel.text = @"";
}

#pragma mark - Private Method
- (void)login
{
    if (!self.userNameLabel.text.length || !self.userPasswordLabel.text.length) {
        self.tipsLabel.text = @"请输入用户名和密码";
        return;
    }

    [self showHUDInWindowJustWithText:@"登录中..." disMissAfterDelay:10];
    [[InterfaceModel sharedInstance] userLoginWithLoginName:self.userNameLabel.text
                                                   loginPwd:self.userPasswordLabel.text
                                                  isEncrypt:NO
                                                    userLoc:@"1"
                                                   callBack:^(int code, UserInfoEntity *userInfo,
                                                      NSString *errorMsg) {
                                                       AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                                       
                                                       [self disMissHUDWithText:@"登录中..." afterDelay:1];
                                                       if (code == REQUEST_SUCCESS_CODE) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                                                           [APService setAlias:userInfo.UI_userId callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:delegate];
#pragma clang diagnostic pop
                                                           [Flurry logEvent:USER_LOG_IN_EVENT];
                                                           
                                                           [delegate mainViewAppearWithUserInfo:userInfo];
                                                       } else {
                                                           self.tipsLabel.text = (errorMsg.length > 0 ? errorMsg : @"网络连接失败，请检查网络");
                                                       }
                                                   }];
}


-(void)jingDongLogin
{
    [[InterfaceModel sharedInstance] jingDongLoginWithNavController:self.navigationController
                                                           callback:^(ThirdSideLoginResult result,
                                                                      UserInfoEntity *userInfo,
                                                                      NSString *errorMsg)
     {

         
         switch (result) {
             case ThirdSideLoginResult_refuse:
             {

                 [self showHUDInView:self.view justWithText:errorMsg disMissAfterDelay:0.8];

             }
                 break;
             case ThirdSideLoginResult_agereeReg:
             {
                 [self showHUDInWindowJustWithText:@"正在登录..."];
                 [[InterfaceModel sharedInstance] thirdSideLogin:userInfo
                                                        callback:^(BOOL resultFlag,
                                                                   NSString *errorMsg) {
                        [self disMissHUDWithText:nil afterDelay:0];
                        if (resultFlag) {
                            AppDelegate *delegate =
                            (AppDelegate *)[UIApplication sharedApplication].delegate;
                            
                            [delegate mainViewAppearWithUserInfo:
                             [[InterfaceModel sharedInstance] getHostUser]];
                        }
                        else{
                            [self showHUDInWindowJustWithText:errorMsg disMissAfterDelay:0.8];
                        }
                 }];
                 
                 
             }
                 break;
             case ThirdSideLoginResult_agereeNoReg:
             {
                 
                 
                 ThirdSideInfoInputViewController *_tsVC =
                    [[ThirdSideInfoInputViewController alloc]
                           initWithNibName:@"ThirdSideInfoInputViewController"
                                    bundle:nil];
                 _tsVC.userInfo = userInfo;
                 [self.navigationController pushViewController:_tsVC animated:YES];
             }
                 break;
             default:
             {
                 
             }
                 break;
         }
    }];
}


#pragma mark - Actions
- (IBAction)loginButtonAction:(id)sender {
    [self login];
}
- (IBAction)forgetPasswordAction:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil userInfoEntity:nil isForgetPassword:YES type:FlowTypeRegister];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tapBackground:(id)sender {
    [self.userNameLabel resignFirstResponder];
    [self.userPasswordLabel resignFirstResponder];
}

- (IBAction)thirdButtonAction:(id)sender
{
    UIControl *_ctl = sender;
    
    if (_thirdSideBoxStartCenter.x == -10 &&
        _thirdSideBoxStartCenter.y == -10
    ) {
        _thirdSideBoxStartCenter = self.thirdSideBox.center;
    }
    
    
    
    CGPoint _p = _thirdSideBoxStartCenter;
    
    if (_ctl.tag == 0) {
        _p.y -= 65;
    }
    _ctl.tag = 1 - _ctl.tag;
    
    
    [UIView beginAnimations:@"thirdButtonAction" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2];
    self.thirdSideBox.center = _p;
    [UIView commitAnimations];
}

- (IBAction)jingDongButtonAction:(id)sender {
    
    
    self.thirdSideBoxButton.tag = 1;
    
    [UIView beginAnimations:@"thirdButtonAction" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2];
    self.thirdSideBox.center    = _thirdSideBoxStartCenter;
    [UIView commitAnimations];
    
    [self jingDongLogin];
    
    /*
    ThirdSideInfoInputViewController *_tsVC =
    [[ThirdSideInfoInputViewController alloc]
     initWithNibName:@"ThirdSideInfoInputViewController"
     bundle:nil];
    [self.navigationController pushViewController:_tsVC animated:YES];
    */
    
}



#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self login];
    return YES;
}

@end
