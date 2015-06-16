//
//  AboutUsViewController.m
//  BodyScaleProduction
//
//  Created by Cloud_Ding on 14-3-27.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *bundleLab;

- (IBAction)WebSiteButton:(id)sender;

@end

@implementation AboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"关于我们";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *appVersion = [Utility getAppVersion];
    self.bundleLab.text = [NSString stringWithFormat:@"版本号%@", appVersion];
}

- (IBAction)WebSiteButton:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.rysmart.com"]];
}

@end
