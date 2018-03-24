//
//  UINavigationController+shouldPopExtension.m
//  PUSHTEST
//
//  Created by hzl on 2018/3/24.
//  Copyright © 2018年 hzl. All rights reserved.
//

#import "UINavigationController+shouldPopExtension.h"
#import <objc/runtime.h>

@implementation UINavigationController (shouldPopExtension)

+ (void)load{
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
        
        
        Class cls = [self class];
        
        SEL originalSelector = @selector(navigationBar:shouldPopItem:);
        SEL swizzledSelector = @selector(hzl_navigationBar:shouldPopItem:);
        
        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        Method sizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
        
        //        BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(sizzledMethod), method_getTypeEncoding(sizzledMethod));
        //        if (didAddMethod) {
        //            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        //        }else{
        method_exchangeImplementations(originalMethod, sizzledMethod);
        //        }
        
    });
}

//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(nonnull UINavigationItem *)item{
//
//}

- (BOOL)hzl_navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(nonnull UINavigationItem *)item{
    UIViewController *vc = self.topViewController;
    if ([vc conformsToProtocol:@protocol(navigationShouldPop)]) {
        if ([(id<navigationShouldPop>)vc navigationShouldPop]) {
            return [self hzl_navigationBar:navigationBar shouldPopItem:item];
        }else{
            return NO;
        }
    }
   return [self hzl_navigationBar:navigationBar shouldPopItem:item];
}

@end
