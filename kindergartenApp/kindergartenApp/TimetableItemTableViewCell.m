//
//  TimetableItemTableViewCell.m
//  kindergartenApp
//
//  Created by You on 15/8/11.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "TimetableItemTableViewCell.h"
#import "KGHttpService.h"
#import "UIImageView+WebCache.h"
#import "UIButton+Extension.h"
#import "UIColor+Extension.h"

@implementation TimetableItemTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TimetableItemTableViewCell";
    TimetableItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TimetableItemTableViewCell"  owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    lastIndex = Number_Ten;
    UIButton * btn = nil;
    for(NSInteger i=Number_Ten; i<Number_Five; i++) {
        btn = (UIButton *)[self viewWithTag:i];
        [btn setTextColor:[UIColor whiteColor] sel:[UIColor whiteColor]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)resetTimetable:(TimetableItemVO *)timetableVO {
    timetableItemVO = timetableVO;
    
    [self loadTimetable:Number_Zero];
    UIButton * btn = (UIButton *)[self viewWithTag:Number_Ten];
    btn.selected = YES;
    
    [headImageView sd_setImageWithURL:[NSURL URLWithString:timetableItemVO.headUrl] placeholderImage:[UIImage imageNamed:@"head_def"] options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [headImageView setBorderWithWidth:Number_Zero color:KGColorFrom16(0xE7E7EE) radian:headImageView.width / Number_Two];
    }];
}

- (IBAction)dateBtnClicked:(UIButton *)sender {
    sender.selected = YES;
    if(sender.tag != lastIndex) {
        [self loadTimetable:sender.tag - Number_Ten];
        UIButton * btn = (UIButton *)[self viewWithTag:lastIndex];
        btn.selected = NO;
        lastIndex = sender.tag;
    }
}


- (void)loadTimetable:(NSInteger)index {
    if(index < [timetableItemVO.timetableMArray count]) {
        TimetableDomain * domain = [timetableItemVO.timetableMArray objectAtIndex:index];
        morningLabel.text = domain.morning;
        afternoonLabel.text = domain.afternoon;
        
        if(self.TimetableItemCellBlock) {
            self.TimetableItemCellBlock(domain);
        }
    }
}

@end