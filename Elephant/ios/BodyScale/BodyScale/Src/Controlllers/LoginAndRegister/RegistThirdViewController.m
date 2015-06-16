//
//  RegistThirdViewController.m
//  BodyScale
//
//  Created by zhangweiwei on 14/12/8.
//  Copyright (c) 2014年 August. All rights reserved.
//
#define SAMEVIEWHEIGHT @35
#import "RegistThirdViewController.h"
#import "TextField+label.h"
#import "FillInfoViewController.h"
#import "AFNetworking.h"
#import "BDKNotifyHUD.h"

@interface RegistThirdViewController () <UITextFieldDelegate,MBProgressHUDDelegate>

@property(strong,nonatomic) TextField_label * nameField;
@property(strong,nonatomic) TextField_label * pwdFirst;
@property(strong,nonatomic) TextField_label * pwdSecond;
@property(strong,nonatomic) UIButton * completeRegister;
@property(strong,nonatomic) MBProgressHUD    *progressHUD;
@property(strong,nonatomic) UILabel * readProtocolLabel;
@property(strong,nonatomic) UIButton * chooseBtn;
@property(strong,nonatomic) UIButton * checkProtocol;

@end

@implementation RegistThirdViewController
#pragma mark setproperty
- (TextField_label *)nameField
{
    if (!_nameField)
    {
        _nameField = [[TextField_label alloc] initWithHolder:@"请输入用户名" andLabelName:@"用户名" textFieldDelegate:self];
    }
    return _nameField;
}

- (TextField_label *)pwdFirst
{
    if (!_pwdFirst)
    {
        _pwdFirst =  [[TextField_label alloc]initWithHolder:@"请输入6-16位密码" andLabelName:@"密码" textFieldDelegate:self];
        _pwdFirst.textFeild.secureTextEntry = YES;
        
    }
    return _pwdFirst;
}

- (TextField_label *)pwdSecond
{
    if (!_pwdSecond)
    {
        _pwdSecond =  [[TextField_label alloc]initWithHolder:@"请输入6-16位密码" andLabelName:@"确认" textFieldDelegate:self];
        _pwdSecond.textFeild.secureTextEntry = YES;
    }
    return _pwdSecond;
}

- (UIButton *)completeRegister
{
    if (!_completeRegister)
    {
        _completeRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeRegister.layer.cornerRadius = 1.5f;
        _completeRegister.backgroundColor = [UIColor clearColor];
        [_completeRegister setTitle:@"完成注册" forState:UIControlStateNormal];
        [_completeRegister addTarget:self action:@selector(finishRegister) forControlEvents:UIControlEventTouchUpInside];
        [_completeRegister setBackgroundImage:[UIImage imageNamed:@"green_bt"] forState:UIControlStateNormal];
        [_completeRegister setBackgroundImage:[UIImage imageNamed:@"green_bt"] forState:UIControlStateHighlighted];
    }
    return _completeRegister;
}

- (MBProgressHUD *)progressHUD
{
    if (!_progressHUD)
    {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view bringSubviewToFront:self.progressHUD];
        self.progressHUD.delegate = self;
        [self.progressHUD show:YES];
    }
    return _progressHUD;
}

- (UILabel *)readProtocolLabel
{
    if(!_readProtocolLabel)
    {
        _readProtocolLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _readProtocolLabel.backgroundColor = [UIColor clearColor];
        _readProtocolLabel.font = [UIFont systemFontOfSize:14];
        _readProtocolLabel.textColor = [UIColor blackColor];
        _readProtocolLabel.text = @"我已阅读并同意";
    }
    return _readProtocolLabel;
}

- (UIButton *)chooseBtn
{
    if (!_chooseBtn)
    {
        _chooseBtn = [[UIButton alloc]initWithFrame:CGRectZero] ;
        _chooseBtn.backgroundColor = [UIColor clearColor];
        [_chooseBtn setTitleColor:BGColor forState:UIControlStateNormal];
        [_chooseBtn setBackgroundImage:[UIImage imageNamed:@"seleted_img"] forState:UIControlStateSelected];
        [_chooseBtn setBackgroundImage:[UIImage imageNamed:@"unselected_img"] forState:UIControlStateNormal];
        _chooseBtn.selected = YES;
    }
    return _chooseBtn;
}

- (UIButton *)checkProtocol
{
    if (!_checkProtocol)
    {
        _checkProtocol = [[UIButton alloc]initWithFrame:CGRectZero] ;
        [_checkProtocol setTitle:@"注册协议" forState:UIControlStateNormal];
        _checkProtocol.backgroundColor = [UIColor clearColor];
        [_checkProtocol setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _checkProtocol.selected = YES;
        _checkProtocol.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _checkProtocol;
}
#pragma mark lifecircle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ishasTextFeild:YES];
    if (self)
    {
        self.view.backgroundColor = [GetWordColor colorWithHexString:@"#dedede"];
        self.title = @"设置密码";
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:self.nameField];
    [self.view addSubview:self.pwdFirst];
    [self.view addSubview:self.pwdSecond];
    [self.view addSubview:self.completeRegister];
    [self.view addSubview:self.chooseBtn];
    [self.view addSubview:self.readProtocolLabel];
    [self.view addSubview:self.checkProtocol];
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(self.view.mas_left);
        maker.top.equalTo(@20);
        maker.right.equalTo(self.view.mas_right);
        maker.height.equalTo(SAMEVIEWHEIGHT);
        
    }];
    
    [self.pwdFirst mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(self.view.mas_left);
        maker.top.equalTo(self.nameField.mas_bottom).offset(5);
        maker.right.equalTo(self.view.mas_right);
        maker.height.equalTo(SAMEVIEWHEIGHT);
        
    }];
    [self.pwdSecond mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(self.view.mas_left);
        maker.top.equalTo(self.pwdFirst.mas_bottom).offset(5);
        maker.right.equalTo(self.view.mas_right);
        maker.height.equalTo(SAMEVIEWHEIGHT);
    }];
    
    
    [self.completeRegister mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(@20);
        maker.top.equalTo(self.pwdSecond.mas_bottom).offset(25);
        maker.right.equalTo(self.view.mas_right).offset(-30);
        maker.height.equalTo(SAMEVIEWHEIGHT);
    }];
    
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(@20);
        maker.top.equalTo(self.completeRegister.mas_bottom).offset(25);
        maker.width.equalTo(@40);
        maker.height.equalTo(SAMEVIEWHEIGHT);
    }];
    
    [self.readProtocolLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(self.chooseBtn.mas_right).offset(5);
        maker.top.equalTo(self.completeRegister.mas_bottom).offset(25);
        maker.width.equalTo(@150);
        maker.height.equalTo(SAMEVIEWHEIGHT);
    }];
    
    [self.checkProtocol mas_makeConstraints:^(MASConstraintMaker *maker){
         maker.left.equalTo(self.readProtocolLabel.mas_right).offset(-50);
         maker.top.equalTo(self.completeRegister.mas_bottom).offset(25);
         maker.width.equalTo(@80);
         maker.height.equalTo(SAMEVIEWHEIGHT);
     }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark ACTION
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)finishRegister
{
    if ([CommanHelp isStringNULL:self.nameField.textFeild.text])
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"用户名为空" message:@"请输入用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if ([CommanHelp isStringNULL:self.pwdFirst.textFeild.text] || [CommanHelp isStringNULL:self.pwdSecond.textFeild.text])
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"请设置正确的密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (![self.pwdFirst.textFeild.text isEqualToString:self.pwdSecond.textFeild.text])
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"两次密码设置不一致。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [self addProgressHUD];
    [self registerToServer];
    
}

#pragma mark HTTP Register
- (void)registerToServer
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"username":self.nameField.textFeild.text,@"mobile":[[NSUserDefaults standardUserDefaults] objectForKey:USERPHONENUMBER],@"code":@"123456",@"password":self.pwdSecond.textFeild.text};
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"register"];
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hidenProgress];
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        
        if (!errorCode)
        {
            NSDictionary * codeDic = [resultDic objectForKey:@"data"];
            [FFConfig currentConfig].isLogined = @YES;
            [FFConfig currentConfig].userId = [codeDic objectForKey:@"user_id"];
            [FFConfig currentConfig].userShowName = [codeDic objectForKey:@"username"];
            [FFConfig currentConfig].privateCode = [codeDic objectForKey:@"private_code"];
            [FFConfig currentConfig].userName = [[NSUserDefaults standardUserDefaults] objectForKey:USERPHONENUMBER];
            [FFConfig currentConfig].password = self.pwdSecond.textFeild.text;
            
            [self.navigationController pushViewController:[[FillInfoViewController alloc] initWithNibName:@"FillInfoViewController" bundle:nil] animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:self];
        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
            [tTip show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [FFConfig currentConfig].isLogined = @NO;
        
        [self hidenProgress];
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
        [tTip show];
        return;
    }];
    
}


#pragma mark private method
- (void)addProgressHUD
{
    [self.view addSubview:self.progressHUD];
}

- (void)hidenProgress
{
    [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
}

#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [self.progressHUD removeFromSuperview];
}

@end
