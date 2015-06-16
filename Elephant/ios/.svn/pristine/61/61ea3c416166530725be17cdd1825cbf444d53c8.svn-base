//
//  ChangeNameViewController.h
//  BodyScale
//
//  Created by zhangweiwei on 14/12/8.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeNameViewControllerDelegate <NSObject>

- (void)changeName:(NSString *)userName andType:(NSInteger)type;

@end

@interface ChangeNameViewController : BaseViewController

@property (strong, nonatomic) NSString *titleString;
@property (assign, nonatomic) NSInteger gType;
@property (strong, nonatomic) NSString *userInfoString;
@property (nonatomic, weak) id<ChangeNameViewControllerDelegate>delegate;

@end
