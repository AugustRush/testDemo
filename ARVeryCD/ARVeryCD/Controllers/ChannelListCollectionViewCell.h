//
//  ChannelListCollectionViewCell.h
//  ARVeryCD
//
//  Created by August on 14-8-5.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCChanelListEntry.h"

@interface ChannelListCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void)buildCellWithChannelListEntry:(VCChanelListEntry *)enrty;

@end
