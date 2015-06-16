//
//  RemindWeightViewController.m
//  BodyScaleProduction
//
//  Created by Cloud_Ding on 14-5-9.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "RemindWeightViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "RemindWeightTableViewCell.h"

@interface RemindWeightViewController ()
@property (weak, nonatomic) IBOutlet UITableView *RemindWeightTableView;
@property (nonatomic, strong)NSMutableArray *arrayList;
@property (weak, nonatomic) IBOutlet UILabel *noRemind;

@end

@implementation RemindWeightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"提醒我称重的人";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.backgroundView removeFromSuperview];
    self.loadingView = [AQLoadingView new];
    [self.view addSubview:self.loadingView];

    self.arrayList = [NSMutableArray array];

    //self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;

    [[InterfaceModel sharedInstance] queryPraiseWithTargetUid:nil type:3 callBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
        [self.loadingView removeFromSuperview];
        if (result == WebCallBackResultSuccess){
            if (!errorMsg) {
                if ([[successParam class] isSubclassOfClass:[NSArray class]]) {
                    if ([successParam count] > 0) {
                        self.RemindWeightTableView.hidden = NO;
                        self.noRemind.hidden = YES;
                        [self.arrayList addObjectsFromArray:successParam];
                        [self.RemindWeightTableView reloadData];
                    }else{
                        self.RemindWeightTableView.hidden = YES;
                        self.noRemind.hidden = NO;
                    }
                }
            }

        }else {
            self.noRemind.text = errorMsg;
            self.noRemind.hidden = NO;
            self.RemindWeightTableView.hidden = YES;
        }
    }];

}

- (void)viewDidLayoutSubviews {
    self.loadingView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RemindWeightTableViewCell *remindWeightCell = nil;
    if (remindWeightCell == nil) {
        NSArray *array = nil;
        array = [[NSBundle mainBundle] loadNibNamed:@"RemindWeightTableViewCell" owner:self options:nil];
        remindWeightCell = [array lastObject];
    }
    UserPraiseEntity *userPraise = self.arrayList[indexPath.row];
    [remindWeightCell queryRemindWithUserPraise:userPraise];
    remindWeightCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return remindWeightCell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
