### dispatch_after

#### 练习：

```objective-c
NSDate *date = [NSDate dateWithTimeIntervalSinceNow:3];
dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int)date);

dispatch_after(time, dispatch_get_main_queue(), ^{
   NSLog(@"waited at least three seconds.");
});

```



### Dispatch Group

#### 思考：

输出结果：

```objective-c
2018-04-26 18:39:09.015922+0800 test3[38183:2906423] blk0
2018-04-26 18:39:09.015923+0800 test3[38183:2906433] blk2
2018-04-26 18:39:09.015929+0800 test3[38183:2906424] blk1
2018-04-26 18:39:09.019263+0800 test3[38183:2906303] Done
```

原因：3个异步任务放入到全局并发队列queue中，队列组group获取了queue，所以3个代码块中的任务在不同线程异步执行。在队列组中的全部任务结束后，disapatch_group_notify函数回到主线程执行代码块中的任务，输出”Done“。

#### 练习：

   dispatch_group_wait实现：

```Objective-c
dispatch_group_t group = dispatch_group_create();
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

dispatch_group_async(group, queue, ^{
	NSLog(@"blk0");
});
dispatch_group_async(group, queue, ^{
    NSLog(@"blk1");
});

dispatch_group_async(group, queue, ^{
     NSLog(@"blk2");
});

dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
NSLog(@"Done");


```



dispatch_sync实现：

```objective-c
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

dispatch_sync(queue, ^{
        NSLog(@"blk0");
    });

dispatch_sync(queue, ^{
        NSLog(@"blk1");
    });

dispatch_sync(queue, ^{
        NSLog(@"blk2");
    });

dispatch_sync(queue, ^{
        NSLog(@"Done");
    });

```

​    

### Dispatch Semaphore

#### 思考：

如果dispatch_semaphore_t semaphore = dispatch_semaphore_create(1)，那只会允许在一个线程上串行按照次序执行