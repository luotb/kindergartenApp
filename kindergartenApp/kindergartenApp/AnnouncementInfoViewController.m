//
//  AnnouncementInfoViewController.m
//  kindergartenApp
//
//  Created by You on 15/7/28.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "AnnouncementInfoViewController.h"
#import "KGHttpService.h"
#import "KGHUD.h"
#import "TopicInteractionView.h"
#import "Masonry.h"
#import "KGNSStringUtil.h"

@interface AnnouncementInfoViewController () <UIWebViewDelegate> {
    
    IBOutlet UIScrollView * contentScrollView;
    IBOutlet UILabel   * titleLabel;
    IBOutlet UIWebView * myWebView;
    IBOutlet UILabel   * groupLabel;
    IBOutlet UILabel   * createTimeLabel;
    TopicInteractionView * topicView;
    AnnouncementDomain * announcementDomain;
}

@end

@implementation AnnouncementInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myWebView.backgroundColor = [UIColor clearColor];
    myWebView.opaque = NO;
    myWebView.delegate = self;
    [self getAnnouncementDomainInfo];
    
    self.contentView.width = KGSCREEN.size.width;
    contentScrollView.width = KGSCREEN.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//加载帖子互动
- (void)loadTopicInteractionView {
   
    self.topicType = announcementDomain.topicType;
    
    CGFloat y = CGRectGetMaxY(createTimeLabel.frame) + Number_Ten;
    topicView = [[TopicInteractionView alloc] init];
    topicView.topicType = self.topicType;
    topicView.topicUUID = announcementDomain.uuid;
    [topicView loadFunView:announcementDomain.dianzan reply:announcementDomain.replyPage];
    [contentScrollView addSubview:topicView];
    
    [topicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(y));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.width.equalTo(@(CELLCONTENTWIDTH));
        make.height.equalTo(@(topicView.topicInteractHeight));
    }];
    
//    [self.keyBoardController buildDelegate];
    
    CGFloat contentHeight = y + topicView.topicInteractHeight + 64;
    CGFloat contentWidth  = KGSCREEN.size.width;
    contentScrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
}


- (void)getAnnouncementDomainInfo {
    
    [[KGHttpService sharedService] getAnnouncementInfo:_annuuid success:^(AnnouncementDomain *announcementObj) {
        
        announcementDomain = announcementObj;
        [self resetViewParam];
        [self loadTopicInteractionView];
        
    } faild:^(NSString *errorMsg) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
    }];
}


- (void)resetViewParam {
    titleLabel.text = announcementDomain.title;
    [myWebView loadHTMLString:announcementDomain.message baseURL:nil];
    groupLabel.text = [[KGHttpService sharedService] getGroupNameByUUID:announcementDomain.groupuuid];
    createTimeLabel.text = announcementDomain.create_time;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //webview 自适应高度
    CGRect frame = webView.frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = CGRectMake(Number_Zero, CGRectGetMaxY(titleLabel.frame), KGSCREEN.size.width, fittingSize.height);
    groupLabel.y = CGRectGetMaxY(webView.frame) + Number_Ten;
    createTimeLabel.y = CGRectGetMaxY(groupLabel.frame) + Number_Ten;
    topicView.y = CGRectGetMaxY(groupLabel.frame) + 30;
    contentScrollView.contentSize = CGSizeMake(KGSCREEN.size.width, topicView.height + topicView.y + CELLPADDING);
}

- (void)alttextFieldDidEndEditing:(UITextField *)textField {
    NSString * replyText = [KGNSStringUtil trimString:textField.text];
    if(replyText && ![replyText isEqualToString:String_DefValue_Empty]) {
        NSDictionary *dic = @{Key_TopicTypeReplyText : [KGNSStringUtil trimString:textField.text],
                              Key_TopicUUID : announcementDomain.uuid,
                              Key_TopicType : [NSNumber numberWithInteger:self.topicType],
                              Key_TopicInteractionView : topicView};
        [[NSNotificationCenter defaultCenter] postNotificationName:Key_Notification_TopicFunClicked object:self userInfo:dic];
        
        [textField resignFirstResponder];
    }
}


@end
