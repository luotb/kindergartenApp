//
//  HomeViewController.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/7/18.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "HomeViewController.h"
#import "ImageCollectionView.h"
#import "Masonry.h"
#import "IntroductionViewController.h"
#import "UIView+Extension.h"
#import "RegViewController.h"
#import "SphereMenu.h"
#import "KGHttpService.h"
#import "KGHUD.h"
#import "AnnouncementListViewController.h"
#import "InteractViewController.h"
#import "TeacherJudgeViewController.h"
#import "SpecialtyCoursesViewController.h"
#import "GiftwareArticlesViewController.h"
#import "StudentSignRecordViewController.h"
#import "RecipesViewController.h"
#import "MoreMenuView.h"
#import "PopupView.h"
#import "RecipesListViewController.h"
#import "TimetableViewController.h"
#import "UIColor+Extension.h"
#import "UIButton+Extension.h"

@interface HomeViewController () <ImageCollectionViewDelegate, MoreMenuViewDelegate, UIGestureRecognizerDelegate> {
    
    IBOutlet UIScrollView * scrollView;
    IBOutlet UIView * photosView;
    IBOutlet UIView * funiView;
    
    IBOutlet UIView * moreView;
    IBOutlet UIImageView * moreImageView;
    PopupView * popupView;
    UIView    * groupListView;
    UIButton  * titleBtn;
    NSArray   * groupDataArray;
}

@end

@implementation HomeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if(!groupListView) {
        [self loadGroupListView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.contentSize = CGSizeMake(self.view.width, funiView.y + funiView.height + Number_Ten);
    [self requestGroupDate];
    
    [self loadPhotoView];
    [self addGestureBtn];
}

- (void)loadNavTitle {
    titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleBtn setText:@"首页"];
    titleBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleBtn setImage:@"xiajiantou" selImg:@"sjiantou"];
    [titleBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 90, 10, 0)];
    [titleBtn addTarget:self action:@selector(titleFunBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

- (void)titleFunBtnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    CGFloat y = 64;
    if(!sender.selected) {
        y = Number_Zero;
        titleBtn.selected = NO;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        groupListView.y = y;
    }];
}

//添加手势
- (void)addGestureBtn {
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
    singleTapGesture.delegate = self;
    singleTapGesture.numberOfTapsRequired = Number_One;
    singleTapGesture.cancelsTouchesInView = NO;
    [self.contentView addGestureRecognizer:singleTapGesture];
}


//单击响应
- (void)singleTap{
    [UIView animateWithDuration:Number_AnimationTime_Five animations:^{
        groupListView.y   = Number_Zero;
        titleBtn.selected = NO;
    }];
}

//加载机构下拉列表
- (void)loadGroupListView {
    if(groupDataArray && [groupDataArray count]>Number_Zero) {
        
        CGFloat h = [groupDataArray count] * Cell_Height2;
        groupListView = [[UIView alloc] initWithFrame:CGRectMake(Number_Zero, 64-h, KGSCREEN.size.width, h)];
        groupListView.backgroundColor = KGColorFrom16(0xE64662);
        [self.view addSubview:groupListView];
        
        GroupDomain *         domain = nil;
        UILabel     * groupNameLabel = nil;
        UILabel     *    spliteLabel = nil;
        UIButton    *            btn = nil;
        
        for(NSInteger i=Number_Zero; i<[groupDataArray count]; i++) {
            
            domain = [groupDataArray objectAtIndex:i];
            
            groupNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Number_Zero, Number_Fifteen + (i*Cell_Height2), KGSCREEN.size.width, Number_Fifteen)];
            groupNameLabel.font = [UIFont systemFontOfSize:Number_Fifteen];
            groupNameLabel.text = domain.company_name;
            groupNameLabel.textColor = [UIColor whiteColor];
            groupNameLabel.textAlignment = NSTextAlignmentCenter;
            [groupListView addSubview:groupNameLabel];
            
            spliteLabel = [[UILabel alloc] initWithFrame:CGRectMake(Number_Zero, CGRectGetMaxY(groupNameLabel.frame) + Number_Fifteen, KGSCREEN.size.width, Number_One)];
            spliteLabel.backgroundColor = [UIColor whiteColor];
            [groupListView addSubview:spliteLabel];
            
            btn = [[UIButton alloc] initWithFrame:CGRectMake(Number_Zero, Number_Zero, KGSCREEN.size.width, Cell_Height2)];
            btn.targetObj = domain;
            [btn addTarget:self action:@selector(didSelectedGroupList:) forControlEvents:UIControlEventTouchUpInside];
            [groupListView addSubview:btn];
        }
    }
}


//选择机构
- (void)didSelectedGroupList:(UIButton *)sender {
    
    GroupDomain * domain = (GroupDomain *)sender.targetObj;
    [titleBtn setText:domain.company_name];
    [KGHttpService sharedService].groupDomain = domain;
    [self singleTap];
}

- (void)requestGroupDate {
    [[KGHttpService sharedService] getGroupList:^(NSArray *groupArray) {
        
        groupDataArray = groupArray;
        [self loadNavTitle];
        [self loadGroupListView];
    } faild:^(NSString *errorMsg) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadPhotoView {
    NSMutableArray * list = [[NSMutableArray alloc] initWithObjects:@"http://f.hiphotos.baidu.com/image/pic/item/a08b87d6277f9e2fa2e847f21c30e924b999f36f.jpg", @"http://a.hiphotos.baidu.com/image/pic/item/342ac65c10385343eb8dfdb69013b07ecb8088e2.jpg", @"http://h.hiphotos.baidu.com/image/pic/item/cefc1e178a82b901e592a725708da9773912efed.jpg", @"http://g.hiphotos.baidu.com/image/pic/item/dbb44aed2e738bd40df8d727a28b87d6267ff9cf.jpg", @"http://f.hiphotos.baidu.com/image/pic/item/3801213fb80e7beca940b6b12d2eb9389a506bcc.jpg", nil];
    
    ImageCollectionView * imgcollview = [[ImageCollectionView alloc] initWithFrame:CGRectMake(Number_Zero, Number_Zero, CGRectGetWidth(self.view.frame), CGRectGetHeight(photosView.frame))];
    imgcollview.dataSource = list;
    imgcollview._delegate = self;
    
    [photosView addSubview:imgcollview];
    imgcollview.backgroundColor = [UIColor grayColor];
    [imgcollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photosView.mas_top);
        make.left.equalTo(photosView.mas_left);
        make.right.equalTo(photosView.mas_right);
        make.bottom.equalTo(photosView.mas_bottom);
    }];
    
    [imgcollview showImageCollectionView];
}



#pragma ImageCollectionViewDelegate

//单击回调
-(void)singleTapEvent:(NSString *)pType {
    
}



- (IBAction)funBtnClicked:(UIButton *)sender {
    BaseViewController * baseVC = nil;
    switch (sender.tag) {
        case 10:
            baseVC = [[InteractViewController alloc] init];
            break;
        case 11:
            baseVC = [[IntroductionViewController alloc] init];
            break;
        case 12:
            baseVC = [[AnnouncementListViewController alloc] init];
            break;
        case 13:
            baseVC = [[StudentSignRecordViewController alloc] init];
            break;
        case 14:
            baseVC = [[TimetableViewController alloc] init];
            break;
        case 15:
            baseVC = [[RecipesListViewController alloc] init];
            break;
        case 16:
            baseVC = [[GiftwareArticlesViewController alloc] init];
            break;
        case 17:
            baseVC = [[SpecialtyCoursesViewController alloc] init];
            break;
        case 18:
            baseVC = [[TeacherJudgeViewController alloc] init];
            break;
        case 19:
            [self loadMoreFunMenu:sender];
            break;
        default:
            break;
    }
    
    if(baseVC) {
        [self.navigationController pushViewController:baseVC animated:YES];
    }
}


- (void)loadMoreFunMenu:(UIButton *)sender {
    
    if(!popupView) {
        popupView = [[PopupView alloc] initWithFrame:CGRectMake(Number_Zero, Number_Zero, KGSCREEN.size.width, KGSCREEN.size.height)];
        popupView.alpha = Number_Zero;
        
        NSArray * moreMenuArray = [KGHttpService sharedService].dynamicMenuArray;
        NSInteger totalRow = ([moreMenuArray count] + Number_Four - Number_One) / Number_Four;
        CGFloat moreViewH = (totalRow * 77) + 64;
        CGFloat moreViewY = KGSCREEN.size.height - moreViewH;
        MoreMenuView * moreVC = [[MoreMenuView alloc] initWithFrame:CGRectMake(Number_Zero, moreViewY, KGSCREEN.size.width, moreViewH)];
        moreVC.delegate = self;
        [popupView addSubview:moreVC];
        [moreVC loadMoreMenu:moreMenuArray];

        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:popupView];
    }
    
    [UIView viewAnimate:^{
        popupView.alpha = Number_One;
    } time:Number_AnimationTime_Five];
    
}

- (void)cancelCallback; {
    [self popupCallback];
}

- (void)popupCallback {
    [UIView viewAnimate:^{
        popupView.alpha = Number_Zero;
    } time:Number_AnimationTime_Five];
}


@end
