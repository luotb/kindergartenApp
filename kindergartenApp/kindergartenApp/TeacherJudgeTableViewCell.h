//
//  TeacherJudgeTableViewCell.h
//  kindergartenApp
//  评价老Cell
//  Created by yangyangxun on 15/7/28.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReFreshBaseCell.h"
#import "TeacherVO.h"
#import "KGTextView.h"

@interface TeacherJudgeTableViewCell : ReFreshBaseCell {
    NSInteger lastSelTag;
}

@property (strong, nonatomic) TeacherVO * teachVO;

@property (strong, nonatomic) IBOutlet UIImageView * headImageView;
@property (strong, nonatomic) IBOutlet UILabel * nameLabel;
@property (strong, nonatomic) IBOutlet KGTextView * judgeTextView;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;


- (IBAction)judgeBtnClicked:(UIButton *)sender;

- (IBAction)submitBtnClicked:(UIButton *)sender;

@end