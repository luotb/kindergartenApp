//
//  FuniHttpService.h
//  kindergartenApp
//
//  Created by You on 15/6/1.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KGTabBarViewController.h"
#import "KGUser.h"
#import "LoginRespDomain.h"

@interface KGHttpService : NSObject


@property (strong, nonatomic) KGTabBarViewController * tabBarViewController;//首页控制器
@property (strong, nonatomic) LoginRespDomain * loginRespDomain;


+ (KGHttpService *)sharedService;


- (void)login:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

- (void)logout:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

- (void)reg:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;


- (void)updatePwd:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;


- (void)getPhoneVlCode:(NSString *)phone success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

@end
