//
//  RegisterInputPasswordViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-21.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "RegisterInputPasswordViewController.h"
#import "RegisterSelectPlanViewController.h"
#import "InputUserInfoViewController.h"

@interface RegisterInputPasswordViewController () <UIAlertViewDelegate>

@property (nonatomic, strong)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *resendButton;
@property (weak, nonatomic) IBOutlet UITextField *checkCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@end

@implementation RegisterInputPasswordViewController {
    NSString *_loginName;
    NSDate          *_lastCheckCodeDate;
    UserInfoEntity *_userInfoEntity;
    BOOL            _isForgetPassword;
    FlowType        _type;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userInfoEntity:(UserInfoEntity *)userInfoEntity
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _loginName = userInfoEntity.UI_loginName;
        _userInfoEntity = userInfoEntity;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userInfoEntity:(UserInfoEntity *)userInfoEntity isForgetPassword:(BOOL)isForgetPassword type:(FlowType)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _type = type;
        _loginName = userInfoEntity.UI_loginName;
        _userInfoEntity = userInfoEntity;
        _isForgetPassword = isForgetPassword;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configXib];
    
    _lastCheckCodeDate = [NSDate date];
    self.resendButton.enabled = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(checkCodeCountdown) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configXib {
    if (_isForgetPassword) {
        self.title = @"找回密码";
    } else {
        self.title = @"注册";
    }
}

#pragma mark - Getter
- (NSString *)loginName {
    return _loginName;
}

#pragma mark - Private Method
- (void)getCheckCode {
    if (_isForgetPassword) {
        [[InterfaceModel sharedInstance] getCheckCodeWithLoginName:_loginName
                                                         validType:ValidCodeTypeReset
                                                          callBack:^(int code, NSString *errorMsg) {
                                                              if (code != REQUEST_SUCCESS_CODE) {
                                                                  [self startCountDown];
                                                              } else {
                                                                  self.tipsLabel.text = errorMsg;
                                                              }
                                                          }];

    } else {
        [[InterfaceModel sharedInstance] getCheckCodeWithLoginName:_loginName
                                                         validType:ValidCodeTypeRegister
                                                          callBack:^(int code, NSString *errorMsg) {
                                                              if (code != REQUEST_SUCCESS_CODE) {
                                                                  [self startCountDown];
                                                              } else {
                                                                  self.tipsLabel.text = errorMsg;
                                                              }
                                                          }];
    }
    
}

- (void)startCountDown {
    _lastCheckCodeDate = [NSDate date];
    NSTimeInterval time = 60 + [_lastCheckCodeDate timeIntervalSinceDate:[NSDate date]];
    [self.resendButton setTitle:[NSString stringWithFormat:@"%d秒", (int)time] forState:UIControlStateDisabled];
    self.resendButton.enabled = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(checkCodeCountdown) userInfo:nil repeats:YES];
}

#pragma mark - Actions
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextStepButtonAction:(id)sender {
    
    NSLog(@"type is %d",_type);
    
    switch (_type) {
        case FlowTypeRegister: {
            if (_isForgetPassword) {
                if (self.checkCodeTextField.text.length && self.passwordTextField.text.length) {
                    _userInfoEntity.UI_loginPwd = self.passwordTextField.text;
                    [self showHUDInWindowJustWithText:@"正在提交..."];
                    [[InterfaceModel sharedInstance]
                     resetPasswordWithLonginName:_userInfoEntity.UI_loginName
                     validCode:self.checkCodeTextField.text
                     newPwd:self.passwordTextField.text
                     callBack:^(int code, id param, id param02) {
                         [self disMissHUDWithText:@"正在提交..." afterDelay:1];
                         if (code == REQUEST_SUCCESS_CODE) {
                             [ViewUtilFactory presentAlertViewWithTitle:@"重置密码成功"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                         } else {
                             [ViewUtilFactory presentAlertViewWithTitle:@"重置密码失败"
                                                                message:param[@"errorMsg"]
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                         }
                     }];
                } else {
                    self.tipsLabel.text = @"请输入正确的验证码和密码";
                }
            } else {
                if (self.checkCodeTextField.text.length && self.passwordTextField.text.length) {
                    _userInfoEntity.UI_loginPwd = self.passwordTextField.text;
                    [self showHUDInWindowJustWithText:@"正在提交..."];
                    [[InterfaceModel sharedInstance]
                     userRegisterWithUser:_userInfoEntity
                     validCode:self.checkCodeTextField.text
                     callBack:^(int code, id userInfo, NSString *errorMsg) {
                         [self disMissHUDWithText:@"正在提交..." afterDelay:1];
                         if (code == REQUEST_SUCCESS_CODE) {
                             [Flurry logEvent:USER_SIGN_UP_EVENT];
                             
                             RegisterSelectPlanViewController *selectPlanVC = [[RegisterSelectPlanViewController alloc] initWithNibName:@"RegisterSelectPlanViewController" bundle:nil];
                             [self.navigationController pushViewController:selectPlanVC animated:YES];
                         } else {
                             self.tipsLabel.text = errorMsg ? errorMsg : @"网络请求失败，请检查网络设置";
                         }
                     }];
                } else {
                    self.tipsLabel.text = @"请输入正确的验证码和密码";
                }
            }
        }
            break;
            
        case FlowTypeAddUser: {
            NSLog(@"add user %@",[self class]);
            [[InterfaceModel sharedInstance] checkCodeInvalidWithCheckCode:self.checkCodeTextField.text loginName:_loginName callback:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
                
                if (errorMsg) {
                    [self showHUDInView:self.view justWithText:errorMsg disMissAfterDelay:1.5];
                } else {
                    InputUserInfoViewController *inputUserVC = [[InputUserInfoViewController alloc] initWithNibName:@"InputUserInfoViewController" bundle:nil type:FlowTypeAddUser checkCode:_checkCodeTextField.text];
                inputUserVC.loginName = self.loginName;
                inputUserVC.loginPassword = _passwordTextField.text;
                    [self.navigationController pushViewController:inputUserVC animated:YES];
                }
            }];
        }
            break;
        default:
            break;
    }
}

- (void)checkCodeCountdown {
    NSTimeInterval time = 60 + [_lastCheckCodeDate timeIntervalSinceDate:[NSDate date]];
    [self.resendButton setTitle:[NSString stringWithFormat:@"%d秒", (int)time] forState:UIControlStateDisabled];
    if (time <= 0) {
        self.resendButton.enabled = YES;
        [self.timer invalidate];
    }
}

- (IBAction)resendButtonAction:(id)sender {
    [self getCheckCode];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIViewController *controller = self.navigationController.viewControllers[1];
    [self.navigationController popToViewController:controller animated:YES];
}


@end
