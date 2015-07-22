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
#import "PageInfoDomain.h"
#import "ClassNewsDomain.h"

@interface KGHttpService : NSObject


@property (strong, nonatomic) KGTabBarViewController * tabBarViewController;//首页控制器
@property (strong, nonatomic) LoginRespDomain * loginRespDomain;


+ (KGHttpService *)sharedService;


// 账号相关 begin

- (void)login:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

- (void)logout:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

- (void)reg:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;


- (void)updatePwd:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;


- (void)getPhoneVlCode:(NSString *)phone success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;


// 账号相关 end



//班级互动 begin

// 根据互动id获取互动详情
- (void)getClassNewsByUUID:(NSString *)uuid success:(void (^)(ClassNewsDomain * classNewInfo))success faild:(void (^)(NSString * errorMsg))faild;


// 分页获取班级互动列表
- (void)getClassNews:(PageInfoDomain *)pageObj success:(void (^)(PageInfoDomain * pageInfo))success faild:(void (^)(NSString * errorMsg))faild;

// 班级互动 end


//学生相关 begin

- (void)saveStudentInfo:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;


//学生相关 end












@end
