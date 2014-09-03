//
//  ARActionSheet.h
//  ARSegmentControl
//
//  Created by August on 14-9-3.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ARActionSheetItemType) {
    ARActionSheetItemTypeDefault//左边图片，右边文字，以后会增加更多的类型
};

@class ARActionSheetItem;
@interface ARActionSheet : UIWindow

@property (atomic, assign) BOOL isShowing;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong, readonly) NSArray *titles;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleTintColor;
@property (nonatomic, strong, readonly) NSArray *itemImages;
@property (nonatomic, strong, readonly) NSArray *itemHighlightImages;
@property (nonatomic, assign) BOOL allowsMultipleSelection;

-(void)show;
-(void)hide;

-(void)setItemImages:(NSArray *)images highlightImages:(NSArray *)highlightImages;

-(instancetype)initWithTitles:(NSArray *)titles;

@end

/**
 *  item
 */
@interface  ARActionSheetItem: UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end