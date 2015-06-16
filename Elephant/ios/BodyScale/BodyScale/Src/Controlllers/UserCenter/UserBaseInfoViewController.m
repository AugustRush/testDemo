//
//  UserBaseInfoViewController.m
//  BodyScale
//
//  Created by August on 14-10-11.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "UserBaseInfoViewController.h"
#import "LeftTableViewCell.h"
#import "FillInfoViewController.h"
#import "ChatListViewController.h"
#import "SettingViewController.h"
#import "VisitorViewController.h"
#import "UIButton+WebCache.h"

#define kMenuCellReuseIdentifier @"MenuCell"
#define kDefaultIdentifier       @"kDefaultIdentifier"

@interface UserBaseInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) HeaderButton *headerBtn;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *isLoginLabel;

@property (nonatomic, strong) NSMutableArray *menuNames;
@property (nonatomic, strong) NSMutableArray *menuImgs;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SettingButton *settingBt;
@property (weak, nonatomic) IBOutlet UIView *SettingBg;

@end

@implementation UserBaseInfoViewController
#pragma mark
#pragma mark - Init & Dealloc
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(baseConfigs) name:@"updateUserInfo" object:nil];
    }
    return self;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(baseConfigs) name:@"updateUserInfo" object:nil];
    }
    return self;
}
-(void)dealloc
{
}
- (UIView *)topView
{
    if (!_topView)
    {
        _topView = [[UIView alloc] init];
        _topView.frame = CGRectMake(0, 0, self.view.frame.size.width, 94);
        [self.view addSubview:_topView];
    }
    return _topView;
}
- (UILabel *)userNameLabel
{
    if (!_userNameLabel)
    {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = [UIColor whiteColor];
        _userNameLabel.frame = CGRectMake(96, 24, 116, 21);
        _userNameLabel.font = [UIFont systemFontOfSize:17.0f];
        [self.topView addSubview:_userNameLabel];
    }
    return _userNameLabel;
}
- (UILabel *)isLoginLabel
{
    if (!_isLoginLabel)
    {
        _isLoginLabel = [[UILabel alloc] init];
        _isLoginLabel.text = @"注册用户";
        _isLoginLabel.textColor = [UIColor whiteColor];
        _isLoginLabel.frame = CGRectMake(96, 56, 116, 21);
        _isLoginLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.topView addSubview:_isLoginLabel];
    }
    return _isLoginLabel;
}
- (HeaderButton *)headerBtn
{
    if (!_headerBtn)
    {
        _headerBtn = [HeaderButton buttonWithType:UIButtonTypeCustom];
        _headerBtn.backgroundColor = [UIColor clearColor];
        [self.topView addSubview:_headerBtn];
        _headerBtn.frame = CGRectMake(21, 20, 60, 60);
        [_headerBtn.layer setMasksToBounds:YES];
        [_headerBtn.layer setCornerRadius:30];
        [_headerBtn.layer setBorderWidth:1];
        [_headerBtn.layer setBorderColor:[UIColor clearColor].CGColor];
        [_headerBtn addTarget:self action:@selector(selectHeadBt:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerBtn;
}
#pragma mark
#pragma mark - System Action
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self baseConfigs];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark
#pragma mark - Other Action
-(void)baseConfigs
{
    DLog(@"msg_lyywhg:usr name~~%@", [FFConfig currentConfig].userShowName);
    self.userNameLabel.text = [FFConfig currentConfig].userShowName;
    if ([[FFConfig currentConfig].isLogined boolValue] == YES)
    {
        self.isLoginLabel.text = @"注册用户";
    }
    else
    {
        self.isLoginLabel.text = @"访客";
    }
    self.navigationController.navigationBarHidden = YES;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(-10,-10,Screen_Width+20,Screen_Height+40)];
    [bgImgView setImage:[[UIImage imageNamed:@"leftBg"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    bgImgView.userInteractionEnabled = YES;
    [self.view addSubview:bgImgView];
    [self.view sendSubviewToBack:bgImgView];
    self.view.userInteractionEnabled = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leftBg"]];
    self.menuNames = [NSMutableArray arrayWithObjects:@"体测",@"数据统计",@"用户管理",@"访客模式"/*, @"消息"*/, nil];
    self.menuImgs = [NSMutableArray arrayWithObjects:@"body",@"data",@"userManager",@"userMode"/*, @"userMessage"*/,nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LeftTableViewCell" bundle:nil] forCellReuseIdentifier:kMenuCellReuseIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(100, 0, -40, 0));
    }];
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    [self.tableView setTableFooterView:view];
    [self.tableView setTableHeaderView:view];
    
    [self.headerBtn sd_setImageWithURL:[NSURL URLWithString:[FFConfig currentConfig].userHeader] forState:UIControlStateNormal  placeholderImage:[UIImage imageNamed:@"DefaultHeader.png"]];

//    [self.bottomView setWithBigHeaderView:[FFConfig currentConfig].userHeader];
    
    SettingButton *settingBtn = [[SettingButton alloc] init];
    [settingBtn setImage:[UIImage imageNamed:@"setting"] WithText:@"设置"];
    [settingBtn addTarget:self action:@selector(selectSetting:) forControlEvents:UIControlEventTouchUpInside];
    settingBtn.frame = CGRectMake(-25, self.view.frame.size.height - 40, 150, 30);
    [self.view addSubview:settingBtn];
}
- (IBAction)selectHeadBt:(id)sender
{//这个地方
    if ([[FFConfig currentConfig].isLogined boolValue] == NO)
    {
        VisitorViewController *visitorVC = [[VisitorViewController alloc]initWithNibName:@"VisitorViewController" bundle:nil];
        [self.navigationController pushViewController:visitorVC animated:YES];
        return;
    }
    [self.sideMenuViewController hideMenuViewController];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[PersonaViewController alloc] initWithNibName:@"PersonaViewController" bundle:nil]] animated:YES];
}

- (IBAction)selectSetting:(id)sender
{
    [self.sideMenuViewController hideMenuViewController];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil]] animated:YES];
}

#pragma mark
#pragma mark - System Delegate & Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuNames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: kMenuCellReuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [cell updateWithImg:[UIImage imageNamed:self.menuImgs[indexPath.row]] WithText:self.menuNames[indexPath.row]];
    cell.separatorInset = UIEdgeInsetsMake(0, -10, 0, 10);
    UILabel *tLabel  = [[UILabel alloc] init];
    tLabel.backgroundColor = [UIColor whiteColor];
    [cell addSubview:tLabel];
    tLabel.frame = CGRectMake(0, 59.5, 200, 0.5);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    switch (indexPath.row)
    {
        case 0:
        {
            [self.sideMenuViewController setContentViewController:[[CenterViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
        }
            break;
        case 1:
        {
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[DataStatisticsViewController alloc] init]] animated:YES];
        }
            break;
        case 2:
        {
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[UserGroupManagerViewController alloc] initWithNibName:@"UserGroupManagerViewController" bundle:nil]] animated:YES];
        }
            break;
        case 3:
        {
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[FillInfoViewController alloc] initWithNibName:@"FillInfoViewController" bundle:nil]] animated:YES];
        }
            break;
//        case 4:
//        {
//            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"功能尚未开发" posY:100];
//            [tTip show];
//            return;
//            ChatListViewController *chatListVC = [[ChatListViewController alloc] init];
//            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:chatListVC] animated:YES];
//        }
//            break;
        default:
            break;
    }
}
@end