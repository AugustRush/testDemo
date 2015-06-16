//
//  CommonWebViewController.m
//  DZB
//
//  Created by 两元鱼 on 14-5-21.
//  Copyright (c) 2014年 FFLtd. All rights reserved.
//

#import "CommonWebViewController.h"

@interface CommonWebViewController ()

@end

@implementation CommonWebViewController


#pragma mark
#pragma mark - Init & Dealloc
- (id)init
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
- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        [(UIScrollView*)[self.webView.subviews objectAtIndex:0] setBounces:NO];
        //上下边缘的黑色阴影
        UIScrollView  *scroller = [_webView.subviews objectAtIndex:0];
        if (scroller)
        {
            for (UIView *v in [scroller subviews])
            {
                if ([v isKindOfClass:[UIImageView class]])
                {
                    [v removeFromSuperview];
                }
            }
        }
        // add by bill.zheng 2014-10-18
//        self.jsBridge = [TGJSBridge jsBridgeWithDelegate:self];
//        _webView.delegate = _jsBridge;
        
        [self.view addSubview:_webView];
    }
    return _webView;
}
#pragma mark
#pragma mark - View Action

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0)
    {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

//-(void)jsBridge:(TGJSBridge *)bridge didReceivedNotificationName:(NSString *)name userInfo:(NSDictionary *)userInfo fromWebView:(UIWebView *)webview
//{
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end