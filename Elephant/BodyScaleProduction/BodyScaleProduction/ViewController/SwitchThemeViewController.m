//
//  SwitchThemeViewController.m
//  BodyScaleProduction
//
//  Created by Zhanghao on 14-6-6.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "SwitchThemeViewController.h"
#import "ThemeTableViewCell.h"

@interface SwitchThemeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *themes;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, assign) BOOL notifyToChange;

@end

@implementation SwitchThemeViewController

#pragma mark - View LifeCycle Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

#pragma mark - Private Methods

- (void)initData {
    self.notifyToChange = NO;
    self.themes = @[@"经典",@"魅力红",@"活力蓝",@"轻悦紫",@"青春绿",@"明媚黄"];
    
    NSInteger row = [ThemeManager sharedManager].style;
    self.currentIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
}

- (void)initViews {
    self.navigationItem.title = @"切换主题";
}

#pragma mark - Override Methods

- (void)configureThemeAppearance {
    [super configureThemeAppearance];

    if (self.notifyToChange) {
        UIImage *image = nil;
        if (kIsiOS_7) {
            image = ThemeImage(@"navigation_bar_background_image_iOS7.png");
        } else {
            image = ThemeImage(@"navigation_bar_background_image_iOS6.png");
        }
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.themes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SwitchThemeTableViewCell";
    ThemeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ThemeTableViewCell" owner:self options:nil] lastObject];
    }

    cell.titleLabel.text = self.themes[indexPath.row];
    
    NSString *imageName = nil;
    if ([indexPath isEqual:self.currentIndexPath]) {
        imageName = [NSString stringWithFormat:@"theme%d_selected", indexPath.row];
    } else {
        imageName = [NSString stringWithFormat:@"theme%d", indexPath.row];
    }
    cell.themeImageView.image = [UIImage imageNamed:imageName];

    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (![indexPath isEqual:self.currentIndexPath]) {
        self.notifyToChange = YES;
        
        [[ThemeManager sharedManager] changeToTheme:indexPath.row];
        
        NSString *previousImageName = [NSString stringWithFormat:@"theme%d", self.currentIndexPath.row];
        NSString *imageName = [NSString stringWithFormat:@"theme%d_selected", indexPath.row];
        ThemeTableViewCell *previousCell = (ThemeTableViewCell *)[tableView cellForRowAtIndexPath:self.currentIndexPath];
        ThemeTableViewCell *selectedCell = (ThemeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        previousCell.themeImageView.image = [UIImage imageNamed:previousImageName];
        selectedCell.themeImageView.image = [UIImage imageNamed:imageName];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"_hasChangeSystemStyle"];
    }

    self.currentIndexPath = indexPath;
}

@end
