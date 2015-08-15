//
//  MyCollectionViewController.h
//  kindergartenApp
//
//  Created by CxDtreeg on 15/8/15.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "BaseViewController.h"

#import "AnnouncementDomain.h"
#import "ReFreshTableViewController.h"
#import "UIColor+Extension.h"

@interface MyCollectionViewController : BaseViewController

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) ReFreshTableViewController * refreshView;

@end
