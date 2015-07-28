//
//  MessageDomain.h
//  kindergartenApp
//
//  Created by You on 15/7/28.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "KGBaseDomain.h"

@interface MessageDomain : KGBaseDomain

@property (strong, nonatomic) NSString * message; //内容
@property (strong, nonatomic) NSString * send_user; //发送人名
@property (strong, nonatomic) NSString * send_useruuid; //	发送人uuid
@property (strong, nonatomic) NSString * revice_user; //	接收人名
@property (strong, nonatomic) NSString * revice_useruuid; //	接收人uuid
@property (strong, nonatomic) NSString * create_time; //	创建时间
@property (assign, nonatomic) BOOL       isread; //	0;未读,1:已读

@end
