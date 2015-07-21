//
//  FuniHttpUrl.m
//  kindergartenApp
//
//  Created by You on 15/6/1.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "KGHttpUrl.h"

#define baseServiceURL       @"http://120.25.248.31/px-mobile/"      //正式
#define loginURL             @"rest/userinfo/login.json"             //登录
#define logoutURL            @"rest/userinfo/logout.json"            //登出
#define regURL               @"rest/userinfo/reg.json"               //注册
//#define updatepasswordURL    @"rest/userinfo/updatepassword.json"    //修改密码
#define updatepasswordURL    @"rest/userinfo/updatepasswordBySms.json"  //修改密码
#define phoneCodeURL         @"rest/sms/sendCode.json"               //短信验证码


@implementation KGHttpUrl

//login
+ (NSString *)getLoginUrl {
    return [NSString stringWithFormat:@"%@%@", baseServiceURL, loginURL];
}


//logout
+ (NSString *)getLogoutUrl {
    return [NSString stringWithFormat:@"%@%@", baseServiceURL, logoutURL];
}


//reg
+ (NSString *)getRegUrl {
    return [NSString stringWithFormat:@"%@%@", baseServiceURL, regURL];
}


//updatepassword
+ (NSString *)getUpdatepasswordUrl {
    return [NSString stringWithFormat:@"%@%@", baseServiceURL, updatepasswordURL];
}


//phone code
+ (NSString *)getPhoneCodeUrl {
    return [NSString stringWithFormat:@"%@%@", baseServiceURL, phoneCodeURL];
}

@end
