//
//  TopicInteractionFrame.h
//  kindergartenApp
//
//  Created by You on 15/7/30.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicInteractionDomain.h"

@interface TopicInteractionFrame : NSObject

@property (strong, nonatomic) TopicInteractionDomain * topicInteractionDomain;

/** 功能按钮视图 */
@property (nonatomic, assign) CGRect funViewF;
/** 发帖时间 */
@property (nonatomic, assign) CGRect dateLabelF;
/** 点赞按钮 */
@property (nonatomic, assign) CGRect dianzanBtnF;
/** 回复按钮 */
@property (nonatomic, assign) CGRect replyBtnF;
/** 点赞列表视图 */
@property (nonatomic, assign) CGRect dianzanViewF;
/** 点赞列表ICON */
@property (nonatomic, assign) CGRect dianzanIconImgF;
/** 点赞列表文本 */
@property (nonatomic, assign) CGRect dianzanLabelF;
/** 回复列表视图 */
@property (nonatomic, assign) CGRect replyViewF;
/** 回复输入框 */
@property (nonatomic, assign) CGRect replyTextFieldF;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
