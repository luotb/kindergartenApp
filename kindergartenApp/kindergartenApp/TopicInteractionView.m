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
#import "KGNSStringUtil.h"
#import "KGRange.h"

@implementation TopicInteractionView 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
    }
    
    return self;
}

- (void)loadFunView:(DianZanDomain *)dzDomain reply:(ReplyPageDomain *)replyPageDomain {
    
    _dianzan = dzDomain;
    _replyPage = replyPageDomain;
    
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
    // cell的宽度
    CGFloat cellW = KGSCREEN.size.width;
    
    if(_funView) {
        [_funView removeFromSuperview];
    }
    
    _funView = [[UIView alloc] initWithFrame:CGRectMake(CELLPADDING, Number_Zero, CELLCONTENTWIDTH, CELLPADDING)];
    _funView.backgroundColor = CLEARCOLOR;
//    funView.backgroundColor = [UIColor redColor];
    [self addSubview:_funView];
    
    /* cell的高度 */
    self.topicInteractHeight = CGRectGetMaxY(_funView.frame);
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(Number_Zero, Number_Three, 100, 10)];
    _dateLabel.backgroundColor = CLEARCOLOR;
    _dateLabel.font = TopicCellDateFont;
    _dateLabel.textColor = KGColorFrom16(0x666666);
    [_funView addSubview:_dateLabel];
    
    //回复按钮
    CGSize funBtnSize = CGSizeMake(31, 16);
    CGFloat replyBtnX = cellW - funBtnSize.width - CELLPADDING - CELLPADDING;
    CGFloat replyBtnY = 0;
    
    //点赞按钮
    CGFloat dzBtnX = replyBtnX - 15 - funBtnSize.width;
    
    _dianzanBtn = [[UIButton alloc] initWithFrame:CGRectMake(replyBtnX, replyBtnY, funBtnSize.width, funBtnSize.height)];
    [_dianzanBtn setBackgroundImage:@"anzan" selImg:@"hongzan"];
    _dianzanBtn.selected = !_dianzan.canDianzan;
    _dianzanBtn.tag = Number_Ten;
    [_dianzanBtn addTarget:self action:@selector(topicFunBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_funView addSubview:_dianzanBtn];
    
    if(_dianzan && _dianzan.canDianzan) {
        _dianzanBtn.selected = YES;
    }
    
    _replyBtn = [[UIButton alloc] initWithFrame:CGRectMake(dzBtnX, replyBtnY, funBtnSize.width, funBtnSize.height)];
    [_replyBtn setBackgroundImage:@"pinglun" selImg:@"pinglun"];
    _replyBtn.tag = Number_Eleven;
    [_replyBtn addTarget:self action:@selector(replyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_funView addSubview:_replyBtn];
}

//加载点赞列表
- (void)initDZLabel {
    if(_dianzanView) {
        [_dianzanView removeFromSuperview];
    }
    _dianzanView = [[UIView alloc] initWithFrame:CGRectMake(Number_Zero, self.topicInteractHeight + TopicCellBorderW, CELLCONTENTWIDTH, TopicCellBorderW)];
    _dianzanView.backgroundColor = CLEARCOLOR;
//    dzView.backgroundColor = [UIColor brownColor];
    [self addSubview:_dianzanView];
    
    _dianzanIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(CELLPADDING, Number_Zero, Number_Ten, Number_Ten)];
    _dianzanIconImg.image = [UIImage imageNamed:@"wodehuizan"];
//    dzImage.backgroundColor = [UIColor redColor];
    [_dianzanView addSubview:_dianzanIconImg];
    
    //点赞列表
    // cell的宽度
    CGFloat cellW = KGSCREEN.size.width;
    CGFloat dzLabelX = CGRectGetMaxX(_dianzanIconImg.frame) + Number_Ten;
    CGFloat dzLabelW = cellW - dzLabelX - CELLPADDING;
    
    _dianzanLabel = [[UILabel alloc] initWithFrame:CGRectMake(dzLabelX, Number_Zero, dzLabelW, Number_Ten)];
    _dianzanLabel.backgroundColor = CLEARCOLOR;
    _dianzanLabel.font = TopicCellDateFont;
    [_dianzanView addSubview:_dianzanLabel];
    
    [self resetDZText];
    
    /* cell的高度 */
    self.topicInteractHeight = CGRectGetMaxY(_dianzanView.frame);
    
}

//加载回复
- (void)initReplyView {
    if(_replyView) {
        [_replyView removeFromSuperview];
    }
    
    _replyView = [MLEmojiLabel new];
    _replyView.backgroundColor = [UIColor brownColor];
    _replyView.numberOfLines = Number_Zero;
    _replyView.font = [UIFont systemFontOfSize:APPUILABELFONTNO12];
    _replyView.textColor = [UIColor blackColor];
    _replyView.customEmojiRegex = String_DefValue_EmojiRegex;
    
    [self addSubview:_replyView];
    
    [self addReplyData];
}

- (void)addReplyData {
    
    if(_replyPage.data && [_replyPage.data count]>Number_Zero) {
        
        self.replyView.text = String_DefValue_Empty;
        
        NSMutableString  * replyStr = [[NSMutableString alloc] init];
        NSMutableArray   * attributedStrArray = [[NSMutableArray alloc] init];
        NSInteger count = Number_Zero;
        for(ReplyDomain * reply in _replyPage.data) {
            if(count < Number_Five) {
                [replyStr appendFormat:@"%@:%@ \n", reply.create_user, reply.content ? reply.content : @""];
                
                NSRange  range = [replyStr rangeOfString:reply.create_user];
                KGRange * tempRange = [KGRange new];
                tempRange.location = range.location;
                tempRange.length   = range.length;
                
                [attributedStrArray addObject:tempRange];
            }
            count++;
        }
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:replyStr];
        [self.replyView setText:attString afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            
            for(KGRange * tempRange in attributedStrArray) {
                [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(tempRange.location, tempRange.length)];
            }
            
            return mutableAttributedString;
        }];
        
        CGSize size = [self.replyView preferredSizeWithMaxWidth:CELLCONTENTWIDTH];
        
        _replyView.frame = CGRectMake(CELLPADDING, CGRectGetMaxY(_dianzanView.frame) + TopicCellBorderW
                                      , CELLCONTENTWIDTH, size.height);
        
        /* cell的高度 */
        self.topicInteractHeight = CGRectGetMaxY(_replyView.frame);
        
        [self loadMoreBtn];
    }
}

//加载显示更多
- (void)loadMoreBtn {
    if(_replyPage.totalCount > _replyPage.pageSize) {
        if(_moreBtn) {
            [_moreBtn removeFromSuperview];
        }
        
        CGFloat w = 50;
        CGFloat x = KGSCREEN.size.width - w  - CELLPADDING;
        CGRect frame = CGRectMake(x, CGRectGetMaxY(self.replyView.frame) - 20, w, 20);
        _moreBtn = [[UIButton alloc] initWithFrame:frame];
        [_moreBtn setText:@"显示更多"];
        _moreBtn.backgroundColor = [UIColor brownColor];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:Number_Ten];
        [_moreBtn setTextColor:[UIColor blueColor] sel:[UIColor blueColor]];
        [_moreBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreBtn];
    }
}


//加载回复输入框
- (void)initReplyTextField {
    if(_replyTextField) {
        [_replyTextField removeFromSuperview];
    }
    _replyTextField = [[KGTextField alloc] initWithFrame:CGRectMake(CELLPADDING, self.topicInteractHeight, CELLCONTENTWIDTH, 30)];
    _replyTextField.placeholder = @"我来说一句...";
    _replyTextField.returnKeyType = UIReturnKeySend;
//    _replyTextField.backgroundColor = [UIColor brownColor];
    _replyTextField.delegate = self;
    [self addSubview:_replyTextField];
    [_replyTextField setBorderWithWidth:1 color:[UIColor blackColor] radian:5.0];
    
    self.topicInteractHeight = CGRectGetMaxY(_replyTextField.frame) + Number_Ten;
    self.height = self.topicInteractHeight;
}

//键盘回车
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString * replyText = [KGNSStringUtil trimString:textField.text];
    if(replyText && ![replyText isEqualToString:String_DefValue_Empty]) {
        NSDictionary *dic = @{Key_TopicTypeReplyText : [KGNSStringUtil trimString:textField.text],
                              Key_TopicUUID : _topicUUID,
                              Key_TopicType : [NSNumber numberWithInteger:_topicType]};
        [[NSNotificationCenter defaultCenter] postNotificationName:Key_Notification_TopicFunClicked object:self userInfo:dic];
        textField.text = String_DefValue_Empty;
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)replyBtnClicked:(UIButton *)sender {
    [_replyTextField becomeFirstResponder];
}

//加载更多按钮点击
- (void)moreBtnClicked:(UIButton *)sender {
    NSDictionary *dic = @{Key_TopicUUID : _topicUUID,
                          Key_TopicFunRequestType : [NSNumber numberWithBool:sender.selected],
                          Key_TopicType : [NSNumber numberWithInteger:_topicType]};
    [[NSNotificationCenter defaultCenter] postNotificationName:Key_Notification_TopicLoadMore object:self userInfo:dic];
}


- (void)topicFunBtnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    NSDictionary *dic = @{Key_TopicCellFunType : [NSNumber numberWithInteger:sender.tag],
                          Key_TopicUUID : _topicUUID,
                          Key_TopicFunRequestType : [NSNumber numberWithBool:sender.selected],
                          Key_TopicType : [NSNumber numberWithInteger:_topicType],
                          Key_TopicInteractionView : self};
    [[NSNotificationCenter defaultCenter] postNotificationName:Key_Notification_TopicFunClicked object:self userInfo:dic];
}

- (NSMutableDictionary *)exampleAttributes
{
    return [@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]],
              NSForegroundColorAttributeName:[UIColor redColor]}mutableCopy];
}

//重置点赞列表
- (void)resetDZName:(BOOL)isAdd name:(NSString *)name {
    if(isAdd) {
        [self addDZ:name];
    } else {
        [self removeDZName:name];
    }
}

- (void)addDZ:(NSString *)name {
    NSArray * nameArray = [_dianzan.names componentsSeparatedByString:String_DefValue_SpliteStr];
    NSMutableString * tempNames = [[NSMutableString alloc] init];
    NSRange range = [_dianzan.names rangeOfString:name];//判断字符串是否包含
    
    if(range.location == NSNotFound) {
        //不包含
        [tempNames appendString:name];
        for(NSInteger i=Number_Zero; i<[nameArray count]; i++) {
            if(i >= Number_Four) {
                break;
            }
            
            if(![[nameArray objectAtIndex:i] isEqualToString:name]) {
                [tempNames appendFormat:@",%@", [nameArray objectAtIndex:i]];
            }
        }
        
        _dianzan.canDianzan = NO;
        _dianzan.count++;
        _dianzan.names = tempNames;
        
        [self resetDZText];
    }
}

- (void)removeDZName:(NSString *)name {
    NSRange range = [_dianzan.names rangeOfString:name];//判断字符串是否包含
    if (range.length > Number_Zero) {
        //包含
        [self reserDZListText:name];
    }
}

- (void)reserDZListText:(NSString *)name {
    NSArray * nameArray = [_dianzan.names componentsSeparatedByString:String_DefValue_SpliteStr];
    NSMutableString * tempNames = [[NSMutableString alloc] init];
    
    for(NSInteger i=Number_Zero; i<[nameArray count]; i++) {
        if(i > Number_Four) {
            break;
        }
        
        if(![[nameArray objectAtIndex:i] isEqualToString:name]) {
            [tempNames appendString:[nameArray objectAtIndex:i]];
        }
    }
    
    _dianzan.canDianzan = YES;
    _dianzan.count--;
    _dianzan.names = tempNames;
    
    [self resetDZText];
}

- (void)resetDZText {
    if(_dianzan.count > Number_Five) {
        _dianzanLabel.text = [NSString stringWithFormat:@"%@等%ld人觉得很赞", _dianzan.names, (long)(_dianzan.count-Number_Five)];
    } else {
        _dianzanLabel.text = [NSString stringWithFormat:@"%@  %ld人觉得很赞", _dianzan.names, (long)_dianzan.count];
    }
}

//重置回复
- (void)resetReplyList:(ReplyDomain *)replyDomain {
    if(!_replyPage.data) {
        _replyPage.data = [[NSMutableArray alloc] init];
    }
    [_replyPage.data insertObject:replyDomain atIndex:Number_Zero];
    [self addReplyData];
    
    self.replyTextField.y = CGRectGetMaxY(self.replyView.frame);
    self.topicInteractHeight = CGRectGetMaxY(self.replyTextField.frame) + Number_Ten;
    
    //通知改变view高度
    [[NSNotificationCenter defaultCenter] postNotificationName:Key_Notification_TopicHeight object:self userInfo:nil];
}

- (void)resetReplyFont:(NSArray *)replyNameArray {
//    for(NSString * str in replyNameArray) {
//        [self.replyView linkString:str
//                  defaultAttributes:[self exampleAttributes]
//              highlightedAttributes:[self exampleAttributes]
//                         tapHandler:nil];
//    }
    
//    [self.replyView linkStrings:replyNameArray
//             defaultAttributes:[self exampleAttributes]
//         highlightedAttributes:[self exampleAttributes]
//                    tapHandler:nil];

}



@end

