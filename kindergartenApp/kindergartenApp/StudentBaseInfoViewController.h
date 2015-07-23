//
//  StudentBaseInfoViewController.h
//  kindergartenApp
//
//  Created by You on 15/7/23.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "BaseKeyboardViewController.h"
#import "KGUser.h"

@interface StudentBaseInfoViewController : BaseKeyboardViewController

@property (strong, nonatomic) KGUser * studentInfo;


- (IBAction)changeHeadImgBtnClicked:(UIButton *)sender;

- (IBAction)sexBtnClicked:(UIButton *)sender;

@end
