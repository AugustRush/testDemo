//
//  ICRunwayView.m
//  Temple
//
//  Created by 张诚亮 on 14-5-14.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "ICRunwayView.h"


@interface ICRunwayView(){
    UILabel *_lab;
    int _timerFlag;
    NSTimer *_timer;
    NSString *_text;
}

@end


@implementation ICRunwayView



-(void)initUI
{
    _timerFlag      = 0;
    CGRect _rect    = self.bounds;
    
    
    _lab            = [[UILabel alloc]initWithFrame:_rect];
    //_lab.text       = @"aaaaa";
    _lab.backgroundColor = [UIColor clearColor];
    _lab.textColor  = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    [self addSubview:_lab];
}

-(void)startRun
{
    if (!_timer) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:0.02
//                                                  target:self
//                                                selector:@selector(timerCallback:)
//                                                userInfo:nil
//                                                 repeats:YES];
        
        _timer = [NSTimer timerWithTimeInterval:0.02
                                         target:self
                                       selector:@selector(timerCallback:)
                                       userInfo:nil
                                        repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    }
    _timerFlag = 1;
    
}


-(void)stopRun
{
    _timerFlag = 0;
    [_timer invalidate];
    _timer = nil;
}

-(void)timerCallback:(NSTimer *)timer
{
    switch (_timerFlag) {
        case 1:
        {
            CGPoint _p = _lab.center;
            _p.x -= 1;
            _lab.center = _p;
            
            if (_lab.frame.origin.x < -_lab.frame.size.width) {
                CGRect _rect = _lab.bounds;
                _rect.origin.x = self.frame.size.width;
                
                _lab.frame = _rect;
            }
        }
            break;
        case 2:
        {
//            [timer invalidate];
//            timer = nil;
//            _timer = nil;
        }
            break;
        default:
            break;
    }
        
        
    
    
}

-(void)setText:(NSString *)text
{
    _text = text;
    _lab.text = _text;
   

/*
    CGSize _size = CGSizeMake(6000,100);
    CGSize _labelsize = [_lab.text sizeWithFont:_lab.font
                              constrainedToSize:_size
                                  lineBreakMode:_lab.lineBreakMode];

    CGRect _rect        = _lab.frame;
    _rect.size.width    = _labelsize.width;
    _lab.frame = _rect;
 */
    [_lab sizeToFit];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initUI];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc
{
    _timerFlag = 2;
    NSLog(@"ICRunwayView dealloc");
}

@end
