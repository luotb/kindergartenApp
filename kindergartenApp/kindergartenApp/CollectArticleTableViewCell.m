//
//  CollectArticleTableViewCell.m
//  kindergartenApp
//
//  Created by CxDtreeg on 15/8/16.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "CollectArticleTableViewCell.h"

@implementation CollectArticleTableViewCell

- (void)awakeFromNib {
}

//设置数据同时初始化 界面
- (void)setData:(AnnouncementDomain *)data{
    _data = data;
    
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"来自%@",data.create_user]];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, attString.length-2)];
    _fromManLabel.attributedText = attString;
    
    _collectTItleLabel.text = data.title;
    _contentLabel.text = data.message;
    if (data.create_time) {
        NSDate *date = [KGDateUtil getDateByDateStr:data.create_time format:dateFormatStr2];
        _timeLabel.text = [KGNSStringUtil compareCurrentTime:date];
    }
    if(data.dianzan) {
        _contentLabel.text = [NSString stringWithFormat:@"%ld", (long)data.dianzan.count];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
