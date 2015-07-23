//
//  StudentBaseInfoViewController.m
//  kindergartenApp
//
//  Created by You on 15/7/23.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "StudentBaseInfoViewController.h"
#import "KGTextField.h"

@interface StudentBaseInfoViewController () {
    
    IBOutlet UIImageView * headImageView;
    IBOutlet KGTextField * nameTextField;
    IBOutlet KGTextField * nickTextField;
    IBOutlet KGTextField * birthdayTextField;
    IBOutlet UIImageView * boyImageView;
    IBOutlet UIImageView * girlImageView;
}

@end

@implementation StudentBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/**
 *  添加输入框到array统一管理验证
 */
- (void)addTextFieldToMArray
{
    [nameTextField setTextFielType:KGTextFielType_Empty];
    [nameTextField setMessageStr:@"姓名不能为空"];
    [textFieldMArray addObject:nameTextField];
}



- (IBAction)changeHeadImgBtnClicked:(UIButton *)sender {
}

- (IBAction)sexBtnClicked:(UIButton *)sender {
    _studentInfo.sex = sender.tag-Number_Ten;
    
}





@end
