//
//  MessageTableViewCell.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/7/28.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MessageDomain.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

/**
 *  重置cell内容
 *
 *  @param baseDomain   cell需要的数据对象
 *  @param parameterDic 扩展字典
 */
- (void)resetValue:(id)baseDomain parame:(NSMutableDictionary *)parameterDic {
    MessageDomain * domain = (MessageDomain *)baseDomain;
    
    _subTitleLabel.text = domain.message;
    _groupLabel.text = domain.revice_user;
    _timeLabel.text = domain.create_time;
}

@end
