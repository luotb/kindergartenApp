//
//  MyCollectionViewController.m
//  kindergartenApp
//
//  Created by CxDtreeg on 15/8/15.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "MyCollectionViewController.h"

@interface MyCollectionViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray * dataArray;

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self createTableView];
    
    //创建数据数组
    _dataArray = [[NSMutableArray alloc] init];
    __weak typeof(self) weakSelf = self;
    [_tableView addHeaderWithCallback:^{
        weakSelf.pageIndex = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf getListWithPage:1];
    }];
    
    [_tableView addFooterWithCallback:^{
        [weakSelf getListWithPage:weakSelf.pageIndex+1];
    }];
    
    [_tableView headerBeginRefreshing];
}

//根据页数获取 数据
- (void)getListWithPage:(NSUInteger)pageNo{
    NSLog(@"requset%ld",pageNo);
    [[KGHttpService sharedService] getFavoritesList:pageNo success:^(NSArray *favoritesArray) {
        if (favoritesArray && favoritesArray.count != 0) {
            [_dataArray addObjectsFromArray:favoritesArray];
            [_tableView reloadData];
            if (pageNo != 1) {
                _pageIndex += 1;
            }
        }
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
    } faild:^(NSString *errorMsg) {
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [[KGHUD sharedHud] show:self.view onlyMsg:errorMsg];
    }];
}

//创建 tableview
- (void)createTableView{
    _tableView = [[UITableView alloc] init];;
    _tableView.size = CGSizeMake(APPWINDOWWIDTH, APPWINDOWHEIGHT);
    _tableView.origin = CGPointZero;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = KGColorFrom16(0xE7E7EE);
    [_tableView registerNib:[UINib nibWithNibName:@"CollectArticleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CollectArticleTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"CollectNoticeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CollectNoticeTableViewCell"];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AnnouncementDomain * data = _dataArray[indexPath.row];
    UITableViewCell * cell;
    if (data.topicType == Topic_Articles) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CollectArticleTableViewCell"];
        CollectArticleTableViewCell * newCell = (CollectArticleTableViewCell *)cell;
        newCell.data = data;

    }else if (data.topicType == Topic_XYGG){
        cell = [tableView dequeueReusableCellWithIdentifier:@"CollectNoticeTableViewCell"];
        CollectNoticeTableViewCell * newCell = (CollectNoticeTableViewCell *)cell;
        newCell.data = data;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AnnouncementDomain * data = _dataArray[indexPath.row];
    if (data.topicType == Topic_XYGG) {
        return 78;
    }else if (data.topicType == Topic_Articles){
        return 133;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
