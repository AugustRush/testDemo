//
//  ARActionSheet.m
//  ARSegmentControl
//
//  Created by August on 14-9-3.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "ARActionSheet.h"

#define kReuseIdentifier @"_ActionCell_"

@interface ARActionSheet ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UIWindow *originKeyWindow;
@property (nonatomic, weak) UICollectionViewController *rootController;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ARActionSheet

#pragma mark - init methods

-(instancetype)initWithTitles:(NSArray *)titles
{
    self = [self init];
    if (self) {
        _titles = titles;
    }
    return self;
}

-(id)init
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(void)initConfigs
{
    self.originKeyWindow = [[[UIApplication sharedApplication] delegate] window];
    self.itemSize = CGSizeMake(CGRectGetWidth(self.originKeyWindow.bounds), 40);
    self.height = 300;
    self.titleColor = [UIColor blackColor];
    self.titleTintColor = [UIColor colorWithRed:105/255.0 green:120/255.0 blue:220/255.0 alpha:1];
    self.backgroundColor = [UIColor whiteColor];
    self.windowLevel = 2001;
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize = CGSizeMake(300, 150);
    self.rootViewController = [[UICollectionViewController alloc] initWithCollectionViewLayout:self.flowLayout];
    self.rootController = (UICollectionViewController *)self.rootViewController;
    self.rootController.collectionView.backgroundColor = [UIColor clearColor];
    self.rootController.collectionView.delegate = self;
    self.rootController.collectionView.dataSource = self;
    [self.rootController.collectionView registerClass:[ARActionSheetItem class] forCellWithReuseIdentifier:kReuseIdentifier];
}

#pragma mark - public methods

-(void)show
{
    [self.originKeyWindow resignFirstResponder];
    [self.originKeyWindow resignKeyWindow];
    [self makeKeyAndVisible];
    self.frame = [self endFrame];
    [UIView animateWithDuration:.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                            self.frame = [self startFrame];
                        }
                     completion:^(BOOL finished) {
                         self.isShowing = YES;
                     }];
}

-(void)hide
{
    [self resignFirstResponder];
    [self resignKeyWindow];
    [self.originKeyWindow makeKeyAndVisible];
    self.frame = [self startFrame];
    [UIView animateWithDuration:.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = [self endFrame];
                     }
                     completion:^(BOOL finished) {
                         self.isShowing = NO;
                     }];
}

-(void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection
{
    _allowsMultipleSelection = allowsMultipleSelection;
    self.rootController.collectionView.allowsMultipleSelection = _allowsMultipleSelection;
}

-(void)setItemImages:(NSArray *)images highlightImages:(NSArray *)highlightImages
{
    _itemImages = images;
    _itemHighlightImages = highlightImages;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.rootController.view.frame = self.bounds;
}

#pragma mark - private methods

-(CGRect)startFrame
{
    return CGRectMake(0, _originKeyWindow.bounds.size.height-self.height, CGRectGetWidth(_originKeyWindow.bounds), self.height);
}

-(CGRect)endFrame
{
    return CGRectMake(0, _originKeyWindow.bounds.size.height+100, CGRectGetWidth(_originKeyWindow.bounds), self.height);
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemSize;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumInteritemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumLineSpacing;
}

#pragma mark - UICollectionViewDataSource methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ARActionSheetItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.row];
    [cell.titleLabel setTextColor:self.titleColor];
    [cell.titleLabel setHighlightedTextColor:self.titleTintColor];
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row < _itemImages.count) {
        [cell.imageView setImage:_itemImages[indexPath.row]];
    }
    
    if (indexPath.row < _itemHighlightImages.count) {
        [cell.imageView setHighlightedImage:_itemHighlightImages[indexPath.row]];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate methods

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index path is %@",indexPath);
}

#pragma mark - manage memory methods

-(void)dealloc
{
    NSLog(@"%@",[self class]);
}

@end


@implementation ARActionSheetItem

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigs];
    }
    return self;
}

-(void)initConfigs
{
    self.contentView.layer.borderWidth = .5;
    self.contentView.layer.borderColor = [UIColor colorWithWhite:.5 alpha:.3].CGColor;
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.imageView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height= CGRectGetHeight(self.bounds);
    self.imageView.frame = CGRectMake(0, 0, height, height);
    self.titleLabel.frame = CGRectMake(height, 0, width-height, height);
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
}

@end

