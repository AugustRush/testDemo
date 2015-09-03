//
//  ARGridTableViewCell.m
//  ARControlsDemo
//
//  Created by August on 15/8/7.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARGridTableViewCell.h"

@implementation ARGridTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.preferredMaxLayoutWidth = 290;
//    self.gridView.itemWidth = 100;
    self.gridView.numberOfColumn = 3;
    self.gridView.numberOfItems = 20;
}

- (void)fill {
    
    self.titleLabel.text = @"很多人在说到Daily Build的时候总是喜欢背书。背书就背书吧，总比混迹软件行业连书都没看过的强。很久以前遇到一个奇葩。每次到代码提交测的通知就着急忙慌的催促组员赶紧干活，开始严重加班，晚饭都不吃。。。偶尔还需要开通宵。但是即使如此，最后也不会得到什么好的反馈。那个team就是这样循环往复的做着项目，直到永恒。如果项目的相关人员能背背敏捷什么的开发书籍，想必情况总能有所改善。";
    [self.gridView setConfiguration:^UIView *(NSUInteger index) {
//        if (index%2 == 0) {
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setTitle:@"test" forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
//            return button;
//        }
        UIImageView *item = [[UIImageView alloc] init];
        item.contentMode = UIViewContentModeScaleAspectFill;
        item.clipsToBounds = YES;
        item.layer.cornerRadius = 4;
        item.layer.borderWidth = 1;
        item.layer.borderColor = [UIColor redColor].CGColor;
        NSString *imageName = [NSString stringWithFormat:@"%lu.jpg",1+index%2];
        item.image = [UIImage imageNamed:imageName];
        return item;
    }];
    [self.gridView reloadAllItems];
}

@end
