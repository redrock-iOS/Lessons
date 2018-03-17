//
//  MEMTestClass.m
//  memoryManagement
//
//  Created by 李展 on 2018/3/17.
//  Copyright © 2018年 JohnLee. All rights reserved.
//

#import "MEMTestClass.h"

@implementation MEMTestClass
+ (instancetype)alloc{
    return [super alloc];
}

+ (instancetype)alloced{
    return [self alloc];
}

+ (instancetype)instance{
    return [[self alloc]init];
}
@end
