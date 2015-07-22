//
//  FuniHttpUrl.h
//  kindergartenApp
//
//  Created by You on 15/6/1.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGHttpUrl : NSObject

//login
+ (NSString *)getLoginUrl;


//logout
+ (NSString *)getLogoutUrl;


//reg
+ (NSString *)getRegUrl;


//updatepassword
+ (NSString *)getUpdatepasswordUrl;


//phone code
+ (NSString *)getPhoneCodeUrl;


//AnnouncementList
+ (NSString *)getAnnouncementListUrl;


//Announcement Info
+ (NSString *)getAnnouncementInfoUrl:(NSString *)uuid;


//MyChildren
+ (NSString *)getMyChildrenUrl;


//SaveChildren
+ (NSString *)getSaveChildrenUrl;


//根据互动UUID获取单个互动详情
+ (NSString *)getClassNewsByIdUrl:(NSString *)uuid;


//分页获取班级互动列表
+ (NSString *)getClassNewsByClassIdUrl;


//分页获取我的孩子相关班级互动列表
+ (NSString *)getClassNewsMyByClassIdUrl;


//更新学生资料
+ (NSString *)getSaveStudentInfoUrl;

@end
