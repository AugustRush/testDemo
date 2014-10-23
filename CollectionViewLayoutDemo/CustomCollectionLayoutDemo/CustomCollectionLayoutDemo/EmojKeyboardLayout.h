//
//  EmojKeyboardLayout.h
//  CustomCollectionLayoutDemo
//
//  Created by August on 14/10/23.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmojKeyboardLayout : UICollectionViewLayout
{
@private
    NSMutableArray *_layoutAttributes;
    CGSize _itemSize;
}

@property (nonatomic, assign) NSInteger perPageColumn;
@property (nonatomic, assign) NSInteger perPageLine;

@end
