//
//  MyCollectionViewController.m
//  kindergartenApp
//
//  Created by CxDtreeg on 15/8/15.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "MyCollectionViewController.h"

@interface MyCollectionViewController () <KGReFreshViewDelegate>

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
}

//创建 refreshView
- (void)createRefreshView{
    _refreshView = [[ReFreshTableViewController alloc] initRefreshView];
    _refreshView._delegate = self;
    _refreshView.tableView.backgroundColor = KGColorFrom16(0xEBEBF2);
    [_refreshView appendToView:self.contentView];
    [_refreshView beginRefreshing];
}

//创建 tableview
- (void)createTableView{
    _tableView = [[UITableView alloc] init];;
    _tableView.size = CGSizeMake(APPWINDOWWIDTH, APPWINDOWHEIGHT-APPWINDOWTOPHEIGHTIOS7);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
