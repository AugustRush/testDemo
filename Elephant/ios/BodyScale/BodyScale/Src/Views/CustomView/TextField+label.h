//
//  TextField+label.h
//  BodyScale
//
//  Created by zhangweiwei on 14/12/8.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetWordColor.h"


@interface TextField_label : UIView
@property(strong,nonatomic) UITextField * textFeild;
@property(strong,nonatomic) UILabel * nameLabel;

- (id)initWithHolder:(NSString *)placeHolder
        andLabelName:(NSString *)labelName textFieldDelegate:(id)tfDelegate;
@end
