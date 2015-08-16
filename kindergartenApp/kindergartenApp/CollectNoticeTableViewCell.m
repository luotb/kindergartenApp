//
//  CollectNoticeTableViewCell.m
//  kindergartenApp
//
//  Created by CxDtreeg on 15/8/16.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "CollectNoticeTableViewCell.h"

@implementation CollectNoticeTableViewCell

- (void)awakeFromNib {
    _flagImageView.layer.cornerRadius = _flagImageView.height/2.0;
}

//设置数据更新界面
- (void)setData:(AnnouncementDomain *)data{
    _data = data;
    
    _myTitleLabel.text = data.title;
    _subLabel.text = [[KGHttpService sharedService] getGroupNameByUUID:data.groupuuid];
    _contentLabel.text = data.message;
    
    if(data.create_time) {
        NSDate * date = [KGDateUtil getDateByDateStr:data.create_time format:dateFormatStr2];
        _timeLabel.text = [KGNSStringUtil compareCurrentTime:date];
    }
    [_flagImageView sd_setImageWithURL:[NSURL URLWithString:[KGHttpService sharedService].groupDomain.img] placeholderImage:[UIImage imageNamed:@"group_head_def"] options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_flagImageView setBorderWithWidth:Number_Zero color:[UIColor clearColor] radian:_flagImageView.width / Number_Two];
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
