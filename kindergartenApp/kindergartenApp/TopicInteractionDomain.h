//
//  TopicInteractionDomain.h
//  kindergartenApp
//
//  Created by You on 15/7/30.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicInteractionDomain : NSObject

//帖子ID
@property (strong, nonatomic) NSString * uuid;
//帖子类型
@property (assign, nonatomic) KGTopicType  topicType;

@end
