//
//  DataStatisticsViewController.m
//  BodyScale
//
//  Created by cxx on 14-11-15.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "DataStatisticsViewController.h"
#import "ShareViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "GetFirstDayAndLastDay.h"

#define _tag_bt 100
#define _tag_change_bt 200

@interface DataStatisticsViewController ()<MBProgressHUDDelegate>
{
    UIView *_secondView;
    UIView *_bottomView;
    UIView *_greenLineView;
    BOOL _isLine;
}

@property (nonatomic, assign) BOOL green;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *weekBt;
@property (nonatomic, strong) UIButton *mounthBt;
@property (nonatomic, strong) UIButton *yearBt;
@property (nonatomic, strong) UILabel  *timeLB;
@property (nonatomic, strong) UIButton *preStepBt;
@property (nonatomic, strong) UIButton *nextStepBt;
@property (nonatomic, strong) UIButton *changeBt;
@property (strong, nonatomic) UILabel  *numLB;
@property (strong, nonatomic) GKBarGraph *graphView;
@property (strong, nonatomic) GKLineGraph *lineView;

@property (strong, nonatomic) MBProgressHUD *progressHUD;

@property (nonatomic, strong) NSMutableArray *nowDataList;
@property (nonatomic, strong) NSMutableArray *selectList;
@property (nonatomic, strong) NSArray * btnName;
@property (nonatomic, strong) NSArray * btnImage;

@property (nonatomic, strong) NSArray *selecTypeList;
@property (nonatomic, strong) NSDate *selectDate;
@property (nonatomic, strong) NSString *selectTypeString;

@end

@implementation DataStatisticsViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.selectDate = [NSDate date];
        self.selectTypeString = @"weight";
    }
    return self;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.selectDate = [NSDate date];
    }
    return self;
}

- (UIView *)topView
{
    if (!_topView)
    {
        _topView = [[UIView alloc] init];
        [_topView setBackgroundColor:[UIColor clearColor]];
    }
    return _topView;
}
- (UIButton *)weekBt
{
    if (!_weekBt)
    {
        _weekBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weekBt setTitle:@"周" forState:UIControlStateNormal];
        [_weekBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_weekBt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_weekBt setBackgroundImage:[UIImage imageNamed:@"seledBt"] forState:UIControlStateSelected];
        [_weekBt addTarget:self action:@selector(selectTimeBt:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weekBt;
}
- (UIButton *)mounthBt
{
    if (!_mounthBt)
    {
        _mounthBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mounthBt setBackgroundColor:[UIColor clearColor]];
        [_mounthBt setTitle:@"月" forState:UIControlStateNormal];
        [_mounthBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_mounthBt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_mounthBt setBackgroundImage:[UIImage imageNamed:@"seledBt"] forState:UIControlStateSelected];
        [_mounthBt addTarget:self action:@selector(selectTimeBt:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mounthBt;
}
- (UIButton *)yearBt
{
    if (!_yearBt)
    {
        _yearBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yearBt setBackgroundColor:[UIColor clearColor]];
        [_yearBt setTitle:@"年" forState:UIControlStateNormal];
        [_yearBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_yearBt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_yearBt setBackgroundImage:[UIImage imageNamed:@"seledBt"] forState:UIControlStateSelected];
        [_yearBt addTarget:self action:@selector(selectTimeBt:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yearBt;
}
- (UILabel *)timeLB
{
    if (!_timeLB)
    {
        _timeLB = [[UILabel alloc] init];
        [_timeLB setBackgroundColor:[UIColor clearColor]];
    }
    return _timeLB;
}
- (UIButton *)preStepBt
{
    if (!_preStepBt)
    {
        _preStepBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_preStepBt setBackgroundImage:[UIImage imageNamed:@"prestep"] forState:UIControlStateNormal];
        [_preStepBt addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventTouchUpInside];
        _preStepBt.tag = _tag_bt;
    }
    return _preStepBt;
}
- (UIButton *)nextStepBt
{
    if (!_nextStepBt)
    {
        _nextStepBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStepBt setBackgroundImage:[UIImage imageNamed:@"nextstep"] forState:UIControlStateNormal];
        [_nextStepBt addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventTouchUpInside];
        _nextStepBt.tag = _tag_bt+1;
    }
    return _nextStepBt;
}
- (UIButton *)changeBt
{
    if (!_changeBt)
    {
        _changeBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeBt setBackgroundImage:[UIImage imageNamed:@"Line_Unselect"] forState:UIControlStateNormal];
        [_changeBt setBackgroundImage:[UIImage imageNamed:@"Line_Select"] forState:UIControlStateHighlighted];
        [_changeBt setTag:_tag_bt+3];
        [_changeBt addTarget:self action:@selector(changeGraphAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBt;
}
- (GKBarGraph *)graphView
{
    if (!_graphView)
    {
        _graphView = [[GKBarGraph alloc] initWithFrame:CGRectMake(0, 125, Screen_Width, (Screen_Height-345-10))];
        [_graphView setBackgroundColor:[UIColor clearColor]];
        _graphView.dataSource = self;
        [_graphView setBarColor:UIColorRef(253, 132, 46)];
        [self.view addSubview:_graphView];
        _graphView.barHeight = 70;
        _graphView.marginBar = 12;
        _graphView.barWidth = 20;
    }
    return _graphView;
}
- (GKLineGraph *)lineView
{
    if (!_lineView)
    {
        _lineView = [[GKLineGraph alloc] initWithFrame:CGRectMake(0, 125, Screen_Width, (Screen_Height-345-10))];
        [_lineView setBackgroundColor:[UIColor clearColor]];
        _lineView.dataSource = self;
        _lineView.lineWidth = 3.0;
        _lineView.valueLabelCount = 10;
        [self.view addSubview:_lineView];
    }
    return _lineView;
}
- (UILabel *)numLB
{
    if (!_numLB)
    {
        _numLB = [[UILabel alloc] init];
        [_numLB setFont:[UIFont systemFontOfSize:34]];
        _numLB.textColor = BGColor;
    }
    
    return _numLB;
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
- (NSMutableArray *)nowDataList
{
    if (!_nowDataList)
    {
        _nowDataList = [[NSMutableArray alloc] init];
    }
    return _nowDataList;
}
- (NSMutableArray *)selectList
{
    if (!_selectList)
    {
        _selectList = [[NSMutableArray alloc] init];
    }
    return _selectList;
}
- (NSArray *)selecTypeList
{
    if (!_selecTypeList)
    {
        _selecTypeList = [[NSArray alloc] initWithObjects:@"weight", @"bf", @"water", @"muscle", @"bone", @"bmr", @"sfat", @"infat", @"bodyage", @"amr", nil];
    }
    return _selecTypeList;
}
- (NSArray *)btnName
{
    if (!_btnName)
    {
        _btnName = [[NSArray alloc] initWithObjects:@"体重",@"体脂率",@"水含量", @"肌肉比例", @"骨重", @"基础代谢", @"皮下脂肪",@"内脏脂肪",@"身体年龄", @"身体代谢", nil];
    }
    return _btnName;
}
- (NSArray *)btnImage
{
    if (!_btnImage)
    {
        _btnImage = [[NSArray alloc] initWithObjects:@"health",@"health",@"health", @"health", @"health", @"health", @"health",@"health",@"health", @"health", nil];
    }
    return _btnImage;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"趋势图";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self baseConfigs];
    [self createBottomView];
    [self createSecondView];
    [self selectTimeBt:self.weekBt];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)baseConfigs
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.mas_equalTo(@0);
        maker.right.mas_equalTo(@0);
        maker.top.mas_equalTo(@0);
        maker.height.mas_equalTo(@80);
    }];
    [self.topView addSubview:self.mounthBt];
    [self.mounthBt mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(@((Screen_Width-71)/2));
        maker.width.equalTo(@71);
        maker.height.equalTo(@35);
        maker.top.equalTo(@14);
    }];
    [self.topView addSubview:self.weekBt];
    [self.weekBt mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.equalTo(self.mounthBt.mas_left).with.offset(-15);
        maker.width.equalTo(@71);
        maker.height.equalTo(@35);
        maker.top.equalTo(@14);
    }];
    [self.topView addSubview:self.yearBt];
    [self.yearBt mas_makeConstraints:^(MASConstraintMaker *maker){
         maker.left.equalTo(self.mounthBt.mas_right).with.offset(15);
         maker.width.equalTo(self.mounthBt);
         maker.height.equalTo(self.mounthBt);
         maker.top.equalTo(self.mounthBt);
     }];
    [self.topView addSubview:self.preStepBt];
    [self.preStepBt mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(self.weekBt);
        maker.top.equalTo(self.weekBt.mas_bottom).with.offset(5);
        maker.width.equalTo(@11);
        maker.height.equalTo(@22);
    }];
    [self.topView addSubview:self.nextStepBt];
    [self.nextStepBt mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.equalTo(self.yearBt);
        maker.top.equalTo(self.weekBt.mas_bottom).with.offset(5);
        maker.width.equalTo(@11);
        maker.height.equalTo(@22);
    }];
    [self.topView addSubview:self.timeLB];
    [self.timeLB mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.centerX.equalTo(_mounthBt.mas_centerX);
        maker.top.equalTo(self.preStepBt);
    }];
}
- (void)createBottomView
{
    _bottomView = [[UIView alloc] init];
    [_bottomView setBackgroundColor:UIColorRef(232, 232, 232)];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(@0);
        maker.right.equalTo(@0);
        maker.bottom.equalTo(@0);
        maker.height.equalTo(@115);
    }];
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share_bg"]];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(@0);
        maker.right.equalTo(@0);
        maker.bottom.equalTo(_bottomView.mas_bottom).offset(-5);
        maker.height.equalTo(@99);
    }];
    bgView.userInteractionEnabled = YES;
    
    UILabel *textLb = [[UILabel alloc] init];
    [textLb setText:@"综合健康指数:"];
    textLb.textColor = BGColor;
    [self.view addSubview:textLb];
    [textLb mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(bgView.mas_left).offset(20);
        maker.top.equalTo(bgView.mas_top).offset((99-14)/2);
    }];
    [self.view addSubview:self.numLB];
    [self.numLB mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(textLb.mas_right).offset(10);
        maker.top.equalTo(bgView.mas_top).offset((99-34)/2);
    }];
    UIButton *shareBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBt setBackgroundImage:[UIImage imageNamed:@"shareBtBg"] forState:UIControlStateNormal];
    [shareBt addTarget:self action:@selector(selectedShareBt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBt];
    [shareBt mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.right.equalTo(bgView.mas_right).with.offset(-4);
        maker.top.equalTo(bgView.mas_top).with.offset((99-110/2)/2);
        maker.width.equalTo(@(55/2));
        maker.height.equalTo(@(110/2));
    }];
}
- (void)createSecondView
{
    _secondView = [[UIView alloc] init];
    [_secondView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_secondView];
    [_secondView mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(@0);
        maker.right.equalTo(@0);
        maker.top.equalTo(_topView.mas_bottom);
        maker.bottom.equalTo(_bottomView.mas_top);
    }];
    
    UIButton *askBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [askBt setBackgroundImage:[UIImage imageNamed:@"askBt"] forState:UIControlStateNormal];
    [askBt setTag:_tag_bt+2];
    [askBt addTarget:self action:@selector(selectBt:) forControlEvents:UIControlEventTouchUpInside];
    [_secondView addSubview:askBt];
    [askBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@25);
        make.top.equalTo(@13);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [_secondView addSubview:self.changeBt];
    [self.changeBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-25));
        make.top.equalTo(askBt);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    [scrollview setBackgroundColor:[UIColor clearColor] ];
    [scrollview setScrollEnabled:YES];
    [_secondView addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(_secondView.mas_bottom).with.offset(5);
        make.height.equalTo(@58);
    }];
    [scrollview setContentSize:CGSizeMake(320*2, 58)];
    
    UIView *grayView = [[UIView alloc] init];
    [grayView setBackgroundColor:UIColorRef(166, 166, 166)];
    [scrollview addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(scrollview.contentSize.width));
        make.height.equalTo(@0.5);
    }];
    for (int i =0; i<[self.btnName count]; i++)
    {
        ButtonExten *bt = [ButtonExten buttonWithType:UIButtonTypeCustom];
        [bt setBackgroundColor:[UIColor clearColor]];
        [bt setImage:[UIImage imageNamed:self.btnImage[i]] WithText:self.btnName[i] WithState:UIControlStateNormal];
        [bt setTag:10000+i];
        [bt addTarget:self action:@selector(changeBtAction:) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitleColor:UIColorRef(166, 166, 166) forState:UIControlStateNormal];
        [bt setTitleColor:BGColor forState:UIControlStateSelected];
        [scrollview addSubview:bt];
        [bt setFrame:CGRectMake(62*i, 0, 62, 55)];
        if (i==0)
        {
            [bt setSelected:YES];
            _greenLineView = [[UIView alloc] init];
            [_greenLineView setBackgroundColor:BGColor];
            [scrollview addSubview:_greenLineView];
            [_greenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
                make.top.equalTo(@0);
                make.width.equalTo(@62);
                make.height.equalTo(@2);
            }];
        }
    }
    _isLine = NO;
    
    UIImageView *line1= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    [_secondView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(askBt.mas_right);
        make.top.equalTo(askBt.mas_bottom).with.offset(30);
    }];
    
    UIImageView *line2= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    [_secondView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(askBt.mas_right);
        make.top.equalTo(scrollview.mas_top).with.offset(-50);
    }];
}

- (void)selectedShareBt
{
    [self.navigationController pushViewController:[[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil] animated:YES];
}
//按钮切换
- (void)changeBtAction:(id)sender
{
    UIButton *bt = (UIButton*)sender;
    [bt setSelected:YES];
    int tag = (int)(bt.tag-10000);
    self.selectTypeString = self.selecTypeList[tag];
    [_greenLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(62*(tag)));
    }];
    for (int i = 0; i < self.selecTypeList.count; i++)
    {
        if (i != tag)
        {
            UIButton *mBt = (UIButton*)[self.view viewWithTag:10000+i];
            [mBt setSelected:NO];
        }
    }
    [self getDetailData];
}
-(void)selectBt:(id)sender
{
    UIButton *bt = (UIButton *)sender;
    switch (bt.tag)
    {
        case 100:
            
            break;
        case 101:
            
            break;
        case 102:
            
            break;
        case 103:
        {
        }
            break;
        default:
            break;
    }
}
- (void)backAction
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

-(void)getInfoFromService
{
    [self.nowDataList removeAllObjects];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * urlStr = nil;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [self addProgressHUD];
    NSDictionary *parameters = nil;
    if (self.weekBt.selected == YES)
    {
        NSString *beginString = [[GetFirstDayAndLastDay getWeekBeginAndEndString:self.selectDate] objectAtIndex:0];
        NSString *endString = [[GetFirstDayAndLastDay getWeekBeginAndEndString:self.selectDate] objectAtIndex:1];
        urlStr =  [NSString stringWithFormat:@"%@%@",POSTURL,@"history_week"];
        parameters = @{@"member_id":[FFConfig currentConfig].userId,@"type":@"week",@"start":@"2014-12-21"/*beginString*/, @"end":@"2014-12-27"/*endString*/};
    }
    else if (self.mounthBt.selected == YES)
    {
        NSString *beginString = [GetFirstDayAndLastDay getThisMonth:self.selectDate];
        urlStr =  [NSString stringWithFormat:@"%@%@",POSTURL,@"history_month"];
        parameters = @{@"member_id":[FFConfig currentConfig].userId,@"type":@"month",@"month":@"2014-12"/*beginString*/};
    }
    else if (self.yearBt.selected == YES)
    {
        NSString *beginString = [GetFirstDayAndLastDay getThisYear:self.selectDate];
        urlStr =  [NSString stringWithFormat:@"%@%@",POSTURL,@"history_year"];
        parameters = @{@"member_id":[FFConfig currentConfig].userId,@"type":@"year",@"year":@"2014"/*beginString*/};
    }
    DLog(@"msg_lyywhg:%@", parameters);
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        [self hidenProgress];

        NSData *resData = [[NSData alloc] initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        int errorCode = [[resultDic objectForKey:@"error_code"] intValue];
        if (!errorCode)
        {
            NSDictionary * codeDic = [resultDic objectForKey:@"data"];
            [self.nowDataList addObjectsFromArray:codeDic[@"list"]];
            self.numLB.text = [NSString stringWithFormat:@"%d", [codeDic[@"score"] intValue]];
            [self getDetailData];
        }
        else
        {
            NSString * errReson = [[resultDic objectForKey:@"error_msg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            DLog(@"%@",errReson);
            BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:errReson posY:100];
            [tTip show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        [FFConfig currentConfig].isLogined = @NO;
        [self hidenProgress];
        BBTipView *tTip = [[BBTipView alloc] initWithView:self.view message:@"您的网络出问题了，请检查。" posY:100];
        [tTip show];
        return;
    }];
}
- (void)selectTimeBt:(id)sender
{
    UIButton *bt = (UIButton *)sender;
    [bt setSelected:YES];
    if(bt == self.weekBt)
    {
        self.timeLB.text = [GetFirstDayAndLastDay getWeekBeginToEndString:self.selectDate];
        [self.mounthBt setSelected:NO];
        [self.yearBt setSelected:NO];
    }
    else if (bt == self.mounthBt)
    {
        self.timeLB.text = [GetFirstDayAndLastDay getThisMonthString:self.selectDate];
        [self.weekBt setSelected:NO];
        [self.yearBt setSelected:NO];
    }
    else if (bt == self.yearBt)
    {
        self.timeLB.text = [GetFirstDayAndLastDay getThisYearString:self.selectDate];
        [self.weekBt setSelected:NO];
        [self.mounthBt setSelected:NO];
    }
    [self getInfoFromService];
}
- (void)changeTime:(id)sender
{
    UIButton *bt = (UIButton *)sender;
    if (bt.tag == _tag_bt)
    {
        if (self.weekBt.selected == YES)
        {
            self.selectDate = [GetFirstDayAndLastDay lastWeekDate:self.selectDate];
            [self selectTimeBt:self.weekBt];
        }
        else if (self.mounthBt.selected == YES)
        {
            self.selectDate = [GetFirstDayAndLastDay lastMonthDate:self.selectDate];
            [self selectTimeBt:self.mounthBt];
        }
        else if (self.yearBt.selected == YES)
        {
            self.selectDate = [GetFirstDayAndLastDay lastYearDate:self.selectDate];
            [self selectTimeBt:self.yearBt];
        }
    }
    else
    {
        if (self.weekBt.selected == YES)
        {
            self.selectDate = [GetFirstDayAndLastDay nextWeekDate:self.selectDate];
            [self selectTimeBt:self.weekBt];
        }
        else if (self.mounthBt.selected == YES)
        {
            self.selectDate = [GetFirstDayAndLastDay nextMonthDate:self.selectDate];
            [self selectTimeBt:self.mounthBt];
        }
        else if (self.yearBt.selected == YES)
        {
            self.selectDate = [GetFirstDayAndLastDay nextYearDate:self.selectDate];
            [self selectTimeBt:self.yearBt];
        }
    }
}
- (void)getDetailData
{
    [self.selectList removeAllObjects];
    if (self.nowDataList.count > 0)
    {
        if ([self.nowDataList[0] isKindOfClass:[NSDictionary class]])
        {
            for (NSDictionary *dict in self.nowDataList)
            {
                NSMutableDictionary *tDict = [[NSMutableDictionary alloc] init];
                NSString *timeString = dict[@"date"];
                NSDateFormatter *formater = [[NSDateFormatter alloc] init];
                [formater setDateFormat:@"yyyy-MM-dd"];
                NSDate *date = [formater dateFromString:timeString];
                if (self.weekBt.selected == YES)
                {
                    [formater setDateFormat:@"MM-dd"];
                    timeString = [formater stringFromDate:date];
                }
                else if (self.mounthBt.selected == YES)
                {
                    [formater setDateFormat:@"MM-dd"];
                    timeString = [formater stringFromDate:date];
                }
                else if (self.yearBt.selected == YES)
                {
                    [formater setDateFormat:@"yyyy-MM"];
                }
                [tDict setObject:timeString forKey:@"time"];
                [tDict setObject:dict[self.selectTypeString] forKey:@"data"];
                [self.selectList addObject:tDict];
            }
        }
    }
    if (_isLine == NO)
    {
        self.lineView.alpha = 0.0f;
        self.graphView.alpha = 1.0f;
        [self.graphView draw];
    }
    else
    {
        self.graphView.alpha = 0.0f;
        [self.lineView draw];
        self.lineView.alpha = 1.0f;
        [self.lineView draw];
    }
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
- (void)changeGraphAction
{
    if (_isLine)
    {
        self.lineView.alpha = 0.0f;
        self.graphView.alpha = 1.0f;
        [self.graphView draw];
        _isLine = NO;
    }
    else
    {
        self.graphView.alpha = 0.0f;
        [self.lineView draw];
        self.lineView.alpha = 1.0f;
        _isLine = YES;
    }
}
#pragma mark
#pragma mark - Other Delegate
// Grap
- (NSInteger)numberOfBars
{
    if (self.selectList.count == 0)
    {
        return 0;
    }
    return self.selectList.count;
}
- (NSNumber *)valueForBarAtIndex:(NSInteger)index
{
    if (self.selectList.count == 0)
    {
        return @0;
    }
    return @([[self.selectList[index] objectForKey:@"data"] floatValue]);
}
- (NSString *)titleForBarAtIndex:(NSInteger)index
{
    if (self.selectList.count == 0)
    {
        return @"";
    }
    return [self.selectList[index] objectForKey:@"time"];
}
- (CFTimeInterval)animationDurationForBarAtIndex:(NSInteger)index
{
    CGFloat percentage = [[self valueForBarAtIndex:index] doubleValue];
    percentage = (percentage / 100);
    return (self.graphView.animationDuration * percentage);
}
// Line
- (NSInteger)numberOfLines
{
    if (self.selectList.count == 0)
    {
        return 0;
    }

    return [self.selectList count];
}
- (NSArray *)valuesForLineAtIndex:(NSInteger)index
{
    if (self.selectList.count == 0)
    {
        return nil;
    }
    NSMutableArray *tList = [[NSMutableArray alloc] init];
    for (NSDictionary *tDict in self.selectList)
    {
        [tList addObject:@([tDict[@"data"] floatValue])];
    }
    return tList;
}
- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index
{
    return 0.5;
}
- (NSString *)titleForLineAtIndex:(NSInteger)index
{
    if (self.selectList.count == 0)
    {
        return @"";
    }
    return [self.selectList[index] objectForKey:@"time"];
}

@end
