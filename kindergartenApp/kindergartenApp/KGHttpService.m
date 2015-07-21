//
//  FuniHttpService.m
//  kindergartenApp
//
//  Created by You on 15/6/1.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "KGHttpService.h"
#import "AFAppDotNetAPIClient.h"
#import "KGHttpUrl.h"
#import "MJExtension.h"

@implementation KGHttpService


+ (KGHttpService *)sharedService {
    static KGHttpService *_sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [[KGHttpService alloc] init];
    });
    
    return _sharedService;
}


// 1001  1009
- (void)requestErrorCode:(NSError*)error faild:(void (^)(NSString* errorMessage))faild
{
    switch (error.code) {
        case -1001:
            faild(@"网络错误，请稍后再试！");
            break;
        case -1004:
        case -1009:
            faild(@"网络错误，请稍后再试！");
            break;
        default:
            faild(@"网络错误，请稍后再试！");
            break;
    }
}


- (void)POST:(NSString *)url param:(NSDictionary *)param success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild {
    
    [[AFAppDotNetAPIClient sharedClient] POST:url
                                   parameters:param
                                      success:^(NSURLSessionDataTask* task, id responseObject) {
                                          
                                          _loginRespDomain = [LoginRespDomain objectWithKeyValues:responseObject];
                                          if([_loginRespDomain.ResMsg.status isEqualToString:String_Success]) {
                                              success(_loginRespDomain.ResMsg.message);
                                          } else {
                                              faild(_loginRespDomain.ResMsg.message);
                                          }
                                          
                                      }
                                      failure:^(NSURLSessionDataTask* task, NSError* error) {
                                          [self requestErrorCode:error faild:faild];
                                      }];
}


- (void)login:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild {
//    NSString * url = [NSString stringWithFormat:@"%@?loginname=%@&password=%@", [KGHttpUrl getLoginUrl], user.loginname, user.password];
    [[AFAppDotNetAPIClient sharedClient] POST:[KGHttpUrl getLoginUrl]
                                   parameters:user.keyValues
                                      success:^(NSURLSessionDataTask* task, id responseObject) {
                                          
                                          _loginRespDomain = [LoginRespDomain objectWithKeyValues:responseObject];
                                          if([_loginRespDomain.ResMsg.status isEqualToString:String_Success]) {
                                              
                                              //取到服务器返回的cookies
                                              
                                              NSString * cookies = ((NSHTTPURLResponse *)task.response).allHeaderFields[@"Set-Cookie"];
                                              NSLog(@"response cookies:%@",cookies);
//                                              [self userCookie:cookies];
                                              success(_loginRespDomain.ResMsg.message);
                                          } else {
//                                              faild(String_LoginFail);
                                              faild(_loginRespDomain.ResMsg.message);
                                          }
                                          
                                      }
                                      failure:^(NSURLSessionDataTask* task, NSError* error) {
                                          [self requestErrorCode:error faild:faild];
                                      }];
}


- (void)logout:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild {
    
    [self POST:[KGHttpUrl getLogoutUrl] param:nil success:^(NSString *msgStr) {
        success(msgStr);
    } faild:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}


- (void)reg:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild {
    
//    AFHTTPRequestSerializer* requestSerializer = [AFAppDotNetAPIClient sharedClient].requestSerializer;
//    [requestSerializer setValue:[NSString stringWithFormat:@"%@", user.keyValues] forHTTPHeaderField:@"body"];
    
//    NSString * url = [NSString stringWithFormat:@"%@?%@", [KGHttpUrl getRegUrl], user.keyValues];
    [self POST:[KGHttpUrl getRegUrl] param:user.keyValues success:^(NSString *msgStr) {
        success(msgStr);
    } faild:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}


- (void)updatePwd:(KGUser *)user success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild {
    
    [self POST:[KGHttpUrl getUpdatepasswordUrl] param:user.keyValues success:^(NSString *msgStr) {
        success(msgStr);
    } faild:^(NSString *errorMsg) {
        faild(errorMsg);
    }];
}


- (void)getPhoneVlCode:(NSString *)phone success:(void (^)(NSString * msgStr))success faild:(void (^)(NSString * errorMsg))faild {
    [[AFAppDotNetAPIClient sharedClient] POST:[KGHttpUrl getPhoneCodeUrl]
                                   parameters:@""
                                      success:^(NSURLSessionDataTask* task, id responseObject) {
                                          
                                          success(@"成功");
                                      }
                                      failure:^(NSURLSessionDataTask* task, NSError* error) {
                                          [self requestErrorCode:error faild:faild];
                                      }];

}
















@end
