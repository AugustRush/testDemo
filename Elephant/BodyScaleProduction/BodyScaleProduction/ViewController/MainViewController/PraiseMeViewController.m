//
//  PraiseMeViewController.m
//  BodyScaleProduction
//
//  Created by Cloud_Ding on 14-4-21.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "PraiseMeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "PraiseMeTableViewCell.h"

@interface PraiseMeViewController ()

@property (nonatomic, strong)NSMutableArray *arrayList;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *noPrise;



@end

@implementation PraiseMeViewController

#pragma mark - init methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"赞我的人";
    }
    return self;
}

#pragma mark - lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.backgroundView removeFromSuperview];
    self.loadingView = [AQLoadingView new];
    [self.view addSubview:self.loadingView];
    self.arrayList = [NSMutableArray array];

    [[InterfaceModel sharedInstance] queryPraiseWithTargetUid:nil type:1 callBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
        [self.loadingView removeFromSuperview];
        if (result == WebCallBackResultSuccess){
            if (!errorMsg) {

                if ([[successParam class]isSubclassOfClass:[NSArray class]]) {

                    if ([successParam count] > 0){
                        self.noPrise.hidden = YES;
                        self.tableView.hidden = NO;
                        [self.arrayList addObjectsFromArray:successParam];
                        [self.tableView reloadData];
                    }else{
                        self.noPrise.hidden = NO;
                        self.tableView.hidden = YES;
                    }
                }
            }

        }else {
            self.noPrise.text = errorMsg;
            self.noPrise.hidden = NO;
            self.tableView.hidden = YES;
        }

    }];


}

- (void)viewDidLayoutSubviews {
    self.loadingView.frame = self.view.bounds;
}

- (void)praise:(NSIndexPath *)indexPath
{
    UserPraiseEntity *userPraise = self.arrayList[indexPath.row];

    [[InterfaceModel sharedInstance] submitPraiseWithTargetUid:userPraise.up_memid type:1 callBack:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
        if (!errorMsg) {
            userPraise.up_status = @"0";
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }else{
            [self showHUDInView:self.view justWithText:errorMsg disMissAfterDelay:1];
        }

    }];
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
    PraiseMeTableViewCell *cell = nil;
    if (cell == nil) {
        NSArray *cells = nil;
        cells = [[NSBundle mainBundle] loadNibNamed:@"PraiseMeTableViewCell" owner:self options:nil];
        cell = [cells lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UserPraiseEntity *userPraise = self.arrayList[indexPath.row];
    [cell fillCellWithUserPraise:userPraise];
    WEAK_SELF;
    cell.userPraiseBlock = ^{
        STRONG_WEAK_SELF;
        [sself praise:indexPath];
    };

    if ([userPraise.up_status isEqualToString:@"0"]) {
        //cell.praiseHerBtn.image = [UIImage imageNamed:@"praised.png"];
        [cell.praiseHerBtn setBackgroundImage:[UIImage imageNamed:@"praised.png"] forState:UIControlStateNormal];
    }else if ([userPraise.up_status isEqualToString:@"1"]){

        if ([userPraise.up_sex isEqualToString:@"1"])
        {
            //男
            [cell.praiseHerBtn setBackgroundImage:[UIImage imageNamed:@"zanta.png"] forState:UIControlStateNormal];
        }else{
            [cell.praiseHerBtn setBackgroundImage:[UIImage imageNamed:@"praiseHer.png"] forState:UIControlStateNormal];
        }

    }

    return cell;
}

#pragma mark - memory manager methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
