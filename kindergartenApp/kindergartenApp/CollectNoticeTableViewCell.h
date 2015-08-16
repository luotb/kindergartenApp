//
//  CollectNoticeTableViewCell.h
//  kindergartenApp
//
//  Created by CxDtreeg on 15/8/16.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnnouncementDomain.h"
#import "KGHttpService.h"
#import "KGNSStringUtil.h"
#import "KGDateUtil.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface CollectNoticeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *flagImageView;
@property (strong, nonatomic) IBOutlet UILabel *myTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *subLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) AnnouncementDomain * data;

@end
