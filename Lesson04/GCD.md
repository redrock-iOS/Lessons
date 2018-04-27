# Grand Central Dispatch(GCD)概要

## 什么是GCD

> Concurrency is the notion of multiple things happening at the same time. With the proliferation of multicore CPUs and the realization that the number of cores in each processor will only increase, software developers need new ways to take advantage of them. Although operating systems like OS X and iOS are capable of running multiple programs in parallel, most of those programs run in the background and perform tasks that require little continuous processor time. It is the current foreground application that both captures the user’s attention and keeps the computer busy. If an application has a lot of work to do but keeps only a fraction of the available cores occupied, those extra processing resources are wasted.
>
> In the past, introducing concurrency to an application required the creation of one or more additional threads. Unfortunately, writing threaded code is challenging. Threads are a low-level tool that must be managed manually. Given that the optimal number of threads for an application can change dynamically based on the current system load and the underlying hardware, implementing a correct threading solution becomes extremely difficult, if not impossible to achieve. In addition, the synchronization mechanisms typically used with threads add complexity and risk to software designs without any guarantees of improved performance.

https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html

Grand Central Dispatch(GCD)是异步执行任务的技术之一。一般将应用程序中记述的线程管理用的代码在系统级中实现。开发者只需要定义想执行的任务。由于线程管理是作为系统的一部分来实现的，因此可统一管理，也可执行任务，这样就比以前的线程更有效率。

```objective-c
dispatch_async(queue,^{
	/*
	*/
	dispatch_async(dispatch_get_main_queue(), ^{
	/*
	*/
	});
});
```

“^”说明使用使用了“Blocks”简化了应用程序代码

使用

```objective-c
performSelector
performSelectorInBackground:withObject;
performSelectorOnMainThread;
```

实现简单的多线程编程技术。performSelector系方法比使用NSThread类进行多线程编程简单，但与使用GCD相比还是难。GCD不需要使用API，GCD提供的系统级线程管理提高执行效率。

## 多线程编程

线程介绍

```objective-c
int main(){
	id o = [[NSObject alloc] init];
	[o description];
    return 0;
}
```

### CPU命令列

所有代码会先被转化为CPU命令列，将CPU命令列配置到内存中，再将CPU命令列转入到CPU进行处理。CPU会一行一行的执行命令，也会因为if语句和for语句等控制语句函数调用跳转，CPU执行的命令好比队列。

CPU不只一个，这样的队列也不只一个，多个CPU就是多核，多个这样的队列就是多线程。

CPU技术：上下文切换。。。。与我们无关

==多线程编程==

缺点：数据竞争	死锁	太多线程导致消耗大量内存

优点：不妨碍主循环执行

## GCD的API

### Dispatch Queue(调度队列)

开发者要做的只是定义想执行的任务并追加到适当的Dispatch Queue中。

```objective-c
dispatch_async(queue,^{
	/*
	想执行的任务
	*/
})
```

Dispatch Queue是执行处理的等待==队列==（FIFO），通过dispathc_async等函数，将任务追加到Dispatch Queue中。

| Dispatch Queue的种类            | 说明                       |
| ------------------------------- | -------------------------- |
| Serial Dispatch queue(串行)     | 等待现在执行处理结束       |
| Concurrent Dispatch Queue(并行) | 不等待待现在执行中处理结束 |

iOS和OS X的核心—XNU内核决定应当使用的线程数，并执行处理。

#### dispatch_queue_create

通过dispatch_queue_create函数生成Dispatch Queue

```objective-c
dispatch_queue_t myDispatchQueue = 
dispatch_queue_create("label", attr)
```

`label`指定Queue的名称，推荐使用应用程序ID这种全限定域名（FQDN，fully qualified domain name）。

`attr`

使用`DISPATCH_QUEUE_SERIAL`(或者 `NULL`) 生成一个 serial queue ，或者使用 `DISPATCH_QUEUE_CONCURRENT` 生成一 concurrent queue。

返回值为类型为"dispatc_queue_t"的Dispatch Queue。

##### serial queue

虽然函数已经指定了串并行，但生成多个Serial Dispatch Queue时，各个Serial Dispatch Queue任会并行执行，每一个Serial Dispatch Queue会生成并使用一个线程。

==注意数据竞争，和消耗大量内存==

##### concurrent queue

不管生成多少，XNU内核只使用有效管理的线程。

##### 释放

```objective-c
dispatch_release(mySerialDispatchQueue);
dispatch_retain(myConcurrentDispatchQueue);
```

可以直接跟在dispatch_async后，只要block没有执行完，就不会被释放。

#### Main Dispatch Queue/Global Dispatch Queue

直接获得系统标准提供的Dispathc Queue。

Main Dispatch Queue主线程中的Dispatch Queue，serial queue。

Global Dispatch Queue所有应用程序都能够使用的concurent queue。

| 名称                  | Dispatch Queue的种类      | 说明   |
| --------------------- | ------------------------- | ------ |
| Main Dispatch Queue   | Serial Dispatch Queue     | 主线程 |
| Global Dispatch Queue | Concurrent Dispatch Queue | 高     |
| Global Dispatch Queue | Concurrent Dispatch Queue | 默认   |
| Global Dispatch Queue | Concurrent Dispatch Queue | 低     |
| Global Dispatch Queue | Concurrent Dispatch Queue | 后台   |

```objective-c
/*
	Main Dispatch Queue
*/
dispatch_queue_t mainDispatchQueue = dispatch_get_main_queue();
/*
	Global Dispatch Queue(高)
*/
dispatch_queue_t globalDispatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
/*
	Global Dispatch Queue(默认)
*/
dispatch_queue_t globalDispatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
/*
	Global Dispatch Queue(低)
*/
dispatch_queue_t globalDispatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
/*
	Global Dispatch Queue(后台)
*/
dispatch_queue_t globalDispatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
```

 优点：不需要考虑内存管理。

> 思考：这种优先级一定会有吗？

#### dispatch_set_target_queue

1、更改优先级

```objective-c
dispatch_queue_t myDispatchQueue = dispatch_queue_create("com.example.gcd.MyDispatchQueue", NULL);
dispatch_queue_t globalDispatchQueueBackgroud = dispatch_get_global_queue(DIAPTCH_QUEUE_PRIORITY_BACKGROUND, 0);
dispatch_set_target_queue(myDispatchQueue, globalDispatchQueueBackground);
```

要更改优先级的Dispatch Queue。

指定优先级的Global Dispatch Queue。

==都不可不指定==

2、更改执行阶层

将可能会并行的dispatch queue指定到目标的serial queue上。

相当于将多个queue放入一个serial queue上。

#### dispatch_after

在指定时间后执行处理的情况。

```objective-c
dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
dispatch_after(time, dispatch_get_main_queue, ^{
	NSLog(@"waited at least three seconds.");
});
```

`time`指定时间用的dispatch_time_t类型的值，该值使用dispatch_time函数或dispatch_walltime函数做成。

> dispatch_time函数能够获取从第一个dispatch_time_t类型中指定时间开始，到第二个参数指定的毫微秒单位时间后的时间。
>
> `DISPATCH_TIME_NOW`现在
>
> `DISPATCH_TIME_FOREVER`无限时间
>
> 'ull'是C语言的数值字面量( unsigned long long)，数值和NSEC_PER_SEC的乘积得到单位为毫微秒的数值。
>
> dispatch_walltime 自行查询。
>
> 练习：NSDate合成struct timespec类型

dispatch_after函数并不是在指定时间后执行处理，而只是在指定时间追加处理到Dispatch Queue。

因为Main Dispatch Queue主线程的RunLoop中执行，所以在比如每隔1/60秒执行的RunLoop中，Block最快3秒后执行，最慢3秒+1/60秒后执行，实际情况更长。

#### Dispatch Group

在追加到dispatch queue中的多个处理全部结束后想执行结束处理。

```objective-c
dispatch_group_t group = dispatch_group_create();
dispatch_queue_t queue = dispatch_get_gloabl_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

dispatch_group_async(group, queue, ^{Nslog(@"blk0");});
dispatch_group_async(group, queue, ^{Nslog(@"blk1");});
dispatch_group_async(group, queue, ^{Nslog(@"blk2");});

dispatch_group_notify(group, dispatch_get_main_queue(), ^{NSLog(@"done");});
dispatch_release(group);
```

dispatch_group_create函数生成dispatch_group_t类型的Dispatch Group。

dispatch_group_async函数，追加Block到指定的dispatch queue中。 

disapatch_group_notify函数会在Dispatch Group结束时，将执行的Block追加到Dispatch Queue中。



> 思考：查看输出结果，为什么有这种现象。
>
> 练习：使用另两种方法实现。（dispatch_set_target_queue,dispatch_sync或dispatch_group_wait）

#### //dispatch_barrier_async

#### dispatch_sync

dispatch_async函数的“async“意味着”非同步“，就是将指定的Block”非同步“地追加到指定的Dispatch中。dispatch函数不做任何等待。

```objective-c
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_sync(queue, ^{
/*
	处理
	*/
})
```

==容易引起死锁==

```objective-c
dispatch_queue_t queue = dispatch_get_main_queue();
dispatch_sync(queue, ^{
NSLog(@"Hello?");});
```

这段代码在主线程中执行指定block，并等待其执行结束。而其实主线程中正在执行这些代码。

```objective-c
dispatch_queue_t queue = dispatch_queue_create("com.example.gcd.MyserialDispatchQueue", NULL);
dispatch_async(queue, ^{
dispatch_sync(queue, ^{
@"Hello"?})});
```

#### dispatch_apply

dispatch_apply函数是dispatch_sync函数和Dispatch Group的关联API。该函数按指定的次数将指定的Block追加到指定的Dispatch Queue中，并等待全部处理执行结束。

```objective-c
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_apply(10, queue, ^(size_t index){
	NSLog(@"%zu", index);
	});
	NSLog(@"done");
```

第一个参数为重复次数

第二个为追加对象的Dispatch Queue

第三个参数为处理任务

#### dispatch_suspend/dispatch_resume

dispatch_suspend函数挂起指定的Dispatch Queue。

```objective-c
dispatch_suspend(queue);
```

dispatch_resume函数恢复指定的Dispatch Queue;

```objective-c
dispatch_resuem(queue);
```

这些函数对已经执行的处理没有影响。挂起后，追加到Dispatch Queue中但尚未执行的处理在此之后停止执行。

#### Dispatch Semaphore(信号量)

当并行执行的处理更新数据时，会产生数据不一致的情况，有时候还会异常结束。也同样用来限制线程数。

Dispatch Semaphore是持有计数的信号，该计数是多线程编程中的计数类型信号。计数为0时等待，计数为1或大于1时，减去1而不等待。

```objective-c
Dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);		
```

生成Dispatch Semaphore，参数表示计数的初始值。

```objective-c
Dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);
```

函数等待Dispatch Semaphore的计算值到达大于或等于1。当计数值大于等于1，或者在待机中计数值大于或等于1时，对该计数进行减法并从dispatch_semaphore_wait函数返回。第二个参数等待时间。

```objective-c
dispatch_semaphore_signal(semaphore);
```

提高信号量

注意，正常的使用顺序是**先降低**然后**再提高**，这两个函数通常成对使用。　

```objective-c
-(void)dispatchSignal{
    //crate的value表示，最多几个资源可访问
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);   
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     
    //任务1
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);       
    });
    //任务2
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);       
    });
    //任务3
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);       
    });   
}
```

> 观察结果，如果dispatch_semaphore_t semaphore = dispatch_semaphore_create(1)又会怎样。

#### dispatch_once

dispatch_once函数是保证在应用程序中只执行一次的指定处理API。

```objective-c
static dispatch_once_t pred;
dispatch_once(&pred,^{
/*
	init;
	*/});
```

该代码保证在多线程环境下执行的安全性。

#### //Dispatch I/O

### GCD实现

<u>通常，应用程序中编写的线程管理用的代码要在系统级实现</u>

| 组件名称       | 提供技术          |
| -------------- | ----------------- |
| libdispatch    | Dispatch Queue    |
| Libc(pthreads) | pthread_workqueue |
| XNU内核        | workqueue         |

[Dispatch](https://developer.apple.com/documentation/dispatch?language=objc)苹果官方文档