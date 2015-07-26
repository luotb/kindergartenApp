//
//  AppDelegate.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/5/30.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "AppDelegate.h"
#import "UIWindow+Extension.h"
#import "BaiduMobStat.h"

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
    
    [self buildBaiduMobStat];
    
    
    
    // 启动tag页面
    [self.window switchRootViewController];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    [self.window makeKeyAndVisible];
    return YES;
}


- (void)buildBaiduMobStat {
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = YES; // 是否允许截获并发送崩溃信息，请设置YES或者NO
//    statTracker.channelId = @"ReplaceMeWithYourChannel";//设置您的app的发布渠道 默认APP Store
    statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch;//根据开发者设定的发送策略,发送日志
//    statTracker.logSendInterval = 1;  //为1时表示发送日志的时间间隔为1小时,当logStrategy设置为BaiduMobStatLogStrategyCustom时生效
    statTracker.logSendWifiOnly = NO; //是否仅在WIfi情况下发送日志数据
    statTracker.sessionResumeInterval = 10;//设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s
    statTracker.shortAppVersion  = IosAppVersion; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    statTracker.enableDebugOn = YES; //调试的时候打开，会有log打印，发布时候关闭
    /*如果有需要，可自行传入adid
     NSString *adId = @"";
     if([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f){
     adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
     }
     statTracker.adid = adId;
     */
    
    //    AppKey:e633eaf16d
    [statTracker startWithAppId:@"e633eaf16d"];//设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey
}


@end
