//
//  ChannelViewController.m
//  ARVeryCD
//
//  Created by August on 14-7-29.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "ChannelViewController.h"
#import "VCHTTPClient+Channel.h"
#import "ChannelCollectionView.h"
#import "ChannelCollcetionViewCell.h"

@interface ChannelViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *channels;
@property (weak, nonatomic) IBOutlet ChannelCollectionView *collcetionView;

@end

@implementation ChannelViewController

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
    [self fetchData];
}

#pragma mark - Private methods

-(void)baseConfigs
{
    self.channels = [NSMutableArray array];
    [self.collcetionView registerNib:[UINib nibWithNibName:@"ChannelCollcetionViewCell" bundle:nil] forCellWithReuseIdentifier:@"channelCell"];
    self.collcetionView.delegate = self;
    self.collcetionView.dataSource = self;
}

-(void)fetchData
{
    [VCHTTPClient fetchChannelListWithFinishedBlock:^(NSArray *channels) {
        [self.channels addObjectsFromArray:channels];
        [self.collcetionView reloadData];
    } failedBlock:^(NSError *error) {

    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(290, 200);
}

#pragma mark - UICollcetionViewDataSource methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channels.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelCollcetionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"channelCell" forIndexPath:indexPath];
    [cell buildCellWithChannel:self.channels[indexPath.row]];
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
