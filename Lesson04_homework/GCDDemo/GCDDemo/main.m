//
//  main.m
//  GCDDemo
//
//  Created by 丁磊 on 2018/4/23.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import <Foundation/Foundation.h>
struct mytimespec{
    double sec;
    double nsec;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        struct mytimespec date;
        //    串行队列的创建
        dispatch_queue_t queue1 = dispatch_queue_create("testqueue.1", DISPATCH_QUEUE_SERIAL);
        
        //    并发队列的创建
        dispatch_queue_t queue2 = dispatch_queue_create("testqueue.2", DISPATCH_QUEUE_CONCURRENT);
        double date1 = [[NSDate date] timeIntervalSince1970];
        //    在队列里追加同步任务
        dispatch_sync(queue1, ^{
            NSLog(@"test------queue1%@",[NSThread currentThread]);
            [NSThread sleepForTimeInterval:3];
        });
        double date2 = [[NSDate date]timeIntervalSince1970];
        date.sec = date2 - date1;
        date.nsec = date.sec * 1000000000;
        NSLog(@"秒数为 %lf, 纳秒数为 %lf",date.sec,date.nsec);

//        实现dispatch_sync
        dispatch_sync(queue1, ^{
            NSLog(@"test1------queue1%@",[NSThread currentThread]);
        });
        dispatch_sync(queue1, ^{
            NSLog(@"test2------queue1%@",[NSThread currentThread]);
        });
        dispatch_sync(queue1, ^{
            NSLog(@"test3------queue1%@",[NSThread currentThread]);
        });
        dispatch_async(queue1, ^{
            NSLog(@"test4------queue1%@",[NSThread currentThread]);
        });

//      测试优先级
        dispatch_queue_t mainDispatchQueue = dispatch_get_main_queue();
        
        dispatch_queue_t globalDispatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        
        dispatch_queue_t globalDispatchQueueDefaut = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_queue_t globalDispatchQueueLow = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        
        dispatch_queue_t globalDispatchQueueBack = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);

        dispatch_async(mainDispatchQueue, ^{
            NSLog(@"test main %@",[NSThread currentThread]);
        });
        
        dispatch_async(globalDispatchQueueLow, ^{
            NSLog((@"test low %@"),[NSThread currentThread]);
        });
        
        dispatch_async(globalDispatchQueueBack, ^{
            NSLog(@"test back %@",[NSThread currentThread]);
        });
        
        dispatch_async(globalDispatchQueueHigh, ^{
            NSLog(@"test high %@",[NSThread currentThread]);
        });
        
        dispatch_async(globalDispatchQueueDefaut, ^{
            NSLog(@"test defaut %@",[NSThread currentThread]);
        });
        
//        实现dispatch_set_target_queue
        
        void (^queue3)() = ^(){
            NSLog(@"test5------queue3%@",[NSThread currentThread]);
        };
        
        dispatch_queue_t queue4 = dispatch_queue_create("testqueue.5", DISPATCH_QUEUE_CONCURRENT);
        dispatch_sync(queue4, ^{
            NSLog(@"test queue4------%@",[NSThread currentThread]);
        });
        
        dispatch_set_target_queue(queue4, queue1);
        
        dispatch_sync(queue1, queue3);
        
        dispatch_group_t group = dispatch_group_create();
//        dispatch_queue_t queue7 = dispatch_get_gloabl_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_group_async(group, globalDispatchQueueDefaut, ^{
            NSLog(@"blk0");
            
        });
        
        dispatch_group_async(group,globalDispatchQueueDefaut, ^{
            NSLog(@"blk1");
            
        });
        
        dispatch_group_async(group, globalDispatchQueueDefaut, ^{
            NSLog(@"blk2");
            
        });
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{NSLog(@"done");});
//        dispatch_release(group);
        
       
    }
    return 0;
}
