//
//  ScanQRCodeViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-5-8.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import "ZBarSDK.h"

@interface ScanQRCodeViewController () <ZBarReaderDelegate>

@end

@implementation ScanQRCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"扫描QR Code";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    [self presentViewController:reader animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZBar Delegate
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
//    imageview.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    

    
    //判断是否包含 头'http:'
    NSString *regex = @"ryfit:[^\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
//    //判断是否包含 头'ssid:'
//    NSString *ssid = @"ssid+:[^\\s]*";;
//    NSPredicate *ssidPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ssid];
    NSLog(@"扫描到二维码:%@", symbol.data);
    
    if ([predicate evaluateWithObject:symbol.data]) {
        [self showHUDInView:self.view justWithText:@"正在发送请求..."];
        [[InterfaceModel sharedInstance] addFriendWithFriendLonginName:symbol.data callBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
            [reader dismissViewControllerAnimated:YES completion:nil];
            if (!errorMsg) {
                [self showHUDInView:self.view justWithText:@"添加成功" disMissAfterDelay:1.3];
            } else {
                [self showHUDInView:self.view justWithText:@"添加失败" disMissAfterDelay:1.3];
            }
        }];
    } else {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无效的二维码"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
