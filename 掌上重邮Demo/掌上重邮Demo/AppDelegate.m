//
//  AppDelegate.m
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/25.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "YouAskViewController.h"
#import "MyMessageViewController.h"
#import "discoverViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ViewController *firstCtrl = [[ViewController alloc] init];
    YouAskViewController *secondCtrl =[[YouAskViewController alloc] init];
    discoverViewController *trirdCtrl = [[discoverViewController alloc] init];
    MyMessageViewController *forthCtrl = [[MyMessageViewController alloc] init];
    
    firstCtrl.title = @"课表";
    secondCtrl.title = @"邮问";
    trirdCtrl.title = @"发现";
    forthCtrl.title = @"我的";
    
    
    UINavigationController *navCtrl1 = [[UINavigationController alloc] initWithRootViewController:firstCtrl];
    UINavigationController *navCtrl2 = [[UINavigationController alloc] initWithRootViewController:secondCtrl];
    UINavigationController *navCtrl3 = [[UINavigationController alloc] initWithRootViewController:trirdCtrl];
    UINavigationController *navCtrl4 = [[UINavigationController alloc] initWithRootViewController:forthCtrl];
    
    UITabBarController *tabbarCtrl = [[UITabBarController alloc] init];
    tabbarCtrl.viewControllers = @[navCtrl1, navCtrl2,navCtrl3,navCtrl4];
    
    self.window.rootViewController = tabbarCtrl;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
