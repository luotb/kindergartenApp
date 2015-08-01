//
//  TopicInteractViewController.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/8/1.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "BaseTopicInteractViewController.h"
#import "KGHttpService.h"
#import "KGHUD.h"
#import "PostTopicViewController.h"

@interface BaseTopicInteractViewController ()

@end

@implementation BaseTopicInteractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册点赞回复通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topicFunClickedNotification:) name:Key_Notification_TopicFunClicked object:nil];
}

//cell点击监听通知
- (void)topicFunClickedNotification:(NSNotification *)notification {
    NSDictionary * dic = [notification userInfo];
    NSInteger type = [[dic objectForKey:Key_TopicCellFunType] integerValue];
    NSString * uuid = [dic objectForKey:Key_TopicUUID];
    BOOL isSelected = [[dic objectForKey:Key_TopicFunRequestType] boolValue];
    
    if(type == Number_Ten) {
        //点赞
        [self dzOperationHandler:isSelected uuid:uuid];
    } else {
        //回复
        [self postTopic:uuid];
    }
}


- (void)dzOperationHandler:(BOOL)isSelected uuid:(NSString *)uuid {
    
    if(isSelected) {
        //点赞
        [[KGHttpService sharedService] saveDZ:uuid type:Topic_Interact success:^(NSString *msgStr) {
            [[KGHUD sharedHud] show:self.contentView onlyMsg:msgStr];
        } faild:^(NSString *errorMsg) {
            [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
        }];
    } else {
        //取消点赞
        [[KGHttpService sharedService] delDZ:uuid success:^(NSString *msgStr) {
            [[KGHUD sharedHud] show:self.contentView onlyMsg:msgStr];
        } faild:^(NSString *errorMsg) {
            [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
        }];
    }
}

- (void)postTopic:(NSString *)topicUUID {
    PostTopicViewController * ptVC = [[PostTopicViewController alloc] init];
    ptVC.topicType = Topic_Interact;
    ptVC.topicUUID = topicUUID;
    [self.navigationController pushViewController:ptVC animated:YES];
}


@end
