//
//  TopicTableViewCell.m
//  MYAPP
//
//  Created by Moyun on 15/7/1.
//  Copyright (c) 2015年 Moyun. All rights reserved.
//

#import "TopicTableViewCell.h"
#import "UIColor+Extension.h"
#import "TopicFrame.h"
#import "UIButton+Extension.h"
#import "UIView+Extension.h"
#import "TopicDomain.h"

#define TOPICTABLECELL @"topicTableCell"

@interface TopicTableViewCell()

@end
@implementation TopicTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    TopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TOPICTABLECELL];
    if (!cell) {
        cell = [[TopicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TOPICTABLECELL];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KGColorFrom16(0xEBEBF2);
        //用户信息加载
        [self initUserView];
        
        //加载帖子内容
        [self initContentView];
        
        //加载功能按钮 (点赞、回复)
        [self initFunView];
        
        //加载点赞列表
        [self initDZLabel];
        
        //加载回复
        [self inirReplyView];
        
        //加载回复输入框
        [self initReplyTextField];
        
        //分割线
        [self initLeve];
    }
    
      return self;
}

//用户信息加载
-(void)initUserView{
    UIView * userview = [[UIView alloc] init];
    userview.backgroundColor = CLEARCOLOR;
//    userview.backgroundColor = [UIColor brownColor];
    [self addSubview:userview];
    _userView = userview;
    
    UIImageView * headImage = [[UIImageView alloc] init];
    [userview addSubview:headImage];
    _headImageView = headImage;
    
    UILabel * namelab = [[UILabel alloc] init];
    namelab.backgroundColor = CLEARCOLOR;
    namelab.font = MYTopicCellNameFont;
    namelab.textColor = [UIColor blackColor];
    [userview addSubview:namelab];
    
    _nameLab = namelab;
    
    UILabel  * titlelab = [[UILabel alloc] init];
    titlelab.backgroundColor = CLEARCOLOR;
    titlelab.font = MYTopicCellNameFont;
//    titlelab.numberOfLines = 0;
    [userview addSubview:titlelab];
    _titleLab = titlelab;
    
}


//加载帖子内容
- (void)initContentView {
    UIWebView * contentWebView = [[UIWebView alloc] init];
//    contentWebView.backgroundColor = KGColorFrom16(0xEBEBF2);
    [contentWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#EBEBF2'"];
    [self addSubview:contentWebView];
    
    [contentWebView.layer setCornerRadius:10.0];
    [contentWebView.layer setMasksToBounds:YES];
    
    _contentWebView = contentWebView;
}


//加载功能按钮 (点赞、回复)
- (void)initFunView {
    UIView * funView = [[UIView alloc] init];
    funView.backgroundColor = CLEARCOLOR;
//    funView.backgroundColor = [UIColor grayColor];
    [self addSubview:funView];
    
    _funView = funView;
    
    UILabel * datelab = [[UILabel alloc] init];
    datelab.backgroundColor = CLEARCOLOR;
    datelab.font = MYTopicCellDateFont;
    datelab.textColor = KGColorFrom16(0x666666);
    [funView addSubview:datelab];
    _dateLabel = datelab;
    
    UIButton * dzBtn = [[UIButton alloc] init];
    [dzBtn setBackgroundImage:@"anzan" selImg:@"hongzan"];
    dzBtn.tag = Number_Ten;
    [dzBtn addTarget:self action:@selector(funBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [funView addSubview:dzBtn];
    _dianzanBtn = dzBtn;
    
    UIButton * replyBtn = [[UIButton alloc] init];
    [replyBtn setBackgroundImage:@"pinglun" selImg:@"pinglun"];
    replyBtn.tag = Number_Eleven;
    [replyBtn addTarget:self action:@selector(funBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [funView addSubview:replyBtn];
    _replyBtn = replyBtn;
}

//加载点赞列表
- (void)initDZLabel {
    UIView * dzView = [[UIView alloc] init];
    dzView.backgroundColor = CLEARCOLOR;
//    dzView.backgroundColor = [UIColor brownColor];
    
    [self addSubview:dzView];
    
    _dianzanView = dzView;
    
    UIImageView * dzImage = [[UIImageView alloc] init];
    dzImage.image = [UIImage imageNamed:@"wodehuizan"];
//    dzImage.backgroundColor = [UIColor redColor];
    [dzView addSubview:dzImage];
    
    _dianzanIconImg = dzImage;
    
    UILabel * dzlabel = [[UILabel alloc] init];
    dzlabel.backgroundColor = CLEARCOLOR;
    dzlabel.font = MYTopicCellDateFont;
    [dzView addSubview:dzlabel];
    _dianzanLabel = dzlabel;
}

//加载回复
- (void)inirReplyView {
    UITextView * replyView = [[UITextView alloc] init];
    replyView.backgroundColor = CLEARCOLOR;
    replyView.backgroundColor = [UIColor blueColor];
    
    replyView.font = MYTopicCellDateFont;
    _replyView = replyView;
}


//加载回复输入框
- (void)initReplyTextField {
    UITextField * replyTextField = [[UITextField alloc] init];
    replyTextField.placeholder = @"我来说一句...";
    [self addSubview:replyTextField];
    
    [replyTextField setBorderWithWidth:1 color:[UIColor blackColor] radian:10.0];
    
    _replyTextField = replyTextField;
}


//加载分割线
-(void)initLeve{
    UILabel * levelab = [[UILabel alloc] init];
    levelab.backgroundColor = KGColor(225, 225, 225, 1);
    [self addSubview:levelab];
    
    _levelab = levelab;
}

-(void)setTopicFrame:(TopicFrame *)topicFrame{
    _topicFrame = topicFrame;
    TopicDomain * topic = self.topicFrame.topic;
    
    /** 用户信息 */
    self.userView.frame =self.topicFrame.userViewF;
    //头部图片
    self.headImageView.frame = self.topicFrame.headImageViewF;
    self.headImageView.image = [UIImage imageNamed:@"youxiang1"];
    
    //名称
    self.nameLab.frame = self.topicFrame.nameLabF;
    self.nameLab.text = topic.create_user;
   
    //title
    self.titleLab.frame = self.topicFrame.titleLabF;
    self.titleLab.text =  topic.title;
    
    //内容
    self.contentWebView.frame = self.topicFrame.contentWebViewF;
    [self.contentWebView loadHTMLString:topic.content baseURL:nil];
    
    //功能按钮
    self.funView.frame = self.topicFrame.funViewF;
    self.dateLabel.frame = self.topicFrame.dateLabelF;
    self.dianzanBtn.frame = self.topicFrame.dianzanBtnF;
    self.replyBtn.frame   = self.topicFrame.replyBtnF;
    
    //时间
    self.dateLabel.text = topic.create_time;
    
    //点赞
    self.dianzanView.frame = self.topicFrame.dianzanViewF;
    self.dianzanIconImg.frame = self.topicFrame.dianzanIconImgF;
    
    //点赞文本
    self.dianzanLabel.frame = self.topicFrame.dianzanLabelF;
    self.dianzanLabel.text = @"张小龙,城建,赵小刚,李四等9人觉得很赞";
    
    //回复
    self.replyView.frame = self.topicFrame.replyViewF;
    
    //回复输入框
    self.replyTextField.frame = self.topicFrame.replyTextFieldF;
    
    //分割线
    self.levelab.frame = self.topicFrame.levelabF;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)funBtnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
                     
    NSDictionary *dic = @{Key_TopicCellFunType : [NSNumber numberWithInteger:sender.tag],
                          Key_TopicUUID : _topicFrame.topic.uuid,
                          Key_TopicFunRequestType : [NSNumber numberWithBool:sender.selected]};
    [[NSNotificationCenter defaultCenter] postNotificationName:Key_Notification_TopicFunClicked object:self userInfo:dic];
}



@end
