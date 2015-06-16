//
//  MyQRCodeViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-5-8.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "MyQRCodeViewController.h"
#import "QREncoder.h"
#import "UIImageView+WebCache.h"

static const CGFloat kPadding = 10;

@interface MyQRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation MyQRCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的QR Code";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UserInfoEntity *userInfo =[[InterfaceModel sharedInstance] getHostUser];
    self.nameLabel.text = userInfo.UI_nickname;
    
    NSString *baseUrl = SERVICE_URL;
    NSString *urlString = [baseUrl stringByAppendingString:userInfo.UI_photoPath];
    
    UIImage *placeholderImage = nil;
    if ([userInfo.UI_sex intValue] == 0) {
        placeholderImage = [UIImage imageNamed:@"default_photo_females.png"];
    } else {
        placeholderImage = [UIImage imageNamed:@"default_photo_males.png"];
    }
    
    [self.photoImageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholderImage];
    UIImage *image = [QREncoder encode:[NSString stringWithFormat:@"ryfit%@", userInfo.UI_userId]];
    self.qrImageView.image = image;
    CGFloat qrSize = self.view.bounds.size.width - kPadding * 2;
	self.qrImageView.frame = CGRectMake(kPadding, (self.view.bounds.size.height - qrSize) / 2,
                                 qrSize, qrSize);
	[self.qrImageView layer].magnificationFilter = kCAFilterNearest;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
