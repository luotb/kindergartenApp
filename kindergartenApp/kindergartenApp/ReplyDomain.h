//
//  ReplyDomain.h
//  kindergartenApp
//  帖子回复对象
//  Created by yangyangxun on 15/7/25.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "KGBaseDomain.h"

@interface ReplyDomain : KGBaseDomain

@property (strong, nonatomic) NSString * content;
@property (strong, nonatomic) NSString * newsuuid;
@property (assign, nonatomic) KGTopicType topicType;

@end
