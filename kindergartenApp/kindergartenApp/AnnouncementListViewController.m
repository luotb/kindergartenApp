//
//  AnnouncementListViewController.m
//  kindergartenApp
//
//  Created by You on 15/7/21.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "AnnouncementListViewController.h"
#import "ReFreshTableViewController.h"
#import "KGHttpService.h"
#import "AnnouncementDomain.h"
#import "KGHUD.h"
#import "PageInfoDomain.h"
#import "UIColor+Extension.h"
#import "AnnouncementInfoViewController.h"

@interface AnnouncementListViewController () <KGReFreshViewDelegate> {
    ReFreshTableViewController * reFreshView;
    PageInfoDomain * pageInfo;
}


@end

@implementation AnnouncementListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"公告";
    
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
    
    [[KGHttpService sharedService] getAnnouncementList:pageInfo success:^(NSArray *announcementArray) {
        reFreshView.tableParam.dataSourceMArray = announcementArray;
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
    reFreshView.tableView.backgroundColor = KGColorFrom16(0xE7E7EE);
    [reFreshView appendToView:self.contentView];
    [reFreshView beginRefreshing];
}

#pragma reFreshView Delegate

/**
 *  选中cell
 *
 *  @param baseDomain  选中cell绑定的数据对象
 *  @param tableView   tableView
 *  @param indexPath   indexPath
 */
- (void)didSelectRowCallBack:(id)baseDomain tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AnnouncementDomain * domain = (AnnouncementDomain *)baseDomain;
    AnnouncementInfoViewController * infoVC = [[AnnouncementInfoViewController alloc] init];
    infoVC.annuuid = domain.uuid;
    [self.navigationController pushViewController:infoVC animated:YES];
}


@end
