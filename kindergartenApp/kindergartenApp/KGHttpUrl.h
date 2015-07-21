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

@end
