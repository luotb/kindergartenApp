//
//  MeViewController.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/7/18.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "MeViewController.h"
#import "KGAccountTool.h"
#import "UIWindow+Extension.h"
#import "KGUser.h"
#import "LoginViewController.h"
#import "KGNavigationController.h"

@interface MeViewController () <UIAlertViewDelegate>

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)logoutBtnClicked:(UIButton *)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认退出" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == Number_One) {
        
        KGUser * currentUser =  [KGAccountTool account];
        LoginViewController * loginVC = [[LoginViewController alloc] init];
        loginVC.userNameTextField.text = currentUser.loginname;
        loginVC.userPwdTextField.text = currentUser.password;
        
        [KGAccountTool delAccount];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [UIApplication sharedApplication].keyWindow.rootViewController = [[KGNavigationController alloc] initWithRootViewController:loginVC];
        });
       
    }
}



@end
