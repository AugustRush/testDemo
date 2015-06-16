//
//  ModifyUserPasswordViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-24.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "ModifyUserPasswordViewController.h"

@interface ModifyUserPasswordViewController () <UIAlertViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *currentPswLabel;
@property (weak, nonatomic) IBOutlet UITextField *kNewPswLabel;

@end

@implementation ModifyUserPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"修改密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Button Action
- (IBAction)sureButtonAction:(id)sender {
    
    if (self.currentPswLabel.text.length && self.kNewPswLabel.text.length) {
        [[InterfaceModel sharedInstance] changePasswordWithOld:self.currentPswLabel.text new:self.kNewPswLabel.text callBack:^(int code, id successParam, id errorMsg) {
            if (code == REQUEST_SUCCESS_CODE) {
                [ViewUtilFactory presentAlertViewWithTitle:@"修改密码成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            } else {
                NSString *message = nil;
                if ([errorMsg isKindOfClass:[NSString class]]) {
                    message = errorMsg;
                }
                [ViewUtilFactory presentAlertViewWithTitle:@"修改密码失败" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            }
        }];
        
    } else {
        
        
        [ViewUtilFactory presentAlertViewWithTitle:@"修改密码失败" message:@"当前密码或新密码输入有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    }
    
    
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
