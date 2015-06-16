//
//  UIAlertBlockView.h
//  MatchNet
//
//  Created by 李翰阳 on 14-11-14.
//  Copyright (c) 2014年 JSLtd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertBasicBlock)(UIAlertView *alert,NSInteger buttonIndex);

@interface UIAlertBlockView : UIAlertView
{
    AlertBasicBlock    _setClickBlock;
}
@property (nonatomic, copy) AlertBasicBlock setClickBlock;
- (void)setClickBlock:(AlertBasicBlock)block;


/*-----用法
 UIAlertBlockView *alert = [[UIAlertBlockView alloc]initWithTitle:@"是否删除？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
 [alert setClickBlock:^(UIAlertView *alertView, NSInteger buttonIndex){
 if (buttonIndex == 1) {
    //click 确认
 }
 }];
 [alert show];
 TT_RELEASE_SAFELY(alert);
 
 */


@end
