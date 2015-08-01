//
//  RecipesDomain.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/8/1.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "RecipesDomain.h"
#import "CookbookDomain.h"

@implementation RecipesDomain

- (NSDictionary *)objectClassInArray
{
    return @{@"list_time_1" : [CookbookDomain class],
             @"list_time_2" : [CookbookDomain class],
             @"list_time_3" : [CookbookDomain class],
             @"list_time_4" : [CookbookDomain class],
             @"list_time_5" : [CookbookDomain class]};
}

@end
