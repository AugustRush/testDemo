//
//  LeftSideViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "LeftSideViewController.h"
#import "InputUserInfoViewController.h"
#import "AQAlertView.h"
#import "FriendPermissionViewController.h"
#import "FriendInfoEntity.h"
#import "BTModel.h"
#import "PraiseMeViewController.h"
#import "MyInfoViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIAlertView+Blocks.h"
#import "MessageViewController.h"
#import "RemindWeightViewController.h"
#import "LeftSideTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "UserManagerViewController.h"
#import "PersonalCenterViewController.h"
#import "HealthMeViewController.h"
#import "BuyRyfitMainController.h"
#import "ModifyUserNameViewController.h"

NSString *const AQHasNewMessageNotification = @"AQHasNewMessageNotification";


#define kLeftSrt001 @"toBuyRyFit"
#define kLeftToBRImgAName @"Left_btn_toBuyRyFit_a.png"
#define kLeftToBRImgBName @"Left_btn_toBuyRyFit_b.png"
#define kLeftToBRImgCName @"Left_btn_toBuyRyFit_c.png"
#define kLeftCellHeight001 50

#define kToBR_btnWidth 75
#define kToBR_btnHeight 57
#define kLeftFootHeight 115
#define kLeftCellWeight 225

@interface LeftSideViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation LeftSideViewController {
    NSArray *_options;
    NSArray *_optionImages;
    UILabel *messageLabel;
    
    
    IBOutlet UIView *_footBox;
    UIImageView     *_footBoxBgImg;
    int _imgChangeCount;
    int _imgFlag;
    float _alphaChangeValue;
    //UIViewController *_nav;
}

#pragma mark - View Lifecycle

- (void)dealloc
{
    [self unregisterNotification];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self registerNotification];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _options = @[@"新消息", @"Health@Me", @"用户管理", @"访客模式"];
    _optionImages = @[@"xiaoxi.png", @"haoyou.png", @"zhanghu.png", @"fangke.png"];
    
    messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    messageLabel.layer.cornerRadius = 11;
    messageLabel.layer.masksToBounds = YES;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.text = @"10";
    messageLabel.backgroundColor = [UIColor colorWithRed:230/255.0 green:47/255.0 blue:52/255.0 alpha:1];
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.hidden = YES;
    
    /*
    CGRect _rect            = self.tableView.frame;
    _rect.size.height       = [UIScreen mainScreen].bounds.size.height - 280;
    self.tableView.frame    = _rect;
     */
    float _imgY= 5;
    if ([UIScreen mainScreen].bounds.size.height > 500) {
        _imgY += 25;
    }
    
    _footBoxBgImg           = [[UIImageView alloc]initWithImage:
                                    [UIImage imageNamed:kLeftToBRImgCName]];
    _alphaChangeValue = 0.02;
    
    CGRect _rect            = CGRectMake( 80,_imgY,
                                        kToBR_btnWidth,
                                        kToBR_btnHeight);
    _footBoxBgImg.frame     = _rect;
    UIButton *_btn          = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.backgroundColor    = [UIColor clearColor];
    [_btn addTarget:self
             action:@selector(toBRDown:)
   forControlEvents:UIControlEventTouchDown];
    [_btn addTarget:self
             action:@selector(toBRUp:)
   forControlEvents:UIControlEventTouchUpInside];
    [_btn addTarget:self
             action:@selector(toBRUpOut:)
   forControlEvents:UIControlEventTouchUpOutside];
    [_btn addTarget:self
             action:@selector(toBRUpOut:)
   forControlEvents:UIControlEventTouchCancel];
    _btn.frame              = _footBox.bounds;
    
    [_footBox addSubview:_footBoxBgImg];
    [_footBox addSubview:_btn];
    _footBox.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(aliPayCallback:)
                                                name:kGetAlipayNotificationName
                                              object:nil];

    _imgChangeCount = 1;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    if (_imgChangeCount == 1) {
        [self changeImg];
    }
    
    
    
    
    
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self refreshMessage];
    [self refreshPhoto];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [GloubleProperty sharedInstance].leftViewWillAppear = NO;
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    [GloubleProperty sharedInstance].leftViewWillAppear = YES;
}

#pragma mark - Override Methods

- (void)configureThemeAppearance {
    [super configureThemeAppearance];
    
    self.backgroundImageView.image = ThemeImage(@"beijing_zuo");
}

#pragma mark - Private Methods
-(void)toBRTouchDown
{
    _imgChangeCount = 0;
    _footBoxBgImg.alpha = 1;
    _footBoxBgImg.image = [UIImage imageNamed:kLeftToBRImgBName];
}

-(void)toBRTouchUp
{
    _imgChangeCount = 0;
    _footBoxBgImg.alpha = 1;
    _footBoxBgImg.image = [UIImage imageNamed:kLeftToBRImgAName];
}


-(void)changeImg
{
    if (_imgChangeCount == 0) {
        return;
    }
    
    
    
    [UIView animateWithDuration:0.1
                     animations:^{
                         _footBoxBgImg.alpha += _alphaChangeValue;
    }
                     completion:^(BOOL finished) {
                         _imgChangeCount++;
                         if (_footBoxBgImg.alpha >= 1) {
                             _alphaChangeValue  = -0.1;
                         }
                         else if (_footBoxBgImg.alpha <= 0.4)
                         {
                             _alphaChangeValue = 0.1;
                         }
                         
                         
                         
                         if (_imgChangeCount < 50) {
                             [self changeImg];
                         }
                         else{
                             _footBoxBgImg.alpha = 1;
                             _footBoxBgImg.image = [UIImage imageNamed:kLeftToBRImgAName];
                             _imgChangeCount = 0;
                         }
    }];
    
    
    
    /*
    [UIView beginAnimations:@"toBuyChange" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDidStopSelector:@selector(changeImgCallback)];
    
    if (_imgChangeCount % 5 == 0) {
        if (_imgFlag) {
            _footBoxBgImg.image = [UIImage imageNamed:kLeftToBRImgCName];
        }
        else{
            _footBoxBgImg.image = [UIImage imageNamed:kLeftToBRImgAName];
        }
    }

    if (_footBoxBgImg.alpha > 0.8) {
        _footBoxBgImg.alpha = 0.7;
    }
    else{
        _footBoxBgImg.alpha = 1;
    }
    [UIView commitAnimations];
    */

}

-(void)changeImgCallback
{
    _imgChangeCount++;
    if (_imgChangeCount % 5 == 0) {
        _imgFlag = 1 - _imgFlag;
    }
    
    if (_imgChangeCount < 25) {
        [self changeImg];
    }
    else{
        _footBoxBgImg.alpha = 1;
        _footBoxBgImg.image = [UIImage imageNamed:kLeftToBRImgAName];
        _imgChangeCount = 0;
    }
}


-(void)aliPayCallback:(NSNotification *)aNotif
{
    
    
    
    NSDictionary *_info     = [aNotif userInfo];
    NSDictionary *_uInfo    = nil;
    if (_info) {
        _uInfo = _info[@"userInfo"];
        if (![@"1" isEqualToString: _uInfo[@"pid"]]) {
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
                     _BRMainVC.pareantId    = 1;
                     BaseNavigationController *messageNav = [[BaseNavigationController alloc] initWithRootViewController:_BRMainVC];
                     [self presentViewController:messageNav animated:YES completion:NULL];
                 }
                     break;
                 case 0:
                 {
                     
                     BuyRyfitMainController *_BRMainVC = [[BuyRyfitMainController alloc] init];
                     _BRMainVC.isToResult   = 2;
                     _BRMainVC.pareantId    = 1;
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
                     _BRMainVC.pareantId    = 1;
                     
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


- (void)refreshMessage {
    [[InterfaceModel sharedInstance] getMSGWithCallback:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
        if (result == WebCallBackResultSuccess) {
            if ([successParam isKindOfClass:[NSNumber class]]) {
                NSInteger msgCount = ((NSNumber *)successParam).intValue;
                [self refreshMessageLabelWithMessageCount:msgCount];
            }
        }
    }];
}

// 将所有消息置为已读
- (void)readAllMessages {
    [[InterfaceModel sharedInstance] setMsgReadedWithCallBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
        if (result == WebCallBackResultSuccess) {
            [self refreshMessageLabelWithMessageCount:0];
        }
    }];
}

- (void)refreshMessageLabelWithMessageCount:(int)count {
    if (count == 0) {
        messageLabel.hidden = YES;
    } else {
        messageLabel.hidden = NO;
        messageLabel.text = [NSString stringWithFormat:@"%d", count];
    }
}




#pragma mark - Public Methods

- (void)refreshPhoto {
    // 设置头像用户名
    UserInfoEntity *userInfo = [[InterfaceModel sharedInstance] getHostUser];
    self.userNickNameLabel.text = userInfo.UI_nickname;
    NSString *urlString = [NSString stringWithFormat:@"%@%@", SERVICE_URL, userInfo.UI_photoPath];
    NSURL *photoURL = [NSURL URLWithString:urlString];
    
    int gender = [userInfo.UI_sex intValue];
    UIImage *placeholderImage = nil;
    if (gender == 0) {
        placeholderImage = [UIImage imageNamed:@"default_photo_females.png"];
    } else {
        placeholderImage = [UIImage imageNamed:@"default_photo_males.png"];
    }
    
    if (userInfo.UI_photoPath.length) {
        [self.photoImageView setImageWithURL:photoURL placeholderImage:placeholderImage];
    } else {
        [self.photoImageView setImage:placeholderImage];
    }
    // 设置头像用户名 END
}

- (void)hackViewWillAppearAfterDismissViewController {
    [self refreshMessage];
}

#pragma mark - Notification 

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMessage) name:AQHasNewMessageNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMessage) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPhoto) name:NickNameDidChangeNotification object:nil];
}

- (void)unregisterNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AQHasNewMessageNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NickNameDidChangeNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:kAlipayNotificationName
                                                 object:nil];
}

#pragma mark - Actions

- (IBAction)tapUserPhotoAction:(id)sender {
    PersonalCenterViewController *personCenterVC = [[PersonalCenterViewController alloc] initWithNibName:@"PersonalCenterViewController" bundle:nil];
    BaseNavigationController *personCenterNavVC = [[BaseNavigationController alloc] initWithRootViewController:personCenterVC];
//    personCenterNavVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:personCenterNavVC animated:YES completion:NULL];
    
    [Flurry logEvent:@"左侧边栏" withParameters:@{@"用户头像按钮":@"弹出个人中心"} timed:YES];
}

-(void)toBRDown:(UIButton *)cellBtn
{
    [self toBRTouchDown];
    

}

-(void)toBRUp:(UIButton *)cellBtn
{
    [self toBRTouchUp];
    
    BuyRyfitMainController *_BRMainVC = [[BuyRyfitMainController alloc] init];
    _BRMainVC.pareantId = 1;
    BaseNavigationController *messageNav = [[BaseNavigationController alloc] initWithRootViewController:_BRMainVC];
    [self presentViewController:messageNav animated:YES completion:NULL];
    
}

-(void)toBRUpOut:(UIButton *)cellBtn
{
    
    [self toBRTouchUp];
    
}

#pragma mark - UITableViewDataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"LeftSideViewCell";
    LeftSideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LeftSideTableViewCell" owner:self options:nil] firstObject];

        UIImageView *_viewLine = [[UIImageView alloc]initWithFrame:CGRectMake(20, 49,205, 1)];
        _viewLine.image = [UIImage imageNamed:@"fengexian.png"];
        _viewLine.tag = 111111;
        [cell.contentView addSubview:_viewLine];
        
    }
    
    cell.accessoryView = nil;
    
    if (indexPath.row == 0) {
        cell.accessoryView = messageLabel;
    }
    
    UIView *_viewLine   = [cell.contentView viewWithTag:111111];

    if ([kLeftSrt001 isEqualToString:_options[indexPath.row]]) {
        cell.textLabel.text = nil;
        _viewLine.hidden = YES;

    }
    else{
        cell.textLabel.text = _options[indexPath.row];
        _viewLine.hidden = NO;

    }

    
    cell.imageView.image = [UIImage imageNamed:_optionImages[indexPath.row]];
    
    return cell;
}

-       (CGFloat)tableView:(UITableView *)tableView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kLeftCellHeight001;

}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


            [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.row) {
        case 0: {
            [self readAllMessages];
            
            MessageViewController *messageVC = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
            //            messageVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            BaseNavigationController *messageNav = [[BaseNavigationController alloc] initWithRootViewController:messageVC];
            [self presentViewController:messageNav animated:YES completion:NULL];
            
            [Flurry logEvent:@"左侧边栏" withParameters:@{@"新消息栏":@"弹出新消息页面"} timed:YES];
        }
            break;
        case 1: {
            HealthMeViewController *healthMeVC = [[HealthMeViewController alloc] initWithNibName:@"HealthMeViewController" bundle:nil];
            //            healthMeVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            BaseNavigationController *healthMeNav = [[BaseNavigationController alloc] initWithRootViewController:healthMeVC];
            [self presentViewController:healthMeNav animated:YES completion:NULL];
            
            [Flurry logEvent:@"左侧边栏" withParameters:@{@"health@me":@"弹出关注页面"} timed:YES];
        }
            break;
        case 2: {
            UserManagerViewController *userManagerVC = [[UserManagerViewController alloc] initWithNibName:@"UserManagerViewController" bundle:nil];
            //            userManagerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            BaseNavigationController *userManagerNav = [[BaseNavigationController alloc] initWithRootViewController:userManagerVC];
            [self presentViewController:userManagerNav animated:YES completion:NULL];
            
            [Flurry logEvent:@"左侧边栏" withParameters:@{@"用户管理栏":@"弹出用户管理页面"} timed:YES];
        }
            break;

        case 3: {
            
            InputUserInfoViewController *inputUserInfoVC = [[InputUserInfoViewController alloc] initWithNibName:@"InputUserInfoViewController" bundle:nil type:FlowTypeGuest checkCode:nil];
            BaseNavigationController *userManagerNav = [[BaseNavigationController alloc] initWithRootViewController:inputUserInfoVC];
            [self presentViewController:userManagerNav animated:YES completion:NULL];
            
            
        }
            break;

        default:
        {
            
        }
            break;
    }
}

@end
