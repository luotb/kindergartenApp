//
//  CollectArticleTableViewCell.h
//  kindergartenApp
//
//  Created by CxDtreeg on 15/8/16.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnnouncementDomain.h"
#import "KGDateUtil.h"
#import "KGNSStringUtil.h"

@interface CollectArticleTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *fromManLabel;
@property (strong, nonatomic) IBOutlet UILabel *collectTItleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *zanCountLabel;
@property (strong, nonatomic) IBOutlet UIImageView *zanImageView;

@property (strong, nonatomic) AnnouncementDomain * data;

@end
