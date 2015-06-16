//
//  SettingViewController.m
//  BodyScale
//
//  Created by cxx on 14-11-21.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "SettingViewController.h"
#import "AFNetworking.h"
@interface SettingViewController ()
{
    NSArray *_textArray;
}
@end

@implementation SettingViewController

#pragma mark life circle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ishasTextFeild:NO];
    if (self)
    {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorRef(232, 233, 232);
    _textArray = @[/*@"版本更新",*/@"关于我们",@"用户反馈",@"帮助",@"给应用评分"];
    
    self.navigationItem.title = @"设置";
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];

    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    [self.tableView setTableFooterView:view];
    self.tableView.scrollEnabled = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _tableView.scrollEnabled = YES;
        _tableView.userInteractionEnabled = YES;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor =RGBCOLOR(225, 225, 225);
        _tableView.backgroundView = nil;
        [self.view addSubview:_tableView];

    }
    return _tableView;
}

- (void)backAction
{
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark private method
- (void)getNewVersion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"getVersion"];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[self hidenProgress];
        
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (!errorCode)
        {
            NSDictionary * codeDic = [resultDic objectForKey:@"data"];
            NSString * versionStr =    [codeDic objectForKey:@"version"];
            NSString * versionDoc =    [codeDic objectForKey:@"info"];
            NSString * versionUrl =  [codeDic objectForKey:@"url"];
            BOOL hasNewVer =  [CommanHelp isHasNewVersion:versionStr];
            if (hasNewVer)
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"更新检查" message:@"您使用的已经是最新版本。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"暂不更新",nil];
                [alert show];
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"更新检查" message:@"您使用的已经是最新版本。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
            //[[NSUserDefaults standardUserDefaults] setValue:codeStr forKey:VERIFICATIONCODE];
        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[self hidenProgress];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络错误" message:@"您的网络出问题了，请检查。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }];
    
}

#pragma mark TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (SettingCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.separatorInset = UIEdgeInsetsZero;
    [cell setText:[_textArray objectAtIndex:indexPath.row] WithIndexNum:indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_textArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row)
    {
//        case 0:
//        {
//            [self getNewVersion];
//        }
//            break;
        case 0:
        {
            //[self.navigationController pushViewController:[[AboutUsViewController alloc]initWithNibName:@"AboutUsViewController" bundle:nil] animated:YES];
            DLog(@"去了解关于我们");
            AboutUsViewController *auvc = [[AboutUsViewController alloc]initWithNibName:@"AboutUsViewController" bundle:nil];
            [self.navigationController pushViewController:auvc animated:YES];
        }
            break;
        case 1:
        {
            DLog(@"去给我们建议");
            [self.navigationController pushViewController:[[FeedBackViewController alloc] initWithNibName:@"FeedBackViewController" bundle:nil] animated:YES];
        }
            break;
        case 2:
        {
            DLog(@"去帮助页面");
            HelpViewController *helpVC = [[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
            [self.navigationController pushViewController:helpVC animated:YES];
        }
        default:
            break;
    }
}



@end
