//
//  TextField+label.m
//  BodyScale
//
//  Created by zhangweiwei on 14/12/8.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "TextField+label.h"

@implementation TextField_label

- (UITextField *)textFeild
{
    if (!_textFeild)
    {
        _textFeild = [[UITextField alloc]initWithFrame:CGRectZero];
        _textFeild.backgroundColor = [UIColor whiteColor];
        _textFeild.textColor = [UIColor blackColor];
        _textFeild.borderStyle = UITextBorderStyleNone;
    }
    return _textFeild;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor whiteColor];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}



- (id)initWithHolder:(NSString *)placeHolder
        andLabelName:(NSString *)labelName textFieldDelegate:(id)tfDelegate
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(@15);
            make.width.equalTo(@80);
            make.top.equalTo(self);
            make.height.equalTo(self);
        }];
        self.nameLabel.text = labelName;
        
        self.layer.borderWidth = 1.2;
        UIColor *borderColor = [GetWordColor colorWithHexString:@"#dddddd"];
        self.layer.borderColor = [borderColor CGColor];
        //        self.borderStyle = UITextBorderStyleRoundedRect;
        self.layer.cornerRadius = 3.0f;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.textFeild];
        [self.textFeild mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.nameLabel.mas_right);
             make.right.equalTo(self.mas_right);
             make.top.equalTo(self.mas_top);
             make.height.equalTo(self.mas_height);
         }];
        self.textFeild.placeholder = placeHolder;
        self.textFeild.delegate = tfDelegate;
      }
    
    return self;
}




@end
