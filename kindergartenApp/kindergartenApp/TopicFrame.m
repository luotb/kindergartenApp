//
//  TopicFrame.m
//  MYAPP
//
//  Created by Moyun on 15/7/1.
//  Copyright (c) 2015年 Moyun. All rights reserved.
//

#import "TopicFrame.h"
#import "TopicDomain.h"
#import "MLEmojiLabel.h"

@implementation TopicFrame


-(void)setTopic:(TopicDomain *)topic{
    
    _topic = topic;
    
    // cell的宽度
    CGFloat cellW = KGSCREEN.size.width;
    
    //用户信息整体
    CGFloat uviewW = cellW;
    CGFloat uviewH = 66;
    CGFloat ux = 0;
    CGFloat uy = 0;
    self.userViewF = CGRectMake(ux, uy, uviewW, uviewH);
    
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.userViewF);
    
    //头像
    CGFloat headWH = 45;
    CGFloat headX  = CELLPADDING;
    CGFloat headY  = 15;
    self.headImageViewF = CGRectMake(headX, headY, headWH, headWH);
    
    //名称
    CGFloat nameX = CGRectGetMaxX(self.headImageViewF) + TopicCellBorderW;
    CGFloat nameY = headY;
    CGFloat nameW = cellW - CELLPADDING - nameX;
    CGFloat nameH = APPUILABELFONTNO14;
    self.nameLabF = CGRectMake(nameX, nameY, nameW, nameH);
    
    
    //title
    if (self.topic.title && ![self.topic.title isEqualToString:String_DefValue_Empty]) {
        CGFloat titleX = nameX;
        CGFloat titleY = CGRectGetMaxY(self.nameLabF) + 8;
        CGFloat titleH = APPUILABELFONTNO13;
        self.titleLabF = CGRectMake(titleX, titleY, nameW, titleH);
    }
    
    //内容
    CGFloat topicContentW = cellW - nameX - CELLPADDING;
    CGFloat topicTextViewH = Number_Zero;
    CGFloat topicContentX = nameX;
    CGFloat topicTextViewY = CGRectGetMaxY(self.userViewF) + TopicCellBorderW;
    
    if(_topic.content && ![_topic.content isEqualToString:String_DefValue_Empty]) {
        //内容 文本+表情
        CGSize size = [MLEmojiLabel boundingRectWithSize:_topic.content w:topicContentW font:12];
        topicTextViewH = size.height;
        if(size.height > 30) {
            topicTextViewH += 30;
        }
        self.topicTextViewF = CGRectMake(topicContentX, topicTextViewY, topicContentW, topicTextViewH);
        /* cell的高度 */
        self.cellHeight = CGRectGetMaxY(self.topicTextViewF);
    }
    
    
    if(_topic.imgs && ![_topic.imgs isEqualToString:String_DefValue_Empty]) {
        //内容 图片
        CGFloat topicImgsViewY = self.cellHeight + TopicCellBorderW;
        CGFloat topicImgsViewH = Number_Zero;
        NSArray * imgArray = [_topic.imgs componentsSeparatedByString:String_DefValue_SpliteStr];
        
        //图片=1 根据图片实际大小决定高度
        //图片>3 换行
        CGFloat imgCellH = topicContentW / Number_Three;
        topicImgsViewH = imgCellH;
        
        if([imgArray count] > Number_Three) {
            //大于三张图片需要换行
            NSInteger page = ([imgArray count] + Number_Three - Number_One) / Number_Three;
            
            topicImgsViewH = page * imgCellH;
        }
        
        self.topicImgsViewF = CGRectMake(topicContentX, topicImgsViewY, topicContentW, topicImgsViewH);
        
        self.cellHeight = CGRectGetMaxY(self.topicImgsViewF);
    }
    
    //帖子互动
    [self setTopicInterActionRect];
    
    self.levelabF = CGRectMake(0, self.cellHeight, cellW, 0.5);
    
    self.cellHeight = CGRectGetMaxY(self.levelabF);
}

//计算点赞回复的rect
- (void)setTopicInterActionRect {
    // cell的宽度
    CGFloat cellW = KGSCREEN.size.width;
    CGFloat height = Number_Zero;
    
    //点赞回复功能H
    height += CELLPADDING;
    
    //点赞列表
    if(_topic.dianzan) {
        height += TopicCellBorderW + TopicCellBorderW;
    }
    
    if(_topic.replyPage && _topic.replyPage.data && [_topic.replyPage.data count]>Number_Zero) {
        NSMutableString * replyStr = [[NSMutableString alloc] init];
        
        NSInteger count = Number_Zero;
        for(ReplyDomain * reply in _topic.replyPage.data) {
            
            if(count < Number_Five) {
                [replyStr appendFormat:@"%@:%@ \n", reply.create_user, reply.content ? reply.title : @""];
            }
            count++;
        }
        
        CGSize size = [replyStr sizeWithFont:[UIFont systemFontOfSize:APPUILABELFONTNO12]
                           constrainedToSize:CGSizeMake(CELLCONTENTWIDTH, 2000)
                               lineBreakMode:NSLineBreakByWordWrapping];
        
        height += (size.height + TopicCellBorderW);
        
//        if(_topic.replyPage.totalCount>_topic.replyPage.pageSize || [_topic.replyPage.data count]>Number_Five) {
//            height += 30;
//        }
        
        if(count > Number_Four) {
            height += 30; //显示更多 按钮项
        }
    }
    
    //回复输入框
    height += 40;
    
    
    self.topicInteractionViewF = CGRectMake(Number_Zero, self.cellHeight + TopicCellBorderW, cellW, height);
    
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.topicInteractionViewF);
}


@end
