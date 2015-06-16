//
//  LoginViewController.m
//  BodyScale
//
//  Created by cxx on 14-11-25.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistFirstViewController.h"
#import "AFNetworking.h"
#import "UIAlertBlockView.h"
#import "sdkCall.h"
#import "LoginSinaViewController.h"
#import "LPSinaEngine.h"

#define _tag_share 1000

#define share_Height 140
@interface LoginViewController () <MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet UIButton *forgetBt;
@property (nonatomic, strong) UIView *sView;
@property (nonatomic, strong) ButtonExten *qqBtn;
@property (nonatomic, strong) ButtonExten *weiboBtn;

@property (strong, nonatomic) MBProgressHUD *progressHUD;

@property (nonatomic, strong) NSArray *sImgArray;
@property (nonatomic, strong) NSArray *sTextArray;
@end

@implementation LoginViewController

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
- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}
- (void)dealloc
{
}
#pragma mark
#pragma mark - Init & Add
- (MBProgressHUD *)progressHUD
{
    if (!_progressHUD)
    {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view bringSubviewToFront:_progressHUD];
        _progressHUD.delegate = self;
        [_progressHUD show:YES];
    }
    return _progressHUD;
}
- (UIView *)sView
{
    if (!_sView)
    {
        _sView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, share_Height)];
        [_sView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *tLabel = [[UILabel alloc] init];
        tLabel.backgroundColor = [UIColor blackColor];
        tLabel.frame = CGRectMake(80, 12, Screen_Width - 160, 1);
        [_sView addSubview:tLabel];
        
        UILabel *textLb = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-45, 0, 90, 24)];
        [textLb setTextColor:[UIColor colorWithRed:132/255.0f green:132/255.0f blue:132/255.0f alpha:1]];
        textLb.backgroundColor = self.view.backgroundColor;
        [textLb setFont:[UIFont systemFontOfSize:14]];
        [textLb setText:@"其他方式登录"];
        [textLb setTextAlignment:NSTextAlignmentCenter];
        [_sView addSubview:textLb];

    }
    return _sView;
}
- (ButtonExten *)qqBtn
{
    if (!_qqBtn)
    {
        _qqBtn = [ButtonExten buttonWithType:UIButtonTypeCustom];
        [_qqBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.sImgArray objectAtIndex:0]]] WithDownText:[NSString stringWithFormat:@"%@",[self.sTextArray objectAtIndex:0]]];
        [_qqBtn setTitleColor:[UIColor colorWithRed:132/255.0f green:132/255.0f blue:132/255.0f alpha:1] forState:UIControlStateNormal ];
        [_qqBtn.titleLabel setCenter:CGPointMake(45, 45)];
        _qqBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_qqBtn addTarget:self action:@selector(loginQQ) forControlEvents:UIControlEventTouchUpInside];
        [self.sView addSubview:_qqBtn];
    }
    return _qqBtn;
}
- (ButtonExten *)weiboBtn
{
    if (!_weiboBtn)
    {
        _weiboBtn = [ButtonExten buttonWithType:UIButtonTypeCustom];
        [_weiboBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.sImgArray objectAtIndex:1]]] WithDownText:[NSString stringWithFormat:@"%@",[self.sTextArray objectAtIndex:1]]];
        [_weiboBtn setTitleColor:[UIColor colorWithRed:132/255.0f green:132/255.0f blue:132/255.0f alpha:1] forState:UIControlStateNormal ];
        [_weiboBtn.titleLabel setCenter:CGPointMake(45, 45)];
        _weiboBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_weiboBtn addTarget:self action:@selector(loginBySinaAction) forControlEvents:UIControlEventTouchUpInside];
        [self.sView addSubview:_weiboBtn];
    }
    return _weiboBtn;

}
- (NSArray *)sImgArray
{
    if (!_sImgArray)
    {
        _sImgArray = [[NSArray alloc] initWithObjects:@"qq",@"sina",@"QQ",@"taobao", nil];
    }
    return _sImgArray;
}
- (NSArray *)sTextArray
{
    if (!_sTextArray)
    {
        _sTextArray = [[NSArray alloc] initWithObjects:@"QQ",@"新浪",@"QQ",@"淘宝", nil];
    }
    return _sTextArray;
}
#pragma mark
#pragma mark - System Action
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"登录";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0.0, 0.0, 40, 20);
    [right setTitle:@"注册" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:right];
    temporaryBarButtonItem1.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = temporaryBarButtonItem1;
    
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.top.equalTo(@20);
    }];
    
    self.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.pswTextField.backgroundColor = [UIColor whiteColor];
    [self.pswTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.top.equalTo(self.nameTextField.mas_bottom).with.offset(15);
    }];
    
    [self.loginBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pswTextField.mas_bottom).with.offset(10);
    }];

    [self.forgetBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginBt.mas_left).with.offset(5);
        make.top.equalTo(self.loginBt.mas_bottom).with.offset(10);
    }];

    self.sView.backgroundColor = [UIColor clearColor];
    [self.sView setFrame:CGRectMake(0, Screen_Height-share_Height-50, Screen_Width, share_Height)];
    [self.view addSubview:self.sView];
    
    DLog(@"nametext\n,x:%.2f\n,y:%.2f\n,w:%.2f\n,h:%.2f\n",self.nameTextField.frame.origin.x,self.nameTextField.frame.origin.y,self.nameTextField.frame.size.width,self.nameTextField.frame.size.height);
    DLog(@"nametext\n,x:%.2f\n,y:%.2f\n,w:%.2f\n,h:%.2f\n",self.pswTextField.frame.origin.x,self.pswTextField.frame.origin.y,self.pswTextField.frame.size.width,self.pswTextField.frame.size.height);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getNeedQQLogin];
    [self closeQQLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark - Other Action
- (void)loginToserver
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"login"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"mobile":self.nameTextField.text,@"password":self.pswTextField.text, @"udid":[OpenUDID value]};
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (!errorCode)
        {
            NSDictionary * codeDic = [resultDic objectForKey:@"data"];
            [FFConfig currentConfig].needAutoLogin = @YES;
            [FFConfig currentConfig].userId = [codeDic objectForKey:@"user_id"];
            [FFConfig currentConfig].userShowName = [codeDic objectForKey:@"username"];
            [FFConfig currentConfig].privateCode = [codeDic objectForKey:@"private_code"];
            [FFConfig currentConfig].userHeader = codeDic[@"avatar"];
            NSMutableArray *tList = [[NSMutableArray alloc] init];
            [tList addObjectsFromArray:codeDic[@"members"]];
            if (tList != nil)
            {
                UserInfoManager *tUser = [UserInfoManager sharedInstance];
                [tUser.userLoginArray addObjectsFromArray:tList];
                NSInteger iCount = tList.count;
                if (iCount > 0)
                {
                    [FFConfig currentConfig].nowUserId = [NSString stringWithFormat:@"%@", [tList[0] objectForKey:@"id"]];
                }
            }
            [FFConfig currentConfig].isLogined = @YES;
            [FFConfig currentConfig].userName = self.nameTextField.text;
            [FFConfig currentConfig].password = self.pswTextField.text;

            
            [self hidenProgress];
            self.navigationController.navigationBarHidden = YES;
            UserBaseInfoViewController *leftMenuViewController = [[UserBaseInfoViewController alloc] initWithNibName:@"UserBaseInfoViewController" bundle:nil];
            CenterViewController *centerViewController = [[CenterViewController alloc]initWithNibName:nil bundle:nil ishasTextFeild:NO];
            UINavigationController *centerNavigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
            self.sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:centerNavigationController leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
            self.sideMenuViewController.panFromEdge = YES;
            self.sideMenuViewController.panGestureEnabled = YES;
            self.sideMenuViewController.scaleMenuView = NO;
            self.sideMenuViewController.contentViewShadowEnabled = YES;
            
            [self.navigationController pushViewController:self.sideMenuViewController animated:YES];
        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
            [tTip show];
            [self hidenProgress];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        [FFConfig currentConfig].isLogined = @NO;
        [self hidenProgress];
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
        [tTip show];
        return;
    }];
}


#pragma mark BUTTONACTION
- (void)shareSpace:(id)sender
{
    UIButton *tBtn = (UIButton *)sender;
    if (tBtn.tag == (_tag_share +1))
    {
        [self loginQQ];
    }
    else
    {
        
        [self loginBySinaAction];
    }
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:self];
}
- (void)rightAction
{
    [self.navigationController pushViewController:[[RegistFirstViewController alloc] initWithNibName:@"RegistFirstViewController" bundle:nil] animated:YES];
}

-(IBAction)loginAction:(id)sender
{
//    if ([CommanHelp isStringNULL:self.nameTextField.text])
//    {
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"账号有误" message:@"用户账号不能为空，请正确填写。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    else if ([CommanHelp isStringNULL:self.pswTextField.text])
//    {
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"密码有误" message:@"密码不能为空，请输入正确的密码。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    else if (![CommanHelp isMobileNumber:self.nameTextField.text])
//    {
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"账号有误" message:@"请输入正确格式的账号。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    
    [self addProgressHUD];
    [self loginToserver];
}

- (IBAction)forgetAction:(id)sender
{
}
- (void)closeQQLogin
{
    if ([[FFConfig currentConfig].closeQQ intValue] != 0)
    {
        self.qqBtn.alpha = 1.0f;
        [self.qqBtn setFrame:CGRectMake((Screen_Width-45*4-20*4)/2+75*1, 50, 45, 50)];
        [self.weiboBtn setFrame:CGRectMake((Screen_Width-45*4-20*4)/2+75*2, 50, 45, 50)];
    }
    else
    {
        self.qqBtn.alpha = 0.0f;
        [self.weiboBtn setFrame:CGRectMake((Screen_Width-45)/2, 50, 45, 50)];
    }
}
#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark MBProgressHUDDelegate
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

#pragma mark
#pragma mark - Union Login
- (void)loginBySinaAction
{
    // FIXME:先判断有无授权。
    DLog(@"新浪微博授权：%d",[LPSinaEngine isAuthorized]);
    if ([LPSinaEngine isAuthorized])
    {
        //已授权
        NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:SINA_USER_ID_KEY];
        [LPSinaEngine getUserInfo:uid success:^(BOOL isSuccess, User *aUser){
            if (isSuccess)
            {
                //授权成功
                NSString *str = [NSString stringWithFormat:@"已有授权账号“%@”,是否登录？",aUser.name];
                UIAlertBlockView *alert = [[UIAlertBlockView alloc]initWithTitle:str message:nil delegate:self cancelButtonTitle:@"其他账号" otherButtonTitles:@"登录", nil];
                alert.tag = 2000;
                [alert setClickBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
                    if (buttonIndex == 1 && alertView.tag == 2000)
                    {
                        DLog(@"点击了登录");
                        [self getSinaInfo];
                    }
                    else
                    {
                        DLog(@"点击了其他账号");
                        //注销新浪账号(这一步集成在里面做了)
                        //[LPSinaEngine logout];
                        //换新的账号
                        [self getSinaAuthorized];
                    }
                }];
                [alert show];
            }
        }];
    }
    else
    {
        [self getSinaAuthorized];
    }
}
//获取新浪微博授权
-(void)getSinaAuthorized
{
    //未授权
    LoginSinaViewController *loginVC = [[LoginSinaViewController alloc] initWithLoginCompletion:^(BOOL isSuccess){
        if (isSuccess)
        {
            [self getSinaInfo];
        }
        else
        {
            //取消或失败。
        }
    }];
    [self presentViewController:loginVC animated:YES completion:nil];
}

//获取授权后的信息
-(void)getSinaInfo
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:SINA_USER_ID_KEY];
    [LPSinaEngine getUserInfo:uid success:^(BOOL isSuccess, User *aUser){
        if (isSuccess)
        {
            
            [self sinaSuccessWith:(User *)aUser];
        }
        
    }];
}
- (void)getNeedQQLogin
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"tencent"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{};
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (errorCode == 0)
        {
            [FFConfig currentConfig].closeQQ = @([[resultDic[@"data"] objectForKey:@"result"] intValue]);
            [self closeQQLogin];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }];
}
-(void)sinaSuccessWith:(User *)aUser
{
    //授权成功
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"unionLogin"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"target":@"sina",@"target_id":aUser.userId, @"username":aUser.name,@"avatar":aUser.profileImageUrl,@"token":@"2.00et8M5C0xXNHX41950fe0307xqTJD"};
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
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
            [FFConfig currentConfig].userHeader = codeDic[@"avatar"];
            [FFConfig currentConfig].userName = @"";
            [FFConfig currentConfig].password = @"";

            NSMutableArray *tList = [[NSMutableArray alloc] init];
            [tList addObjectsFromArray:codeDic[@"members"]];
            if (tList != nil)
            {
                NSInteger iCount = tList.count;
                if (iCount > 0)
                {
                    for (NSDictionary *tDict in tList)
                    {
                        NSMutableDictionary *ttDict = [[NSMutableDictionary alloc] init];
                        [ttDict setObject:@"sina" forKey:@"userInfoType"];
                        [ttDict setObject:[NSString stringWithFormat:@"%@", [FFConfig currentConfig].userId] forKey:@"userInfoSuperId"];
                        [ttDict setObject:[NSString stringWithFormat:@"%@",tDict[@"id"]] forKey:@"userInfoId"];
                        [ttDict setObject:[NSString stringWithFormat:@"%@",tDict[@"name"]] forKey:@"userInfoNickName"];
                        [ttDict setObject:[NSString stringWithFormat:@"%@",tDict[@"sex"]] forKey:@"userInfoSex"];
                        [ttDict setObject:@" " forKey:@"userInfoPhone"];
                        [ttDict setObject:@" " forKey:@"userInfoEmail"];
                        [ttDict setObject:@" " forKey:@"userRealName"];
                    }
                }
            }
            [FFConfig currentConfig].isLogined = @YES;
            [FFConfig currentConfig].userName = self.nameTextField.text;
            [FFConfig currentConfig].password = self.pswTextField.text;
            [FFConfig currentConfig].nowUserId = [codeDic objectForKey:@"user_id"];

            [self hidenProgress];
            self.navigationController.navigationBarHidden = YES;
            UserBaseInfoViewController *leftMenuViewController = [[UserBaseInfoViewController alloc] initWithNibName:@"UserBaseInfoViewController" bundle:nil];
            CenterViewController *centerViewController = [[CenterViewController alloc]initWithNibName:nil bundle:nil ishasTextFeild:NO];
            UINavigationController *centerNavigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
            self.sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:centerNavigationController leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
            self.sideMenuViewController.panFromEdge = YES;
            self.sideMenuViewController.panGestureEnabled = YES;
            self.sideMenuViewController.scaleMenuView = NO;
            self.sideMenuViewController.contentViewShadowEnabled = YES;
            
            [self.navigationController pushViewController:self.sideMenuViewController animated:YES];
        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
            [tTip show];
            [self hidenProgress];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        [FFConfig currentConfig].isLogined = @NO;
        [self hidenProgress];
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
        [tTip show];
        return;
    }];
}
- (void)loginQQ
{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_IDOL,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_PIC_T,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_DEL_IDOL,
                            kOPEN_PERMISSION_DEL_T,
                            kOPEN_PERMISSION_GET_FANSLIST,
                            kOPEN_PERMISSION_GET_IDOLLIST,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_GET_REPOST_LIST,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                            nil];
    
    [[[sdkCall getinstance] oauth] authorize:permissions inSafari:NO];
}
- (void)tencentDidLogin
{
    [[[sdkCall getinstance] oauth] getUserInfo];
}
- (void)analysisResponse:(NSNotification *)notify
{
    if (notify)
    {
        APIResponse *response = [[notify userInfo] objectForKey:kResponse];
        NSString *tNameString = response.jsonResponse[@"nickname"];
        NSString *tHeadImgString = response.jsonResponse[@"figureurl_qq_2"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"unionLogin"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSDictionary *parameters = @{@"target":@"tencent",@"target_id":[[sdkCall getinstance] oauth].openId, @"username":tNameString,@"avatar":tHeadImgString,@"token":@"2.00et8M5C0xXNHX41950fe0307xqTJD"};
        [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
            
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
                [FFConfig currentConfig].userHeader = codeDic[@"avatar"];
                [FFConfig currentConfig].userName = @"";
                [FFConfig currentConfig].password = @"";
                
                NSMutableArray *tList = [[NSMutableArray alloc] init];
                [tList addObjectsFromArray:codeDic[@"members"]];
                if (tList != nil)
                {
                    NSInteger iCount = tList.count;
                    if (iCount > 0)
                    {
                        for (NSDictionary *tDict in tList)
                        {
                            NSMutableDictionary *ttDict = [[NSMutableDictionary alloc] init];
                            [ttDict setObject:@"qq" forKey:@"userInfoType"];
                            [ttDict setObject:[NSString stringWithFormat:@"%@", [FFConfig currentConfig].userId] forKey:@"userInfoSuperId"];
                            [ttDict setObject:[NSString stringWithFormat:@"%@",tDict[@"id"]] forKey:@"userInfoId"];
                            [ttDict setObject:[NSString stringWithFormat:@"%@",tDict[@"name"]] forKey:@"userInfoNickName"];
                            [ttDict setObject:[NSString stringWithFormat:@"%@",tDict[@"sex"]] forKey:@"userInfoSex"];
                            [ttDict setObject:@" " forKey:@"userInfoPhone"];
                            [ttDict setObject:@" " forKey:@"userInfoEmail"];
                            [ttDict setObject:@" " forKey:@"userRealName"];
                        }
                        [FFConfig currentConfig].nowUserId = [NSString stringWithFormat:@"%@", [tList[0] objectForKey:@"id"]];
                    }
                }
                [FFConfig currentConfig].isLogined = @YES;
                [FFConfig currentConfig].userName = self.nameTextField.text;
                [FFConfig currentConfig].password = self.pswTextField.text;

                [self hidenProgress];
                self.navigationController.navigationBarHidden = YES;
                UserBaseInfoViewController *leftMenuViewController = [[UserBaseInfoViewController alloc] initWithNibName:@"UserBaseInfoViewController" bundle:nil];
                CenterViewController *centerViewController = [[CenterViewController alloc]initWithNibName:nil bundle:nil ishasTextFeild:NO];
                UINavigationController *centerNavigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
                self.sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:centerNavigationController leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
                self.sideMenuViewController.panFromEdge = YES;
                self.sideMenuViewController.panGestureEnabled = YES;
                self.sideMenuViewController.scaleMenuView = NO;
                self.sideMenuViewController.contentViewShadowEnabled = YES;
                
                [self.navigationController pushViewController:self.sideMenuViewController animated:YES];
            }
            else
            {
                NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                DLog(@"%@",errReson);
                BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
                [tTip show];
                [self hidenProgress];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            
            [FFConfig currentConfig].isLogined = @NO;
            
            [self hidenProgress];
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
            [tTip show];
            return;
        }];
    }
}

@end
