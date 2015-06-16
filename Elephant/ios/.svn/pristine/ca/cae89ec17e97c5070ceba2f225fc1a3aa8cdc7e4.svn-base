//
//  ChangePasswordNewViewController.m
//  BodyScale
//
//  Created by 祁鹏翔 on 15/3/20.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ChangePasswordNewViewController.h"
#import "PersonaViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface ChangePasswordNewViewController ()<MBProgressHUDDelegate>

@property (strong, nonatomic) UITextField *oldPWD;
@property (strong, nonatomic) UITextField *myNewPass;
@property (strong, nonatomic) UITextField *myNewPass2;
@property (strong, nonatomic) UIButton *YESBt;
@property (strong,nonatomic) MBProgressHUD *progressHUD;

@end

@implementation ChangePasswordNewViewController

#pragma mark
#pragma mark - Init & Dealloc
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ishasTextFeild:YES];
    if (self)
    {
    }
    return self;
}
- (UITextField *)oldPWD
{
    if (!_oldPWD)
    {
        _oldPWD = [[UITextField alloc] init];
        _oldPWD.delegate = (id<UITextFieldDelegate>)self;
        _oldPWD.placeholder = @"请输入旧密码";
        _oldPWD.backgroundColor = [UIColor whiteColor];
        _oldPWD.borderStyle = UITextBorderStyleRoundedRect;
        _oldPWD.secureTextEntry = YES;
        [self.view addSubview:_oldPWD];
    }
    return _oldPWD;
}
- (UITextField *)myNewPass
{
    if (!_myNewPass)
    {
        _myNewPass = [[UITextField alloc] init];
        _myNewPass.delegate = (id<UITextFieldDelegate>)self;
        _myNewPass.backgroundColor = [UIColor whiteColor];
        _myNewPass.borderStyle = UITextBorderStyleRoundedRect;
        _myNewPass.placeholder = @"请输入新密码";
        _myNewPass.secureTextEntry = YES;
        [self.view addSubview:_myNewPass];
    }
    return _myNewPass;
}
- (UITextField *)myNewPass2
{
    if (!_myNewPass2)
    {
        _myNewPass2 = [[UITextField alloc] init];
        _myNewPass2.delegate = (id<UITextFieldDelegate>)self;
        _myNewPass2.backgroundColor = [UIColor whiteColor];
        _myNewPass2.borderStyle = UITextBorderStyleRoundedRect;
        _myNewPass2.placeholder = @"请再次输入新密码";
        _myNewPass2.secureTextEntry = YES;
        [self.view addSubview:_myNewPass2];
    }
    return _myNewPass2;
}
- (UIButton *)YESBt
{
    if (!_YESBt)
    {
        _YESBt = [[UIButton alloc] init];
        [_YESBt setTitle:@"确定" forState:UIControlStateNormal];
        [_YESBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_YESBt addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
        [_YESBt setBackgroundImage:[UIImage imageNamed:@"green_bt.png"] forState:UIControlStateNormal];
        [self.view addSubview:_YESBt];
    }
    return _YESBt;
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"修改密码";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBarBtn.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = rightBarBtn;

    
    [self.oldPWD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.height.equalTo(@40);
    }];
    [self.myNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oldPWD.mas_bottom).with.offset(10);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.height.equalTo(@40);
    }];
    [self.myNewPass2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myNewPass.mas_bottom).with.offset(10);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.height.equalTo(@40);
    }];
    [self.YESBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myNewPass2.mas_bottom).with.offset(10);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.height.equalTo(@40);
    }];
    
//
// Do any additional setup after loading the view from its nib.
    DLog(@"oldPWD\n,x:%.2f\n,y:%.2f\n,w:%.2f\n,h:%.2f\n",self.oldPWD.frame.origin.x,self.oldPWD.frame.origin.y,self.oldPWD.frame.size.width,self.oldPWD.frame.size.height);
    DLog(@"myNewPass\n,x:%.2f\n,y:%.2f\n,w:%.2f\n,h:%.2f\n",self.myNewPass.frame.origin.x,self.myNewPass.frame.origin.y,self.myNewPass.frame.size.width,self.myNewPass.frame.size.height);
    DLog(@"myNewPass2\n,x:%.2f\n,y:%.2f\n,w:%.2f\n,h:%.2f\n",self.myNewPass2.frame.origin.x,self.myNewPass2.frame.origin.y,self.myNewPass2.frame.size.width,self.myNewPass2.frame.size.height);
}
-(void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)saveAction
{
    if (self.oldPWD.text == nil || self.myNewPass.text == nil || self.myNewPass2.text == nil)
    {
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"请全部填满" posY:100];
        [tTip show];
        return;
    }
    if (![self.myNewPass.text isEqualToString:self.myNewPass2.text])
    {
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"前后两次新密码不正确" posY:100];
        [tTip show];
        return;
    }
    [self addProgressHUD];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"modify"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString *userName = [FFConfig currentConfig].userShowName;
    NSString *userPhone = [FFConfig currentConfig].userPhoneNumber;
    NSString *userEmail = [FFConfig currentConfig].userEmail;
    NSString *userRealName = [FFConfig currentConfig].userRealName;
    NSString *userNewPas = self.myNewPass.text;
    NSString *userSex = @"male";
    if ([[FFConfig currentConfig].userGender intValue] != 0)
    {
        userSex = @"female";
    }
    
    NSDictionary *parameters = @{@"id":[FFConfig currentConfig].userId,@"avatar":@"",@"mobile":userPhone, @"email":userEmail,@"name":userRealName,@"sex":userSex,@"old_password":[FFConfig currentConfig].password,@"password":userNewPas,@"private_code":[FFConfig currentConfig].privateCode};
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        [self hidenProgress];
        
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (!errorCode)
        {
            [FFConfig currentConfig].password = self.myNewPass.text;
        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
            [tTip show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        [self hidenProgress];
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
        [tTip show];
        return;
    }];
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


@end
