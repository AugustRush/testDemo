//
//  PersonaViewController.m
//  BodyScale
//
//  Created by cxx on 14-11-21.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "PersonaViewController.h"
#import "VisitorViewController.h"
#import "NSData+Base64.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

#import "ChangePasswordNewViewController.h"
#import "ChangePasswordNewViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "ChangeNameViewController.h"
#import "TWRSliderStackedView.h"
#import "TWRPickerSlider.h"
#import "TWRDemoObject.h"
#import "TWRPickerSliderFooterView.h"
#import "ELCImagePickerController.h"
#import "BHServiceDataCentre.h"

@interface PersonaViewController () <UIActionSheetDelegate,TWRPickerSliderDelegate,TWRPickerSliderDatasource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,ELCImagePickerControllerDelegate>
{
    NSArray *_textArray;
    NSMutableArray *_infoArray;
    TWRSliderStackedView *stack;
    UIView      *maskView;
}


@property(strong,nonatomic) NSString *userShowName;
@property(assign,nonatomic) Choose_Gender_Type gender_Type;
@property(strong,nonatomic) NSString *userPhoneNumber;
@property(assign,nonatomic) NSString *userEmailString;
@property(assign,nonatomic) NSString *userRealNameString;

@property(nonatomic,strong) UIImagePickerController * imagePicController;

@property (strong,nonatomic) MBProgressHUD *progressHUD;

@end

@implementation PersonaViewController
#pragma mark
#pragma mark - Init & Dealloc
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ishasTextFeild:NO];
    if (self)
    {
    }
    return self;
}
#pragma mark
#pragma mark - Init & Add
- (MBProgressHUD *)progressHUD
{
    if (!_progressHUD)
    {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view bringSubviewToFront:self.progressHUD];
        self.progressHUD.delegate = (id<MBProgressHUDDelegate>)self;
        [self.progressHUD show:YES];
    }
    return _progressHUD;
}
#pragma mark
#pragma mark - System
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColorRef(233, 233, 232)];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"个人资料";
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(Screen_Width));
        make.height.equalTo(@310);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    [self.tableView setTableFooterView:view];
    [self.tableView setTableHeaderView:view];
    
    
    [self.loginout setBackgroundColor:UIColorRef(229, 31, 18)];
    [self.loginout.layer setCornerRadius:5];
    
    _textArray = @[@"头像", @"昵称", @"性别", @"手机号", @"邮箱", @"真实姓名", @"修改密码"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    self.userShowName = [FFConfig currentConfig].userShowName;
    self.gender_Type = [[FFConfig currentConfig].userGender intValue];
    self.userPhoneNumber = [FFConfig currentConfig].userPhoneNumber;
    self.userEmailString = [FFConfig currentConfig].userEmail;
    self.userRealNameString = [FFConfig currentConfig].userRealName;

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark
#pragma mark - Other Action
- (void)backAction
{
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _textArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0.)
    {
        return 85;
    }
    else
    {
        return 45;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsZero;
    if (indexPath.row == 0)
    {
//        [cell.contentView setBackgroundColor:UIColorRef(233, 233, 233)];
    }
    switch (indexPath.row)
    {
        case 0:
        {
            [cell setPersonalText:[_textArray objectAtIndex:indexPath.row]  WithInfo:nil];
            [cell addHeadButton:[FFConfig currentConfig].userHeader];
            [cell.headBt addTarget:self action:@selector(selectIMageByAlert) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 1:
        {
             [cell setPersonalText:[_textArray objectAtIndex:indexPath.row]  WithInfo:[FFConfig currentConfig].userShowName];
        }
            break;
        case 2:
        {
            if(2 == [[FFConfig currentConfig].userGender intValue])
            {
                [cell setPersonalText:[_textArray objectAtIndex:indexPath.row]  WithInfo: @"女"];
            }
            else
            {
                [cell setPersonalText:[_textArray objectAtIndex:indexPath.row]  WithInfo: @"男"];
            }
        }
            break;
        case 3:
        {
            [cell setPersonalText:[_textArray objectAtIndex:indexPath.row]  WithInfo:[FFConfig currentConfig].userPhoneNumber];
        }
            break;
        case 4:
        {
            [cell setPersonalText:[_textArray objectAtIndex:indexPath.row]  WithInfo:[FFConfig currentConfig].userEmail];
        }
            break;
        case 5:
        {
            [cell setPersonalText:[_textArray objectAtIndex:indexPath.row]  WithInfo:[FFConfig currentConfig].userRealName];
        }
        case 6:
        {
            [cell setPersonalText:[_textArray objectAtIndex:indexPath.row]  WithInfo:@" "];
        }
            break;
        default:
            break;
    }
    return cell;
}
- (void)selectIMageByAlert
{
    UIActionSheet* mySheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"用户相册" otherButtonTitles:@"拍照", nil];
    mySheet.tag = 0x1;
    [mySheet showInView:self.view];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        [self selectIMageByAlert];
    }
    else if (1 == indexPath.row)
    {
        ChangeNameViewController * changeNameVC = [[ChangeNameViewController alloc]initWithNibName:nil bundle:nil];
        changeNameVC.userInfoString = [FFConfig currentConfig].userShowName;
        changeNameVC.gType = 0;
        changeNameVC.titleString = @"修改昵称";
        [self.navigationController pushViewController:changeNameVC animated:YES];
    }
    else if(2 == indexPath.row)
    {
        UIActionSheet* mySheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"男" otherButtonTitles:@"女", nil];
        mySheet.tag = 0x2;
        [mySheet showInView:self.view];

    }
    else if (3 == indexPath.row)
    {
        ChangeNameViewController * changeNameVC = [[ChangeNameViewController alloc]initWithNibName:nil bundle:nil];
        changeNameVC.userInfoString = [FFConfig currentConfig].userPhoneNumber;
        changeNameVC.gType = 1;
        changeNameVC.titleString = @"修改手机号码";
        [self.navigationController pushViewController:changeNameVC animated:YES];
    }
    else if (4 == indexPath.row)
    {
        ChangeNameViewController * changeNameVC = [[ChangeNameViewController alloc]initWithNibName:nil bundle:nil];
        changeNameVC.userInfoString = [FFConfig currentConfig].userEmail;
        changeNameVC.gType = 2;
        changeNameVC.titleString = @"修改邮箱";
        [self.navigationController pushViewController:changeNameVC animated:YES];
    }
    else if (5 == indexPath.row)
    {
        ChangeNameViewController * changeNameVC = [[ChangeNameViewController alloc]initWithNibName:nil bundle:nil];
        changeNameVC.userInfoString = [FFConfig currentConfig].userRealName;
        changeNameVC.gType = 3;
        changeNameVC.titleString = @"修改真实姓名";
        [self.navigationController pushViewController:changeNameVC animated:YES];
    }
    else if (6 == indexPath.row)
    {
        ChangePasswordNewViewController *changVC = [[ChangePasswordNewViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:changVC animated:YES];
    }
}
- (IBAction)loginoutAction:(id)sender
{    
    [FFConfig currentConfig].isLogined = @NO;
    [FFConfig currentConfig].needAutoLogin = @NO;
    [FFConfig currentConfig].nowUserId = @"";
    [FFConfig currentConfig].userRealName = @"";
    [FFConfig currentConfig].userShowName = @"";
    [FFConfig currentConfig].userNickName = @"";
    [FFConfig currentConfig].userGender = @0;
    [FFConfig currentConfig].userPhoneNumber = @"";
    [FFConfig currentConfig].userEmail = @"";

    
    VisitorViewController *wVC = [[VisitorViewController alloc] initWithNibName:@"VisitorViewController" bundle:nil];
    UINavigationController *mNav = [[UINavigationController alloc] initWithRootViewController:wVC];
    [AppDelegate currentAppDelegate].window.rootViewController = mNav;
}

- (void)removeBlackView
{
    [maskView removeFromSuperview];
}
- (void)takePhoto
{
    if((AVAuthorizationStatusAuthorized == [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]) || (AVAuthorizationStatusNotDetermined == [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]))
    {
        self.imagePicController = [[UIImagePickerController alloc]init];
        self.imagePicController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicController.delegate = self;
        [self presentViewController:self.imagePicController animated:YES completion:^{}];
        self.imagePicController = nil;
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"由于iOS系统的安全限制，该功能需要开启照片服务，打开照片服务步骤，设置－>隐私－>相机->开启" delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}
- (void)shoosePhoto
{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if ((ALAuthorizationStatusNotDetermined == status) || (ALAuthorizationStatusAuthorized == status) )
    {
        [self launchController];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"由于iOS系统的安全限制，该功能需要开启照片服务，打开照片服务步骤，设置－>隐私－>照片->开启" delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}
- (NSInteger)ageWithDateOfBirth:(NSDate *)date;
{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSInteger brithDateYear = [components1 year];
    NSInteger brithDateDay = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear = [components2 year];
    NSInteger currentDateDay = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay))
    {
        iAge++;
    }
    return iAge;
}
- (void)launchController
{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 1;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}
#pragma mark
#pragma mark - System Delegate & Datasource
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0x1 == actionSheet.tag)
    {
        if (0 == buttonIndex)
        {
            [self shoosePhoto];
        }
        else if (1 == buttonIndex)
        {
            [self takePhoto];
        }
        else
        {
            return;
        }
    }
    else if (0x2 == actionSheet.tag)
    {
        if (0 == buttonIndex)
        {
            self.gender_Type = Choose_Gender_Type_Male;
        }
        else if (1 == buttonIndex)
        {
            self.gender_Type = Choose_Gender_Type_FMale;
        }
        [self saveAction:self.gender_Type];
        
    }
    [self.tableView reloadData];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [CommanHelp saveImage:image withFileName:HEADERIMAGE ofType:@"png" inDirectory:[CommanHelp getDocmentsDirectory]];
    [self.tableView reloadData];
    [self uploadImage:image];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
- (void)uploadImage:(UIImage *)image
{
    [self addProgressHUD];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"avatar"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSData *tData = UIImageJPEGRepresentation(image, 0.5);
    NSString *tString = [tData base64Encoding];
    
    NSDictionary *parameters = @{@"avatar":tString,@"private_code":[FFConfig currentConfig].privateCode};
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        [self hidenProgress];
        
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (errorCode != 2000)
        {
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"头像上传成功" posY:100];
            [tTip show];
            [FFConfig currentConfig].userHeader = [resultDic[@"data"] objectForKey:@"avatar"];
            [self.tableView reloadData];
        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
            [tTip show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        [self hidenProgress];
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
        [tTip show];
        return;
    }];
}
#pragma mark
#pragma mark - Other Delegate & Datasource
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    NSDictionary * dic = [info objectAtIndex:0];
    UIImage * img = [dic objectForKey:UIImagePickerControllerOriginalImage];
    [CommanHelp saveImage:img withFileName:HEADERIMAGE ofType:@"png" inDirectory:[CommanHelp getDocmentsDirectory]];
    [self.tableView reloadData];
    [self uploadImage:img];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
- (void)changeName:(NSString *)userName andType:(NSInteger)type
{
    if (type == 0)
    {
        self.userShowName = userName;
    }
    else if (type == 1)
    {
        self.userPhoneNumber = userName;
    }
    else if (type == 2)
    {
        self.userEmailString = userName;
    }
    else if (type == 3)
    {
        self.userRealNameString = userName;
    }
    [self.tableView reloadData];
}
- (void)addProgressHUD
{
    [self.view addSubview:self.progressHUD];
}
- (void)hidenProgress
{
    [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
}
- (void)saveAction:(NSInteger )gender
{
    [self addProgressHUD];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"modify"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
//    NSString *userName = [FFConfig currentConfig].userShowName;
    NSString *userPhone = [FFConfig currentConfig].userPhoneNumber;
    NSString *userEmail = [FFConfig currentConfig].userEmail;
    NSString *userRealName = [FFConfig currentConfig].userRealName;
    NSString *userSex = @"male";
    if (gender != 1)
    {
        userSex = @"female";
    }
    NSDictionary *parameters = @{@"id":[FFConfig currentConfig].userId, @"avatar":@"",@"mobile":userPhone, @"email":userEmail,@"name":userRealName,@"sex":userSex,@"old_password":[FFConfig currentConfig].password,@"password":[FFConfig currentConfig].password,@"private_code":[FFConfig currentConfig].privateCode};
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        [self hidenProgress];
        
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (!errorCode)
        {
            [FFConfig currentConfig].userGender = @(gender);
            [self.tableView reloadData];
        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
            [tTip show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        [self hidenProgress];
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
        [tTip show];
        return;
    }];
}


@end
