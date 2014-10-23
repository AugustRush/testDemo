//
//  CustomCell.m
//  CustomCollectionLayoutDemo
//
//  Created by August on 14/10/23.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
{
    UILabel *_lable;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lable = [[UILabel alloc] initWithFrame:self.bounds];
        _lable.backgroundColor = [UIColor clearColor];
        _lable.textColor = [UIColor whiteColor];
        [self addSubview:_lable];
    }
    return self;
}

-(void)setIndex:(NSInteger)index
{
    _lable.text = [NSString stringWithFormat:@"%ld",index];
}

-(void)prepareForReuse
{
    NSLog(@"prepar reuse");
    _lable.text = nil;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
