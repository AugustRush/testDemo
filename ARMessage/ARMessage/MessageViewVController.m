//
//  MessageViewVController.m
//  ARMessage
//
//  Created by August on 15/4/27.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "MessageViewVController.h"
#import "Message.h"

@implementation MessageViewVController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *initMesages = [NSMutableArray array];
    int i = 100;
    while (i > 0) {
        Message *message = [[Message alloc] init];
        message.time = [NSDate date];
        message.text = [NSString stringWithFormat:@"index %d",i];
        [initMesages addObject:message];
        i--;
    }
    
    [self.messages addObjectsFromArray:initMesages];

}

#pragma mark - override methods

-(void)sendMessageWithText:(NSString *)text
{
    Message *message = [[Message alloc] init];
    message.time = [NSDate date];
    message.text = text;
    
    [self addMessage:message];
}

-(void)rightButtonTapped:(UIButton *)sender
{

}

@end
