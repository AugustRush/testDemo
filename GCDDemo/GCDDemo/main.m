//
//  main.m
//  GCDDemo
//
//  Created by August on 15/8/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //semaphore test
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//        int i = 0;
//        for (; i < 10; i++)
//        {
//            NSLog(@"start wait");
//            dispatch_async(queue, ^{
//                NSLog(@"%i",i);
//                sleep(1);
//                NSLog(@"send a signal");
//                dispatch_semaphore_signal(semaphore);
//            });
//            NSLog(@"wait before");
//            long result =  dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, (int64_t)2*NSEC_PER_SEC));
//            NSLog(@"after wait");
//            if (result == 0) {
//                NSLog(@"success i is %d",i);
//            }else{
//                NSLog(@"failed i is %d",i);
//            }
//        }
        
        
        // source add test
        dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        dispatch_source_set_event_handler(source, ^{
            unsigned long data = dispatch_source_get_data(source);
            NSLog(@"data is %lu",data);
        });
        
        dispatch_resume(source);
        
        dispatch_apply(1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
            NSLog(@"source is %@",source);
            dispatch_source_merge_data(source, index);
        });
    }
    return 0;
}
