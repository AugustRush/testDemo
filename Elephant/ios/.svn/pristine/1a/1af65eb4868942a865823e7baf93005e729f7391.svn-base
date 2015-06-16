//
//  ImageViewTextField.h
//  FFLtd
//
//  Created by cw on 12-3-20.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//


@protocol ImageViewTextFieldDelegate <UITextFieldDelegate>
@optional
//点击照相机按钮，触发该方法，遵循此协议的类实现
- (void)cameraButtonClicked:(id)sender;
//点击分享按钮，触发该方法，遵循此协议的类实现
- (void)shareButtonClicked:(id)sender;

@end



@interface ImageViewTextField : UITextField
{
    //用于展示照片
    UIImageView  *_imageView;
    //用于存放照片的数组
    NSMutableArray *_imageList;
    //用于存放照片和关闭按钮组合视图的数组
    NSMutableArray *_imageAndBtnList;
    //用于存放关闭按钮的数组
    NSMutableArray *_closeBtnList;
    //分享到微博的按钮
    UIButton      *_shareBtn;
    //判断是否分享到新浪微博
    BOOL          _isSelected;
    //用于存放绘图后返回的结果
    UIImage *_conbineImage;
    //存放组合后的图片，并用于展示的视图
    UIImageView *_imageConbineView;
    
    
}


/****************getter And Setter method*************/
//照片视图
@property (nonatomic, strong) UIImageView  *imageView;
//分割线
@property (nonatomic,strong) UIImageView  *separatorLine;
//用于展示多张照片的视图
@property (nonatomic,strong)  UIView *showImageList;
//照相机按钮、分享按钮及说明性文字
@property (nonatomic,strong) UIView *takePhotoAndShare;
//图片上悬浮的关闭按钮
@property (nonatomic,strong) UIButton *closeBtn;
//存放照片视图和按钮视图
@property (nonatomic,strong) UIView *imageAndButtonView;
//照片组合后的视图
@property (nonatomic,strong) UIImageView *imageConbineView;
//代理
@property (nonatomic, assign) id <ImageViewTextFieldDelegate> imageViewTextFieldDelegate;
/****************getter And Setter method*************/



//该方法的主要功能是将选取的照片存放到数组中
- (void)setItemByImage:(UIImage *)image;

@end
