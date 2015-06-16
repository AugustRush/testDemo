//
//  LoginSinaViewController.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-9-25.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LPSinaEngine.h"

@interface LoginSinaViewController : UIViewController<UIWebViewDelegate>
{
	UIWebView *_webView;
    void (^_completionHandler)(BOOL);
}
@property (nonatomic, copy)void (^completionHandler)(BOOL);

- (id)initWithLoginCompletion:(void (^) (BOOL isLoginSuccess))isLoginSuccess;
- (void)startRequest;
@end
