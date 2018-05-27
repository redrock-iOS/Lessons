//
//  SignInViewController.h
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/25.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DataDelegate <NSObject>
@required

- (void)GetUserImformation:(NSMutableDictionary *)dic;

@end

@interface SignInViewController : UIViewController

@property (nonatomic, strong) id<DataDelegate>delegate;



@end
