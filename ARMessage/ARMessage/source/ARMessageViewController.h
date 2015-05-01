//
//  ARMessageViewController.h
//  ARMessage
//
//  Created by August on 15/4/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARMessageProtocol.h"

@class ARMessageViewController;
@protocol ARMessageViewControllerDelegate <NSObject>

@end

@interface ARMessageViewController : UIViewController

@property (nonatomic, assign) id<ARMessageViewControllerDelegate> delegate;

@property (nonatomic, strong, readonly) NSMutableArray *messages;

-(void)addMessage:(id<ARMessageProtocol>)message;

//override methods
-(void)sendMessageWithText:(NSString *)text;
-(void)rightButtonTapped:(UIButton *)sender;

@end
