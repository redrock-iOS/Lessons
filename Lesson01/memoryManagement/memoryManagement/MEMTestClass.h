//
//  MEMTestClass.h
//  memoryManagement
//
//  Created by 李展 on 2018/3/17.
//  Copyright © 2018年 JohnLee. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MEMTestClass : NSObject
@property (nonatomic, strong) NSNumber *num;//保留新值，再释放旧值
+ (instancetype)alloced; //要符合驼峰命名
+ (instancetype)instance;
@end
