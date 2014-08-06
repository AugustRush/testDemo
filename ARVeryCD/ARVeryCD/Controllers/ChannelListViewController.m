//
//  ChannelListViewController.m
//  ARVeryCD
//
//  Created by August on 14-8-5.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ChannelListViewController.h"
#import "ChannelListCollctionView.h"
#import "ChannelListCollectionViewCell.h"
#import "VCHTTPClient+ChannelList.h"

@interface ChannelListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet ChannelListCollctionView *collectionVIew;
@property (nonatomic, strong) NSMutableDictionary *fetchParamaters;
@property (nonatomic, strong) NSMutableArray *entrys;

@end

@implementation ChannelListViewController

#pragma mark - lifeCycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil catalogId:(NSString *)catalogId
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.catalogId = catalogId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self baseConfigs];
    [self fetchChannelEntrysList];
}

#pragma mark - Private methods

-(void)baseConfigs
{
    [self.collectionVIew registerNib:[UINib nibWithNibName:@"ChannelListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CHANNELLISTCELL"];
    self.collectionVIew.dataSource = self;
    self.collectionVIew.delegate = self;
    
    self.fetchParamaters = [NSMutableDictionary dictionary];
    [self.fetchParamaters setObject:@"18" forKey:@"count"];
    [self.fetchParamaters setObject:@"1" forKey:@"page"];
    [self.fetchParamaters setObject:self.catalogId forKey:@"catalog_id"];
    [self.fetchParamaters setObject:@"1" forKey:@"show_options"];
    
    self.entrys = [NSMutableArray array];
}

-(void)fetchChannelEntrysList
{
    [VCHTTPClient fetchChannelListWithParamaters:self.fetchParamaters FinishedBlock:^(NSArray *entrys) {
        [self.entrys removeAllObjects];
        [self.entrys addObjectsFromArray:entrys];
        [self.collectionVIew reloadData];
    } failedBlock:^(NSError *error) {

    }];
}

#pragma mark - UICollectionViewDataSource methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.entrys.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHANNELLISTCELL" forIndexPath:indexPath];
    [cell buildCellWithChannelListEntry:self.entrys[indexPath.row]];
    return cell;
}

#pragma mark - manage memory methods

-(void)dealloc
{}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
