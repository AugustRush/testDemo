//
//  ChangeNameViewController.m
//  BodyScale
//
//  Created by zhangweiwei on 14/12/8.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ChangeNameViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface ChangeNameViewController ()<UITextFieldDelegate>
@property(strong,nonatomic) UITextField * changeNameTF;
@property (strong,nonatomic) MBProgressHUD    *progressHUD;
@end

@implementation ChangeNameViewController
#pragma mark setproperty
- (UITextField *)changeNameTF
{
    if (!_changeNameTF)
    {
        _changeNameTF = [[UITextField alloc]init];
        _changeNameTF.backgroundColor = [UIColor whiteColor];
        _changeNameTF.textColor = [UIColor blackColor];
        _changeNameTF.font = [UIFont systemFontOfSize:14];
        _changeNameTF.delegate = self;
    }
    return _changeNameTF;
}
- (MBProgressHUD *)progressHUD
{
    if (!_progressHUD)
    {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view bringSubviewToFront:self.progressHUD];
        self.progressHUD.delegate = (id<MBProgressHUDDelegate>)self;
        [self.progressHUD show:YES];
    }
    return _progressHUD;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ishasTextFeild:YES];
    if (self)
    {
        self.view.backgroundColor = [GetWordColor colorWithHexString:@"#dedede"];
        self.title = @"修改用户名";
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title = self.titleString;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;

    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(Screen_Width - 40, 0.0, 40, 20)];
    [rightBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBarBtn.style = UIBarButtonItemStylePlain;
    rightBarBtn.title = @"保存";
    self.navigationItem.rightBarButtonItem = rightBarBtn;
   
     self.changeNameTF.text = self.userInfoString;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (![CommanHelp isStringNULL:self.changeNameTF.text])
    {
        self.userInfoString = self.changeNameTF.text;
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
}

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.changeNameTF];
    [self.changeNameTF mas_makeConstraints:^(MASConstraintMaker *maker){
         maker.left.equalTo(@15);
         maker.top.equalTo(@50);
         maker.right.equalTo(@-15);
         maker.height.equalTo(@45);
     }];
    [self.changeNameTF becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![CommanHelp isStringNULL:textField.text])
    {
        self.userInfoString = textField.text;
    }
    return YES;
}
- (void)addProgressHUD
{
    [self.view addSubview:self.progressHUD];
}

- (void)hidenProgress
{
    [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
}
- (void)saveAction
{
    [self addProgressHUD];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"modify"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *userName = [FFConfig currentConfig].userShowName;
    NSString *userPhone = [FFConfig currentConfig].userPhoneNumber;
    NSString *userEmail = [FFConfig currentConfig].userEmail;
    NSString *userRealName = [FFConfig currentConfig].userRealName;
    NSString *userSex = @"male";
    if ([[FFConfig currentConfig].userGender intValue] != 0)
    {
        userSex = @"female";
    }
    self.userInfoString = self.changeNameTF.text;
    if (self.userInfoString.length == 0)
    {
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"输入内容不能为空" posY:100];
        [tTip show];
        return;
    }
    NSDictionary *parameters = nil;
    if (_gType == 0)
    {
        userName = self.userInfoString;
    }
    else if (_gType == 1)
    {
        userPhone = self.userInfoString;
    }
    else if (_gType == 2)
    {
        userEmail = self.userInfoString;
    }
    else if (_gType == 3)
    {
        userRealName = self.userInfoString;
    }
    if (_gType == 0)
    {
        parameters = @{@"id":[FFConfig currentConfig].userId,@"username":userName, @"avatar":@"",@"mobile":userPhone, @"email":userEmail,@"name":userRealName,@"sex":userSex,@"old_password":[FFConfig currentConfig].password,@"password":[FFConfig currentConfig].password,@"private_code":[FFConfig currentConfig].privateCode};
    }
    else
    {
        parameters = @{@"id":[FFConfig currentConfig].userId, @"avatar":@"",@"mobile":userPhone, @"email":userEmail,@"name":userRealName,@"sex":userSex,@"old_password":[FFConfig currentConfig].password,@"password":[FFConfig currentConfig].password,@"private_code":[FFConfig currentConfig].privateCode};
    }
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        [self hidenProgress];
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (!errorCode)
        {
            if (_gType == 0)
            {
                [FFConfig currentConfig].userShowName = self.userInfoString;
            }
            else if (_gType == 1)
            {
                [FFConfig currentConfig].userPhoneNumber = self.userInfoString;
            }
            else if (_gType == 2)
            {
                [FFConfig currentConfig].userEmail = self.userInfoString;
            }
            else if (_gType == 3)
            {
                [FFConfig currentConfig].userRealName = self.userInfoString;
            }
            if (_delegate && [_delegate respondsToSelector:@selector(changeName:andType:)])
            {
                [_delegate changeName:self.userInfoString andType:_gType];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:self];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
            [tTip show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self hidenProgress];
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
        [tTip show];
        return;
    }];
}

@end
