//
//  EntryViewController.m
//  ARVeryCD
//
//  Created by August on 14-8-1.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "EntryViewController.h"

#define kVeryCDBaseWebURL @"http://m.verycd.com/entries/%@/?source=iphone"

@interface EntryViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EntryViewController

#pragma mark - lifeCycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Private methods

-(void)setEntryId:(NSString *)entryId
{
    _entryId = entryId;
    NSString *entryWebUrl = [NSString stringWithFormat:kVeryCDBaseWebURL,_entryId];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:entryWebUrl]]];
    NSLog(@"entry wed url is %@, web is %@",entryWebUrl,self.webView);
}

#pragma mark - manage memory methods

-(void)dealloc
{}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
