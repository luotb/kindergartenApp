//
//  SystemConfig.h
//  funiApp
//
//  Created by You on 13-4-18.
//  Copyright (c) 2013年 you. All rights reserved.
//

#import "AppDelegate.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define bIsIos7 [[[UIDevice currentDevice]systemVersion]floatValue]>=7.0
#define bIsIos8 [[[UIDevice currentDevice]systemVersion]floatValue]>=8.0
#define _IPHONE80_ 80000

//定义数据库文件路径
#define  CACHE_DIRECTORY	[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define BASE_PATHES			[NSString stringWithFormat:@"%@/funiiphone.sqlite", CACHE_DIRECTORY]
/*对象序列化成文件时保存的路径*/
#define vObjectSavePath      [NSString stringWithFormat:@"%@/ClassesObject.plist", CACHE_DIRECTORY]

//登录账号归档路径
#define MFAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
