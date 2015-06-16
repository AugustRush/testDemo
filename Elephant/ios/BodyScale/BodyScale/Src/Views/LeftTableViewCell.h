//
//  LeftTableViewCell.h
//  BodyScale
//
//  Created by cxx on 14-11-14.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIImageView *imgView;
@property(nonatomic,weak)IBOutlet UILabel     *textLb;
- (void)updateWithImg:(UIImage *)img WithText:(NSString *)text;
@end
