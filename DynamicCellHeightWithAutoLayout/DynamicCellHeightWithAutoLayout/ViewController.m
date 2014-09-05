//
//  ViewController.m
//  DynamicCellHeightWithAutoLayout
//
//  Created by August on 14-9-5.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    
    self.dataArr = @[@"love is a story that you and me to make",
                     @"oherwise, i want to tell you what is we can do and must do ,so palease tell me your story and tell you heart, you can ?",
                     @"just make a demo to study",
                     @"aaaaaaaaa\naaaaaaaaaaaa\n",
                     @"wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww",
                     @"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static TableViewCell *sizingCell = nil;
    if (sizingCell == nil) {
     sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    }

    sizingCell.toplabel.text = self.dataArr[indexPath.row%self.dataArr.count];
    sizingCell.botLabel.text = self.dataArr[indexPath.row%self.dataArr.count];

    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    return size.height+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.toplabel.text = self.dataArr[indexPath.row%self.dataArr.count];
    cell.botLabel.text = self.dataArr[indexPath.row%self.dataArr.count];
    return cell;
}

@end
