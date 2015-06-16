//
//  CenterViewController.m
//  BodyScale
//
//  Created by August on 14-10-11.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "CenterViewController.h"
#import "M13ProgressViewSegmentedRing.h"
#import "CustomProgressView.h"
#import "HealthIndexView.h"
#import "UIButton+WebCache.h"
#import "ShareViewController.h"
#import "AFHTTPRequestOperationManager.h"

#define kCellReuseIdentifier @"indexCell"
#define _tag_share 1000

#define share_Height 140

@interface CenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView         *hudBgView;//透明背景
}


@property (strong, nonatomic) HealthIndexView *healthIndexView;
@property (strong, nonatomic) CustomProgressView * progressView;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) MesureModel * mesureModel;
@property (strong, nonatomic) NSMutableArray *gList;
@property(nonatomic,weak)UIView *sView;

@property (nonatomic, strong) NSMutableDictionary *userInfoDict;
@property (nonatomic, strong) NSMutableDictionary *deviceDict;
@property (nonatomic, strong) NSString *deviceNumber;
@end

@implementation CenterViewController
#pragma mark
#pragma mark Init & Dealloc
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.deviceNumber = @"9";
    }
    return self;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ishasTextFeild:(BOOL)haseTextFeild
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ishasTextFeild:haseTextFeild];
    if (self)
    {
        self.deviceNumber = @"9";
        self.fillData = [[UserFillData alloc]init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceConnectFail) name:@"DeviceConnectFail" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDisConnectOK) name:@"DeviceDisConnectOK" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceConnectOK) name:@"DeviceConnectOK" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDeviceDiscover) name:@"DeviceDiscover" object:nil];
    }
    return self;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark
#pragma mark Init & Add
- (HealthIndexView *)healthIndexView
{
    if (!_healthIndexView)
    {
        _healthIndexView = [[HealthIndexView alloc] init];
        [self.view addSubview:_healthIndexView];
        [_healthIndexView.headBt addTarget:self action:@selector(selectHeadBt) forControlEvents:UIControlEventTouchUpInside];
        [_healthIndexView.shareBt addTarget:self action:@selector(selectshareBt) forControlEvents:UIControlEventTouchUpInside];
    }
    return _healthIndexView;
}
- (CustomProgressView *)progressView
{
    if (!_progressView)
    {
        _progressView = [[CustomProgressView alloc] initWithConnected:[[NSUserDefaults standardUserDefaults] boolForKey:HASALREADYCONNECTED]];
        _progressView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_progressView];
        [_progressView setShowPercentage:NO];
        [_progressView showConnectImg];
    }
    return _progressView;
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[CenterTableViewCell class] forCellReuseIdentifier:kCellReuseIdentifier];
    }
    return _tableView;
}
- (MesureModel *)mesureModel
{
    if (!_mesureModel)
    {
        _mesureModel = [[MesureModel alloc]init];
    }
    return _mesureModel;
}
- (NSMutableArray *)gList
{
    if (!_gList)
    {
        _gList = [[NSMutableArray alloc] init];
        NSArray *array1=[NSArray arrayWithObjects:@"weight",@"fatPercentage",@"waterContent",@"bmr",@"skinfat",@"boneweight",@"muscle",@"infat",@"bodyage", nil];
        NSArray *array2=[NSArray arrayWithObjects:@"体重",@"体脂率",@"水含量", @"BMR",@"皮下脂肪",@"骨骼重量",@"肌肉比例",@"内脏脂肪",@"身体年龄",nil];
        for (int i =0; i < array1.count;i++ )
        {
            WeightModel * model = [[WeightModel alloc]init];
            model.imagePath = [NSString stringWithFormat:@"%@",[array1 objectAtIndex:i]];
            model.weightName = [NSString stringWithFormat:@"%@",[array2 objectAtIndex:i]];
            [_gList addObject:model];
        }
    }
    return _gList;
}
- (NSMutableDictionary *)userInfoDict
{
    if (!_userInfoDict)
    {
        _userInfoDict = [[NSMutableDictionary alloc] init];
    }
    return _userInfoDict;
}
- (NSMutableDictionary *)deviceDict
{
    if (!_deviceDict)
    {
        _deviceDict = [[NSMutableDictionary alloc] init];
    }
    return _deviceDict;
}
#pragma mark
#pragma mark - System Action
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self baseConfigs];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([AppDelegate currentAppDelegate].connectType == 0)
    {
        [self.progressView showConnectImg];
    }
    else if ([AppDelegate currentAppDelegate].connectType == 1)
    {
        [self deviceConnectOK];
    }
    else if ([AppDelegate currentAppDelegate].connectType == 2)
    {
        [self deviceDisConnectOK];
    }
    else if ([AppDelegate currentAppDelegate].connectType == 3)
    {
        [self deviceConnectFail];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark
#pragma mark - Other Action
-(void)baseConfigs
{
    [self initBaseView];
    [self checkVersion];
    if ([[FFConfig currentConfig].isLogined boolValue]== NO)
    {
        self.healthIndexView.userNameLb.text = [FFConfig currentConfig].userNickName;
        [self.healthIndexView.headBt sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"DefaultHeader.png"]];
    }
    else
    {
        UserInfoManager *tUser = [UserInfoManager sharedInstance];
        if (tUser.userLoginArray.count > 0)
        {
            for (NSDictionary *tDict in tUser.userLoginArray)
            {
                if ([[FFConfig currentConfig].nowUserId intValue] == [tDict[@"userInfoId"] intValue])
                {
                    [self.healthIndexView.headBt sd_setImageWithURL:[NSURL URLWithString:tDict[@"userInfoHeader"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"DefaultHeader.png"]];
                    self.healthIndexView.userNameLb.text = tDict[@"userInfoNickName"];
                    break;
                }
            }
        }
        else
        {
            [self.healthIndexView.headBt sd_setImageWithURL:[NSURL URLWithString:[FFConfig currentConfig].userHeader] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"DefaultHeader.png"]];
            self.healthIndexView.userNameLb.text = [FFConfig currentConfig].userShowName;
        }
    }
}
- (void)deviceDisConnectOK
{
    self.progressView.scoreNumLb.text = @"0.0";
    self.progressView.scoreLb.text = @"失去连接，请重新连接";
    [self.progressView showHighestLabel];
}
- (void)deviceConnectOK
{
    self.progressView.scoreNumLb.text = @"0.0";
    self.progressView.scoreLb.text = @"连接成功，请上称测量";
    [self.progressView showHighestLabel];
//    [BodyScaleBTInterface deleteUserInBodyScaleWithLocation:1 completeHandler:^(NSInteger statusCode) {
//        
//    }];
//    [BodyScaleBTInterface deleteUserInBodyScaleWithLocation:2 completeHandler:^(NSInteger statusCode) {
//        
//    }];
//    [BodyScaleBTInterface deleteUserInBodyScaleWithLocation:3 completeHandler:^(NSInteger statusCode) {
//        
//    }];
//    [BodyScaleBTInterface deleteUserInBodyScaleWithLocation:4 completeHandler:^(NSInteger statusCode) {
//        
//    }];
//    [BodyScaleBTInterface deleteUserInBodyScaleWithLocation:5 completeHandler:^(NSInteger statusCode) {
//        
//    }];
//    [BodyScaleBTInterface deleteUserInBodyScaleWithLocation:6 completeHandler:^(NSInteger statusCode) {
//        
//    }];
//    [BodyScaleBTInterface deleteUserInBodyScaleWithLocation:7 completeHandler:^(NSInteger statusCode) {
//        
//    }];
//    [BodyScaleBTInterface deleteUserInBodyScaleWithLocation:8 completeHandler:^(NSInteger statusCode) {
//        
//    }];
    
//    [BodyScaleBTInterface getAllUserInfosInBodyScaleWithCompleteHandler:^(NSError *error, NSArray *infos) {
//        
//        DLog(@"msg_lyywhg~%@", infos);
//    }];

    [self.deviceDict removeAllObjects];
    [self.userInfoDict removeAllObjects];
    if ([[FFConfig currentConfig].isLogined boolValue]== NO)
    {
        [self getDataFromMatch];
    }
    else
    {
        UserInfoManager *userInfo = [UserInfoManager sharedInstance];
        NSMutableArray *tUserList = [[NSMutableArray alloc] init];
        for (NSDictionary *tDict in userInfo.userLoginArray)
        {
            if ([tDict[@"id"] intValue] == [[FFConfig currentConfig].nowUserId intValue])
            {
                [self.userInfoDict addEntriesFromDictionary:tDict];
                break;
            }
        }
        self.healthIndexView.userNameLb.text = self.userInfoDict[@"name"];
        BOOL haveDevice = NO;
        if (self.userInfoDict[@"devices"] != nil)
        {
            [tUserList addObjectsFromArray:self.userInfoDict[@"devices"]];
        }
        if (tUserList != nil && tUserList.count > 0)
        {
            for (NSMutableDictionary *tDict in tUserList)
            {
                if ([tDict[@"device_id"] isEqualToString:[AppDelegate currentAppDelegate].deviceId])
                {
                    haveDevice = YES;
                    [self.deviceDict addEntriesFromDictionary:tDict];
                    break;
                }
            }
        }
        if (haveDevice == NO)
        {
            [self registerMatch];
        }
        else
        {
            [self getDataFromMatch];
        }
    }
}
- (void)deviceConnectFail
{
    self.progressView.scoreNumLb.text = @"0.0";
    self.progressView.scoreLb.text = @"连接失败";
    [self.progressView showHighestLabel];
}
- (void)deviceDeviceDiscover
{
}
- (void)registerMatch
{
    NSString *tSex = @"1";
    if ([self.userInfoDict[@"sex"] isEqualToString:@"男"])
    {
        tSex = @"0";
    }
    [BodyScaleBTInterface createNewUserInBodyScaleWithBodyHeight:[self.userInfoDict[@"height"] intValue] age:[self.userInfoDict[@"age"] intValue] sex:[tSex intValue] completionHandler:^(NSError *error, NSInteger location) {
        
        if (error == nil)
        {
            if (location == 11)
            {
                BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"坑位已满" posY:100];
                [tTip show];
            }
            else if (location == 10)
            {
                BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"用户信息错误" posY:100];
                [tTip show];
            }
            else
            {
                [self.deviceDict setValue:[NSString stringWithFormat:@"%d", location] forKey:@"device_number"];
                [self.deviceDict setValue:[AppDelegate currentAppDelegate].deviceId forKey:@"device_id"];
                [self getDataFromMatch];
            }
        }
    }];
}
// getBodyScaleSoftVersionWithCompleteHandler
- (void)checkVersion
{
    [BodyScaleBTInterface getBodyScaleBlueToothVersionWithCompleteHandler:^(NSError *error, NSNumber *number) {
    }];
}
- (void)getDataFromMatch
{
    [BodyScaleBTInterface selectUserMeasureWithLocation:[self.deviceNumber intValue] height:self.fillData.height age:self.fillData.userAge sex:self.fillData.sex ackHandler:^(NSError *error){
        DLog(@"ack error is %@",error);
    }completionHandler:^(NSError *error, NSDictionary *response){
        float iWater = [[response objectForKey:@"water"] floatValue];
        self.mesureModel.water = [NSString stringWithFormat:@"%.2f%@",iWater,@"%"];
        float iFat = [[response objectForKey:@"bodyFat"] floatValue];
        self.mesureModel.bodyFat = [NSString stringWithFormat:@"%.2f%@", iFat, @"%"];
        float iWeight = [[response objectForKey:@"weight"] floatValue];
        NSMutableString * weightStr =[NSMutableString stringWithFormat:@"%.2fkg", iWeight];
        self.mesureModel.weight = weightStr;
        [self.progressView showHighestLabel];
        NSMutableDictionary *tDict = [[NSMutableDictionary alloc] init];
        [tDict setObject:[FFConfig currentConfig].userId forKey:@"user_id"];
        [tDict setObject:self.userInfoDict[@"id"] forKey:@"member_id"];
        [tDict setObject:[AppDelegate currentAppDelegate].deviceId forKey:@"device_id"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [tDict setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"time"];
        [tDict setObject:self.mesureModel.weight forKey:@"weight"];
        [tDict setObject:@"" forKey:@"bf"];
        [tDict setObject:self.mesureModel.water forKey:@"water"];
        [tDict setObject:@"" forKey:@"muscle"];
        [tDict setObject:@"" forKey:@"bone"];
        [tDict setObject:@"" forKey:@"bmr"];
        [tDict setObject:self.mesureModel.bodyFat forKey:@"sfat"];
        [tDict setObject:@"" forKey:@"infat"];
        [tDict setObject:@"" forKey:@"bodyage"];
        [tDict setObject:@"" forKey:@"amr"];
        [self uploadDeviceData:tDict];
        
    }extraDataHandler:^(NSError *error, NSDictionary *extraInfo){
        DLog(@"extra data is %@ error is %@",extraInfo,error);
        int bodyAge = [[extraInfo objectForKey:@"bodyAge"] floatValue];
        self.mesureModel.bodyAge = [NSString stringWithFormat:@"%d", bodyAge];
        float inFat = [[extraInfo objectForKey:@"inFat"] floatValue];
        self.mesureModel.inFat = [NSString stringWithFormat:@"%.2f%@", inFat, @"%"];
        float sFat = [[extraInfo objectForKey:@"sFat"] floatValue];
        self.mesureModel.sFat = [NSString stringWithFormat:@"%.2f", sFat];
        float bmr = [[extraInfo objectForKey:@"BMR"] floatValue];
        self.mesureModel.bmr = [NSString stringWithFormat:@"%.2f", bmr];
        float bone = [[extraInfo objectForKey:@"bone"] floatValue];
        self.mesureModel.bone = [NSString stringWithFormat:@"%.2fkg", bone];
        float muscle = [[extraInfo objectForKey:@"muscle"] floatValue];
        self.mesureModel.muscle = [NSString stringWithFormat:@"%.2f%@", muscle, @"%"];
        [self setWeightValue];
        [self.tableView reloadData];
        [self.progressView showHighestLabel];
        self.progressView.scoreNumLb.text = @"88.2";
        self.progressView.scoreLb.text = @"健康指数\n最高92分";
        NSMutableDictionary *tDict = [[NSMutableDictionary alloc] init];
        [tDict setObject:[FFConfig currentConfig].userId forKey:@"user_id"];
        [tDict setObject:self.userInfoDict[@"id"] forKey:@"member_id"];
        [tDict setObject:[AppDelegate currentAppDelegate].deviceId forKey:@"device_id"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [tDict setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"time"];
        [tDict setObject:self.mesureModel.weight forKey:@"weight"];
        [tDict setObject:@"" forKey:@"bf"];
        [tDict setObject:self.mesureModel.water forKey:@"water"];
        [tDict setObject:self.mesureModel.muscle forKey:@"muscle"];
        [tDict setObject:self.mesureModel.bone forKey:@"bone"];
        [tDict setObject:@"" forKey:@"bmr"];
        [tDict setObject:self.mesureModel.bodyFat forKey:@"sfat"];
        [tDict setObject:@"" forKey:@"infat"];
        [tDict setObject:self.mesureModel.bodyAge forKey:@"bodyage"];
        [tDict setObject:@"" forKey:@"amr"];
        [self uploadDeviceData:tDict];
    }];
}
- (void)initBaseView
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:HASALREADYCONNECTED])
    {
        [self initBaseViewConnected];
    }
    else
    {
        [self initBaseViewUnconnected];
    }
}
- (void)initBaseViewConnected
{
    CGFloat leftX = 43.0f;
    CGFloat width = Screen_Width-leftX*2-10;
    [self.healthIndexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(370));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.healthIndexView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(@(leftX));
        maker.top.equalTo(@80);
        maker.height.equalTo(@(width));
        maker.width.equalTo(@(width));
    }];
    [self performSelector:@selector(animation:) withObject:@"0" afterDelay:0.2];
    self.healthIndexView.weightLabel.text = @"您的体重已超标，请控制饮食，多运动";
    self.healthIndexView.bmiNumLb.text = @"18.9";
    self.healthIndexView.ageLb.text = @"24";
}
- (void)initBaseViewUnconnected
{
    CGFloat leftX = 43;
    CGFloat width = Screen_Width-leftX*2-10;
    [self.healthIndexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(370));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.healthIndexView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(@(leftX));
        maker.top.equalTo(@80);
        maker.height.equalTo(@(width));
        maker.width.equalTo(@(width));
    }];
    [self performSelector:@selector(animation:) withObject:@"0" afterDelay:0.2];
    self.healthIndexView.weightLabel.text =  @"";
    self.healthIndexView.bmiNumLb.text = @"00.";
    self.healthIndexView.ageLb.text = @"00";
}
- (void)setWeightValue
{
    for (WeightModel * model in self.gList)
    {
        if ([model.weightName isEqualToString:@"体重"])
        {
            model.weightValue = self.mesureModel.weight;
        }
        if ([model.weightName isEqualToString:@"体脂率"])
        {
            model.weightValue = self.mesureModel.bodyFat;
        }
        if ([model.weightName isEqualToString:@"水含量"])
        {
            model.weightValue = self.mesureModel.water;
        }
        if ([model.weightName isEqualToString:@"BMR"])
        {
            model.weightValue = self.mesureModel.bmr;
        }
        if ([model.weightName isEqualToString:@"皮下脂肪"])
        {
            model.weightValue = self.mesureModel.sFat;
        }
        if ([model.weightName isEqualToString:@"骨骼重量"])
        {
            model.weightValue = self.mesureModel.bone;
        }
        if ([model.weightName isEqualToString:@"肌肉比例"])
        {
            model.weightValue = self.mesureModel.muscle;
        }
        if ([model.weightName isEqualToString:@"内脏脂肪"])
        {
            model.weightValue = self.mesureModel.inFat;
        }
        if ([model.weightName isEqualToString:@"身体年龄"])
        {
            model.weightValue = self.mesureModel.bodyAge;
        }
    }
}
- (void)animation:(NSString*)percent
{
    CGFloat floatpercent = [percent floatValue];
    [self.progressView setProgress:floatpercent animated:YES];
}
- (void)selectHeadBt
{
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (void)selectshareBt
{
    DLog(@"msg_lyywhg:~");
    ShareViewController *shareVC = [[ShareViewController alloc] init];
    [self.navigationController pushViewController:shareVC animated:YES];
}
- (void)respondsToHudBgView
{
    [hudBgView removeFromSuperview];
}
- (void)removeBlackView
{
}
- (void)shareSpace:(id)sender
{
    // 跳转到下一个界面
}
- (void)uploadDeviceData:(NSDictionary *)dict
{
    if ([self.deviceNumber intValue] == 9)
    {
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",POSTURL,@"upload"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"user_id":dict[@"user_id"],@"member_id":dict[@"member_id"],@"device_id":[AppDelegate currentAppDelegate].deviceId,@"device_number":self.deviceNumber,@"time":dict[@"time"],@"weight":dict[@"weight"],@"bf":dict[@"bf"],@"water":dict[@"water"],@"muscle":dict[@"muscle"],@"bone":dict[@"bone"],@"bmr":dict[@"bmr"],@"sfat":dict[@"sfat"],@"infat":dict[@"infat"],@"bodyage":dict[@"bodyage"],@"amr":dict[@"amr"]};
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (!errorCode)
        {
        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
            [tTip show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
        [tTip show];
        return;
    }];
}
#pragma mark - System Delegate & Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gList.count;
}
-(CenterTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CenterTableViewCell *cell  = nil;
    if (indexPath.row < [self.gList count])
    {
        WeightModel * temp = [self.gList objectAtIndex:indexPath.row];
        cell = [[CenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseIdentifier model:temp];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark - manage memory methods

@end
