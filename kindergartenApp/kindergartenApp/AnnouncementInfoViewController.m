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
#import "TopicInteractionDomain.h"
#import "TopicInteractionFrame.h"
#import "Masonry.h"

@interface AnnouncementInfoViewController () {
    
    IBOutlet UIScrollView * contentScrollView;
    IBOutlet UILabel   * titleLabel;
    IBOutlet UIWebView * myWebView;
    IBOutlet UILabel   * groupLabel;
    IBOutlet UILabel   * createTimeLabel;
}

@end

@implementation AnnouncementInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getAnnouncementDomainInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//加载帖子互动
- (void)loadTopicInteractionView {
    TopicInteractionDomain * domain = [[TopicInteractionDomain alloc] init];
    domain.uuid = _announcementDomain.uuid;
    domain.topicType = Topic_Announcement;
    
    TopicInteractionFrame * topicFrame = [[TopicInteractionFrame alloc] init];
    topicFrame.topicInteractionDomain = domain;
    
    CGFloat y = CGRectGetMaxY(createTimeLabel.frame) + Number_Ten;
//    CGRect frame = CGRectMake(CELLPADDING, y, CELLCONTENTWIDTH, topicFrame.cellHeight);
//    TopicInteractionView * topicView = [[TopicInteractionView alloc] initWithFrame:frame];
    TopicInteractionView * topicView = [[TopicInteractionView alloc] init];
    topicView.topicFrame = topicFrame;
//    topicView.backgroundColor = [UIColor grayColor];
    [contentScrollView addSubview:topicView];
    
    [topicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(y));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.width.equalTo(@(CELLCONTENTWIDTH));
        make.height.equalTo(@(topicFrame.cellHeight));
    }];
    
    [self.keyBoardController buildDelegate];
    
    CGFloat contentHeight = y + topicFrame.cellHeight + 64;
    CGFloat contentWidth  = KGSCREEN.size.width;
    contentScrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    NSLog(@"scroll:%@", NSStringFromCGRect(contentScrollView.frame));
}


- (void)getAnnouncementDomainInfo {
    
    [[KGHttpService sharedService] getAnnouncementInfo:_announcementDomain.uuid success:^(AnnouncementDomain *announcementObj) {
        
        _announcementDomain = announcementObj;
        [self resetViewParam];
        [self loadTopicInteractionView];
        
    } faild:^(NSString *errorMsg) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
    }];
}


- (void)resetViewParam {
    titleLabel.text = _announcementDomain.title;
    [myWebView loadHTMLString:_announcementDomain.content baseURL:nil];
    groupLabel.text = [[KGHttpService sharedService] getGroupNameByUUID:_announcementDomain.groupuuid];
    createTimeLabel.text = _announcementDomain.create_time;
}


@end
