//
//  ShareViewController.m
//  kindergartenApp
//
//  Created by You on 15/8/6.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "ShareViewController.h"
#import "PopupView.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:Number_ViewAlpha_Five];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)shareBtnClicked:(UIButton *)sender {
    
    switch (sender.tag) {
        case 10:
            //微信
            break;
        case 11:
            //QQ好友
            break;
        case 12:
            //朋友圈
            break;
        case 13:
            //新浪
            break;
    }
}

- (IBAction)cancelShareBtnClicked:(UIButton *)sender {
    PopupView * view = (PopupView *)self.view.superview;
    [view singleBtnTap];
}



@end
