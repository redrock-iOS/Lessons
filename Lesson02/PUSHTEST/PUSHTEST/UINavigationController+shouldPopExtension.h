//
//  UINavigationController+shouldPopExtension.h
//  PUSHTEST
//
//  Created by hzl on 2018/3/24.
//  Copyright © 2018年 hzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol navigationShouldPop<NSObject>

- (BOOL)navigationShouldPop;

@end

@interface UINavigationController (shouldPopExtension)



@end
