//
//  FeedBackViewController.m
//  BodyScale
//
//  Created by 祁鹏翔 on 15/3/20.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.frame = CGRectMake(0, 0, CONTROLLERVIEW_WIDTH, CONTROLLERVIEW_HEIGHT-64);
//    [self displayOverFlowActivityView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bodyscale.cookst.com/touch/feedback.php"]]]];
    [self initNavBarAndView];
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
    [titleBtn setTitle:@"关于我们" forState:UIControlStateNormal];
    [titleBtn setTitleColor:TITLELABELCOLOR forState:UIControlStateNormal];
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    self.navigationItem.titleView = titleBtn;
    [self.navigationController.view.layer setCornerRadius:10.0f];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 27, 22);
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:leftBarBtn animated:YES];
    //TT_RELEASE_SAFELY(leftBarBtn);
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
//    [self removeOverFlowActivityView];
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title = self.title;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
