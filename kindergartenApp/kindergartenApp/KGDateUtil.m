//
//  FuniDateUtil.m
//  funiApp
//
//  Created by You on 13-5-18.
//  Copyright (c) 2013年 you. All rights reserved.
//

#import "KGDateUtil.h"


@implementation KGDateUtil

+ (NSString *)getTime{
    // 获取系统当前时间
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * na = [df stringFromDate:currentDate];
    
    return na;
}


//获取过去几天日期  默认当天
+ (NSString *)getDate:(NSInteger)date {
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:dateFormatStr1];
    
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-(date * 24*60*60)];
    NSString * tempDate =  [formatter stringFromDate:yesterday];
    
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", tempDate];
    return timeLocal;
}

//获取指定日期差
+ (NSString *)calculateDay:(NSString *)currentDateStr date:(NSInteger)date {
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:dateFormatStr1];
    
    NSDate * currentDate = [format dateFromString:currentDateStr];
    NSDate * newDate = nil;
    
    long temp = date * 24 * 3600;
    newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([currentDate timeIntervalSinceReferenceDate] - temp)];

    return [format stringFromDate:newDate];
}


//毫秒时间
+ (NSString *)millisecond
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    NSInteger i=time;      //NSTimeInterval返回的是double类型
    return [NSString stringWithFormat:@"%ld",(long)i];
}

//当前时间
+ (NSString *)presentTime
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:dateFormatStr2];
    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    return timeLocal;
}

/**
 * 计算指定时间是否大雨指定分钟数
 */
+(BOOL)isReload:(NSDate *)compareDate loadTime:(NSInteger)loadTime{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    BOOL  result = NO;
    if(timeInterval > loadTime*60){
        result = YES;
    }
    return  result;
}

//时间格式的字符串转日期对象
+ (NSDate *)getDateByDateStr:(NSString *)str format:(NSString *)formatStr {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    return [dateFormatter dateFromString:str];
}

//获取指定日期的周一
+ (NSString *)getBeginWeek:(NSString *)dateStr {
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:dateFormatStr1];// you can use your format.
    
    NSDate * today = [dateFormat dateFromString:dateStr];
    
    //Week Start Date
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:today] weekday];// this will give you current day of week
    
    [components setDay:([components day] - ((dayofweek) - 2))];// for beginning of the week.
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    
    NSDateFormatter *dateFormat_first = [[NSDateFormatter alloc] init];
    [dateFormat_first setDateFormat:dateFormatStr1];
    NSString * dateString2Prev = [dateFormat stringFromDate:beginningOfWeek];
    
    NSLog(@"StartDate:%@",dateString2Prev);
    
    return dateString2Prev;
}

//获取指定日期的周五
+ (NSString *)getEndWeek:(NSString *)dateStr {
    //Week End Date
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:dateFormatStr1];
    
    NSDate * today = [dateFormat dateFromString:dateStr];
    
    NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *componentsEnd = [gregorianEnd components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    NSInteger Enddayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:today] weekday];// this will give you current day of week
    
    [componentsEnd setDay:([componentsEnd day]+(7-Enddayofweek) - 1)];// for end day of the week
    
    NSDate *EndOfWeek = [gregorianEnd dateFromComponents:componentsEnd];
    NSDateFormatter *dateFormat_End = [[NSDateFormatter alloc] init];
    [dateFormat_End setDateFormat:dateFormatStr1];
    NSString * dateEndPrev = [dateFormat stringFromDate:EndOfWeek];
    
    NSLog(@"EndDate:%@",dateEndPrev);
    return dateEndPrev;
}

//输入参数是日期字符串，输出结果是星期几的数字。
+ (NSInteger)weekdayStringFromDate:(NSString *)inputDateStr {
    NSDate * inputDate = [KGDateUtil getDateByDateStr:inputDateStr format:dateFormatStr2];
    
//    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
//    return [weekdays objectAtIndex:theComponents.weekday];
    return theComponents.weekday - 1;
}

//输入参数是日期字符串，输出结果是星期几。
+ (NSString *)weekdayFromDate:(NSString *)inputDateStr {
    NSDate * inputDate = [KGDateUtil getDateByDateStr:inputDateStr format:dateFormatStr1];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}


@end
