//
//  ShareViewController.m
//  kindergartenApp
//
//  Created by You on 15/8/6.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "ShareViewController.h"
#import "PopupView.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "SystemShareKey.h"

@interface ShareViewController () <UMSocialUIDelegate>

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:Number_ViewAlpha_Five];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)shareBtnClicked:(UIButton *)sender {
    
    switch (sender.tag) {
        case 10:
            //微信
            [self handelShareWithShareType:UMShareToWechatSession];
            break;
        case 11:
            //QQ好友
            [self handelShareWithShareType:UMShareToQQ];
            break;
        case 12:
            [self handelShareWithShareType:UMShareToWechatTimeline];
            //朋友圈
            break;
        case 13:
            [self handelShareWithShareType:UMShareToSina];
            //新浪
            break;
    }
}

//处理分享操作
- (void)handelShareWithShareType:(NSString *)shareType{
    
    NSString * contentString = [NSString stringWithFormat:@"%@ %@",_announcementDomain.title,@"www.baidu.com"];
    
    //微信title设置方法：
    [UMSocialData defaultData].extConfig.wechatSessionData.title = _announcementDomain.title;
    //朋友圈title设置方法：
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = _announcementDomain.title;
    [UMSocialWechatHandler setWXAppId:ShareKey_WeChat appSecret:ShareKey_WeChatSecret url:webUrl];
    
    //设置分享内容，和回调对象
    [[UMSocialControllerService defaultControllerService] setShareText:contentString shareImage:nil socialUIDelegate:self];
    UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:shareType];
    snsPlatform.snsClickHandler(self, [UMSocialControllerService defaultControllerService],YES);
    
}

- (IBAction)cancelShareBtnClicked:(UIButton *)sender {
    PopupView * view = (PopupView *)self.view.superview;
    [view singleBtnTap];
}



@end
