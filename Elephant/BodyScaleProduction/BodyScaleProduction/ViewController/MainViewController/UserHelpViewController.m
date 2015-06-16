//
//  UserHelpViewController.m
//  BodyScaleProduction
//
//  Created by 刘平伟 on 14-4-18.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "UserHelpViewController.h"

@interface UserHelpViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation UserHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"帮助";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.webView.backgroundColor = [UIColor clearColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.rysmart.com/help.html"]]];


}


#pragma mark - memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
