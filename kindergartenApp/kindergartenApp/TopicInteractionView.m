//
//  TopicInteractionView.m
//  kindergartenApp
//
//  Created by You on 15/7/30.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "TopicInteractionView.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "UIButton+Extension.h"
#import "KGHttpService.h"

@implementation TopicInteractionView 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        [self loadFunView];
    }
    
    return self;
}


- (void)loadFunView {
    //加载功能按钮 (点赞、回复)
    [self initFunView];
    
    //加载点赞列表
    [self initDZLabel];
    
    //加载回复
    [self initReplyView];
    
    //加载回复输入框
    [self initReplyTextField];
}


//加载功能按钮 (点赞、回复)
- (void)initFunView {
    UIView * funView = [[UIView alloc] init];
    funView.backgroundColor = CLEARCOLOR;
//    funView.backgroundColor = [UIColor redColor];
    [self addSubview:funView];
    
    _funView = funView;
    
    UILabel * datelab = [[UILabel alloc] init];
    datelab.backgroundColor = CLEARCOLOR;
    datelab.font = TopicCellDateFont;
    datelab.textColor = KGColorFrom16(0x666666);
    [funView addSubview:datelab];
    _dateLabel = datelab;
    
    UIButton * dzBtn = [[UIButton alloc] init];
    [dzBtn setBackgroundImage:@"anzan" selImg:@"hongzan"];
    dzBtn.tag = Number_Ten;
    [dzBtn addTarget:self action:@selector(topicFunBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [funView addSubview:dzBtn];
    _dianzanBtn = dzBtn;
    
    UIButton * replyBtn = [[UIButton alloc] init];
    [replyBtn setBackgroundImage:@"pinglun" selImg:@"pinglun"];
    replyBtn.tag = Number_Eleven;
    [replyBtn addTarget:self action:@selector(topicFunBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    dzlabel.font = TopicCellDateFont;
    [dzView addSubview:dzlabel];
    _dianzanLabel = dzlabel;
}

//加载回复
- (void)initReplyView {
    HBVLinkedTextView * replyLabel = [[HBVLinkedTextView alloc] init];
    replyLabel.backgroundColor = CLEARCOLOR;
//    replyLabel.backgroundColor = [UIColor greenColor];
    replyLabel.font = TopicCellDateFont;
    [self addSubview:replyLabel];
    
    _replyView = replyLabel;
}


//加载回复输入框
- (void)initReplyTextField {
    KGTextField * replyTextField = [[KGTextField alloc] init];
    replyTextField.placeholder = @"我来说一句...";
    replyTextField.returnKeyType = UIReturnKeySend;
    replyTextField.delegate = self;
    [self addSubview:replyTextField];
    
    [replyTextField setBorderWithWidth:1 color:[UIColor blackColor] radian:5.0];
    
    _replyTextField = replyTextField;
}


//键盘回车
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}


- (void)topicFunBtnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    NSDictionary *dic = @{Key_TopicCellFunType : [NSNumber numberWithInteger:sender.tag],
                          Key_TopicUUID : _topicFrame.topicInteractionDomain.uuid,
                          Key_TopicFunRequestType : [NSNumber numberWithBool:sender.selected]};
    [[NSNotificationCenter defaultCenter] postNotificationName:Key_Notification_TopicFunClicked object:self userInfo:dic];
}


-(void)setTopicFrame:(TopicInteractionFrame *)topicFrame {
    
    _topicFrame = topicFrame;
    //功能按钮
    self.funView.frame = self.topicFrame.funViewF;
    self.dateLabel.frame = self.topicFrame.dateLabelF;
    self.dianzanBtn.frame = self.topicFrame.dianzanBtnF;
    self.replyBtn.frame   = self.topicFrame.replyBtnF;
    
    //时间
//    if(topic.create_time) {
//        NSDate * date = [KGDateUtil getDateByDateStr:topic.create_time format:dateFormatStr2];
//        self.dateLabel.text = [KGNSStringUtil compareCurrentTime:date];
//    }
    
    //回复输入框
    self.replyTextField.frame = self.topicFrame.replyTextFieldF;
    
//    [self getDZInfo];
   
    NSLog(@"fun:%@, reply:%@", NSStringFromCGRect(self.topicFrame.funViewF), NSStringFromCGRect(self.topicFrame.replyTextFieldF));
}


- (void)getDZInfo {
    
    [[KGHttpService sharedService] getDZList:_topicFrame.topicInteractionDomain.uuid success:^(DianZanDomain *dzDomain) {
        
        if(dzDomain && dzDomain.count>Number_Zero) {
            //点赞
            self.dianzanView.frame = self.topicFrame.dianzanViewF;
            self.dianzanIconImg.frame = self.topicFrame.dianzanIconImgF;
            
            //点赞文本
            self.dianzanLabel.frame = self.topicFrame.dianzanLabelF;
            
            NSArray * nameArray = [dzDomain.names componentsSeparatedByString:@","];
            
            if([nameArray count] >= Number_Five) {
                self.dianzanLabel.text = [NSString stringWithFormat:@"%@等%ld人觉得很赞", dzDomain.names, (long)dzDomain.count];
            } else {
                self.dianzanLabel.text = [NSString stringWithFormat:@"%@ %ld人觉得很赞", dzDomain.names, (long)dzDomain.count];
            }
            
            self.dianzanBtn.selected = dzDomain.canDianzan;
            
            CGFloat h = CGRectGetHeight(self.topicFrame.dianzanViewF);
            
            /* cell的高度 */
            self.topicFrame.cellHeight += h;
            
            [self resetFrame:[[NSArray alloc] initWithObjects:self.replyTextField, nil] h:CGRectGetMaxY(self.topicFrame.dianzanViewF) + Number_Ten];
            
            _isDZList = YES;
        }
        
         [self getReplyList];
        
    } faild:^(NSString *errorMsg) {
         [self getReplyList];
    }];
}


- (void)getReplyList {
    
    PageInfoDomain * pageInfo = [[PageInfoDomain alloc] initPageInfo:Number_One size:Number_Ten];
    
    [[KGHttpService sharedService] getReplyList:pageInfo topicUUID:_topicFrame.topicInteractionDomain.uuid success:^(PageInfoDomain *pageInfo) {
        
        if([pageInfo.data count] > Number_Zero) {
            
            CGFloat y = CGRectGetMaxY(self.topicFrame.funViewF);
            
            if(_isDZList) {
                y = CGRectGetMaxY(self.topicFrame.dianzanViewF);
            }
            
            NSMutableArray  * arrayOfStrings = [[NSMutableArray alloc] initWithCapacity:[pageInfo.data count]];
            NSMutableString * replyStr       = [[NSMutableString alloc] init];
            
            for(ReplyDomain * reply in pageInfo.data) {
                [replyStr appendFormat:@"%@:%@ \n", reply.create_user, reply.title ? reply.title : @""];
                [arrayOfStrings addObject:[NSString stringWithFormat:@"%@:", reply.create_user]];
            }
            
            CGSize size = [replyStr sizeWithFont:[UIFont systemFontOfSize:APPUILABELFONTNO12]
                               constrainedToSize:CGSizeMake(CELLCONTENTWIDTH, 2000)
                                   lineBreakMode:NSLineBreakByWordWrapping];
            
            
            _topicFrame.replyViewF = CGRectMake(CELLPADDING, y + Number_Five, CELLCONTENTWIDTH, size.height);
            _replyView.frame = _topicFrame.replyViewF;
            
            self.replyView.text = replyStr;
            [self.replyView linkStrings:arrayOfStrings
                      defaultAttributes:[self exampleAttributes]
                  highlightedAttributes:[self exampleAttributes]
                             tapHandler:nil];
            
            CGFloat addH = CGRectGetMaxY(_replyView.frame) - y;
            
            /* cell的高度 */
            self.topicFrame.cellHeight += addH;
            
            [self resetFrame:[[NSArray alloc] initWithObjects:self.replyTextField, nil] h:CGRectGetMaxY(_topicFrame.replyViewF)];
        }
        
    } faild:^(NSString *errorMsg) {
        
    }];
}

- (void)resetFrame:(NSArray *)views h:(CGFloat)h {
    CGFloat y = h;
    for(UIView * view in views){
        if(view) {
            view.y = y;
            y = CGRectGetMaxY(view.frame);
        }
    }
}


- (NSMutableDictionary *)exampleAttributes
{
    return [@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]],
              NSForegroundColorAttributeName:[UIColor redColor]}mutableCopy];
}


@end
