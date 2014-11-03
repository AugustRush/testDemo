//
//  CollectionViewCell.m
//  CollectionViewTable
//
//  Created by August on 14/11/2.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor redColor];
}

-(CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize
{
    self.textLabel.preferredMaxLayoutWidth = targetSize.width-80;//
    return [super systemLayoutSizeFittingSize:targetSize];
}

@end
