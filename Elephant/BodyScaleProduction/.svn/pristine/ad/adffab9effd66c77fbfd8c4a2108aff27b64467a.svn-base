//
//  ModifyUserAgeViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-24.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "ModifyUserAgeViewController.h"
#import "HorizontalPickerView.h"

@interface ModifyUserAgeViewController ()<HorizontalPickerViewDataSource, HorizontalPickerViewDelegate>

@property (nonatomic, strong)HorizontalPickerView *agePickerView;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation ModifyUserAgeViewController {
    NSArray *_arrowImageViews;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self buildNavigationBarWithTitle:@"我的个人资料"];
    
    _agePickerView = [[HorizontalPickerView alloc] initWithFrame:CGRectMake(0,
                                                                            150,
                                                                            SCREEN_WIDTH,
                                                                            79)
                                                        delegate:self
                                                      dataSource:self];
    [self.view addSubview:_agePickerView];
    
    NSString *imageName = @"triangle.png";
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image];
    [imageView1 setFrame:CGRectMake(_agePickerView.frame.size.width / 2 - image.size.width / 2,
                                    _agePickerView.frame.origin.y,
                                    image.size.width,
                                    image.size.height)];
    [self.view addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image];
    imageView2.transform = CGAffineTransformRotate(imageView2.transform, M_PI);
    [imageView2 setFrame:CGRectMake(_agePickerView.frame.size.width / 2 - image.size.width / 2,
                                    _agePickerView.frame.origin.y + _agePickerView.frame.size.height - image.size.height,
                                    image.size.width,
                                    image.size.height)];
    [self.view addSubview:imageView2];
    _arrowImageViews = @[imageView1, imageView2];
    
    NSString *ageStr = [[GloubleProperty sharedInstance] currentUserEntity].UI_age;
    if (ageStr.length) {
        self.ageLabel.text = [[GloubleProperty sharedInstance] currentUserEntity].UI_age;
        [_agePickerView setCurrentIndex:[ageStr intValue] - 10];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PickerView Delegate
- (NSInteger)numberOfItemsInPickerView:(id)pickerView {
    if ([pickerView isKindOfClass:[HorizontalPickerView class]]) {
        return 71;
    } else {
        return 121;
    }
}

- (NSString *)pickerView:(id)pickerView titleForItemsIndex:(NSInteger)index {
    if ([pickerView isKindOfClass:[HorizontalPickerView class]]) {
        return [NSString stringWithFormat:@"%d", (int)index + 10];
    } else {
        return [NSString stringWithFormat:@"%d", (int)index + 100];
    }
}

- (void)pickerView:(HorizontalPickerView *)pickerView indexChaged:(NSInteger)index {
    self.ageLabel.text = [NSString stringWithFormat:@"%d", (int)index + 10];
#warning 更新年龄
}

@end
