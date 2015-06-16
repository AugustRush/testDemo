//
//  DataDetailViewController.m
//  BodyScale
//
//  Created by Go Salo on 14-3-4.
//  Copyright (c) 2014年 于菲. All rights reserved.
//

#import "DataDetailViewController.h"
#import "CircleFormView.h"
#import "UserDataEntity.h"
#import "RegisterViewController.h"
#import "DataDetailTableViewCell.h"
#import "ScaleUserDataEntity.h"
#import "ScaleRealTimeWeightEntity.h"
#import "UIViewController+MMDrawerController.h"
#import "BTModel.h"
#import "CalculateTool.h"
#import "NSObject+HUD.h"
#import "AQAlertView.h"
#import "ICRunwayView.h"
#import "AQTrendingViewController.h"
#import "HistoryDataViewController.h"
#import "BaseNavigationController.h"
#import "BodyFatHistoryViewController.h"
#import "CalculateDisplayViewUtil.h"
#import "NewShareViewViewController.h"
#import "BuyRyfitMainController.h"
#import "ModifyUserNameViewController.h"
#import <AudioToolbox/AudioServices.h>
#import "AppDelegate.h"

typedef NS_ENUM(NSInteger, ViewState) {
    ViewStateConnecting,
    ViewStateConnected,
    ViewStateBLESystemPowerOff,
    ViewStateResult,
    ViewStateLastData
};

@interface DataDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView         *circleViewBackground;
@property (weak, nonatomic) IBOutlet UITableView    *tableView;
@property (weak, nonatomic) IBOutlet UILabel        *tipsLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *errorImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *connectingImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *connectingRotationImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong)CircleFormView *circleFormView;
@property (nonatomic, strong)NSArray *dataSource;

@property (nonatomic, strong)UIControl *indicator;
@property (nonatomic, strong)UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UIButton *roundAboutBt;
@property (weak, nonatomic) IBOutlet UIImageView *roundAboutImage;

@property (nonatomic, retain) UILabel *yaoShareLabel;

@end

@implementation DataDetailViewController {
    UserDataEntity  *_userDataEntity;
    UserInfoEntity  *_userInfoEntity;
    NSArray         *_values;
    BOOL            _isAnimation;
    FlowType        _type;
    
    UIButton        *_homeButton;
    NSMutableArray  *_typeButtonImages;
}

#pragma mark - Life Circle
- (void)dealloc {
    [[FlowManager sharedInstance] popToFlow];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:kAlipayNotificationName
                                                 object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
       userInfoEntity:(UserInfoEntity *)userInfoEntity
                 type:(FlowType)type {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _type = type;
        _userInfoEntity = userInfoEntity;
        [self loadImages];
        
        switch (_type) {
            case FlowTypeUser: {
                _userDataEntity = userInfoEntity.UI_lastUserData;
                self.title = userInfoEntity.UI_nickname;
                
            }
                break;
            case FlowTypeGuest: {
                
            }
                break;
            default:
                _userDataEntity = nil;
                break;
        }
        
        [[FlowManager sharedInstance] pushToFlowWithType:_type userInfo:userInfoEntity];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configXib];
    [self reloadData];

    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    //引导层
    if ([[NSUserDefaults standardUserDefaults] objectForKey:APPISNotFirstEnter]) {
        
    }else{
        self.indicator = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.indicator.userInteractionEnabled = YES;
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        if (SCREEN_HEIGHT>480) {
           self.imgView.image = [UIImage imageNamed:@"indicator1.png"];
        }else{
            self.imgView.image = [UIImage imageNamed:@"indicator3.5.png"];
        }
        [self.indicator addTarget:self action:@selector(indicatorAction:) forControlEvents:UIControlEventTouchUpInside];
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        [keyWindow addSubview:self.indicator];
        [self.indicator addSubview:self.imgView];

    }

    [self performSelector:@selector(checkVersion) withObject:nil afterDelay:3];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemBluetoothStateUpdate:) name:BTSERVICE_NOTIFICATION_CENTRALMANAGERDIDUUPDATESTATE object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemBluetoothDidConnected) name:BTSERVICE_NOTIFICATION_CONNECTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemBluetoothDidDisconnected) name:BTSERVICE_NOTIFICATION_DISCONNECT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btInitDataSuccess) name:BT_DATA_INITAIL_FINISHED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btInitDataFailed) name:BT_DATA_INITAIL_FAILED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nickNameDidChange) name:NickNameDidChangeNotification object:nil];
    
    switch (_type) {
        case FlowTypeUser: {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kIMLoginDataOk object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailue:) name:kIMLoginDataFailure object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataData:) name:kIMDataChanged object:nil];
            
            // 设置蓝牙状态提示初始状态
            if ([BTModel sharedInstance].isConnecting) {
                if ([BTModel sharedInstance].peripheralDataPrepareOK) {
                    self.tipsLabel.text = @"连接成功，请上秤";
                } else {
                    self.tipsLabel.text = @"正在同步数据，请稍候...";
                }
            } else {
                if ([BTModel sharedInstance].managerState == CBCentralManagerStatePoweredOff) {
                    self.tipsLabel.text = @"系统蓝牙已关闭，请在设置->蓝牙中打开蓝牙";
                } else {
                    self.tipsLabel.text = @"正在连接设备，请稍候...";
                }
            }

        }
            break;
        case FlowTypeGuest: {
            UIImage *image = [UIImage imageNamed:@"guestshoppingcart"];
            [self buildBarButtonItemIn:BaseViewControllerBarButtonItemPositionRight withImage:image];
            self.roundAboutBt.hidden = YES;
            self.roundAboutImage.hidden = YES;
            // 设置蓝牙状态提示初始状态
            if ([BTModel sharedInstance].isConnecting) {
                self.tipsLabel.text = @"连接成功，请上秤";
            } else {
                if ([BTModel sharedInstance].managerState == CBCentralManagerStatePoweredOff) {
                    self.tipsLabel.text = @"系统蓝牙已关闭，请在设置->蓝牙中打开蓝牙";
                } else {
                    self.tipsLabel.text = @"正在连接设备，请稍候...";
                }
            }
        }
            break;
        case FlowTypeRegister: {
            // 设置蓝牙状态提示初始状态
            if ([BTModel sharedInstance].isConnecting) {
                self.tipsLabel.text = @"连接成功，请上秤";
            } else {
                if ([BTModel sharedInstance].managerState == CBCentralManagerStatePoweredOff) {
                    self.tipsLabel.text = @"系统蓝牙已关闭，请在设置->蓝牙中打开蓝牙";
                } else {
                    self.tipsLabel.text = @"正在连接设备，请稍候...";
                }
            }
        }
            break;
        default:
            break;
    }
   
//    if (_type == FlowTypeGuest) {
//        self.roundAboutBt.hidden = YES;
//    }else{
//        self.roundAboutBt.hidden = NO;
//    }
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(aliPayCallback:)
                                                name:kGetAlipayNotificationName
                                              object:nil];
    
    self.yaoShareLabel = [[UILabel alloc] init];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveScaleData:) name:REALTIME_USERDATA_RESPONSE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveRealTimeWeightData:) name:REALTIME_WEIGHT_RESPONSE object:nil];
    
    switch (_type) {
        case FlowTypeUser: {
            
            
            [self buildBarButtonItemIn:BaseViewControllerBarButtonItemPositionLeft withImagePath:_userInfoEntity.UI_photoPath gender:[_userInfoEntity.UI_sex intValue]];
            
        }
            break;
        case FlowTypeGuest: {
            // 个性化视图
            
            UIImage *homeButtonImage = [UIImage imageNamed:@"guestbuttonimage_normal.png"];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:homeButtonImage forState:UIControlStateNormal];
            
//            CGFloat y = 5;
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
//                y += 20;
//            }
            
            [button setFrame:CGRectMake((SCREEN_WIDTH - homeButtonImage.size.width) / 2, 0, homeButtonImage.size.width, homeButtonImage.size.height)];
            [button addTarget:self action:@selector(homeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationController.navigationBar addSubview:button];
            _homeButton = button;
        }
            break;
            
        default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     [self becomeFirstResponder];
    
    self.tableView.frame = CGRectMake(self.tableView.left, self.tableView.top, self.tableView.width, SCREEN_HEIGHT - 20 - 44);


}

- (void)viewWillDisappear:(BOOL)animated {

     [self resignFirstResponder];

    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:REALTIME_USERDATA_RESPONSE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:REALTIME_WEIGHT_RESPONSE object:nil];
    [_homeButton removeFromSuperview];
}

- (void)configXib {
    // TableView Header
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
    view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    UIImage *image = [UIImage imageNamed:@"shangla.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake((view.width - image.size.width) / 2,
                                   (view.height - image.size.height) / 2,
                                   image.size.width,
                                   image.size.height)];
    [view addSubview:imageView];
    [self.tableView addSubview:view];
    
    // 图表
    CircleFormView *circleFormView = [[CircleFormView alloc] initWithFrame:self.circleViewBackground.bounds];
    [self.circleViewBackground addSubview:circleFormView];
    self.circleFormView = circleFormView;
    
    // 注册流程 Title显示名字     使用流程 Title显示跑马灯
    switch (_type) {
        case FlowTypeUser: {
            [self buildBarButtonItemIn:BaseViewControllerBarButtonItemPositionRight withImage:[UIImage imageNamed:@"menu.png"]];
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark - Private Method
- (void)reloadData {
    // 计算Ryfit指数
    CGFloat ryfit = [CalculateTool calculateRyFitWithUserInfo:_userInfoEntity data:_userDataEntity];
    
    if (ryfit == -1) {
        if (_userDataEntity) {
            self.errorImageView.image = [UIImage imageNamed:@"tanhao.png"];
            [self.circleFormView setItemName:@"数据异常" dataNum:-1 percentage:0];
        } else {
            self.errorImageView.image = [UIImage imageNamed:@"warning.png"];
            [self.circleFormView setItemName:@"" dataNum:-1 percentage:0];
        }
        
        self.errorImageView.hidden = NO;
    } else if (ryfit >= 0 && ryfit <= 100) {
        [self.circleFormView setItemName:@"RyFit 指数" dataNum:ryfit percentage:ryfit];
        self.errorImageView.hidden = YES;
    } else {
        NSAssert(1, @"RyFit指数计算错误");
    }
    
    // 计算 十项数据
    _values = [CalculateTool calculatePhysicalCharacteristicsByData:_userDataEntity withUserEnitty:_userInfoEntity];
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)homeButtonAction:(UIButton *)button {
    BSMainViewController *rootVC = (BSMainViewController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    [rootVC closeDrawerAnimated:NO completion:NULL];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)tapRunView:(UITapGestureRecognizer *)tap {
    BodyFatHistoryViewController *cloudLineVC = [[BodyFatHistoryViewController alloc] initWithNibName:@"BodyFatHistoryViewController" bundle:nil];
    BaseNavigationController *cloudLineNavVC = [[BaseNavigationController alloc] initWithRootViewController:cloudLineVC];
    cloudLineNavVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    MMDrawerController *mmd = self.mm_drawerController;
    [mmd presentViewController:cloudLineNavVC animated:YES completion:nil];
    
    [Flurry logEvent:@"主页" withParameters:@{@"导航栏滚动文本":@"弹出时间线"} timed:YES];
}

- (IBAction)roundaboutButtonAction:(id)sender {
    if (self.tableView.contentOffset.y < -214 && !_isAnimation) {
        AQAlertView *alertView = [[AQAlertView alloc] initWithTitle:@""
                                                            message:@"RyFit指数是根据各项指数计算，综合反应您健康状况的分值。满分为100，分值越高越好哦！"
                                                 confirmButtonTitle:@"知道了"
                                                        cancelTitle:nil];
        [alertView show];
    }
    
    [Flurry logEvent:@"主页" withParameters:@{@"RyFit指数按钮":@"弹出提示"} timed:YES];
}

- (void)rightBarButtonAction:(id)sender {
    switch (_type) {
        case FlowTypeUser: {
            switch (self.mm_drawerController.openSide) {
                case MMDrawerSideNone:
                    [self.mm_drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:NULL];
                    [Flurry logEvent:@"主页" withParameters:@{@"导航栏右边按钮":@"打开侧边栏"} timed:YES];
                    break;
                case MMDrawerSideLeft:
                    break;
                case MMDrawerSideRight:
                    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
                    [Flurry logEvent:@"主页" withParameters:@{@"导航栏右边按钮":@"关闭侧边栏"} timed:YES];
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case FlowTypeRegister: {
            _userInfoEntity.UI_lastUserData = _userDataEntity;
            RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil userInfoEntity:_userInfoEntity isForgetPassword:NO type:FlowTypeRegister];
            [self.navigationController pushViewController:registerVC animated:YES];
        }
            break;
        case FlowTypeGuest: {
            /*
            BuyRyfitMainController *buyRyfitMainVC = [[BuyRyfitMainController alloc] init];
            [self.navigationController pushViewController:buyRyfitMainVC animated:YES];
            */
            BuyRyfitMainController *_BRMainVC = [[BuyRyfitMainController alloc] init];
            _BRMainVC.pareantId = 2;
            BaseNavigationController *messageNav = [[BaseNavigationController alloc] initWithRootViewController:_BRMainVC];
            [self presentViewController:messageNav animated:YES completion:NULL];
           
        }
            break;
        default:
            break;
    }
}

- (void)leftBarButtonAction:(id)sender {
    switch (self.mm_drawerController.openSide) {
        case MMDrawerSideNone:
            [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:NULL];
            [Flurry logEvent:@"主页" withParameters:@{@"导航栏左边按钮":@"打开左侧边栏"} timed:YES];
            break;
        case MMDrawerSideLeft:
            [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
            [Flurry logEvent:@"主页" withParameters:@{@"导航栏左边按钮":@"关闭左侧边栏"} timed:YES];
            break;
        case MMDrawerSideRight:
            break;
            
        default:
            break;
    }
}

- (void)indicatorAction:(id)sender
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:APPISNotFirstEnter]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:APPISNotFirstEnter];
    }

    [UIView animateWithDuration:2 animations:^{
        [self.indicator removeFromSuperview];
        [self.imgView removeFromSuperview];
    }];

    [self checkVersion];



}

#pragma mark - Notification

-(void)aliPayCallback:(NSNotification *)aNotif
{
    
    
    
    NSDictionary *_info     = [aNotif userInfo];
    NSDictionary *_uInfo    = nil;
    if (_info) {
        _uInfo = _info[@"userInfo"];
        if (![@"2" isEqualToString: _uInfo[@"pid"]]) {
            return;
        }
    }
    
    
    
    
    int _tp     = _info[@"r"]?[(NSString *)_info[@"r"] intValue]:0;
    int _tpF    = _tp / 10;
    _tp         = _tp % 10;
    
    _tpF    = abs(_tpF);
    //_tp     = abs(_tp);
    
    if ( _tpF == 1) {
        
        
        
        // 没有安装支付宝时回调到这里
        // 由于支付宝开发SDK的人脑残，导致我不得不进行如下处理
        [[[UIApplication sharedApplication] keyWindow]
         addSubview:self.presentedViewController.view];
        [self.presentedViewController
         dismissViewControllerAnimated:NO
         completion:^{
             
             switch (_tp) {
                 case -1:
                 {
                     BuyRyfitMainController *_BRMainVC = [[BuyRyfitMainController alloc] init];
                     _BRMainVC.pareantId    = 2;
                     BaseNavigationController *messageNav = [[BaseNavigationController alloc] initWithRootViewController:_BRMainVC];
                     [self presentViewController:messageNav animated:YES completion:NULL];
                 }
                     break;
                 case 0:
                 {
                     
                     BuyRyfitMainController *_BRMainVC = [[BuyRyfitMainController alloc] init];
                     _BRMainVC.isToResult   = 2;
                     _BRMainVC.pareantId = 2;
                     BaseNavigationController *messageNav = [[BaseNavigationController alloc] initWithRootViewController:_BRMainVC];
                     [self presentViewController:messageNav animated:YES completion:NULL];
                     
                 }
                     break;
                 case 1:
                 {
                     
                     
                     
                     
                     BuyRyfitMainController *_BRMainVC = [[BuyRyfitMainController alloc] init];
                     _BRMainVC.orderNo      = _uInfo[@"orderNo"];
                     _BRMainVC.password     = _uInfo[@"password"];
                     _BRMainVC.username     = _uInfo[@"username"];
                     _BRMainVC.isToResult   = 3;
                     _BRMainVC.pareantId    = 2;
                     
                     BaseNavigationController *messageNav = [[BaseNavigationController alloc] initWithRootViewController:_BRMainVC];
                     [self presentViewController:messageNav animated:YES completion:NULL];
                     
                     
                     /*
                      BR_payResultController *_prVc = [[BR_payResultController alloc] initWithNibName:@"BR_payResultController" bundle:nil];
                      _prVc.tp        = 1;
                      _prVc.tradeNo   = _orderNo;
                      _prVc.url       = [NSString stringWithFormat:@"http://demo.ichronocloud.com/shop/external!orderDetail.action?username=%@&password=%@&orderSn=%@",
                      _username,
                      _password,
                      _orderNo];
                      [self.navigationController pushViewController:_prVc animated:YES];
                      */
                     
                 }
                     break;
                     
                 default:
                     break;
             }
             
         }];
        
        
    }
    
}



/* 登录成功通知 */
- (void)loginSuccess:(NSNotification *)notif {
    [self buildBarButtonItemIn:BaseViewControllerBarButtonItemPositionLeft withImagePath:_userInfoEntity.UI_photoPath gender:[_userInfoEntity.UI_sex intValue]];
    self.title = _userInfoEntity.UI_nickname;
    [self reloadData];
}

/* 登录失败通知 */
- (void)loginFailue:(NSNotification *)notif {
    [self buildBarButtonItemIn:BaseViewControllerBarButtonItemPositionLeft withImagePath:_userInfoEntity.UI_photoPath gender:[_userInfoEntity.UI_sex intValue]];
}

/* 收到称重信息通知 */
- (void)receiveScaleData:(NSNotification *)notif {
    
    // 统计测量
    [Flurry logEvent:START_WEIGHTING_EVENT];
    
    ScaleUserDataEntity *scaleUserDataEntity = notif.object;
    UserDataEntity *userDataEntity = [scaleUserDataEntity convertToUserDataEntityWithHeight:[_userInfoEntity.UI_height intValue]];
    _userInfoEntity.UI_lastUserData = userDataEntity;
    
    switch (_type) {
        case FlowTypeUser: {
            if (![GloubleProperty sharedInstance].registering) {
                [[InterfaceModel sharedInstance] submitUserData:userDataEntity
                                                       deviceNo:[BTModel sharedInstance].deviceCode
                                                           flag:NO
                                                   WithCallBack:^(int code, id param, NSString *errorMsg) {
                                                       NSLog(@"提交成功");
                                                   }];
                NSLog(@"上传数据To DEVICE NO:%@", [BTModel sharedInstance].deviceCode);
            }
        }
            break;
        case FlowTypeRegister: {
            __weak DataDetailViewController *wself = self;
            [self buildBarButtonItemIn:BaseViewControllerBarButtonItemPositionRight withTitle:@"注册"];
            AQAlertView *alertView = [[AQAlertView alloc] initWithTitle:@""
                                                                message:@"想保留数据提供更多贴心服务请注册"
                                                     confirmButtonTitle:@"注册"
                                                            cancelTitle:@"取消"
                                                         confirmHandler:^(AQAlertView *alertView) {
                                                             [wself rightBarButtonAction:nil];
                                                         } cancelHandler:^(AQAlertView *alertView) {
                                                             
                                                         }];
            [alertView show];
        }
            break;
        default:
            break;
    }
    
    [self finishScaleAnimation:[[InterfaceModel sharedInstance] dataIsNormal:userDataEntity]];
    
    self.roundAboutBt.hidden = NO;
    self.roundAboutImage.hidden = NO;
    _userDataEntity = userDataEntity;
    [self reloadData];
}

/* 用户最后一条称重更新通知 */
- (void)updataData:(NSNotification *)notif {
    _userDataEntity = [[InterfaceModel sharedInstance] getHostUser].UI_lastUserData;
    _userInfoEntity = [[InterfaceModel sharedInstance] getHostUser];
    [self reloadData];
}

/* 实时体重接收 */
- (void)receiveRealTimeWeightData:(NSNotification *)notif {
    if ([notif.object isKindOfClass:[ScaleRealTimeWeightEntity class]]) {
        ScaleRealTimeWeightEntity *entity = notif.object;
        if (entity.weight == 0) {
            [self breakScaleAnimation];
        } else {
            if (!_isAnimation) {
                [self startScaleAnimation];
            }
        }
    }
}

- (void)systemBluetoothStateUpdate:(NSNotification *)notif {
    CBCentralManager *manager = notif.object;
    switch (manager.state) {
        case CBCentralManagerStateUnknown:
            
            break;
        case CBCentralManagerStateResetting: {
            
        }
            break;
        case CBCentralManagerStateUnsupported: {
            self.tipsLabel.text = @"您所使用的设备不支持蓝牙4.0";
        }
            break;
        case CBCentralManagerStateUnauthorized: {
            
        }
            break;
        case CBCentralManagerStatePoweredOff: {
            [self breakScaleAnimation];
            self.tipsLabel.text = @"系统蓝牙已关闭，请在设置->蓝牙中打开蓝牙";
        }
            break;
        case CBCentralManagerStatePoweredOn: {
            self.tipsLabel.text = @"正在连接设备，请稍候...";
        }
            break;
        default:
            break;
    }
}

- (void)nickNameDidChange {
    self.navigationItem.title = [[GloubleProperty sharedInstance] currentUserEntity].UI_nickname;
}

- (void)btInitDataSuccess {
    self.tipsLabel.text = @"连接成功，请上秤";
}

- (void)btInitDataFailed {
    self.tipsLabel.text = @"同步数据失败，请上秤使用常规模式（P9）测量";
}

- (void)systemBluetoothDidConnected {
    self.tipsLabel.text = @"已连接，正在同步数据...";
}

- (void)systemBluetoothDidDisconnected {
    [self breakScaleAnimation];
    self.tipsLabel.text = @"正在连接设备，请稍候...";
}

#pragma mark - UITableView Delegate and DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // ============= 复用队列 =======================
    static NSString *identifier = @"DataDetailTableViewCell";      // 三个区间CELL
    static NSString *identifierTP = @"DataDetailTableViewCellTP";  // 两个区间CELL
    static NSString *identifierFP = @"DataDetailTableViewCellFP";  // 四个区间CELL
    static NSString *identifierAG = @"DataDetailTableViewCellAG";  // 身体年龄CELL
    static NSString *identifierIF = @"DataDetailTableViewCellIF";  // 内脏脂肪
    
    DataDetailTableViewCell *cell = nil;
    
    if (indexPath.row == PCType_bmr || indexPath.row == PCType_eBmr) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifierTP];
    } else if (indexPath.row == PCType_weight || indexPath.row == PCType_bmi || indexPath.row == PCType_fat) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifierFP];
    } else if (indexPath.row == PCType_bodyage) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifierAG];
    } else if (indexPath.row == PCType_offal) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifierIF];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    
    if (!cell) {
        if (indexPath.row == PCType_bmr || indexPath.row == PCType_eBmr) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"DataDetailTableViewCell" owner:self options:nil][2];
        } else if (indexPath.row == PCType_weight || indexPath.row == PCType_bmi || indexPath.row == PCType_fat) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"DataDetailTableViewCell" owner:self options:nil][1];
        } else if (indexPath.row == PCType_bodyage) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"DataDetailTableViewCell" owner:self options:nil][3];
        } else if (indexPath.row == PCType_offal) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"DataDetailTableViewCell" owner:self options:nil][4];
        } else {
            cell = [[NSBundle mainBundle] loadNibNamed:@"DataDetailTableViewCell" owner:self options:nil][0];
        }
    }
    // ===============================================

    __weak DataDetailViewController *wself = self;
    __weak UserInfoEntity *wuserInfo = _userInfoEntity;
    [cell setData:_values[indexPath.row]];
    [cell setIconButtonTouchUpInsideCallBack:^{
        UIView *view = [CalculateDisplayViewUtil calculateDisplayViewWithType:indexPath.row userInfo:wuserInfo];
        [wself showHUDWithCustomView:view inView:wself.view];
        
    [Flurry logEvent:@"主页" withParameters:@{@"数据列表左侧按钮":@"查看指数说明"} timed:YES];
    } historyButtonTouchUpInsideCallback:^{
        NSDate *initDate = [NSDate stringToDate:wuserInfo.UI_lastUserData.UD_CHECKDATE];
        AQTrendingViewController *trendingVC = [[AQTrendingViewController alloc] initWithNibName:@"AQTrendingViewController" initialType:(indexPath.row + 1) dateType:AQDateTypeDay initDate:initDate];
        BaseNavigationController *trendingNavVC = [[BaseNavigationController alloc] initWithRootViewController:trendingVC];
        trendingNavVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        MMDrawerController *mmd = wself.mm_drawerController;
        [mmd presentViewController:trendingNavVC animated:YES completion:nil];
        
        [Flurry logEvent:@"主页" withParameters:@{@"数据列表右边按钮":@"查看历史数据"} timed:YES];
    }];
    
    [cell.typeButton setImage:_typeButtonImages[indexPath.row * 2] forState:UIControlStateNormal];
    [cell.typeButton setImage:_typeButtonImages[indexPath.row * 2 + 1] forState:UIControlStateHighlighted];
    
    return cell;
}

#pragma mark - Animation ImageView

- (void)startScaleAnimation {
    _isAnimation = YES;
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    NSArray *imageNames = @[[UIImage imageNamed:@"yuan1.png"],
                            [UIImage imageNamed:@"yuan2.png"],
                            [UIImage imageNamed:@"yuan3.png"],
                            [UIImage imageNamed:@"yuan2.png"]];
    UIImage *animationImage = [UIImage animatedImageWithImages:imageNames duration:0.3 * imageNames.count];
    self.connectingImageView.image = animationImage;
    self.connectingRotationImageView.image = [UIImage imageNamed:@"xuanzhuan.png"];
    
    [self.connectingRotationImageView.layer removeAllAnimations];
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INT32_MAX;
    [self.connectingRotationImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    self.tipsLabel.text = @"测量中，请勿下秤";
}

- (void)finishScaleAnimation:(BOOL)dataIsRight {
    self.connectingRotationImageView.image = nil;
    NSString *imageName = dataIsRight ? @"duihao.png" : @"tanhao1.png";
    self.connectingImageView.image = [UIImage imageNamed:imageName];
    self.tipsLabel.text = dataIsRight ? @"测量完成" : @"测量失败，请重试";
    self.tipsLabel.text = nil;
    self.tipsLabel.alpha = 0;
    
    [self performSelector:@selector(breakScaleAnimation) withObject:nil afterDelay:2];
    
    
    if (dataIsRight) {
        self.yaoShareLabel.frame = CGRectMake(0, 0, 300, 30);
        self.yaoShareLabel.backgroundColor = [UIColor clearColor];
        self.yaoShareLabel.center = self.tipsLabel.center;
        self.yaoShareLabel.font = [UIFont systemFontOfSize:16];
        self.yaoShareLabel.textColor = [UIColor whiteColor];
        self.yaoShareLabel.textAlignment = 1;
        self.yaoShareLabel.text = @"可摇一摇进行分享哦...";
        [self.view addSubview:self.yaoShareLabel];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 30, 30)];
        imageView.animationImages = @[[UIImage imageNamed:@"zuoyao.png"],[UIImage imageNamed:@"youyao.png"]];
        imageView.animationDuration = 0.6;
        imageView.animationRepeatCount = 8;
        [self.yaoShareLabel addSubview:imageView];
        [imageView startAnimating];
        
    }
    
}

/* 中断动画 */
- (void)breakScaleAnimation {
    [UIView animateWithDuration:0.3 delay:2 options:0 animations:^{
        self.tipsLabel.alpha = 1;
        self.yaoShareLabel.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.yaoShareLabel removeFromSuperview];
    }];
    
    self.tipsLabel.text = @"蓝牙已连接，可直接上秤测量";
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    _isAnimation = NO;
}

#pragma mark -
#pragma mark yaoyiyao
- (BOOL)canBecomeFirstResponder
{
    return YES;// default is NO
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        if (_type != FlowTypeGuest) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"yaoyiyao" object:nil];
            [Flurry logEvent:@"主页" withParameters:@{@"摇一摇":@"分享"} timed:YES];
        }
    }
}

#pragma mark - check updata

- (void)checkVersion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSString *URL = APP_URL;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:URL]];
        [request setHTTPMethod:@"POST"];
        NSHTTPURLResponse *urlResponse = nil;
        NSError *error = nil;
        NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];

        dispatch_async(dispatch_get_main_queue(), ^{
            if ( [recervedData length] > 0 && !error ) { // Success

                NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingAllowFragments error:nil];

                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];

                if (![versionsInAppStore count] ) { // No versions of app in AppStore

                    return;

                } else {

                    NSString *currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
                    //NSString *releaseNotesStr = [releaseNotes objectAtIndex:0];

                    if ([kRyFitCurrentVersion compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending) {

                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有新版本了哦！快去更新一下，体验新功能吧？" message:nil  delegate:self cancelButtonTitle:@"无情地拒绝"  otherButtonTitles:@"更新", nil];


                        [alertView show];

                    }
                    else {
                        

                    }

                }

            }

        });
    });

}

#pragma mark - UIAlertViewDelegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{



        switch ( buttonIndex ) {

            case 0:{


            } break;

            case 1:{
                NSString *iTunesString = trackView_URL;
                NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
                [[UIApplication sharedApplication] openURL:iTunesURL];

            } break;
                
            default:
                break;
        }
        

    
    
}

- (void)configureThemeAppearance {
    [super configureThemeAppearance];
    [self loadImages];
    [self.tableView reloadData];
}

- (void)loadImages {
    _typeButtonImages = [NSMutableArray array];
    
    for (int index = 0; index < 11; index ++) {
        // 类型图标
        NSString *imageNormalName = [NSString stringWithFormat:@"datadetailtbcelllisticon_normal_%d", (int)index];
        UIImage *typeImageNormal = ThemeImage(imageNormalName);
        
        NSString *imageHighlight = [NSString stringWithFormat:@"datadetailtbcelllisticon_highlight_%d", (int)index];
        UIImage *typeImageHighlight = ThemeImage(imageHighlight);
        
        [_typeButtonImages addObject:typeImageNormal];
        [_typeButtonImages addObject:typeImageHighlight];
    }
}


@end
