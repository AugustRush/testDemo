//
//  AddFriendViewController.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 4/19/14.
//  Copyright (c) 2014 Go Salo. All rights reserved.
//

#import "AddFriendViewController.h"
#import "ScanQRCodeViewController.h"
#import "ZBarSDK.h"
#import "MyQRCodeViewController.h"

@interface AddFriendViewController () <UITextFieldDelegate, ZBarReaderDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addFriendButton;
@property (weak, nonatomic) IBOutlet UIButton *qrCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation AddFriendViewController {
    ZBarReaderViewController *_reader;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self textFieldResignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self textFieldResignFirstResponder];
}

#pragma mark - Private Methods

- (void)initViews {
    self.navigationItem.title = @"添加关注";
    [self buildBarButtonItemIn:BaseViewControllerBarButtonItemPositionRight withImage:[UIImage imageNamed:@"erweima.png"]];
}

- (void)textFieldResignFirstResponder {
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
    }
}

- (void)textFieldDidChanged:(NSNotification *)notification {
    NSString *text = [(UITextField *)[notification object] text];
    self.addFriendButton.enabled = (text && text.length > 0) ? YES: NO;
}

#pragma mark - Requests

- (void)issueAddFriendRequest {
    [[InterfaceModel sharedInstance] addFriendWithFriendLonginName:self.textField.text callBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
        self.addFriendButton.enabled = YES;

        if(result == WebCallBackResultSuccess) {
            [self showHUDInView:self.view justWithText:@"关注请求已发送" disMissAfterDelay:1];
        } else {
            if (errorMsg) {
                [self showHUDInView:self.view justWithText:errorMsg disMissAfterDelay:1];
            }
        }
    }];
}

#pragma mark - Actions

- (IBAction)addFriend:(UIButton *)sender {
    sender.enabled = NO;
    
    [self textFieldResignFirstResponder];
    [self issueAddFriendRequest];
}

- (IBAction)scanQRCodeAction:(UIButton *)sender {
    [self textFieldResignFirstResponder];

    _reader = [ZBarReaderViewController new];
    _reader.readerDelegate = self;
    _reader.showsZBarControls = NO;
    _reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    ZBarImageScanner *scanner = _reader.scanner;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.backgroundColor = [UIColor blackColor];
    [_reader.view addSubview:cancelButton];
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    [self presentViewController:_reader animated:YES completion:nil];
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)rightBarButtonAction:(id)sender {
    MyQRCodeViewController *myQRCodeVC = [[MyQRCodeViewController alloc] initWithNibName:@"MyQRCodeViewController" bundle:nil];
    [self.navigationController pushViewController:myQRCodeVC animated:YES];
}

#pragma mark - ZBar Delegate

- (void)imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary *)info {
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    if (symbol.data.length <= 5) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无效的二维码"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }

    if ([[symbol.data substringToIndex:5] isEqualToString:@"ryfit"]) {
        [self showHUDInView:self.view justWithText:@"正在发送请求..."];
        
        NSString *userId = [symbol.data substringFromIndex:5];
        [[InterfaceModel sharedInstance] addFriendWithFriendUid:userId callBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
            
            [self disMissHUDWithText:@"正在发送请求..." afterDelay:0];
            [self performSelector:@selector(delayDismiss:) withObject:reader afterDelay:1];
            if (!errorMsg) {
                [self showHUDInView:self.view justWithText:@"添加成功" disMissAfterDelay:2];
            } else {
                [self showHUDInView:self.view justWithText:[NSString stringWithFormat:@"%@", errorMsg] disMissAfterDelay:2];
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

- (void)cancelButtonAction:(UIButton *)button {
    [_reader dismissViewControllerAnimated:YES completion:nil];
}

- (void)delayDismiss:(UIViewController *)vc {
    [vc dismissViewControllerAnimated:YES completion:nil];
}

@end
