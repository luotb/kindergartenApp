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
#import "TopicDomain.h"
#import "ReplyDomain.h"
#import "DianZanDomain.h"

@interface KGHttpService : NSObject


@property (strong, nonatomic) KGTabBarViewController * tabBarViewController;//首页控制器
@property (strong, nonatomic) LoginRespDomain * loginRespDomain;
@property (strong, nonatomic) NSArray         * dynamicMenuArray; //首页动态菜单数据


+ (KGHttpService *)sharedService;


//图片上传
- (void)uploadImg:(UIImage *)img withName:(NSString *)imgName type:(NSInteger)imgType success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

//获取首页动态菜单
- (void)getDynamicMenu:(void (^)(NSArray * menuArray))success faild:(void (^)(NSString * errorMsg))faild;

//获取机构列表
- (void)getGroupList:(void (^)(NSArray * groupArray))success faild:(void (^)(NSString * errorMsg))faild;

// 账号相关 begin

- (void)login:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

- (void)logout:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

- (void)reg:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;


- (void)updatePwd:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;


- (void)getPhoneVlCode:(NSString *)phone success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;


// 账号相关 end



//班级互动 begin

// 根据互动id获取互动详情
- (void)getClassNewsByUUID:(NSString *)uuid success:(void (^)(TopicDomain * classNewInfo))success faild:(void (^)(NSString * errorMsg))faild;


// 分页获取班级互动列表
- (void)getClassNews:(PageInfoDomain *)pageObj success:(void (^)(PageInfoDomain * pageInfo))success faild:(void (^)(NSString * errorMsg))faild;

// 班级互动 end


//学生相关 begin

- (void)saveStudentInfo:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;


//学生相关 end


//点赞相关 begin

//保存点赞
- (void)saveDZ:(NSString *)newsuid type:(KGTopicType)dzype success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

//取消点赞
- (void)delDZ:(NSString *)newsuid success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

//点赞列表
- (void)getDZList:(NSString *)newsuid success:(void (^)(DianZanDomain * dzDomain))success faild:(void (^)(NSString * errorMsg))faild;

//点赞相关 end


//回复相关 begin

//保存回复
- (void)saveReply:(ReplyDomain *)reply success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

//取消回复
- (void)delReply:(NSString *)uuid success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild;

//分页获取回复列表
- (void)getReplyList:(PageInfoDomain *)pageInfo topicUUID:(NSString *)topicUUID success:(void (^)(PageInfoDomain * pageInfo))success faild:(void (^)(NSString * errorMsg))faild;

//回复相关 end










@end
