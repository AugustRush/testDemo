//
//  RegistSecondViewController.m
//  BodyScale
//
//  Created by cxx on 14-11-26.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "RegistSecondViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "BDKNotifyHUD.h"
#import "UserBaseInfoViewController.h"
#import "RegistThirdViewController.h"

@interface RegistSecondViewController () <MBProgressHUDDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *phoneLb;
@property (weak, nonatomic) IBOutlet UILabel *gTipLabel;
@property (weak, nonatomic) IBOutlet UITextField *vCodeLb;
@property (strong, nonatomic) UIButton *reSend;
@property (weak, nonatomic) IBOutlet UIButton *finishedBt;
@property (strong,nonatomic) MBProgressHUD    *progressHUD;
@property (strong, nonatomic) BDKNotifyHUD *notify;
@property(nonatomic,assign)int count;
@property(nonatomic,assign)int daojishiTime;
@end

@implementation RegistSecondViewController
@synthesize phoneNumStr;
#pragma mark setproperty
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
- (UIButton *)reSend
{
    if (!_reSend)
    {
        _reSend = [[UIButton alloc] init];
        [_reSend setTitle:@"重新发送" forState:UIControlStateNormal];
        _reSend.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_reSend addTarget:self action:@selector(resendAction:) forControlEvents:UIControlEventTouchUpInside];
        [_reSend setTitleColor:[UIColor colorWithRed:13/255.0f green:1 blue:1/255.0f alpha:1] forState:UIControlStateNormal];
        [self.view addSubview:_reSend];
    }
    return _reSend;
}

- (BDKNotifyHUD *)notify
{
    if (_notify != nil)
    {
        return _notify;
    }
    DLog(@"这是一个发送验证码的故事");
    _notify = [BDKNotifyHUD notifyHUDWithImage:nil text:@"验证码已经发出，请耐心接收。"];
    self.daojishiTime = 60;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTitle:) userInfo:nil repeats:YES];
    _notify.center = CGPointMake(self.view.center.x, self.view.center.y - 20);
    return _notify;
}

-(void)updateTitle:(NSTimer *)timer{
    self.daojishiTime --;
    //[self.gTipLabel setFont:FONT15];
    //CGSize titleSize = [self.gTipLabel.text sizeWithFont:FONT15 constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    
    self.gTipLabel.text = [NSString stringWithFormat:@"如果%i秒内没有收到验证码,请",self.daojishiTime];
    if (self.daojishiTime == 0) {
        UIAlertView *reSendAlertView = [[UIAlertView alloc]initWithTitle:@"服务超时" message: nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新发送验证码", nil];
        [reSendAlertView show];
        [timer invalidate];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    DLog(@"clickedButtonAtIndex:%i",buttonIndex);
    switch (buttonIndex)
    {
        case 0:
            DLog(@"取消");
            break;
        default:
            DLog(@"重新发送验证码");
            [self resendAction:nil];
            break;
    }
}

#pragma mark lifecircle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ishasTextFeild:YES];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *tLabel = [[UILabel alloc] init];
    [self.view addSubview:tLabel];
    tLabel.textColor = [UIColor colorWithRed:49.0/255.0f green:190.0/255.0f blue:51.0/255.0f alpha:1.0f];
    tLabel.text = @"验证短信";
    tLabel.textAlignment = NSTextAlignmentCenter;
//    tLabel.frame = CGRectMake(37, 5, self.view.frame.size.width/2, 30);
    if(Screen_Width == 320){
        tLabel.frame = CGRectMake(10, 5, self.view.frame.size.width/2, 30);
    }else if (Screen_Width == 375){
        tLabel.frame = CGRectMake(37, 5, self.view.frame.size.width/2, 30);
    }else{
        tLabel.frame = CGRectMake(57, 5, self.view.frame.size.width/2, 30);
    }
    
    self.navigationItem.title = @"短信验证";
    self.view.backgroundColor = UIColorRef(233, 233, 233);
    [self baseConfig];
    [self addProgressHUD];
    [self GetVerificationCode:self.phoneNumStr];
    [self.gTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vCodeLb.mas_bottom).with.offset(15);
        make.left.equalTo(self.view.mas_left).with.offset(15);
    }];

    self.reSend.frame = CGRectMake(self.gTipLabel.bounds.size.width + self.gTipLabel.frame.origin.x -14, self.gTipLabel.frame.origin.y+2, 80, 30);
    [self.reSend setTitle:@"重新发送" forState:UIControlStateNormal];
    [self.view addSubview:self.finishedBt];
    [self.finishedBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.reSend.mas_bottom).with.offset(15);
    }];
    [self.view sendSubviewToBack:self.finishedBt];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma private method
- (void)baseConfig
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    self.vCodeLb.keyboardType = UIKeyboardTypeNumberPad;
    self.vCodeLb.delegate = self;
    [self.vCodeLb addTarget:self action:@selector(textEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.vCodeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@43);
    }];
    
    self.phoneLb.text = self.phoneNumStr;
}

- (void)GetVerificationCode:(NSString *)phoneNumber
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"mobile":phoneNumber,@"type":@"register",@"udid":[OpenUDID value]};
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"sendCode"];
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hidenProgress];
        
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (!errorCode)
        {
            NSDictionary * codeDic = [resultDic objectForKey:@"data"];
            NSString * codeStr = [codeDic objectForKey:@"code"];
//            self.vCodeLb.text = codeStr;
            //[[NSUserDefaults standardUserDefaults] setValue:codeStr forKey:VERIFICATIONCODE];
        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
            [tTip show];
        }
        [self displayNotification];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hidenProgress];
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
        [tTip show];
        return;
    }];
}

- (void)displayNotification
{
    if (self.notify.isAnimating)
    {
        return;
    }
    
    [self.view addSubview:self.notify];
    [self.notify presentWithDuration:1.0f speed:0.5f inView:self.view completion:^{
        [self.notify removeFromSuperview];
    }];
}



#pragma  mark action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)resendAction:(id)sender
{
    NSLog(@"触发事件");
    [self addProgressHUD];
    [self GetVerificationCode:self.phoneNumStr];
    
}

- (IBAction)finishAction:(id)sender
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"mobile":self.phoneNumStr,@"code":self.vCodeLb.text,@"udid":[OpenUDID value]};
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"sendCode"];
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hidenProgress];
        
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (!errorCode)
        {
            RegistThirdViewController * registThVC = [[RegistThirdViewController alloc]initWithNibName:nil bundle:nil];
            registThVC.validateCode = self.vCodeLb.text;
            [self.navigationController pushViewController:registThVC animated:YES];        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
            [tTip show];
        }
        [self displayNotification];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hidenProgress];
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
        [tTip show];
        return;
    }];

    
    

}

- (IBAction)ruleAction:(id)sender
{
    
}

- (IBAction)selectAction:(id)sender
{
    UIButton *bt = (UIButton *)sender;
    if (bt.selected)
    {
        bt.selected = NO;
    }
    else
    {
        bt.selected = YES;
    }
}

#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [self.progressHUD removeFromSuperview];
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

#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(void)textEditingChanged:(UITextField *)textField
{
    if ([textField.text length] > 6)
    {
        textField.text = [textField.text substringToIndex:6];
    }
}

@end
