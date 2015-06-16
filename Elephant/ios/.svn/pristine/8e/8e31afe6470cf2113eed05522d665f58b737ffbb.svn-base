//
//  ShareViewController.m
//  BodyScale
//
//  Created by cxx on 14-11-25.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ShareViewController.h"
#import "HeaderButton.h"
#import "ButtonExten.h"
#define _tag_share 1000

#define share_Height 140
@interface ShareViewController ()
@property (nonatomic, strong) UIWebView *webView;
@property (strong, nonatomic) UIView *shareBtsView;
@property (strong, nonatomic) UIImageView *shareBgView;
@property (nonatomic, strong) NSString *shareUrlString;

@end

@implementation ShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"分享";
    // Do any additional setup after loading the view from its nib.
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.navigationController.navigationBarHidden = NO;
    
    NSDate *tDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:tDate];
    self.shareUrlString = [NSString stringWithFormat:@"http://bodyscale.cookst.com/share.php?member_id=%@&day=%@", [FFConfig currentConfig].userId/*self.shareIdString*/, dateString];
    NSURL *url = [[NSURL alloc] initWithString:self.shareUrlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.shareBtsView.alpha = 1.0f;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 140);
        [self.view addSubview:_webView];
    }
    return _webView;
}
- (UIView *)shareBtsView
{
    if (!_shareBtsView)
    {
        _shareBtsView = [[UIView alloc] init];
        _shareBtsView.frame = CGRectMake(0, self.view.frame.size.height - 140, self.view.frame.size.width, 80);
        UIView *shareView = [self createShareView];
        [_shareBtsView addSubview:shareView];
        [self.view addSubview:_shareBtsView];
    }
    return _shareBtsView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIView *)createShareView
{
    UIView *sView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, share_Height)];
    [sView setBackgroundColor:[UIColor whiteColor]];
    NSArray *sImgArray = @[@"weixin-Firend",@"FrendGroup",@"QQSpace",@"sina"];
    NSArray *sTextArray = @[@"微信好友",@"朋友圈",@"QQ空间",@"新浪微博"];
    for (int i =0; i<4; i++)
    {
        ButtonExten *bt = [ButtonExten buttonWithType:UIButtonTypeCustom];
        [bt setFrame:CGRectMake((Screen_Width-45*4-20*4)/2+75*i, 20, 45, 50)];
        [bt setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[sImgArray objectAtIndex:i]]] WithDownText:[NSString stringWithFormat:@"%@",[sTextArray objectAtIndex:i]]];
        [bt.titleLabel setCenter:CGPointMake(45, 45)];
        bt.titleLabel.textAlignment = NSTextAlignmentCenter;
        bt.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft  ;
        [bt addTarget:self action:@selector(shareSpace:) forControlEvents:UIControlEventTouchUpInside];
        [sView addSubview:bt];
        [bt setTitleColor:BGColor forState:UIControlStateNormal];
        [bt setTag:_tag_share+i];
    }
    return sView;
}
- (void)shareSpace:(id)sender
{
    UIButton *bt = (UIButton*)sender;
    NSString *imagePath = @"";
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"测试数据"
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
                                            mediaType:SSPublishContentMediaTypeNews];
    
    ///////////////////////
    //以下信息为特定平台需要定义分享内容，如果不需要可省略下面的添加方法
    
    
    //定制QQ空间信息
    [publishContent addQQSpaceUnitWithTitle: @"Hello QQ空间"
                                        url:INHERIT_VALUE
                                       site:nil
                                    fromUrl:nil
                                    comment:INHERIT_VALUE
                                    summary:INHERIT_VALUE image:INHERIT_VALUE  type:INHERIT_VALUE playUrl:nil nswb:nil];
    
    //定制微信好友信息
    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE content:INHERIT_VALUE title:@"Hello 微信好友!"  url:INHERIT_VALUE thumbImage:[ShareSDK imageWithUrl:@""] image:INHERIT_VALUE musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
    
    //定制微信朋友圈信息
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeMusic] content:INHERIT_VALUE title:@"Hello 微信朋友圈!" url:@""  thumbImage:[ShareSDK imageWithUrl:@""]  image:INHERIT_VALUE musicFileUrl:@"" extInfo:nil fileData:nil emoticonData:nil];
    
    //定制微信收藏信息
    [publishContent addWeixinFavUnitWithType:INHERIT_VALUE  content:INHERIT_VALUE  title:@"Hello 微信收藏!" url:INHERIT_VALUE thumbImage:[ShareSDK imageWithUrl:@""] image:INHERIT_VALUE musicFileUrl:nil  extInfo:nil fileData:nil  emoticonData:nil];
    
    //定制QQ分享信息
    [publishContent addQQUnitWithType:INHERIT_VALUE content:INHERIT_VALUE title:@"Hello QQ!" url:INHERIT_VALUE image:INHERIT_VALUE];
    
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:YES authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:self];
    
    if (bt.tag == 1002 )
    {
        //        snsName = @"qzone";
        [ShareSDK shareContent:publishContent
                          type:ShareTypeQQSpace
                   authOptions:authOptions
                 statusBarTips:YES
                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                            
                            if (state == SSPublishContentStateSuccess)
                            {
                                NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                            }
                            else if (state == SSPublishContentStateFail)
                            {
                                NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                            }
                        }];
        
    }
    else if (bt.tag == 1003)
    {
        //        snsName = @"sina";
        [ShareSDK shareContent:publishContent
                          type:ShareTypeSinaWeibo
                   authOptions:authOptions
                 statusBarTips:YES
                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                            
                            if (state == SSPublishContentStateSuccess)
                            {
                                NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                            }
                            else if (state == SSPublishContentStateFail)
                            {
                                NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                            }
                        }];
        
    }
    else if (bt.tag == 1000)
    {
        //        snsName = @"wxsession";
        [ShareSDK showShareViewWithType:ShareTypeWeixiSession
                              container:nil
                                content:publishContent
                          statusBarTips:YES
                            authOptions:authOptions
                           shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                               oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                                qqButtonHidden:NO
                                                         wxSessionButtonHidden:NO
                                                        wxTimelineButtonHidden:NO
                                                          showKeyboardOnAppear:NO
                                                             shareViewDelegate:self
                                                           friendsViewDelegate:self
                                                         picViewerViewDelegate:nil]
                                 result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                     
                                     if (state == SSPublishContentStateSuccess)
                                     {
                                         //                                         NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                                     }
                                     else if (state == SSPublishContentStateFail)
                                     {
                                         NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                                     }
                                 }];
        
    }
    else if(bt.tag == 1001)
    {
        //        snsName = @"wxfavorite";
        [ShareSDK showShareViewWithType:ShareTypeWeixiTimeline
                              container:nil
                                content:publishContent
                          statusBarTips:YES
                            authOptions:authOptions
                           shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                               oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                                qqButtonHidden:NO
                                                         wxSessionButtonHidden:NO
                                                        wxTimelineButtonHidden:NO
                                                          showKeyboardOnAppear:NO
                                                             shareViewDelegate:self
                                                           friendsViewDelegate:self
                                                         picViewerViewDelegate:nil]
                                 result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                     
                                     if (state == SSPublishContentStateSuccess)
                                     {
                                         NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                                     }
                                     else if (state == SSPublishContentStateFail)
                                     {
                                         NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                                     }
                                 }];
        
    }    
}
@end
