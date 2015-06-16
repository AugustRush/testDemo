//
//  UserManagerViewController.m
//  BodyScale
//
//  Created by cxx on 14-11-29.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "UserGroupManagerViewController.h"
#import "UserManagerCell.h"
#import "FillInfoViewController.h"
#import "UIButton+WebCache.h"
#import "AFHTTPRequestOperationManager.h"

@interface UserGroupManagerViewController ()<MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MBProgressHUD *progressHUD;
@property (nonatomic, strong) NSMutableArray *gCurrentList;
@property (nonatomic, strong) NSMutableArray *gOtherList;

@end

@implementation UserGroupManagerViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ishasTextFeild:NO];
    if (self)
    {
    }
    return self;
}
- (MBProgressHUD *)progressHUD
{
    if (!_progressHUD)
    {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view bringSubviewToFront:_progressHUD];
        _progressHUD.delegate = self;
        [_progressHUD show:YES];
    }
    return _progressHUD;
}
- (NSMutableArray *)gCurrentList
{
    if (!_gCurrentList)
    {
        _gCurrentList = [[NSMutableArray alloc] init];
    }
    return _gCurrentList;
}
- (NSMutableArray *)gOtherList
{
    if (!_gOtherList)
    {
        _gOtherList = [[NSMutableArray alloc] init];
    }
    return _gOtherList;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"用户管理";
   
    [self.view setBackgroundColor:UIColorRef(233, 233, 233)];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0.0, 0.0,42, 20);
    [right setTitle:@"添加" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:right];
    temporaryBarButtonItem1.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = temporaryBarButtonItem1;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UserManagerCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    [self.tableView setTableFooterView:view];
    [self.tableView setTableHeaderView:view];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAllInfo];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)backAction
{
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (void)rightAction
{
   [self.navigationController pushViewController:[[FillInfoViewController alloc] initWithNibName:@"FillInfoViewController" bundle:nil] animated:YES];
}
- (void)getAllInfo
{
    UserInfoManager *tUser = [UserInfoManager sharedInstance];

    if (tUser.userLoginArray.count > 0)
    {
        [self.gCurrentList removeAllObjects];
        [self.gOtherList removeAllObjects];
        for (NSDictionary *tDict in tUser.userLoginArray)
        {
            if ([[FFConfig currentConfig].nowUserId intValue] == [tDict[@"userInfoId"] intValue])
            {
                [self.gCurrentList addObject:tDict];
            }
            else
            {
                [self.gOtherList addObject:tDict];
            }
        }
    }
    [self.tableView reloadData];
}

#pragma mark --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.gOtherList.count > 0)
    {
        return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.gCurrentList.count;
    }
    return self.gOtherList.count;
}
- (UserManagerCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserManagerCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell"];
    NSMutableDictionary *tDict= [[NSMutableDictionary alloc] init];
    if (indexPath.section == 0)
    {
        [tDict addEntriesFromDictionary:self.gCurrentList[indexPath.row]];
    }
    else
    {
        DLog(@"msg_lyywhg:~~ row ~ %d", indexPath.row);
        [tDict addEntriesFromDictionary:self.gOtherList[indexPath.row]];
    }
    cell.userNameLb.text = tDict[@"userInfoNickName"];
    cell.weightLb.text = [NSString stringWithFormat:@"身高%@cm", tDict[@"userInfoHeight"]];
    cell.tizhiLb.text = [NSString stringWithFormat:@"年龄%@岁", tDict[@"userInfoAge"]];
    cell.preTiLiangLb.text = [NSString stringWithFormat:@"上次测量%@", tDict[@"userRealLastTime"]];
    [cell.headBt sd_setImageWithURL:[NSURL URLWithString:tDict[@"userInfoHeader"]] forState:UIControlStateNormal  placeholderImage:[UIImage imageNamed:@"DefaultHeader.png"]];
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSMutableDictionary *tDict= [[NSMutableDictionary alloc] init];
//    if (indexPath.section == 0)
//    {
//    }
//    else
//    {
//        [tDict addEntriesFromDictionary:self.gOtherList[indexPath.row]];
//        [FFConfig currentConfig].nowUserId = [NSString stringWithFormat:@"%d", [tDict[@"userInfoId"] intValue]];
//        [self.gOtherList removeObject:tDict];
//        [self.gOtherList addObjectsFromArray:self.gCurrentList];
//        [self.gCurrentList removeAllObjects];
//        [self.gCurrentList addObject:tDict];
//        [self.tableView reloadData];
//    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UILabel *lb ;
        lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, Screen_Width, 30)];
        lb.text = @"  当前用户";
        [lb setFont:[UIFont boldSystemFontOfSize:14]];
        [lb setBackgroundColor:[UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0f]];
        return lb;
    }
    UILabel *lb ;
    lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, Screen_Width, 30)];
    lb.text = @"  其他用户";
    [lb setFont:[UIFont boldSystemFontOfSize:14]];
    [lb setBackgroundColor:[UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0f]];
    return lb;
}

-(void)getUserInfoById:(NSString *)idString
{
    [self addProgressHUD];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"getUserInfo"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"id":idString,@"private_code":[FFConfig currentConfig].privateCode};
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        [self hidenProgress];
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (!errorCode)
        {
            NSDictionary * codeDic = [resultDic objectForKey:@"data"];
            [FFConfig currentConfig].userId = [codeDic objectForKey:@"user_id"];
            [FFConfig currentConfig].userShowName = [codeDic objectForKey:@"username"];
            [FFConfig currentConfig].userHeader = codeDic[@"avatar"];
            [FFConfig currentConfig].userEmail = codeDic[@"email"];
            [FFConfig currentConfig].userPhoneNumber = codeDic[@"mobile"];
            [FFConfig currentConfig].userNickName = [codeDic objectForKey:@"name"];
            if ([[codeDic objectForKey:@"sex"] isEqualToString:@"female"])
            {
                [FFConfig currentConfig].userGender = @1;
            }
            else
            {
                [FFConfig currentConfig].userGender = @0;
            }
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
- (void)addProgressHUD
{
    [self.view addSubview:self.progressHUD];
}

- (void)hidenProgress
{
    [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
}
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [self.progressHUD removeFromSuperview];
}

@end
