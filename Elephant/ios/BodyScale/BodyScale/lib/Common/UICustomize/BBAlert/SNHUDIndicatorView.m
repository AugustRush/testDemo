//
//  SNHUDIndicatorView.m
//  FFLtd
//
//  Created by 两元鱼 on 13-4-24.
//  Copyright (c) 2013年 FFLtd. All rights reserved.
//

#import "SNHUDIndicatorView.h"
#import "UIImage-Extensions.h"

@interface SNHUDIndicatorView ()

@property (nonatomic, strong) NSTimerHelper  *indicatorTimer;

@end

@implementation SNHUDIndicatorView

- (void)dealloc
{
    [self.indicatorTimer invalidate];
}

- (void)drawRect:(CGRect)rect
{
    float radian = 90;
    @autoreleasepool {
        UIImage *image = self.indicatorImgView.image;
        image = [image imageRotatedByDegrees:radian];
        self.indicatorImgView.image = image;
    }
}

- (UIImageView *)indicatorImgView{

    if (!_indicatorImgView) {
      
        _indicatorImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        _indicatorImgView.image = [UIImage imageNamed:@"sncloud_disk_animation_1.png"];
        [self addSubview:_indicatorImgView];
    }
    return _indicatorImgView;
}

- (void)handleProgres{
    if (self.progress == 0) {
        self.progress = 0.25;
    }else if(self.progress !=1){
        self.progress += 0.25;
    }else {
        self.progress =0;
    }
}
- (void)startAnimation{
    
    [self.indicatorTimer invalidate];
    self.indicatorTimer = [NSTimerHelper scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(handleProgres) userInfo:nil repeats:YES];

}
- (void)stopAnimation{
    [self.indicatorTimer invalidate];
}
@end
