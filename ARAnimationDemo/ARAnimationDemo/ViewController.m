//
//  ViewController.m
//  ARAnimationDemo
//
//  Created by August on 15/6/17.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import "ARDisplayLink.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

CGFloat BounceEaseOut(CGFloat p)
{
    if(p < 4/11.0)
    {
        return (121 * p * p)/16.0;
    }
    else if(p < 8/11.0)
    {
        return (363/40.0 * p * p) - (99/10.0 * p) + 17/5.0;
    }
    else if(p < 9/10.0)
    {
        return (4356/361.0 * p * p) - (35442/1805.0 * p) + 16061/1805.0;
    }
    else
    {
        return (54/5.0 * p * p) - (513/25.0 * p) + 268/25.0;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ARDisplayLink *displayLink = [[ARDisplayLink alloc] init];
    displayLink.writeBlock = ^(CGFloat value){
        CGFloat color = value/255.0;
        NSLog(@"test value is %f color is %f",value,color);
        self.label.frame = CGRectMake(0, 400*BounceEaseOut(color), 100, 20);
        self.view.backgroundColor = [UIColor colorWithRed:BounceEaseOut(color) green:BounceEaseOut(color) blue:BounceEaseOut(color) alpha:1];
        self.label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, color);
    };
    
    [displayLink startRun];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
