//
//  ARActionSheet.h
//  ARSegmentControl
//
//  Created by August on 14-9-3.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ARActionSheetSelectedBlock)(id sender,NSInteger selectIndex);

typedef NS_ENUM(NSUInteger, ARActionSheetItemType) {
    ARActionSheetItemTypeDefault//左边图片，右边文字，以后会增加更多的类型
};

@class ARActionSheetItem;
@interface ARActionSheet : UIWindow

@property (nonatomic, copy) ARActionSheetSelectedBlock selectedBlock;

@property (atomic, assign, readonly) BOOL isShowing;
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
@property (nonatomic, assign, readonly) ARActionSheetItemType itemType;

/**
 *  隐藏和显示的方法
 */
-(void)show;
-(void)hide;

/**
 *  为defaultItem配置相应的图片/高亮图片
 *
 *  @param images          默认图片数组
 *  @param highlightImages 高亮图片数组
 */
-(void)setItemImages:(NSArray *)images highlightImages:(NSArray *)highlightImages;

/**
 *  实例初始化方法
 *
 *  @param titles 决定actionSheet的items数量以及标题
 *
 *  @return ARActionSheet的市里对象
 */
-(instancetype)initWithTitles:(NSArray *)titles;

/**
 *  多了一个type控制item的类型
 *
 *  @param titles   同上
 *  @param itemType item的类型枚举值
 *
 *  @return 实例对象
 */
-(instancetype)initWithTitles:(NSArray *)titles itemType:(ARActionSheetItemType)itemType;

@end


/**
 *  //
 *
 *////////////////////////////////////
/**
 *  item
 */
@interface  ARActionSheetItem: UICollectionViewCell

@property (nonatomic, assign) ARActionSheetItemType type;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end