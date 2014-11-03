//
//  ViewController.m
//  CollectionViewTable
//
//  Created by August on 14/11/2.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *texts;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) CollectionViewCell *sizeCell;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *texts = @[@"马克手机话费奥哈佛卡地方大家骚动佛撒的佛啊是发送后啊发哈松地方送啊哈佛啊大佛萨佛啊豆腐花",
                       @"你好啊",
                       @"en",
                       @"尼克斯队看撒哦副科级阿拉丁发票短发批发商的地方啊平均分啊平时的肌肤怕等级分怕谨防扒手地方分啊发泡剂地方撒泼放阿桑的肌肤怕十分惧怕减肥怕等级分怕分 啊师傅批发商酒店发票就啊啊谁地方跑法朴素大方啊怕就是地方 ",
                       @"aa天淘的五官爱咳嗽 啊上课监督卡哈哈😄哈哈😊撒娇啊谁看得见",
                       @"823902bf20eufh2b28ef02bf20ufb2ufb208fh203b0283f\nwoubfwuefwoejfbwoj\nwefiwvefiwefwieyfwyef\nwefiwefviwhvefiwhefiwhbe\nwyevfwiefwbefwhef\nqivfiqvpqviq\n"];

    self.texts = [NSMutableArray array];
    [self.texts addObjectsFromArray:[texts mutableCopy]];
        [self.texts addObjectsFromArray:[texts mutableCopy]];
        [self.texts addObjectsFromArray:[texts mutableCopy]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    
    self.sizeCell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:nil options:nil] lastObject];
//    self.sizeCell.frame = CGRectMake(0, 0, CGRectGetWidth(self.collectionView.bounds), 100);
//    [self.sizeCell setNeedsLayout];
//    [self.sizeCell layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - flowLayout delegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.texts[indexPath.row];
    self.sizeCell.textLabel.text = text;
    
    self.sizeCell.frame = CGRectMake(0, 0, CGRectGetWidth(self.collectionView.bounds), 100);
    [self.sizeCell setNeedsLayout];
    [self.sizeCell layoutIfNeeded];

    CGSize size = [self.sizeCell systemLayoutSizeFittingSize:CGSizeMake(CGRectGetWidth(collectionView.bounds), 100)];

//    CGSize size = [self.sizeCell systemLayoutSizeFittingSize:CGSizeMake(CGRectGetWidth(collectionView.bounds), 100) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityDefaultLow];
    return size;
}

#pragma mark - dateSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.texts.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.texts[indexPath.row];
    return cell;
}

@end
