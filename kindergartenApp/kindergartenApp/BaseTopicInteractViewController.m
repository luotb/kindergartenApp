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
#import "TopicInteractionView.h"
#import "ReplyListViewController.h"
#import "UUInputFunctionView.h"
#import "Masonry.h"
#import "KGEmojiManage.h"

@interface BaseTopicInteractViewController () <UUInputFunctionViewDelegate, UIGestureRecognizerDelegate> {
    TopicInteractionView * topicInteractionView; //点赞回复视图
    UUInputFunctionView  * IFView;
}

@end

@implementation BaseTopicInteractViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadInputFuniView];
    
    [self addGestureBtn];
    
    //注册点赞回复通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topicFunClickedNotification:) name:Key_Notification_TopicFunClicked object:nil];
    //注册加载更多回复通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topicRelpyMoreBtnClickedNotification:) name:Key_Notification_TopicLoadMore object:nil];

    //添加键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
}

//添加手势
- (void)addGestureBtn {
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
    singleTapGesture.delegate = self;
    singleTapGesture.numberOfTapsRequired = Number_One;
    singleTapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:singleTapGesture];
}

//单击手势响应
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UITextField class]] ||
        [touch.view.superview isKindOfClass:[UITextView class]] ||
        [touch.view.superview isKindOfClass:[UUInputFunctionView class]])
        return NO;
    return YES;
}

//单击响应
- (void)singleTap{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

//topicFun点击监听通知
- (void)topicFunClickedNotification:(NSNotification *)notification {
    NSDictionary  * dic = [notification userInfo];
    NSInteger      type = [[dic objectForKey:Key_TopicCellFunType] integerValue];
    BOOL     isSelected = [[dic objectForKey:Key_TopicFunRequestType] boolValue];
    NSString * replyText = [dic objectForKey:Key_TopicTypeReplyText];
    topicInteractionView = [dic objectForKey:Key_TopicInteractionView];
    
    _topicUUID = [dic objectForKey:Key_TopicUUID];
    _topicType = [[dic objectForKey:Key_TopicType] integerValue];
    
    [[KGHUD sharedHud] show:self.contentView];
    if(type == Number_Ten) {
        //点赞
        [self dzOperationHandler:isSelected];
    } else {
        //回复
        [self postTopic:replyText];
    }
}


- (void)dzOperationHandler:(BOOL)isSelected {
    
    if(isSelected) {
        //点赞
        [[KGHttpService sharedService] saveDZ:_topicUUID type:_topicType success:^(NSString *msgStr) {
            [[KGHUD sharedHud] show:self.contentView onlyMsg:msgStr];
            [topicInteractionView resetDZName:YES name:[KGHttpService sharedService].loginRespDomain.userinfo.name];
        } faild:^(NSString *errorMsg) {
            [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
        }];
    } else {
        //取消点赞
        [[KGHttpService sharedService] delDZ:_topicUUID success:^(NSString *msgStr) {
            [[KGHUD sharedHud] show:self.contentView onlyMsg:msgStr];
            [topicInteractionView resetDZName:NO name:[KGHttpService sharedService].loginRespDomain.userinfo.name];
        } faild:^(NSString *errorMsg) {
            [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
        }];
    }
}

- (void)postTopic:(NSString *)replyText {
    ReplyDomain * replyObj = [[ReplyDomain alloc] init];
    replyObj.content = replyText;
    replyObj.newsuuid = _topicUUID;
    replyObj.type = _topicType;
    
    [[KGHttpService sharedService] saveReply:replyObj success:^(NSString *msgStr) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:msgStr];
        
        ReplyDomain * domain = [[ReplyDomain alloc] init];
        domain.content = replyText;
        domain.newsuuid = _topicUUID;
        domain.type = _topicType;
        domain.create_user = [KGHttpService sharedService].loginRespDomain.userinfo.name;;
        domain.create_useruuid = [KGHttpService sharedService].loginRespDomain.userinfo.uuid;
        
        [topicInteractionView resetReplyList:domain];
        [self resetTopicReplyContent:domain];
        
    } faild:^(NSString *errorMsg) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
    }];
}

//重置回复内容
- (void)resetTopicReplyContent:(ReplyDomain *)domain {
    
}

//回复加载更多按钮点击
- (void)topicRelpyMoreBtnClickedNotification:(NSNotification *)notification {
    NSDictionary  * dic = [notification userInfo];
    NSString * tUUID = [dic objectForKey:Key_TopicUUID];
    _topicType = (KGTopicType)[dic objectForKey:Key_TopicType];
    
    ReplyListViewController * baseVC = [[ReplyListViewController alloc] init];
    baseVC.topicUUID = tUUID;
    baseVC.topicType = _topicType;
    [self.navigationController pushViewController:baseVC animated:YES];
}


//键盘通知
-(void)keyboardChange:(NSNotification *)notification
{
    if(![KGEmojiManage sharedManage].isChatEmoji) {
        
    }
    NSDictionary * userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyysize:%@", NSStringFromCGSize(keyboardSize));
    
    
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    
    //adjust ChatTableView's height
    if (notification.name == UIKeyboardWillShowNotification) {
        
        IFView.y = keyboardEndFrame.origin.y - IFView.height;
        
//        self.bottomConstraint.constant = keyboardEndFrame.size.height+40;
//        self.contentView.y -= (keyboardEndFrame.size.height + 40);
        [IFView.TextViewInput becomeFirstResponder];
//        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(@(keyboardEndFrame.size.height+40));
//        }];
    }else{
        IFView.y = self.view.height + IFView.height;
//        self.bottomConstraint.constant = 40;
//        self.contentView.y = 0;
//        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(@(0));
//        }];
    }
    
    [self.view layoutIfNeeded];
    
    //adjust UUInputFunctionView's originPoint
    
    
    [UIView commitAnimations];
    
}

//加载底部输入功能View
- (void)loadInputFuniView {
    IFView = [[UUInputFunctionView alloc]initWithSuperVC:self isShow:NO];
    IFView.delegate = self;
    [self.view addSubview:IFView];
}

#pragma UUIput Delegate
// text
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message {
    
}


@end
