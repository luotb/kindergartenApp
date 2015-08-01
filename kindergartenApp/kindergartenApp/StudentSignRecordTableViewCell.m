//
//  StudentSignRecordTableViewCell.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/8/1.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "StudentSignRecordTableViewCell.h"
#import "StudentSignRecordDomain.h"

@implementation StudentSignRecordTableViewCell

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
    StudentSignRecordDomain * domain = (StudentSignRecordDomain *)baseDomain;
    
//    nameLabel.text = domain.
    timeLabel.text = domain.sign_time;
    addressLabel.text = domain.groupname;
    signNameLabel.text = domain.sign_name;
    typeLabel.text = domain.type;
}

@end
