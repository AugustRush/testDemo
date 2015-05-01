//
//  ARMessageInputBar.h
//  Mindssage
//
//  Created by August on 14/10/31.
//
//

#import <UIKit/UIKit.h>
#import "ARTextView.h"

@class ARMessageInputBar;
@protocol ARMessageInputBarDelegate <NSObject>

-(void)ar_MessageInputBar:(ARMessageInputBar *)inputBar didSendText:(NSString *)text;
-(void)ar_MessageInputBar:(ARMessageInputBar *)inputBar didTriggerRightButton:(UIButton *)button;

@end

//**
//////////////
@interface ARMessageInputBar : UIView<UITextViewDelegate>

@property (nonatomic, assign) id<ARMessageInputBarDelegate> delegate;

@property (nonatomic, strong) ARTextView *textView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, assign) NSUInteger maxNumberOfLines;

@end

//键盘位置变化通知
FOUNDATION_EXTERN NSString * const ARMessageInputKeyBoardFrameChangedNotification;

@interface ARMessageInputAccessoryView : UIView

@end
