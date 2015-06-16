//
//  DeleteDataTipsView.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-6-6.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "DeleteDataTipsView.h"
#import "DeleteDataTipsTableViewCell.h"

@interface DeleteDataTipsView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation DeleteDataTipsView {
    NSArray *reasons;
    
    // Block
    DeleteDataTipsViewSureCallBack confirmHandler;
    DeleteDataTipsViewCancelCallBack cancelHandler;
    NSInteger _selectedIndex;
}

+ (void)showDeleteDataTipsViewWithConfirmHandler:(DeleteDataTipsViewSureCallBack)aConfirmHandler cancelHandler:(DeleteDataTipsViewCancelCallBack)aCancelHandler {
    DeleteDataTipsView *deleteDataTipsView = [[[NSBundle mainBundle] loadNibNamed:@"DeleteDataTipsView" owner:self options:nil] firstObject];
    deleteDataTipsView.frame = [UIScreen mainScreen].bounds;
    [deleteDataTipsView setConfirmHandler:aConfirmHandler cancelHandler:aCancelHandler];
    [deleteDataTipsView show];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // IOS 7.0 分割线偏移
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    reasons = @[@"数据异常", @"这数据不是我的", @"我不说，我就是要删除"];
}

- (void)setConfirmHandler:(DeleteDataTipsViewSureCallBack)aConfirmHandler cancelHandler:(DeleteDataTipsViewCancelCallBack)aCancelHandler {
    confirmHandler = [aConfirmHandler copy];
    cancelHandler = [aCancelHandler copy];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    DeleteDataTipsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DeleteDataTipsTableViewCell" owner:self options:nil] firstObject];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    
    cell.textLabel.text = reasons[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    self.sureButton.enabled = YES;
}

#pragma mark - Public Method
- (void)show {
    [self showInView:[[UIApplication sharedApplication] keyWindow]];
}

- (void)showInView:(UIView *)view {
        CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        popAnimation.duration = 0.4f;
        popAnimation.delegate = self;
        popAnimation.values = @[
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95f, 0.95f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
        popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.contentView.layer addAnimation:popAnimation forKey:@"popAnimation"];
        
        [view addSubview:self];
}

- (void)dismissAlertView {
    confirmHandler = nil;
    cancelHandler = nil;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)sureButtonAction:(id)sender {
    if (confirmHandler) {
        confirmHandler(self, _selectedIndex);
    }
    [self dismissAlertView];
}

- (IBAction)cancelButtonAction:(id)sender {
    if (cancelHandler) {
        cancelHandler(self);
    }
    [self dismissAlertView];
}

@end
