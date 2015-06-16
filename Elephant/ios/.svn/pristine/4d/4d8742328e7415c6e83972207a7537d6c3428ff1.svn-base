//
//  FillInfoViewController.m
//  BodyScale
//
//  Created by cxx on 14-11-26.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "FillInfoViewController.h"
#import "UserBaseInfoViewController.h"



#define _tag_bt 1000
@interface FillInfoViewController () <UITextFieldDelegate,TWRPickerSliderDelegate,TWRPickerSliderDatasource>

{
    UIImageView *_sBgView;
    
    UIImageView *nameImgView;
    
    UIImageView *sexImgView;
    
    UIImageView *ageImgView;
    
    UIImageView *heightImgView;
    
    UITextField     *nameTF;
    
    UIButton    *girlBt;
    
    UIButton    *manBt;
    
    UIButton    *ageBt;
    
    UIButton    *heightBt;
    
    TWRSliderStackedView *stack;
    
    UIView      *maskView;
    
    int         ageNum;
    
}

@property(assign,nonatomic) Choose_Gender_Type gender_Type;
@property(strong,nonatomic) NSString * noteName;
@property(strong,nonatomic) NSString * personalHeight;
@property(assign,nonatomic) NSInteger myAge;

@end

@implementation FillInfoViewController
#pragma mark life circle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ishasTextFeild:YES];
    if (self)
    {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"填写资料";
    self.navigationController.navigationBarHidden = NO;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0.0, 0.0,62, 20);
    [right setTitle:@"下一步" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor whiteColor ] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:right];
    temporaryBarButtonItem1.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = temporaryBarButtonItem1;
    
    _sBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seperateLine"]];
    [_sBgView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_sBgView];
    [_sBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@((Screen_Width-225)/2));
        make.top.equalTo(@((Screen_Height-225)/2-26-(TabBar_Height+24)));
        make.width.equalTo(@225);
        make.height.equalTo(@225);
    }];
    _sBgView.userInteractionEnabled = YES;
    
    nameImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bg"]];
    nameImgView.userInteractionEnabled = YES;
    [_sBgView addSubview:nameImgView];
    [nameImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(-20));
        make.top.equalTo(@(-20));
        make.width.equalTo(@123);
        make.height.equalTo(@123);
    }];
    
    
    sexImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bg"]];
    [_sBgView addSubview:sexImgView];
    [sexImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(20));
        make.top.equalTo(@(-20));
        make.width.equalTo(@123);
        make.height.equalTo(@123);
    }];
    
    ageImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bg"]];
    [_sBgView addSubview:ageImgView];
    [ageImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(-20));
        make.bottom.equalTo(@(20));
        make.width.equalTo(@123);
        make.height.equalTo(@123);
    }];
    
    heightImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bg"]];
    [_sBgView addSubview:heightImgView];
    [heightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(20));
        make.bottom.equalTo(@(20));
        make.width.equalTo(@123);
        make.height.equalTo(@123);
    }];
    
    
    UIView *nameTextLb = [self createLable:@"名   字"];
    [nameImgView addSubview:nameTextLb];
    [nameTextLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@(-20));
        make.width.equalTo(@125);
    }];
    
    UIView *sexLb = [self createLable:@"男  .  女"];
    [sexImgView addSubview:sexLb];
    [sexLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@(-20));
        make.width.equalTo(@125);
    }];
    
    UIView *ageLb = [self createLable:@"年   龄"];
    [ageImgView addSubview:ageLb];
    [ageLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@(-20));
        make.width.equalTo(@125);
    }];
    
    UIView *heightLb = [self createLable:@"身   高"];
    [heightImgView addSubview:heightLb];
    [heightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@(-20));
        make.width.equalTo(@125);
    }];
    
    nameTF = [[UITextField alloc]init];
    nameTF.backgroundColor = [UIColor clearColor];
    nameTF.placeholder = @"用户名";
    nameTF.textAlignment = NSTextAlignmentCenter;
    [nameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    nameTF.textColor = [UIColor whiteColor];
    nameTF.delegate = self;
    [nameTF setFont:[UIFont systemFontOfSize:15]];
    [nameTF becomeFirstResponder];
    [nameImgView addSubview:nameTF];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(@7);
        make.top.equalTo(@(40));
        make.width.equalTo(@110);
        make.height.equalTo(@20);
    }];
    
    manBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [manBt setBackgroundImage:[UIImage imageNamed:@"unselected_man"] forState:UIControlStateNormal];
    [manBt setBackgroundImage:[UIImage imageNamed:@"selectedMan"] forState:UIControlStateSelected];
    manBt.tag = _tag_bt;
    [manBt addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [sexImgView addSubview:manBt];
    sexImgView.userInteractionEnabled = YES;
    [manBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@32);
        make.top.equalTo(@40);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    self.gender_Type = Choose_Gender_Type_Male;
    self.personalHeight = [NSString stringWithFormat:@"%@",@"00.0cm"];
    self.myAge = 0;
    
    girlBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [girlBt setBackgroundImage:[UIImage imageNamed:@"unselected_girl"] forState:UIControlStateNormal];
    [girlBt setBackgroundImage:[UIImage imageNamed:@"selected_girl"] forState:UIControlStateSelected];
    girlBt.tag = _tag_bt+1;
    [girlBt addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [sexImgView addSubview:girlBt];
    sexImgView.userInteractionEnabled = YES;
    [girlBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-32));
        make.top.equalTo(@40);
        make.width.equalTo(@18);
        make.height.equalTo(@25);
    }];
    
    ageImgView.userInteractionEnabled = YES;
    ageBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [ageBt setTitle:@"0岁" forState:UIControlStateNormal];
    [ageBt.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ageBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ageBt.tag = _tag_bt+2;
    [ageBt addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [ageImgView addSubview:ageBt];
    [ageBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(40));
        make.width.equalTo(@125);
    }];
    
    heightImgView.userInteractionEnabled = YES;
    heightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [heightBt setTitle:@"00.0cm" forState:UIControlStateNormal];
    [heightBt.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [heightBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    heightBt.tag = _tag_bt+3;
    [heightBt addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [heightImgView addSubview:heightBt];
    [heightBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(40));
        make.width.equalTo(@125);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    nameTF.text = @"";
    manBt.selected = NO;
    girlBt.selected = NO;
    [ageBt setTitle:@"0岁" forState:UIControlStateNormal];
    [heightBt setTitle:@"00.0cm" forState:UIControlStateNormal];

    self.noteName = @"";
    self.personalHeight = [NSString stringWithFormat:@"%@",@"00.0cm"];
    self.myAge = 0;
}


#pragma mark private method
- (void)createPickerView
{
    if (!maskView)
    {
        maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        [maskView setBackgroundColor:[UIColor clearColor]];
        
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        [blackView setBackgroundColor:[UIColor blackColor]];
        [blackView setAlpha:0.5];
        [maskView addSubview:blackView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBlackView)];
        [blackView addGestureRecognizer:tap];
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:maskView];
    
    
    // Picker Slider 1
    TWRPickerSlider *slider1 = [[TWRPickerSlider alloc] init];
    // Colors
    slider1.mainColor = [UIColor whiteColor];
    slider1.secondaryColor = [UIColor blackColor];
    __block FillInfoViewController *fill =self;
    slider1.removeBlackView = ^(){
        [fill removeBlackView];
    };
    NSMutableArray *array = [NSMutableArray array];
    for (int i =0; i<50; i++)
    {
        int height = 150;
        TWRDemoObject *obj = [[TWRDemoObject alloc] initWithTitle:[NSString stringWithFormat:@"%d",(height+i)]];
        [array addObject:obj];
    }
    // Objects for picker
    //    slider1.pickerObjects = @[obj1,obj2,obj3,obj1,obj2,obj3];
    NSMutableArray *cmArray = [NSMutableArray array];
    for (int i =0 ; i<10; i++)
    {
        TWRDemoObject *obj = [[TWRDemoObject alloc] initWithFloatTitle:[NSString stringWithFormat:@".%d",i]];
        [cmArray addObject:obj];
    }
    slider1.pickerObjects = array;
    slider1.cmObjects = cmArray;
    
    
    slider1.rightText = @"身高";
    // Delegate
    slider1.delegate = self;
    
    stack = [[TWRSliderStackedView alloc] initWithPosition:TWRPickerSliderPositionBottom bottomPadding:0];
    stack.type = TWRPickerSliderTypeCustomObjects;
    stack.sliders = @[slider1];
    [maskView addSubview:stack];
}

- (void)createDatePickView
{
    if (!maskView)
    {
        maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        [maskView setBackgroundColor:[UIColor clearColor]];
        
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        [blackView setBackgroundColor:[UIColor blackColor]];
        [blackView setAlpha:0.5];
        [maskView addSubview:blackView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBlackView)];
        [blackView addGestureRecognizer:tap];
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:maskView];
    
    
    TWRPickerSlider *slider1 = [[TWRPickerSlider alloc] init];
    slider1.mainColor = [UIColor whiteColor];
    slider1.secondaryColor = [UIColor blackColor];
    
    __block FillInfoViewController *fill =self;
    slider1.removeBlackView = ^(){
        [fill removeBlackView];
    };
    
    TWRDemoObject *obj = [[TWRDemoObject alloc] initWithTitle:@"title"];
    
    slider1.pickerObjects = @[obj];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *todayTime = @"1990年01月01日";//[dateFormatter stringFromDate:date];
    slider1.rightText = todayTime;
    
    // Delegate
    slider1.delegate = self;
    
    stack = [[TWRSliderStackedView alloc] initWithPosition:TWRPickerSliderPositionBottom bottomPadding:0];
    stack.type = TWRPickerSliderTypeDatePicker;
    stack.sliders = @[slider1];
    [maskView addSubview:stack];
}

- (UIView *)createLable:(NSString *)text
{
    UILabel *textLb = [[UILabel alloc] init];
    [textLb setBackgroundColor:[UIColor clearColor]];
    textLb.text = text;
    [textLb setTextColor:[UIColor whiteColor]];
    [textLb setTextAlignment:NSTextAlignmentCenter];
    [textLb setFont:[UIFont systemFontOfSize:14]];
    return textLb;
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

- (NSTimeInterval)get28YearAgoDate
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    a =  a - 28*365*24*60*60;
    return a;
}

- (void)goToHomePage
{
    if (self.sideMenuViewController == nil)
    {
        self.navigationController.navigationBarHidden = YES;
        UserBaseInfoViewController *leftMenuViewController = [[UserBaseInfoViewController alloc] initWithNibName:@"UserBaseInfoViewController" bundle:nil];
        CenterViewController *centerViewController = [[CenterViewController alloc] initWithNibName:nil bundle:nil ishasTextFeild:NO];
        UINavigationController *centerNavigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
        RESideMenu *msideMenuViewController = [[RESideMenu alloc] initWithContentViewController:centerNavigationController leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
        msideMenuViewController.panFromEdge = YES;
        msideMenuViewController.panGestureEnabled = YES;
        msideMenuViewController.scaleMenuView = NO;
        msideMenuViewController.contentViewShadowEnabled = YES;
        
        centerViewController.fillData.userAge = self.myAge;
        centerViewController.fillData.height = self.personalHeight.integerValue;
        if (Choose_Gender_Type_Male == self.gender_Type)
        {
            centerViewController.fillData.sex = 1;
        }
        else if (Choose_Gender_Type_FMale == self.gender_Type)
        {
            centerViewController.fillData.sex = 0;
        }
        
        [self.navigationController pushViewController:msideMenuViewController animated:YES];
    }
    else
    {
        [self.sideMenuViewController setContentViewController:[[CenterViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
    }
}


- (BOOL)isSetedLegal
{
    if([CommanHelp isStringNULL:nameTF.text])
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"用户名为空" message:@"请正确填写用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return false;
    }
    if ((Choose_Gender_Type_FMale != self.gender_Type) && (Choose_Gender_Type_Male !=  self.gender_Type))
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"性别没设置" message:@"请正确设置性别" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return false;
    }
    if ((self.myAge < 10) || (self.myAge > 80))
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"年龄设置不正确" message:@"本app建议的合适年龄为10岁-80岁，请正确设置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return false;
    }
    NSString * heightPrefix = [self.personalHeight substringWithRange:NSMakeRange(0, 4)];
    double height = [heightPrefix doubleValue];
    if ((height < 80.0) || (height > 249.0))
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"身高设置不正确" message:@"本app建议的合适身高为80cm-249cm，请正确设置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return false;
    }
    return true;
}

#pragma  mark buttonAction
- (void)backAction
{
    DLog(@"%@",[self.navigationController viewControllers]);
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.sideMenuViewController presentLeftMenuViewController];
    }
}

- (void)rightAction
{
    if (! [self isSetedLegal])
    {
        return;
    }
    [nameTF resignFirstResponder];
    [FFConfig currentConfig].userNickName = self.noteName;
    [FFConfig currentConfig].userHeight = self.personalHeight;
    [FFConfig currentConfig].userAge = @(self.myAge);
    [FFConfig currentConfig].userGender = @(self.gender_Type);
    [self goToHomePage];
}

- (void)selectAction:(id)sender
{
    [nameTF resignFirstResponder];
    UIButton *bt = (UIButton *)sender;
    NSInteger num = bt.tag - (NSInteger)_tag_bt;
    switch (num)
    {
        case 0:
        {
            UIButton *mBt = (UIButton *)[self.view viewWithTag:_tag_bt+1];
            
            bt.selected = YES;
            mBt.selected = NO;
            self.gender_Type = Choose_Gender_Type_Male;
        }
            break;
        case 1:
        {
            UIButton *mBt = (UIButton *)[self.view viewWithTag:_tag_bt];
            
            bt.selected = YES;
            mBt.selected = NO;
            self.gender_Type = Choose_Gender_Type_FMale;
        }
            break;
            
        case 2:
        {
            [stack removeFromSuperview];
            stack = nil;
            [[stack.sliders objectAtIndex:0 ] setDelegate:nil];
            [self createDatePickView];
            
        }
            break;
        case 3:
        {
            [stack removeFromSuperview];
            stack = nil;
            [[stack.sliders objectAtIndex:0 ] setDelegate:nil];
            [self createPickerView];
        }
            break;
        default:
            break;
    }
}
- (void)removeBlackView
{
    [maskView removeFromSuperview];
}
#pragma mark TWRPickerSliderDelegate
- (void)objectSelected:(id<TWRPickerSliderDatasource>)selectedObject WithCmSelectedObject:(id<TWRPickerSliderDatasource>)cmSelectedObject sender:(TWRPickerSlider *)sender
{
    if (stack.type == TWRPickerSliderTypeCustomObjects)
    {
        if (selectedObject==nil &&cmSelectedObject != nil) {
            self.personalHeight = [NSString stringWithFormat:@"170.%@cm",[cmSelectedObject twr_pickerFloatTitle]];
            [heightBt setTitle:[NSString stringWithFormat:self.personalHeight,[cmSelectedObject twr_pickerFloatTitle]] forState:UIControlStateNormal];
            
        }
        else if (selectedObject!=nil &&cmSelectedObject == nil)
        {
            self.personalHeight = [NSString stringWithFormat:@"%@.0cm",[selectedObject twr_pickerTitle]];
            [heightBt setTitle:[NSString stringWithFormat:self.personalHeight,[selectedObject twr_pickerTitle]] forState:UIControlStateNormal];
            
            
        }
        else if (selectedObject==nil && cmSelectedObject == nil)
        {
            self.personalHeight = @"170.0cm";
            [heightBt setTitle:self.personalHeight forState:UIControlStateNormal];
            
        }
        else
        {
            self.personalHeight = [NSString stringWithFormat:@"%@%@cm",[selectedObject twr_pickerTitle],[cmSelectedObject twr_pickerFloatTitle]];
            [heightBt setTitle:[NSString stringWithFormat:self.personalHeight,[selectedObject twr_pickerTitle],[cmSelectedObject twr_pickerFloatTitle]] forState:UIControlStateNormal];
        }
    }
}

- (void)dateSelected:(NSDate *)selectedDate sender:(TWRPickerSlider *)sender
{
    if (selectedDate == nil)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *todayTime = @"1990年01月01日";
        selectedDate = [dateFormatter dateFromString:todayTime];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    //NSString *todayTime = [dateFormatter stringFromDate:selectedDate];
    
    NSTimeInterval dateDiff = [selectedDate timeIntervalSinceNow];
    int age=trunc(dateDiff/(60*60*24))/365;
    if (age < 0) {
        age = (int)[self ageWithDateOfBirth:selectedDate];
        
        [ageBt setTitle:[NSString stringWithFormat:@"%d岁",age] forState:UIControlStateNormal];
        self.myAge = age;
    }
    
    DLog(@"Selected object: %d", age);
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![CommanHelp isStringNULL:textField.text])
    {
        self.noteName = textField.text;
    }
}

@end
