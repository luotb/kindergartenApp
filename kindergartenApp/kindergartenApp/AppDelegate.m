//
//  AppDelegate.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/5/30.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "AppDelegate.h"
#import "UIWindow+Extension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


+ (AppDelegate *)appDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication]  delegate];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [application setStatusBarStyle:UIStatusBarStyleDefault];
    
    // 创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.tintColor =
    [UIColor colorWithHue:1
               saturation:0.67
               brightness:0.93
                    alpha:1];
    // 启动tag页面
    [self.window switchRootViewController];
    
//    [self.window makeKeyAndVisible];
    return YES;
}


@end
