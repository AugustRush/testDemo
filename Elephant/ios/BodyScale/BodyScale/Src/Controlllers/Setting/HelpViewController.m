//
//  HelpViewController.m
//  BodyScale
//
//  Created by 祁鹏翔 on 15/3/20.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"帮助";
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 27, 22);
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:leftBarBtn animated:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.frame = CGRectMake(0, 0, CONTROLLERVIEW_WIDTH, CONTROLLERVIEW_HEIGHT-64);
//    [self displayOverFlowActivityView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bodyscale.cookst.com/touch/help.php"]]]];
    [self initNavBarAndView];
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initNavBarAndView
{
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = CGRectMake(CONTROLLERVIEW_WIDTH/2 - 32, 7, 102, 22);
    [titleBtn addTarget:self action:@selector(titleBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [titleBtn setTitle:@"" forState:UIControlStateNormal];
    [titleBtn setTitleColor:TITLELABELCOLOR forState:UIControlStateNormal];
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    self.navigationItem.titleView = titleBtn;
    [self.navigationController.view.layer setCornerRadius:10.0f];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)titleBtnPress
{
}
- (void)leftBarBtnPress
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [self removeOverFlowActivityView];
}
-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title = self.title;
}

@end
