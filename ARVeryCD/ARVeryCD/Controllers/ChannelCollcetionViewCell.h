//
//  ChannelCollcetionViewCell.h
//  ARVeryCD
//
//  Created by August on 14-8-1.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCChannel.h"
#import <UIImageView+WebCache.h>

@interface ChannelCollcetionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionlabel;
@property (weak, nonatomic) IBOutlet UILabel *channelLabel;

-(void)buildCellWithChannel:(VCChannel *)channel;

@end
