//
//  TopicInteractionView.h
//  kindergartenApp
//  帖子互动部分  包含： 点赞、回复按钮和列表
//  Created by You on 15/7/30.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicInteractionFrame.h"
#import "HBVLinkedTextView.h"
#import "KGTextField.h"

@interface TopicInteractionView : UIView <UITextFieldDelegate>


@property (strong, nonatomic) TopicInteractionFrame * topicFrame;

/** 功能按钮视图 */
@property (nonatomic, weak) UIView   * funView;
/** 发帖时间 */
@property (nonatomic, weak) UILabel  * dateLabel;
/** 点赞按钮 */
@property (nonatomic, weak) UIButton * dianzanBtn;
/** 回复按钮 */
@property (nonatomic, weak) UIButton * replyBtn;

/** 点赞列表视图 */
@property (nonatomic, weak) UIView   * dianzanView;
/** 点赞列表ICON */
@property (nonatomic, weak) UIImageView * dianzanIconImg;

/** 点赞列表文本 */
@property (nonatomic, weak) UILabel  * dianzanLabel;

/** 回复列表视图 */
@property (nonatomic, weak) HBVLinkedTextView  * replyView;

/** 回复输入框 */
@property (nonatomic, weak) KGTextField * replyTextField;

@property (assign, nonatomic) BOOL isDZList;

@end
