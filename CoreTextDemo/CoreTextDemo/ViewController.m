//
//  ViewController.m
//  CoreTextDemo
//
//  Created by August on 15/6/15.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import "CommonCell.h"
#import "CoreTextCell.h"

NSString *const text = @"实现的思路主要是给控件添加手势点击并进行监听，在用户点击时拿到点击的位置，并在手势识别结束后用CoreText遍历每一个CTLine，判断点击的位置是否在识别的特定字符串（比如人名或者连续的数字串）内，如果是则找出该字符串。使用CTLineGetStringIndexForPosition函数来找出点击的字符位于整个字符串的位置。\n实现的思路主要是给控件添加手势点击并进行监听，在用户点击时拿到点击的位置，并在手势识别结束后用CoreText遍历每一个CTLine，判断点击的位置是否在识别的特定字符串（比如人名或者连续的数字串）内，如果是则找出该字符串。使用CTLineGetStringIndexForPosition函数来找出点击的字符位于整个字符串的位置。\n实现的思路主要是给控件添加手势点击并进行监听，在用户点击时拿到点击的位置，并在手势识别结束后用CoreText遍历每一个CTLine，判断点击的位置是否在识别的特定字符串（比如人名或者连续的数字串）内，如果是则找出该字符串。使用CTLineGetStringIndexForPosition函数来找出点击的字符位于整个字符串的位置。\n实现的思路主要是给控件添加手势点击并进行监听，在用户点击时拿到点击的位置，并在手势识别结束后用CoreText遍历每一个CTLine，判断点击的位置是否在识别的特定字符串（比如人名或者连续的数字串）内，如果是则找出该字符串。使用CTLineGetStringIndexForPosition函数来找出点击的字符位于整个字符串的位置。";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableAttributedString *string;

@property (nonatomic, assign) BOOL isCoreText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.tableView.estimatedRowHeight = 100;
    
    self.string = [[NSMutableAttributedString alloc] initWithString:text];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"some.jpg"];
    [self.string appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isCoreText) {
        CoreTextCell *coreTextCell = [tableView dequeueReusableCellWithIdentifier:@"CoreTextCell"];
        coreTextCell.label.text = [NSString stringWithFormat:@"%@%@",text,indexPath];
        coreTextCell.label.textColor = [UIColor purpleColor];
        return coreTextCell;
    }else{
        CommonCell *commenCell = [tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
        commenCell.label.text = [NSString stringWithFormat:@"%@%@",text,indexPath];
        return commenCell;
    
    }
}

#pragma mark - UITableViewDelegte methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 1000;
    if (self.isCoreText) {
        static CoreTextCell *coreTextCell = nil;
        if (coreTextCell == nil) {
            coreTextCell = [tableView dequeueReusableCellWithIdentifier:@"CoreTextCell"];
        }
        
        coreTextCell.label.text = [NSString stringWithFormat:@"%@%@",text,indexPath];
        
        return coreTextCell.label.textHeight + 23;
    }else{
    
        static CommonCell *commentCell = nil;
        if (commentCell == nil) {
            commentCell = [tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
        }
    
        commentCell.label.text = [NSString stringWithFormat:@"%@%@",text,indexPath];
        CGSize size = [commentCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
        return size.height+1;}
}

#pragma mark - event methods

- (IBAction)changeToCoreText:(id)sender {
    self.isCoreText = !self.isCoreText;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
