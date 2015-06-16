//
//  UITableViewMoreCell.h
//  FFLtd
//
//  Created by 两元鱼 on 10/4/11.
//  Copyright (c) 2011 FFLtd. All rights reserved.
//


@interface UITableViewMoreCell : UITableViewCell{
    
    UIActivityIndicatorView* _activityIndicatorView;
    
    BOOL _animating;
    
    NSString *_title;
}


@property(nonatomic,strong) UIActivityIndicatorView* activityIndicatorView;

@property(nonatomic,assign) BOOL animating;

@property(nonatomic,strong) NSString *title;


@end
