//
//  BRCityAreaController.m
//  BodyScaleProduction
//
//  Created by 张诚亮 on 14-6-9.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BRCityAreaController.h"
#import "BRCityAreaControllerCell.h"

@interface BRCityAreaController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataList;
    UITableView *_table;
    int _tp;
}

@end

@implementation BRCityAreaController

-(void)setTP:(int)tp
    dataList:(NSArray *)aryList
{
    _tp         = tp;
    _dataList   = aryList;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}


-(void)viewWillAppear:(BOOL)animated
{
    [self initUI];
}

-(void)initUI
{
    if (_tp) {
        self.navigationItem.title   = @"请选择区县";
    }else{
        self.navigationItem.title   = @"请选择省份";
    }
    
    CGRect _rect                = [UIScreen mainScreen].bounds;
    _rect.size.height           -= (44 + 20);
    _table                      = [[UITableView alloc]initWithFrame:_rect
                                                      style:UITableViewStylePlain];
    _table.delegate         = self;
    _table.dataSource       = self;
    _table.backgroundView   = nil;
    _table.backgroundColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    _table.separatorStyle   = UITableViewCellSeparatorStyleNone;
    _table.allowsSelection  = YES;
    _table.showsVerticalScrollIndicator = YES;
    [self.view addSubview:_table];
}

#pragma mark - table



- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
   return _dataList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier01   = @"BRCityAreaControllerCell";
    BRCityAreaControllerCell *_cellT      = [tableView
                                             dequeueReusableCellWithIdentifier:
                                             identifier01];
    
    if (!_cellT) {
        _cellT = [[[NSBundle mainBundle] loadNibNamed:@"BRCityAreaControllerCell"
                                                owner:self
                                              options:nil] lastObject];
        
        [_cellT initCell];
    }
    
    [_cellT updateCell:_dataList[indexPath.row] index:indexPath];
    return _cellT;
    
}



-       (float)tableView:(UITableView *)tableView
 heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}



#pragma mark - sys
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *_areaStr = @"";
    if (_tp) {
        _areaStr = @"area";
    }else{
        _areaStr = @"city";
    }

    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BRMain"
                                                       object:nil
                                                     userInfo:@{@"cell":_areaStr,
                                                                @"ip":_dataList[indexPath.row]
                                                                }];
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
