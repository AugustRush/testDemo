//
//  RegisterViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-21.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterInputPasswordViewController.h"
#import "UserInfoEntity.h"
#import "LoginViewController.h"
#import "Helpers.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userPhoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@property (weak, nonatomic) IBOutlet UIButton *registerBottomBar;
@property (weak, nonatomic) IBOutlet UIView *addUserBottomBar;

@end

@implementation RegisterViewController {
    UserInfoEntity      *_userInfoEntity;
    BOOL                _isForgetPassword;
    FlowType            _type;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userInfoEntity:(UserInfoEntity *)userInfoEntity isForgetPassword:(BOOL)isForgetPassword type:(FlowType)type
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _userInfoEntity = userInfoEntity;
        _isForgetPassword = isForgetPassword;
        _type = type;
        
        
        if (!userInfoEntity) {
            _userInfoEntity = [[UserInfoEntity alloc] init];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configXib];
    
    switch (_type) {
        case FlowTypeAddUser:
            self.addUserBottomBar.hidden = NO;
            self.registerBottomBar.hidden = YES;
            break;
        case FlowTypeRegister: {
            self.registerBottomBar.hidden = NO;
            self.addUserBottomBar.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (void)configXib {
    if (_isForgetPassword) {
        self.title = @"重置密码";
        self.photoImageView.image = [UIImage imageNamed:@"default_photo_females.png"];
    } else {
        self.title = @"注册";
        NSString *imageName = nil;
        if ([_userInfoEntity.UI_sex intValue] == 0) {
            imageName = @"default_photo_females.png";
        } else {
            imageName = @"default_photo_males.png";
        }
        self.photoImageView.image = [UIImage imageNamed:imageName];
    }
}

#pragma mark - Private Method
- (void)getCheckCode {

    NSString *text = self.userPhoneTextField.text;
    
    if (text.length <= 0) {
        [self showHUDInWindowJustWithText:@"请输入手机号/邮箱地址" disMissAfterDelay:1];
        return;
    }
    
    BOOL isValidInput = [Helpers strIsMobileOrEmail:text];
    
    if (!isValidInput) {
        [self showHUDInWindowJustWithText:@"用户名必须为手机号或邮箱" disMissAfterDelay:1];
        return;
    } else {
        
        // 有效输入
        if (_isForgetPassword) {
            [self showHUDInView:self.view justWithText:@"正在请求验证码..."];
            
            [[InterfaceModel sharedInstance] getCheckCodeWithLoginName:self.userPhoneTextField.text validType:ValidCodeTypeReset callBack:^(int code, NSString *errorMsg) {

                if (code == REQUEST_SUCCESS_CODE) {
                    // 请求验证码成功
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self disMissHUDWithText:@"" afterDelay:0];
                        
                        _userInfoEntity.UI_loginName = self.userPhoneTextField.text;
                        RegisterInputPasswordViewController *regiserInputPswVC = [[RegisterInputPasswordViewController alloc] initWithNibName:@"RegisterInputPasswordViewController" bundle:nil userInfoEntity:_userInfoEntity isForgetPassword:_isForgetPassword type:_type];
                        [self.navigationController pushViewController:regiserInputPswVC animated:YES];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self disMissHUDWithText:@"" afterDelay:0];
                        self.tipsLabel.text = errorMsg;
                    });
                }
            }];
        } else {
            // 注册

            [[InterfaceModel sharedInstance] checkLoginNameWithName:text callback:^(WebCallBackResult result, BOOL isUsed, NSString *errorMsg) {

                if (result == WebCallBackResultSuccess) {
                    // Request成功
                    
                    if (isUsed) {
                        // 用户名已被使用
                        [self showHUDInWindowJustWithText:@"该用户名已被注册" disMissAfterDelay:1];
                        return;
                    } else {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self showHUDInView:self.view justWithText:@"正在请求验证码..."];
                        });
                        
                        [[InterfaceModel sharedInstance] getCheckCodeWithLoginName:text validType:ValidCodeTypeRegister callBack:^(int code, NSString *errorMsg) {
                            
                            // 请求验证码成功
                            if (code == REQUEST_SUCCESS_CODE) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self disMissHUDWithText:@"" afterDelay:0];
                                    
                                    _userInfoEntity.UI_loginName = self.userPhoneTextField.text;
                                    RegisterInputPasswordViewController *regiserInputPswVC = [[RegisterInputPasswordViewController alloc] initWithNibName:@"RegisterInputPasswordViewController" bundle:nil userInfoEntity:_userInfoEntity isForgetPassword:_isForgetPassword type:_type];
                                    [self.navigationController pushViewController:regiserInputPswVC animated:YES];
                                });
                                
                            } else {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self disMissHUDWithText:@"" afterDelay:0];
                                    self.tipsLabel.text = errorMsg;
                                });
                                
                            }
                        }];
                    }
                    
                } else {
                    // 网络异常
                    // 服务器异常
                    [self showHUDInWindowJustWithText:errorMsg disMissAfterDelay:1];
                }
            }];
        }
    }
}

#pragma mark - Actions
- (IBAction)getCheckCodeButtonAction:(id)sender {
    [self getCheckCode];
}

- (IBAction)loginButtonAction:(id)sender {
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil type:FlowTypeAddUser];
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self getCheckCode];
    [textField resignFirstResponder];
    return YES;
}

@end
