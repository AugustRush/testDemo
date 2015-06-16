//
//  ARViewController.m
//  GradientVIew
//
//  Created by August on 14-7-24.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ARViewController.h"
#import "ARGradientView.h"

#define RedColor        [UIColor redColor]
#define PurpleColor     [UIColor purpleColor]
#define GreenColor      [UIColor greenColor]
#define WhiteColor      [UIColor whiteColor]
#define GrayColor       [UIColor grayColor]
#define LightGrayColor  [UIColor lightGrayColor]
#define BLueColor       [UIColor blueColor]
#define RGBColor(a,b,c) [UIColor colorWithRed:a green:b blue:c alpha:1.0]


@interface ARViewController ()
@property (strong, nonatomic) ARGradientView *gradientView;
- (IBAction)segmentClicked:(id)sender;

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gradientView = (ARGradientView *)self.view;
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)loadView
{
    ARGradientView *view = [[ARGradientView alloc] init];
    self.view = view;
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
            [self.gradientView setColors:@[[UIColor purpleColor],
                                           [UIColor greenColor],
                                           [UIColor yellowColor],
                                           [UIColor whiteColor]]
                withAnimationDescription:ARGradientAnimateDescriptionMake(2,
                                                                          ARGradientAnimateTypeRadial,
                                                                          ARGradientAnimateDirectionBottomToTop,
                                                                          CGPointMake(100, 200))];
        }
            break;
        case 1:
        {
            [self.gradientView setColors:@[PurpleColor,GreenColor,LightGrayColor]
                withAnimationDescription:ARGradientAnimateDescriptionMake(1,
                                                                          ARGradientAnimateTypeNone,
                                                                          ARGradientAnimateDirectionBottomToTop,
                                                                          CGPointMake(0, 0))];
        }
            break;
        case 2:
        {
            [self.gradientView setColors:@[[UIColor blackColor],
                                           [UIColor greenColor],
                                           [UIColor blueColor]]
                withAnimationDescription:ARGradientAnimateDescriptionMake(1,
                                                                          ARGradientAnimateTypeLiner,
                                                                          ARGradientAnimateDirectionLeftToRight,
                                                                          CGPointZero)];
        }
            break;

        case 3:
        {
            [self.gradientView setColors:@[[UIColor purpleColor],
                                           [UIColor greenColor],
                                           [UIColor whiteColor]]
                withAnimationDescription:ARGradientAnimateDescriptionMake(1,
                                                                          ARGradientAnimateTypeRadial,
                                                                          ARGradientAnimateDirectionBottomToTop,
                                                                          CGPointMake(0, 0))];
        }
            break;

            
        default:
            break;
    }
    
}
@end
