//
//  HistoryDataViewController.m
//  ViewDraw
//
//  Created by Go Salo on 14-5-13.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "HistoryDataViewController.h"
#import "HistoryDataTableViewCell.h"
#import "HistoryDetailDataTableViewCell.h"
#import "HistoryDataTableViewHeaderView.h"
#import "HistoryDetailDataTableViewHeaderView.h"
#import "HistoryDetailDataTableViewHeaderView.h"
#import "PCEntity.h"
#import "CalculateTool.h"
#import "UINavigationController+Flip.h"
#import "BaseNavigationController.h"
#import "NewShareViewViewController.h"
#import "HistoryDetailDeleteTableViewCell.h"
#import "DeleteDataTipsView.h"

@interface HistoryDataViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *totalTableView;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (weak, nonatomic) IBOutlet UIView *noDataView;
@property (weak, nonatomic) IBOutlet UILabel *text;

@property (nonatomic, strong)NSMutableArray *dataList;

@end

@implementation HistoryDataViewController {
    NSIndexPath *_selectedIndexPath;
    NSArray     *_attriKeys;
    UIActivityIndicatorView *indicatorView;
    BOOL        _isLoading;
    int         _pageNo;
    BOOL        _noMore;
}

- (void)dealloc {

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"历史数据";
        _isLoading = NO;
        _pageNo = 0;
        _noMore = NO;
        self.dataList = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 16, 25);
    [backButton setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back_icon_press"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    
    if (kIsiOS_7) {
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -11, 0, 0)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    } else {
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, 26, 26);
    [barButton setImage:[UIImage imageNamed:@"quxian"] forState:UIControlStateNormal];
    [barButton addTarget:self action:@selector(flipToTrending) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    _selectedIndexPath = nil;
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
    [self.view addSubview:indicatorView];
    [indicatorView startAnimating];
    
    
    // 清除渐变背景
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.dataList.count == 0) {
        self.totalTableView.hidden = YES;
        self.detailTableView.hidden = YES;
        self.noDataView.hidden = YES;
        self.text.hidden = YES;
        
        _isLoading = YES;
        _attriKeys = @[@"UD_WEIGHT", @"UD_BMI", @"UD_FAT", @"UD_WATER", @"UD_MUSCLE", @"UD_BONE", @"UD_METABOLISM", @"UD_eBMR", @"UD_SKINFAT", @"UD_OFFALFAT", @"UD_BODYAGE", @"UD_CHECKDATE"];
        
        [[InterfaceModel sharedInstance] getCurrentUserTotalDataByPageId:_pageNo callback:^(NSArray *dataList) {
            if (dataList.count == 0) {
                _noMore = YES;
            }
            [self.dataList addObjectsFromArray:dataList];
            [self.totalTableView reloadData];
            
            if (self.dataList.count > 0) {   // 有数据选择第一行
                [self.totalTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
                [self tableView:self.totalTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            } else {
                self.noDataView.hidden = NO;
            }
            self.text.hidden = NO;
            self.totalTableView.hidden = NO;
            self.detailTableView.hidden = NO;
            
            _isLoading = NO;
            [indicatorView stopAnimating];
        }];
    }
}

#pragma mark - Private Method
- (void)deleteActionWithIndexPath:(NSIndexPath *)indexPath {
    [DeleteDataTipsView showDeleteDataTipsViewWithConfirmHandler:^(DeleteDataTipsView *tipsView, NSInteger selectedIndex) {
        
        [[InterfaceModel sharedInstance] deleteDataWithData:self.dataList[_selectedIndexPath.section][@"list"][_selectedIndexPath.row] reason:selectedIndex callback:^(WebCallBackResult result, id successParam, NSString *errorMsg) {
            if (errorMsg) {
                [self showHUDInView:self.view justWithText:errorMsg disMissAfterDelay:1.5f];
            } else {
                NSMutableArray *dataList = self.dataList[_selectedIndexPath.section][@"list"];
                
                if (dataList.count == 1) {
                    [dataList removeObjectAtIndex:_selectedIndexPath.row];
                    [self.dataList removeObjectAtIndex:_selectedIndexPath.section];
                    [self.totalTableView deleteSections:[NSIndexSet indexSetWithIndex:_selectedIndexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
                } else {
                    [dataList removeObjectAtIndex:_selectedIndexPath.row];
                    [self.totalTableView deleteRowsAtIndexPaths:@[_selectedIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
                }
                
                // 计算删除掉泡泡之后选择哪个泡泡
                if (_selectedIndexPath.section == 0 && _selectedIndexPath.row == 0) { // 如果选择的是第一个格 而且数据已经为空 则 制空
                    if (!self.dataList.count) {
                        _selectedIndexPath = nil;
                    }
                } else {
                    if (dataList.count < _selectedIndexPath.row + 1) { // 如果当前日期的数据数量 删除掉的是最后一次数据
                        
                        if (self.dataList.count > _selectedIndexPath.section + 1) {         // 如果还有更早日期
                            _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:_selectedIndexPath.section + 1];
                        } else if (self.dataList.count <= _selectedIndexPath.section + 1) { // 如果没有更早日期
                            if (dataList.count == 0) {          // 如果当前天没有数据
                                NSMutableArray *lastDataList = self.dataList[_selectedIndexPath.section - 1][@"list"];
                                _selectedIndexPath = [NSIndexPath indexPathForRow:lastDataList.count - 1 inSection:_selectedIndexPath.section - 1];
                            } else {                                // 如果当前天还有数据
                                _selectedIndexPath = [NSIndexPath indexPathForRow:_selectedIndexPath.row - 1 inSection:_selectedIndexPath.section];
                            }
                        }
                    }
                }
                
                // 有数据则选择相应的泡泡，没有数据则显示没有数据
                if (self.dataList.count) {
                    [self.totalTableView selectRowAtIndexPath:_selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                    [self tableView:self.totalTableView didSelectRowAtIndexPath:_selectedIndexPath];
                } else {
                    self.noDataView.hidden = NO;
                    self.text.hidden = YES;
                    self.totalTableView.hidden = YES;
                    self.detailTableView.hidden = YES;
                }
            }
        }];
    } cancelHandler:nil];
    
    [Flurry logEvent:@"数据统计" withParameters:@{@"删除历史数据按钮":@"删除数据"} timed:YES];
}

#pragma mark - Action 

- (void)dismissVC {

    [self dismissViewControllerAnimated:YES completion:NULL];
    
    [Flurry logEvent:@"数据统计" withParameters:@{@"导航栏左侧按钮":@"关闭数据统计"} timed:YES];
}

- (void)flipToTrending {
    [self.navigationController popWithTransition:UIViewAnimationTransitionFlipFromLeft];
    
    [Flurry logEvent:@"数据统计" withParameters:@{@"导航栏右侧按钮":@"切换到图表"} timed:YES];
}

#pragma mark - UITableView Delegate and DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.totalTableView) {
        return self.dataList.count;
    } else return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.totalTableView) {
        return [[self.dataList[section] objectForKey:@"list"] count];
    } else {
        if (_attriKeys.count > 0) {
            return _attriKeys.count;
        } return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.totalTableView) {
        static NSString *identifier = @"HistoryDataViewCell";
        HistoryDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HistoryDataTableViewCell" owner:self options:nil] firstObject];
        }
        
        UserDataEntity *userData = self.dataList[indexPath.section][@"list"][indexPath.row];
        float ryfit = [CalculateTool calculateRyFitWithUserInfo:[[InterfaceModel sharedInstance] getHostUser] data:userData];
        [cell setRyfitValue:ryfit];
        return cell;
    } else {
        if (_attriKeys.count - 1 == indexPath.row) {
            static NSString *identifier = @"DeleteDataCell";
            HistoryDetailDeleteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"HistoryDetailDeleteTableViewCell" owner:self options:nil] firstObject];
            }
            
            __weak HistoryDataViewController *wself = self;
            [cell setDeleteBlock:^{
                [wself deleteActionWithIndexPath:indexPath];
            }];
            
            return cell;
        } else {
            static NSString *identifier = @"HistoryDetailDataViewCell";
            HistoryDetailDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"HistoryDetailDataTableViewCell" owner:self options:nil] firstObject];
            }
        
            if (_selectedIndexPath) {
                UserDataEntity *dataEntity = self.dataList[_selectedIndexPath.section][@"list"][_selectedIndexPath.row];
                NSString *value = [dataEntity valueForKey:_attriKeys[indexPath.row]];
                PCEntity *pcEntity = dataEntity.UD_pcEntityList[indexPath.row];
                [cell setType:indexPath.row valueString:value health:pcEntity.pc_status];
            }
            
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.totalTableView) {
        return 55;
    } else {
        self.noDataView.hidden = YES;
        if (_selectedIndexPath) {
            UserDataEntity *userData = self.dataList[_selectedIndexPath.section][@"list"][_selectedIndexPath.row];
            float ryfit = [CalculateTool calculateRyFitWithUserInfo:[[InterfaceModel sharedInstance] getHostUser] data:userData];
            if (ryfit == -1) {
                return 67;
            } else {
                return 48;
            }
        } else {
//            self.noDataView.hidden = NO;
            return 0;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.totalTableView) {
        HistoryDataTableViewHeaderView *headerView = [[HistoryDataTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, 111, 55)];
        [headerView setDateString:self.dataList[section][@"date"]];
        return headerView;
    } else {
        HistoryDetailDataTableViewHeaderView *headerView = [[HistoryDetailDataTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, 209, 48)];
        if (_selectedIndexPath) {
            UserDataEntity *userDataEntity = self.dataList[_selectedIndexPath.section][@"list"][_selectedIndexPath.row];
            float ryfit = [CalculateTool calculateRyFitWithUserInfo:[[InterfaceModel sharedInstance] getHostUser] data:userDataEntity];
            BOOL isError = NO;
            if (ryfit == -1) {
                isError = YES;
            }
            [headerView setDataString:userDataEntity.UD_CHECKDATE isError:isError];
            
        }
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.totalTableView) {
        if ([_selectedIndexPath isEqual:indexPath]) {
            return 77;
        }
        return 54;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.totalTableView) {
        _selectedIndexPath = indexPath;
        [self.totalTableView beginUpdates];
        [self.totalTableView endUpdates];

        [self.detailTableView reloadData];
    }
    
    [Flurry logEvent:@"数据统计" withParameters:@{@"ryfit指数列表":@"查看详细数据"} timed:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentSize.height * 0.8 <= scrollView.contentOffset.y + scrollView.frame.size.height) {
        if (!_isLoading && !_noMore) {
            _pageNo ++;
            _isLoading = YES;
            [[InterfaceModel sharedInstance] getCurrentUserTotalDataByPageId:_pageNo callback:^(NSArray *dataList) {
                if (dataList.count == 0) {
                    _noMore = YES;
                }
                
                NSLog(@"%@", dataList);
                
                if ([[dataList firstObject][@"date"] isEqualToString:[self.dataList lastObject][@"date"]]) {
                    NSMutableArray *newFirstList = [dataList firstObject][@"list"];
                    NSMutableArray *oldLastList = [self.dataList lastObject][@"list"];
                    [oldLastList addObjectsFromArray:newFirstList];
                    
                    [((NSMutableArray *)dataList) removeObjectAtIndex:0];
                }
                
                NSLog(@"%@", dataList);
                
                [self.dataList addObjectsFromArray:dataList];
                _isLoading = NO;
                [self.totalTableView reloadData];
                [self.totalTableView selectRowAtIndexPath:_selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                [self tableView:self.totalTableView didSelectRowAtIndexPath:_selectedIndexPath];
            }];
        }
    }
}

@end
