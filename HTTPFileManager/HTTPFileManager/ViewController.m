//
//  ViewController.m
//  HTTPFileManager
//
//  Created by August on 14/10/21.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ViewController.h"
#import "HTTPFileDownLoader.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)downImage:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshImage:) name:@"testImage" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshImage:(NSNotification *)notification
{
    self.imageView.image = notification.object;
}

- (IBAction)downImage:(id)sender {
    
    HTTPFileDownLoader *downloader = [[HTTPFileDownLoader alloc] init];
    [downloader loadImage];
}
@end
