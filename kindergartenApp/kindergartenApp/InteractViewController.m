//
//  InteractViewController.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/7/18.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "InteractViewController.h"
#import "ReFreshTableViewController.h"
#import "KGHttpService.h"
#import "PageInfoDomain.h"
#import "KGHUD.h"

@interface InteractViewController () <KGReFreshViewDelegate> {
    ReFreshTableViewController * reFreshView;
}

@end

@implementation InteractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initReFreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//获取数据加载表格
- (void)getTableData{
//    NSMutableArray * dataMArray = [[NSMutableArray alloc] initWithObjects:@"111", @"222", @"333", nil];
//    reFreshView.tableParam.dataSourceMArray   = dataMArray;
//    [reFreshView reloadRefreshTable];
    //    [reFreshView initReFreshTable];
    
    [[KGHttpService sharedService] getClassNews:[[PageInfoDomain alloc] initPageInfo:reFreshView.page size:reFreshView.pageSize] success:^(PageInfoDomain *pageInfo) {
        
        reFreshView.tableParam.dataSourceMArray   = pageInfo.data;
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
    reFreshView.tableParam.cellHeight       = Number_Fifty;
    reFreshView.tableParam.cellClassNameStr = @"TestTableViewCell";
    [reFreshView appendToView:self.contentView];
    [reFreshView beginRefreshing];
    //    [self getTableData];
}

//选中cell
- (void)didSelectRowCallBack:(id)baseDomain to:(NSString *)toClassName{
    
}


@end
