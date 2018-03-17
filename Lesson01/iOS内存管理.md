# iOS内存管理
## 什么是自动引用计数（ARC）
> 在LLVM编译器中设置ARC为有效状态，就无需再次键入retain或者是release代码
- 使用Xcode4.2或以上版本
- 使用LLVM编译器3.0或以上版本
- 编译器选项中设置ARC为有效
- 引用树根对象(NSApplication/UIApplication)
## 内存管理的思考方式
1. 自己生成的对象，自己持有
- alloc
- new
- copy
- mutableCopy
-  ***注意驼峰命名***
2. 非自己生成的对象，自己也能持有
- array
- init返回的对象不会注册到自动释放池中
- autorelease
3. 不再需要自己持有的对象时释放
- release之后清空指针（避免悬挂指针的出现）

4. 非自己持有的对象无法释放
- 释放非自己持有的对象可能会造成程序崩溃（放回可用内存池）

## alloc/retain/release/autorelease/dealloc实现
### [GNUstep框架](https://github.com/gnustep/libs-base/edit/master/Source/NSObject.m)
- GNUstep是Cocoa的互换框架
- alloc
- allocWithZone

### [苹果的实现](https://opensource.apple.com/source/objc4/objc4-723/runtime/)
- 散列表

## ARC下的规则
1. 不能使用alloc/retain/release/autorelease(ARC直接使用C语言函数)
2. 不能使用NSAllocateObject/NSDeallocateObject
3. 须遵守内存管理的方法命名规则
4. 不要显式调用dealloc
5. 使用@autoreleasepool块替代NSAutoreleasePool
6. 不能使用区域（NSZone）
7. 对象型变量不能作为C语言结构体(struct/union)的成员
8. 显示转换id和void*

## 所有权修饰符
- __strong
- __weak（保留环）
- __unsafe_unretained
- __autoreleasing
- 一般不显式声明
- 对象作为函数返回值，自动注册到autoreleasepool
- 在访问附有__weak修饰符的变量时，实际上必定要访问注册到autoreleasepool的对象
- id的指针或对象的指针在没有显式指定时会被附加上__autoreleasing修饰符（NSError）
- 与属性修饰符的关系（保留新值，释放旧值，设置实例变量）
## 不要使用retainCount
- 考虑autorealease
- 在保留计数还是1的时候可能就回收了

## 在dealloc方法中只释放引用并解除监听
- 自动调用析构函数
- 取消KVO和通知
- malloc()分配在堆上的内存和CoreFoundation中的对象
- 系统未必会在每个对象上调用其dealloc方法
## 使用autoreleasepool降低内存峰值
- 每次runloop释放自动释放池
- 自己在循环中创建池

## ARC的实现
- objc_retainAutoReleasedReturnValue
- objc_autoreleaseReturnValue
- __weak修饰符置nil的实现
1. 从weak表中获取废弃对象的地址为键值的记录
2. 将包含在记录中的所有附有__weak修饰符变量的地址，赋值为nil
3. 从weak表中删除该记录
4. 从引用计数表中删除废弃对象的地址为键值的记录
- 不支持__weak修饰符的类(NSMachPort)
- allowsWeakReference/retainWeakRefence方法

## 用僵尸对象调试管理内存
- 对象转化为僵尸对象但不会彻底回收
- 僵尸类是从名为_NSZombie_的模板类里复制出来的
- 系统会修改对象的isa指针，令其指向特殊的僵尸类
## 使用Instruments调试
- 使用Leak来查看内存泄露





