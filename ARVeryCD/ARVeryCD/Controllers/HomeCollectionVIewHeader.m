//
//  HomeCollectionVIewHeader.m
//  ARVeryCD
//
//  Created by August on 14-7-31.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "HomeCollectionVIewHeader.h"

typedef void(^FBlock) (id sender);

@interface HomeCollectionVIewHeader ()

@property (nonatomic, copy) FBlock finishedBLock;

@end

@implementation HomeCollectionVIewHeader


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)awakeFromNib
{
    self.titleLabel.textColor = FlatWhite;
}

-(void)setTouchFinishedBlock:(void (^)(id))block
{
    self.finishedBLock = block;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.finishedBLock) {
        self.finishedBLock(self);
    }
}

@end
