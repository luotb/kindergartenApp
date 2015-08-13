//
//  GiftwareArticlesInfoViewController.m
//  kindergartenApp
//
//  Created by You on 15/7/31.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "GiftwareArticlesInfoViewController.h"
#import "KGHUD.h"
#import "KGHttpService.h"
#import "ReplyListViewController.h"
#import "ShareViewController.h"
#import "UIView+Extension.h"
#import "PopupView.h"
#import "FavoritesDomain.h"
#import "KGDateUtil.h"

@interface GiftwareArticlesInfoViewController () {
    
    IBOutlet UILabel * titleLabel;
    IBOutlet UIWebView * myWebView;
    IBOutlet UILabel * createUserLabel;
    IBOutlet UILabel * timeLabel;
    IBOutlet UIView * bottomFunView;
    IBOutlet UIImageView * dzImageView;
    IBOutlet UIButton *dzBtn;
    
    IBOutlet UIImageView *favImageView;
    IBOutlet UIButton *favBtn;
    PopupView * popupView;
    ShareViewController * shareVC;
    AnnouncementDomain * announcementDomain;
}

@end

@implementation GiftwareArticlesInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"文章详情";
    
    myWebView.backgroundColor = [UIColor clearColor];
    myWebView.opaque = NO;
    [self getArticlesInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getArticlesInfo {
    
    [[KGHttpService sharedService] getArticlesInfo:_annuuid success:^(AnnouncementDomain *announcementObj) {
        
        announcementDomain = announcementObj;
        [self resetViewParam];
        
    } faild:^(NSString *errorMsg) {
        
    }];
}

- (void)resetViewParam {
    titleLabel.text = announcementDomain.title;
    [myWebView loadHTMLString:announcementDomain.message baseURL:nil];
    timeLabel.text = announcementDomain.create_time;
    createUserLabel.text = announcementDomain.create_user;
    
    if(announcementDomain.dianzan && !announcementDomain.dianzan.canDianzan) {
        dzImageView.image = [UIImage imageNamed:@"zan2"];
        dzBtn.userInteractionEnabled = NO;
    }
    
    if(!announcementDomain.isFavor) {
        favImageView.image = [UIImage imageNamed:@"shoucang2"];
        favBtn.userInteractionEnabled = NO;
    }
}


- (IBAction)articlesFunBtnClicked:(UIButton *)sender {
   
    switch (sender.tag) {
        case 10:
            //赞
            [self savwDZ];
            break;
        case 11: {
            //分享
            [self shareClicked];
            break;
        }
        case 12:
            //收藏
            [self saveFavorites];
            break;
        case 13: {
            //评论
            ReplyListViewController * baseVC = [[ReplyListViewController alloc] init];
            baseVC.topicUUID = announcementDomain.uuid;
            [self.navigationController pushViewController:baseVC animated:YES];
            break;
        }
    }
}

//保存点赞
- (void)savwDZ {
    [[KGHUD sharedHud] show:self.contentView];
    
    [[KGHttpService sharedService] saveDZ:announcementDomain.uuid type:Topic_Articles success:^(NSString *msgStr) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:msgStr];
        dzImageView.image = [UIImage imageNamed:@"zan2"];
        dzBtn.userInteractionEnabled = NO;
    } faild:^(NSString *errorMsg) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
    }];
}


//分享
- (void)shareClicked {
    if(!popupView) {
        popupView = [[PopupView alloc] initWithFrame:CGRectMake(Number_Zero, Number_Zero, KGSCREEN.size.width, KGSCREEN.size.height)];
        popupView.alpha = Number_Zero;
        
        CGFloat height = 140;
        shareVC = [[ShareViewController alloc] init];
        shareVC.view.frame = CGRectMake(Number_Zero,  KGSCREEN.size.height-height, KGSCREEN.size.width, height);
        [popupView addSubview:shareVC.view];
        [self.view addSubview:popupView];
    }
    
    [UIView viewAnimate:^{
        popupView.alpha = Number_One;
    } time:Number_AnimationTime_Five];
}

//保存收藏
- (void)saveFavorites {
    [[KGHUD sharedHud] show:self.contentView];
    
    FavoritesDomain * domain = [[FavoritesDomain alloc] init];
    domain.title = announcementDomain.title;
    domain.type  = Topic_Articles;
    domain.reluuid = announcementDomain.uuid;
    domain.createtime = [KGDateUtil presentTime];
    
    [[KGHttpService sharedService] saveFavorites:domain success:^(NSString *msgStr) {
        favImageView.image = [UIImage imageNamed:@"shoucang2"];
        favBtn.userInteractionEnabled = NO;
        [[KGHUD sharedHud] show:self.contentView onlyMsg:msgStr];
    } faild:^(NSString *errorMsg) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
    }];
}

@end
