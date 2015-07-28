//
//  MessageViewController.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/7/18.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "MessageViewController.h"
#import "ReFreshTableViewController.h"
#import "KGHttpService.h"
#import "MessageDomain.h"
#import "KGHUD.h"
#import "PageInfoDomain.h"
#import "UIColor+Extension.h"

@interface MessageViewController () <KGReFreshViewDelegate> {
    ReFreshTableViewController * reFreshView;
    PageInfoDomain * pageInfo;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息";
    
    [self initPageInfo];
    [self initReFreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initPageInfo {
    if(!pageInfo) {
        pageInfo = [[PageInfoDomain alloc] init];
    }
}


//获取数据加载表格
- (void)getTableData{
    pageInfo.pageNo = reFreshView.page;
    pageInfo.pageSize = reFreshView.pageSize;
    
    [[KGHttpService sharedService] getMessageList:pageInfo success:^(NSArray *messageArray) {
        reFreshView.tableParam.dataSourceMArray = messageArray;
        [reFreshView reloadRefreshTable];
    } faild:^(NSString *errorMsg) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
        [reFreshView endRefreshing];
    }];
}


//初始化列表
- (void)initReFreshView{
    reFreshView = [[ReFreshTableViewController alloc] initRefreshView];
    reFreshView._delegate = self;
    reFreshView.tableParam.cellHeight       = 78;
    reFreshView.tableParam.cellClassNameStr = @"AnnouncementTableViewCell";
    reFreshView.tableView.backgroundColor = KGColorFrom16(0xEBEBF2);
    [reFreshView appendToView:self.contentView];
    [reFreshView beginRefreshing];
}

#pragma reFreshView Delegate

//选中cell
- (void)didSelectRowCallBack:(id)baseDomain to:(NSString *)toClassName{
    
}


@end
