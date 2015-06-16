//
//  CommonViewController.m
//  FFLtd
//
//  Created by 两元鱼 on 10-10-11.
//  Copyright 2010 FFLtd. All rights reserved.
//

#import "TPKeyboardAvoidingTableView.h"
#import "CommonViewController.h"
#import "MBProgressHUD.h"
#import "AuthManagerNavViewController.h"


@implementation CommonViewController


@synthesize  tableView = _tableView;

@synthesize tpTableView = _tpTableView;

@synthesize  dlgTimer = _dlgTimer;

@synthesize pageInTime = _pageInTime;

+ (id)controller
{
    return [[self alloc] init];
}

- (id)init{
	
    self = [super init];
	
    if (self) {
		

    }
    return self;
}

- (void)dealloc
{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    
    _tpTableView.dataSource = nil;
    _tpTableView.delegate = nil;
    
    [_dlgTimer invalidate];
    
    [self dismissAllCustomAlerts];
}
- (void)setDlgTimer:(NSTimerHelper *)dlgTimer
{
    if (dlgTimer != _dlgTimer) {
        [_dlgTimer invalidate];
        _dlgTimer = dlgTimer;
    }
}

- (void)displayOverFlowActivityView:(NSString*)indiTitle{
	
	[self.view showHUDIndicatorViewAtCenter:indiTitle];
	
	self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT 
                                                           target:self 
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil 
                                                          repeats:NO];
	
	return;
	
}

- (void)displayOverFlowActivityView:(NSString *)indiTitle maxShowTime:(CGFloat)time
{
    [self.view showHUDIndicatorViewAtCenter:indiTitle];
	
	if (time > 0.0f) {
        self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:time 
                                                               target:self 
                                                             selector:@selector(timeOutRemoveHUDView)
                                                             userInfo:nil 
                                                              repeats:NO];
    }else{
        self.dlgTimer = nil;
    }
	
	return;
}

- (void)displayOverFlowActivityView{
    
	[self.view showHUDIndicatorViewAtCenter:L(@"加载中...")];
    
	self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT 
                                                           target:self 
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil 
                                                          repeats:NO];
	
	return;
	
}

- (void)displayOverFlowActivityView:(NSString*)indiTitle yOffset:(CGFloat)y{
	
	[self.view showHUDIndicatorViewAtCenter:indiTitle yOffset:y];
	
	self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT 
                                                           target:self 
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil 
                                                          repeats:NO];
	
	return;
	
}

- (void)timeOutRemoveHUDView
{
    [self.view hideHUDIndicatorViewAtCenter];
}


- (void)timerOutRemoveOverFlowActivityView
{
	
	[self.view hideActivityViewAtCenter ];
	
	return;
	
	
}

- (void)removeOverFlowActivityView
{
    [self.view hideHUDIndicatorViewAtCenter];

    [_dlgTimer invalidate];
	
}

- (void)presentSheet:(NSString*)indiTitle
{
	
    [self.view showTipViewAtCenter:indiTitle];
}

- (void)presentSuccessLogoSheet:(NSString*)indiTitle{
	
    [self.view showSuccessTipViewAtCenter:indiTitle];
}

- (void)presentFailLogoSheet:(NSString*)indiTitle{
	
    [self.view showFailTipViewAtCenter:indiTitle];
}


- (void)presentSheet:(NSString*)indiTitle posY:(CGFloat)y{
	
    [self.view showTipViewAtCenter:indiTitle posY:y];
    
}

- (void)presentCustomDlg:(NSString*)indiTitle{
	
    BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault
                                                      Title:L(@"system-info")
                                                    message:indiTitle
                                                 customView:nil
                                                   delegate:self
                                          cancelButtonTitle:L(@"Confirm")
                                          otherButtonTitles:nil];
    [alert show];
}
#pragma mark
#pragma mark View Action
- (void)loadView{
	
    [super loadView];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
        
    [super viewDidDisappear:animated];
    
}
#pragma mark
#pragma mark Init & Add
- (UITableView *)tableView
{
	if(!_tableView)
    {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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

- (TPKeyboardAvoidingTableView *)tpTableView
{
	if(!_tpTableView)
    {
		_tpTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		[_tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[_tpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		_tpTableView.scrollEnabled = YES;
		_tpTableView.userInteractionEnabled = YES;
		_tpTableView.delegate =self;
		_tpTableView.dataSource =self;
		_tpTableView.backgroundColor =[UIColor clearColor];
        _tpTableView.backgroundView = nil;
        [self.view addSubview:_tpTableView];
	}
	return _tpTableView;
}
#pragma mark
#pragma mark - TableView Delegate & Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	return 0;	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    DLog(@"Commmon didReceiveMemoryWarning \n");
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
    {
        [super presentViewController:modalViewController animated:animated completion:NULL];
    }
    else
    {
        [super presentModalViewController:modalViewController animated:animated];
    }
}


@end
