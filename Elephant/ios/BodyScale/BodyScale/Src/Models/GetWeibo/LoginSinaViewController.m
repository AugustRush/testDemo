//
//  LoginViewController.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-9-25.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "LoginSinaViewController.h"

@implementation LoginSinaViewController
@synthesize completionHandler = _completionHandler;

- (id)initWithLoginCompletion:(void (^) (BOOL isLoginSuccess))isLoginSuccess
{
    if (self = [super init]) {
        self.completionHandler = isLoginSuccess;
    }
    return self;
}

- (void)dealloc
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationController.navigationBar.hidden = YES;
    
    //自定义导航
    UIView *customNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CONTROLLERVIEW_WIDTH, 44)];
    customNavBar.backgroundColor = [UIColor blackColor];
    [self.view addSubview:customNavBar];
    
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setTitle:@"取消" forState:UIControlStateNormal];
    returnBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    returnBtn.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
    returnBtn.contentVerticalAlignment  = UIControlContentVerticalAlignmentCenter;
    returnBtn.frame = CGRectMake(15, 0, 100, 44);
    [returnBtn addTarget:self action:@selector(Cancelbtn) forControlEvents:UIControlEventTouchUpInside];
    [customNavBar addSubview:returnBtn];
    
	_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,44, CONTROLLERVIEW_WIDTH, CONTROLLERVIEW_HEIGHT-44)];
	_webView.delegate = self;
	[self.view addSubview:_webView];
    
    //单独开一个线程请求网页
    [NSThread detachNewThreadSelector:@selector(requestSinaWebView:) toTarget:self withObject:nil];

}
#pragma mark ---------------------------------------------------------------
#pragma mark --多线程方法
- (void)requestSinaWebView:(id)anObj
{
    @synchronized(anObj)
    {
        [self startRequest];
    }
}
-(void)Cancelbtn
{
    DLog(@"点击");
    _webView.delegate = nil;
    if(self.completionHandler)
    {
        self.completionHandler(NO);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark 请求网络

-(void)startRequest
{
    DLog(@"begin");
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[LPSinaEngine authorizeURL]];
	[_webView loadRequest:request];
    DLog(@"end");
}


#pragma mark -
#pragma mark UIWebView代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    DLog(@"begin");
    if ([request.URL.absoluteString rangeOfString:@"code="].location != NSNotFound) {
        
        DLog(@"点击了登录");
        
        //清除账号信息
        if ([LPSinaEngine isAuthorized]) {
            [LPSinaEngine logout];
        }
        
        NSString *code = [[request.URL.query componentsSeparatedByString:@"="] objectAtIndex:1];
        [LPSinaEngine getAccessToken:code success:^(BOOL isSuccess){
            if (isSuccess) {
                [self dismissViewControllerAnimated:YES completion:nil];
                if(self.completionHandler)
                {
                    self.completionHandler(YES);
                }
            }
        }];
        DLog(@"endNo");

        return NO;
    }
    DLog(@"endyes");

    return YES;
}

@end
