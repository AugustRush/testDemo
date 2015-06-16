//
//  SYUserFeedbackView.m
//  chatViewTest
//
//  Created by 刘平伟 on 14-3-27.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYUserFeedbackView.h"

#define kChatCellReuseIdentifier @"chat__cell"

@implementation SYUserFeedbackView

#pragma mark - init/config methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfig];
    }
    return self;
}


-(void)initConfig
{
    ///
    self.backgroundColor = SYColor(244, 244, 244);
    
    self.clipsToBounds = YES;
    [self registerClass:[SYUserFeedbackCell class] forCellWithReuseIdentifier:kChatCellReuseIdentifier];
    self.dataSource = self;
    self.delegate = self;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    self.collectionViewLayout = flowLayout;
}

-(void)setSuggestArr:(NSArray *)SuggestArr
{
    _SuggestArr = SuggestArr;
    if (_SuggestArr.count > 0) {
        [self reloadData];
        [self setContentOffset:CGPointMake(0, self.contentSize.height - CGRectGetHeight(self.frame)) animated:NO];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SYUserFeedbackCell *cell = [[SYUserFeedbackCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 100)];
    SuggestEntity *suggest = self.SuggestArr[indexPath.row];
    return [cell sizeWithString:suggest.S_content];
}

#pragma mark - UICollectionViewDataSource methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.SuggestArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SYUserFeedbackCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kChatCellReuseIdentifier forIndexPath:indexPath];
    SuggestEntity *suggest = self.SuggestArr[indexPath.row];
    cell.contentLabel.text = suggest.S_content;
    cell.dateLabel.text = suggest.S_createtime;
    if ([suggest.S_status isEqualToString:@"0"]) {
        cell.type = SYUserFeedbackCellTypeSend;
    }else{
        cell.type = SYUserFeedbackCellTypeBack;
    }
    return cell;
}

@end
