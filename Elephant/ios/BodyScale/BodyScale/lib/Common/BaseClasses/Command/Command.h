//
//  Command.h
//  FFLtd
//
//  Created by  两元鱼 on 12-11-16.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//


@interface Command : NSObject
{

}

+ (id)command;
- (void) execute;
- (void) undo;

@end
