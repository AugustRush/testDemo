//
//  ViewController.m
//  ARRefreshDemo
//
//  Created by August on 15/6/16.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+ARRefresh.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign) NSUInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.count = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 50, 0);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //refresh header
    __weak typeof(self) wself = self;
    [self.tableView ar_addRefreshHeaderWithTrigger:^(UIScrollView *scrollView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //add more cells
            wself.count += 2;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            
            //end refresh
            [wself.tableView ar_endRefresh];
        });
    }];
    
    
    //infinity scroll
    
    [self.tableView ar_addInfinityScrollWithTrigger:^(UIScrollView *scrollView) {
        NSLog(@"infinity scroll");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //add more cells
            wself.count += 2;
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
            //end refresh
            [wself.tableView ar_endInfinityScroll];
        });

    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.imageView.image = [UIImage imageNamed:@"2.jpeg"];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}

@end
