//
//  ViewController.m
//  BounceAnimation
//
//  Created by August on 14-8-28.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *bounceButton;
- (IBAction)toBounce:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)toBounce:(id)sender {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.calculationMode = @"cubic";
    animation.duration = 1;
    int steps = 100;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:steps];
    double value = 0;
    float e = 2.71;
    for (int t = 0; t < steps; t++) {
        value = 320 * pow(e, -0.055*t) * cos(0.08*t);
        [values addObject:[NSNumber numberWithFloat:value]];
    }
    animation.values = values;
    [self.bounceButton.layer setValue:[NSNumber numberWithInt:160] forKeyPath:animation.keyPath];
    [self.bounceButton.layer addAnimation:animation forKey:nil];
}
@end
