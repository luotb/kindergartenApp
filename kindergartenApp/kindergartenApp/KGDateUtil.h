//
//  FuniDateUtil.h
//  funiApp
//
//  Created by You on 13-5-18.
//  Copyright (c) 2013年 you. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGDateUtil : NSObject

+ (NSString *)getTime;

//毫秒时间
+ (NSString *)millisecond;

//当前时间
+ (NSString *)presentTime;

/**
 * 计算指定时间是否大雨指定分钟数
 */
+(BOOL)isReload:(NSDate*)compareDate loadTime:(NSInteger)loadTime;
@end
