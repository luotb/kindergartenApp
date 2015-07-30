//
//  TopicInteractionFrame.m
//  kindergartenApp
//
//  Created by You on 15/7/30.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "TopicInteractionFrame.h"

@implementation TopicInteractionFrame

- (void)setTopicInteractionDomain:(TopicInteractionDomain *)topic{
    
    _topicInteractionDomain = topic;
    
    // cell的宽度
    CGFloat cellW = KGSCREEN.size.width;
    
    //功能视图
    CGFloat funViewY = Number_Zero;
    CGFloat funViewH = CELLPADDING;
    self.funViewF = CGRectMake(CELLPADDING, funViewY, CELLCONTENTWIDTH, funViewH);
    
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.funViewF);
    
    //时间
    CGSize dateSize =CGSizeMake(100, 10);
    CGFloat dateX = 0;
    CGFloat dateY = 3;
    self.dateLabelF = (CGRect){{dateX, dateY}, dateSize};
    
    //回复按钮
    CGSize funBtnSize = CGSizeMake(31, 16);
    CGFloat replyBtnX = cellW - funBtnSize.width - CELLPADDING - CELLPADDING;
    CGFloat replyBtnY = 0;
    self.replyBtnF = (CGRect){{replyBtnX, replyBtnY}, funBtnSize};
    
    //点赞按钮
    CGFloat dzBtnX = replyBtnX - 15 - funBtnSize.width;
    self.dianzanBtnF = (CGRect){{dzBtnX, replyBtnY}, funBtnSize};
    
    //点赞列表
    self.dianzanViewF = CGRectMake(0, self.cellHeight + TopicCellBorderW, CELLCONTENTWIDTH, TopicCellBorderW);
    
    //点赞ICON
    self.dianzanIconImgF = CGRectMake(CELLPADDING, Number_Zero, Number_Ten, Number_Ten);
    
    //点赞列表
    CGFloat dzLabelX = CGRectGetMaxX(self.dianzanIconImgF) + Number_Ten;
    CGFloat dzLabelW = cellW - dzLabelX - CELLPADDING;
    
    self.dianzanLabelF = CGRectMake(dzLabelX, Number_Zero, dzLabelW, Number_Ten);
    
    //回复视图
    self.replyViewF = CGRectMake(CELLPADDING, CGRectGetMaxY(self.dianzanViewF), CELLCONTENTWIDTH, TopicCellBorderW);
    
    //回复输入框
    self.replyTextFieldF = CGRectMake(CELLPADDING, self.cellHeight + TopicCellBorderW, CELLCONTENTWIDTH, 30);
    
    self.cellHeight = CGRectGetMaxY(self.replyTextFieldF) + TopicCellBorderW;
}

@end
