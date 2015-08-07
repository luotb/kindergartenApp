//
//  RecipesViewController.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/8/1.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "RecipesViewController.h"
#import "KGHttpService.h"
#import "KGHUD.h"
#import "RecipesDomain.h"
#import "KGDateUtil.h"
#import "RecipesCollectionViewCell.h"
#import "TestCollectionViewCell.h"

#define recipesCollectionCellIden  @"recipesCollectionCellIden"

@interface RecipesViewController () <UICollectionViewDataSource,UICollectionViewDelegate> {
    
    IBOutlet UICollectionView * recipesCollectionView;
    NSMutableArray * dataSource; //数据源 key  只是存储了日期
    NSMutableDictionary * recipesMDict; //食谱数据 key=日期 value=食谱Domain
    NSInteger dataCount;
    NSInteger lastRow;
    NSString * lastDateStr;
    BOOL isNoFirstReq;
}

@end

@implementation RecipesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"每日食谱";
    
    lastRow = -1;
    dataCount = 100;
    [self initCollectionView];
    [self collectionViewScrollToRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)initDataSource {
    dataSource = [[NSMutableArray alloc] init];
    
}

- (void)getRecipesList:(NSInteger)index success:(void (^)(RecipesDomain * domain))success{
    
    [self getQueryDate:index];
    
    NSString * endDate = isNoFirstReq ? nil : [KGDateUtil getDate:Number_Three];
    
    [[KGHttpService sharedService] getRecipesList:lastDateStr endDate:endDate success:^(NSArray *recipesArray) {
        
        if(recipesArray && [recipesArray count]>Number_Zero) {
            success([recipesArray objectAtIndex:Number_Zero]);
        }
    } faild:^(NSString *errorMsg) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
    }];
}


//初始化collectionview
- (void)initCollectionView
{
    CGSize itemSize = CGSizeMake(CGRectGetWidth(KGSCREEN), CGRectGetHeight(KGSCREEN));
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = Number_Zero;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;  //横向滚动
    layout.itemSize = itemSize;
    
    [recipesCollectionView setCollectionViewLayout:layout];
    recipesCollectionView.backgroundColor = [UIColor clearColor];
    recipesCollectionView.dataSource = self;
    recipesCollectionView.delegate = self;
    recipesCollectionView.pagingEnabled = YES;
    [recipesCollectionView setShowsHorizontalScrollIndicator:NO];
    [recipesCollectionView registerNib:[UINib nibWithNibName:@"RecipesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:recipesCollectionCellIden];
}


#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataCount;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifierCell = recipesCollectionCellIden;
    RecipesCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell forIndexPath:indexPath];
    
    [self getRecipesList:indexPath.row success:^(RecipesDomain *domain) {
        [cell loadRecipesData:domain];
    }];
    
    return cell;
}

//collectionView Scroll to right
- (void)collectionViewScrollToRight
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:dataCount-Number_One inSection:Number_Zero];
    
    [recipesCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}


- (void)getQueryDate:(NSInteger)index {
    if(isNoFirstReq) {
        if(index != lastRow) {
            if(index > lastRow) {
                //明天
                lastDateStr = [KGDateUtil nextOrPreyDay:lastDateStr isNext:YES];
            } else {
                //昨天
                lastDateStr = [KGDateUtil nextOrPreyDay:lastDateStr isNext:NO];
            }
        }
    } else {
        lastDateStr = [KGDateUtil getDate:Number_Eight];
    }
    
    isNoFirstReq = YES;
    lastRow = index;
}


@end
