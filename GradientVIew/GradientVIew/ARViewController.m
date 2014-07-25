//
//  ARViewController.m
//  GradientVIew
//
//  Created by August on 14-7-24.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ARViewController.h"
#import "ARGradientView.h"

@interface ARViewController ()
@property (weak, nonatomic) IBOutlet ARGradientView *gradientView;
- (IBAction)segmentClicked:(id)sender;

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentClicked:(UISegmentedControl *)sender {
    NSUInteger value = sender.selectedSegmentIndex;
    
    switch (value) {
        case 0:
        {
            [self.gradientView setColors:@[[UIColor purpleColor],[UIColor greenColor],[UIColor yellowColor],[UIColor whiteColor]] withAnimationDescription:ARGradientAnimateDescriptionMake(2, ARGradientAnimateTypeRadial, ARGradientAnimateDirectionBottomToTop, CGPointMake(100, 200))];
        }
            break;
        case 1:
        {
            [self.gradientView setColors:@[[UIColor purpleColor],[UIColor greenColor],[UIColor whiteColor]] withAnimationDescription:ARGradientAnimateDescriptionMake(1,                                                                                            ARGradientAnimateTypeNone,                                                                                       ARGradientAnimateDirectionBottomToTop,                                                                                                                            CGPointMake(0, 0))];
        }
            break;
        case 2:
        {
            [self.gradientView setColors:@[[UIColor blackColor],[UIColor greenColor],[UIColor blueColor]] withAnimationDescription:ARGradientAnimateDescriptionMake(1,                                                                                            ARGradientAnimateTypeLiner,                                                                                       ARGradientAnimateDirectionLeftToRight,                                                                                                                           CGPointZero)];
        }
            break;

        case 3:
        {
            [self.gradientView setColors:@[[UIColor purpleColor],[UIColor greenColor],[UIColor whiteColor]] withAnimationDescription:ARGradientAnimateDescriptionMake(1,                                                                                            ARGradientAnimateTypeRadial,                                                                                       ARGradientAnimateDirectionBottomToTop,                                                                                                                            CGPointMake(0, 0))];
        }
            break;

            
        default:
            break;
    }
    
}
@end
