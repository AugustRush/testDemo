//
//  HomeViewController.m
//  ARVeryCD
//
//  Created by August on 14-7-29.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *entrys;
@property (weak, nonatomic) IBOutlet HomeCollectionView *collectionView;

@end

@implementation HomeViewController

#pragma mark - lifeCycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self baseConfigs];
    [self fetchListData];
    
}

#pragma mark - Private methods

-(void)baseConfigs
{
    self.title = NSLocalizedStringFromTable(@"Home", @"MY", nil);
    self.entrys = [NSMutableArray array];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionVIewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionVIewHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeSectionHeader"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate= self;
}

-(void)fetchListData
{
    [VCHTTPClient fetchHomeListWithFinishedBlock:^(NSArray *list) {
        [self.entrys addObjectsFromArray:list];
        [self.collectionView reloadData];
    } failedBlock:^(NSError *error) {
        
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 160);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
    
        return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeSectionHeader" forIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - UICollectionViewDataSource methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.entrys.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.entrys[section] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell" forIndexPath:indexPath];
    [cell buildCellWithEntry:self.entrys[indexPath.section][indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate methods

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - manage memory methods

-(void)dealloc
{}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
