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
    
    ARDisplayLink *displayLink = [[ARDisplayLink alloc] init];
    displayLink.writeBlock = ^(CGFloat value){
        CGFloat color = value/255.0;
        NSLog(@"test value is %f color is %f",value,color);
        self.label.frame = CGRectMake(0, 400*color*color*color*color, 100, 20);
        self.view.backgroundColor = [UIColor colorWithRed:color*color*color green:color*color*color blue:color*color*color alpha:1];
    };
    [displayLink startRun];
}


-(UIColor *)randomColor
{
    CGFloat r = (arc4random()%255)/255.0;
    CGFloat g = (arc4random()%255)/255.0;
    CGFloat b = (arc4random()%255)/255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
