//
//  main.m
//  memoryManagement
//
//  Created by 李展 on 2018/3/17.
//  Copyright © 2018年 JohnLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "MEMTestClass.h"
void PrintClassInfo(id obj);
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        id __strong obj = [NSObject new];
        id __strong obj1 = obj;
        obj1 = nil;
        obj = nil;//strong置为nil只是让指针指向nil
        
        
        
        while([obj retainCount]>=1) {
            [obj release];
            obj = nil;
        }//不要使用retainCount判断引用计数，被回收时可能还是1
        
       NSAutoreleasePool  *pool = [[NSAutoreleasePool alloc]init];
        [obj release];
        [obj retain];
        
        [obj autorelease];
        [pool drain];// 老式自动释放池
        
        
        @autoreleasepool{

        }//轻量级的自动释放池
        

        
        extern void _objc_autoreleasePoolPrint(void);
        _objc_autoreleasePoolPrint();
        id __weak o = obj;
        id __strong tmp = o;
        NSLog(@"1 %@",tmp);
        NSLog(@"2 %@",tmp);
        NSLog(@"3 %@",tmp);
        NSLog(@"4 %@",tmp);
        _objc_autoreleasePoolPrint(); //取weak对象会注册到自动释放池中
        
        
        MEMTestClass *obj2 = [[MEMTestClass alloc] init];
        NSLog(@"Before release:");
        PrintClassInfo(obj2);
        [obj2 release];
        NSLog(@"After release:");
        PrintClassInfo(obj2);
        NSString *desc = [obj2 description];//僵尸对象的使用

    }
    return 0;
}
void PrintClassInfo(id obj){
    Class cls = object_getClass(obj);
    Class superCls = class_getSuperclass(cls);
    NSLog(@"=== %s : %s ===",class_getName(cls),class_getName(superCls));
}
