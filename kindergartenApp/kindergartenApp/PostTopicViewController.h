//
//  PostTopicViewController.h
//  kindergartenApp
//  发帖
//  Created by yangyangxun on 15/7/25.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "BaseKeyboardViewController.h"
#import "BaseViewController.h"

@interface PostTopicViewController : BaseViewController

@property (strong, nonatomic) NSString * topicUUID;
@property (assign, nonatomic) KGTopicType topicType;

- (IBAction)addImgBtnClicked:(UIButton *)sender;

@end
