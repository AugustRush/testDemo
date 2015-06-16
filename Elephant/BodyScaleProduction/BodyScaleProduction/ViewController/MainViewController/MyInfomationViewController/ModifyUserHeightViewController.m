//
//  ModifyUserHeightViewController.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-24.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "ModifyUserHeightViewController.h"

#import "HorizontalPickerView.h"

@interface ModifyUserHeightViewController ()<HorizontalPickerViewDataSource, HorizontalPickerViewDelegate>

@property (nonatomic, strong)HorizontalPickerView *heightPickerView;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;

@end

@implementation ModifyUserHeightViewController {
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
    
    _heightPickerView = [[HorizontalPickerView alloc] initWithFrame:CGRectMake(0,
                                                                            150,
                                                                            SCREEN_WIDTH,
                                                                            79)
                                                        delegate:self
                                                      dataSource:self];
    [self.view addSubview:_heightPickerView];
    
    NSString *imageName = @"triangle.png";
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image];
    [imageView1 setFrame:CGRectMake(_heightPickerView.frame.size.width / 2 - image.size.width / 2,
                                    _heightPickerView.frame.origin.y,
                                    image.size.width,
                                    image.size.height)];
    [self.view addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image];
    imageView2.transform = CGAffineTransformRotate(imageView2.transform, M_PI);
    [imageView2 setFrame:CGRectMake(_heightPickerView.frame.size.width / 2 - image.size.width / 2,
                                    _heightPickerView.frame.origin.y + _heightPickerView.frame.size.height - image.size.height,
                                    image.size.width,
                                    image.size.height)];
    [self.view addSubview:imageView2];
    _arrowImageViews = @[imageView1, imageView2];
    
    NSString *heightStr = [[GloubleProperty sharedInstance] currentUserEntity].UI_height;
    if (heightStr.length) {
        self.heightLabel.text = [[GloubleProperty sharedInstance] currentUserEntity].UI_height;
        [_heightPickerView setCurrentIndex:[heightStr intValue] - 100];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PickerView Delegate
- (NSInteger)numberOfItemsInPickerView:(id)pickerView {
    return 121;
}

- (NSString *)pickerView:(id)pickerView titleForItemsIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"%d", (int)index + 100];
}

- (void)pickerView:(HorizontalPickerView *)pickerView indexChaged:(NSInteger)index {
    NSString *height = [NSString stringWithFormat:@"%d", (int)index + 100];
    self.heightLabel.text = height;
    [[GloubleProperty sharedInstance] currentUserEntity].UI_height = height;
#warning 更新身高
}

@end
