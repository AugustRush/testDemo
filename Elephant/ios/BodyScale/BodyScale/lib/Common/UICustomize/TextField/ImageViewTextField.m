//
//  ImageViewTextField.m
//  FFLtd
//
//  Created by lanfeng on 12-3-20.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "ImageViewTextField.h"


@implementation ImageViewTextField

@synthesize imageView = _imageView;
@synthesize separatorLine = _separatorLine;
@synthesize showImageList = _showImageList;
@synthesize takePhotoAndShare = _takePhotoAndShare;
@synthesize closeBtn = _closeBtn;
@synthesize imageAndButtonView = _imageAndButtonView;
@synthesize imageConbineView = _imageConbineView;
@synthesize imageViewTextFieldDelegate = _imageViewTextFieldDelegate;


- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.inputAccessoryView = self.showImageList;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.inputAccessoryView = self.showImageList;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.inputAccessoryView = self.showImageList;
    }
    return self;
}

- (void)dealloc
{
}


-(UIView *)showImageList{
    
    if (nil == _showImageList) {
        
        _showImageList = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        _showImageList.backgroundColor = [UIColor whiteColor];
        [_showImageList addSubview:self.takePhotoAndShare];
        
    }
    int i = 0;
    
    if (_imageList != nil && [_imageList count]>0) 
    {
        
        for (_imageList in _imageList) 
        {
            self.closeBtn = [_closeBtnList objectAtIndex:i];
            self.imageAndButtonView =  [_imageAndBtnList objectAtIndex:i];
            [self.imageAndButtonView setFrame:CGRectMake(5+i*45,32, 40, 40)];
            
            [self.imageAndButtonView addSubview:self.imageView];
            [self.imageAndButtonView addSubview:self.closeBtn];
            
            [_showImageList addSubview:self.separatorLine];
            [_showImageList addSubview:self.imageAndButtonView];
            
            
            //test
            /**********************************/
            if (_isSelected) 
            {
                if (nil == _conbineImage) {
                    
                    UIGraphicsBeginImageContext(CGSizeMake(40, 40));
                    _conbineImage = self.imageView.image;
                    [_conbineImage drawInRect:CGRectMake(0,0,40,40)];
                    _conbineImage = UIGraphicsGetImageFromCurrentImageContext();
                }else{
                    UIGraphicsBeginImageContext(CGSizeMake(_conbineImage.size.width+40, 40));
                    [_conbineImage drawInRect:CGRectMake(0,0,_conbineImage.size.width,_conbineImage.size.height)];
                    [self.imageView.image drawInRect:CGRectMake(_conbineImage.size.width,0,40,40)];
                    _conbineImage = UIGraphicsGetImageFromCurrentImageContext();
                }
                UIGraphicsEndImageContext();
                [self.imageConbineView setFrame:CGRectMake(150, 30, _conbineImage.size.width, 40)];
                self.imageConbineView.image = _conbineImage;
                [_showImageList addSubview:self.imageConbineView];
            }
            /**********************************/
            i++;
            
        }
        
    }
    return _showImageList;
}

#pragma mark - imageView CloseBtn imageAndButtonView
-(UIImageView *)imageView{
    if(nil == _imageView){        
        _imageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)]; 
    }
    return _imageView;
}

-(UIButton *)closeBtn{
    if (nil == _closeBtn) 
    {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setFrame:CGRectMake(30, 0, 15, 15)];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        [_closeBtn setBackgroundColor:[UIColor whiteColor]];
        [_closeBtn addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _closeBtn;
    
}

-(UIView *)imageAndButtonView{
    if (nil == _imageAndButtonView) {
        _imageAndButtonView = [[UIView alloc]init];
    }
    return _imageAndButtonView;
}

-(UIImageView *)separatorLine{
    
    if (nil == _separatorLine) {
        _separatorLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 29, 320, 2)];
        _separatorLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
    }
    return  _separatorLine;
}
//test
-(UIImageView *)imageConbineView{
    if (nil == _imageConbineView) {
        _imageConbineView = [[UIImageView alloc]init];
    }
    
    return _imageConbineView;
}


#pragma mark
- (void)setItemByImage:(UIImage *)image{
    if (nil == image)
    {
        return;
    }        
    if (nil == _imageList) 
    {
        _imageList = [[NSMutableArray alloc]init];
    }
    if (nil == _closeBtnList) {
        _closeBtnList = [[NSMutableArray alloc]init];
    }
    if (nil == _imageAndBtnList) {
        _imageAndBtnList = [[NSMutableArray alloc]init];
    }
    self.imageView.image = image;
    
    
    //添加到image视图的数组中。
    [_imageList addObject:self.imageView];
    //每添加一张新照片，给该照片的右上角对应加上一个关闭按钮    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   // tempBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    [tempBtn setFrame:CGRectMake(30, 0, 15, 15)];
    [tempBtn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [tempBtn setBackgroundColor:[UIColor clearColor]];
    [tempBtn addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [_closeBtnList addObject:tempBtn];
    //存放照片和按钮的容器视图
    UIView *tempView = [[UIView alloc]init];
    [_imageAndBtnList addObject:tempView];
    
    [super setNeedsLayout];
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if ([_imageList count] == 0) {
        //当用户还没有添加照片时，显示的是添加招聘按钮和分享新浪微博的选择框
        self.showImageList.frame = CGRectMake(0, 0, 320, 30);
        return;
        
    }
    //用户添加按钮后，给照片添加展示的位置
    self.showImageList.frame = CGRectMake(0, 0, 320, 75);
    
}


-(UIView *)takePhotoAndShare{
    if (nil == _takePhotoAndShare) {
        _takePhotoAndShare = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        _takePhotoAndShare.backgroundColor = [UIColor clearColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5, 4, 25, 25);
        [button setBackgroundImage:[UIImage imageNamed:@"LoginN.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(CameraClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_takePhotoAndShare addSubview:button];
        
        UILabel *tipLbl = [[UILabel alloc]initWithFrame:CGRectMake(30,3,178,30)];
        tipLbl.text = @"3张以上图片有机会获得积分哦";
        tipLbl.backgroundColor = [UIColor clearColor];
        tipLbl.textColor = [UIColor blackColor];
        tipLbl.font = FONT13;
        [_takePhotoAndShare addSubview:tipLbl];
        
        if (nil == _shareBtn) {
            _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _shareBtn.frame = CGRectMake(210, 10, 15, 15);
            [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Remember_unselected.png"] forState:UIControlStateNormal];
            [_shareBtn addTarget:self action:@selector(ShareClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_takePhotoAndShare addSubview:_shareBtn];
        }
        UILabel *shareLbl = [[UILabel alloc]initWithFrame:CGRectMake(225,3,130,30)];
        shareLbl.text = @"分享至新浪微博";
        shareLbl.backgroundColor = [UIColor clearColor];
        shareLbl.textColor = [UIColor blackColor];
        shareLbl.font = FONT13;
        [_takePhotoAndShare addSubview:shareLbl];
        
        
    }
    
    return _takePhotoAndShare;
}

-(void)deletePhoto:(id)sender{
    //通过获取点击button的下标定位应该被删除的照片
    int index = 0;
    int i = 0;
    for (UIButton *tempBtn in _closeBtnList) 
    {
        if (sender == tempBtn) {
            index = i;
            break;
        }
        
        i++;
    }
    //将视图移走
    self.imageAndButtonView = [_imageAndBtnList objectAtIndex:index] ;
    [self.imageAndButtonView removeFromSuperview];
    //从数组中删除
    [_imageAndBtnList removeObjectAtIndex:index];
    [_imageList removeObjectAtIndex:index];
    [_closeBtnList removeObjectAtIndex:index];
    [super setNeedsLayout];
    
}

#pragma mark - ImageViewTextFieldDelegate method
- (void)CameraClicked:(id)sender
{
    if ([_imageViewTextFieldDelegate conformsToProtocol:@protocol(ImageViewTextFieldDelegate)])
    {
        if ([_imageViewTextFieldDelegate respondsToSelector:@selector(cameraButtonClicked:)])
        {
            [_imageViewTextFieldDelegate cameraButtonClicked:(id)sender];
        }
        else
        {
            [self resignFirstResponder];
        }
    }
    else
    {
        [self resignFirstResponder];
    }
}


- (void)ShareClicked:(id)sender
{
    if ([_imageViewTextFieldDelegate conformsToProtocol:@protocol(ImageViewTextFieldDelegate)])
    {
        if ([_imageViewTextFieldDelegate respondsToSelector:@selector(shareButtonClicked:)])
        {
            [_imageViewTextFieldDelegate shareButtonClicked:(id)sender];
        }
    }
    if (_isSelected) {
        _isSelected = NO;
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Remember_unselected.png"] forState:UIControlStateNormal];
        
    }else{
        _isSelected = YES;
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"Remember_selected.png"] forState:UIControlStateNormal];
        
    }
    
}

@end
