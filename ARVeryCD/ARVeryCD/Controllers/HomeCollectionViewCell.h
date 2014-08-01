//
//  HomeCollectionViewCell.h
//  ARVeryCD
//
//  Created by August on 14-7-30.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "VCHomeEntry.h"

@interface HomeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(void)buildCellWithEntry:(VCHomeEntry *)entry;

@end
