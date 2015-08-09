//
//  RecipesListViewController.m
//  kindergartenApp
//
//  Created by You on 15/8/7.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "RecipesListViewController.h"
#import "RecipesInfoView.h"
#import "KGHttpService.h"
#import "KGHUD.h"
#import "KGDateUtil.h"
#import "UIView+Extension.h"
#import "Masonry.h"
#import "PagedFlowView.h"

@interface RecipesListViewController () <PagedFlowViewDataSource,PagedFlowViewDelegate> {
    RecipesInfoView * recipesInfoView;
    NSString * lastDateStr;
    PagedFlowView   * hFlowView;
    NSMutableArray  * itemViewArray;
}

@end

@implementation RecipesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"每日食谱";
    lastDateStr = [KGDateUtil getDate:Number_Two];
    [self loadRecipesInfoByData];
    [self initFlowView];
//    [self addPanSwipeGesture];
//    [self addSwipeGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//初始化view
- (void)initFlowView{
    itemViewArray = [[NSMutableArray alloc] initWithCapacity:30];
    RecipesInfoView * itemView = nil;
    for(NSInteger i=Number_Zero; i<30; i++){
        itemView = [[RecipesInfoView alloc] initWithFrame:CGRectMake(Number_Zero, Number_Zero, KGSCREEN.size.width, self.contentView.height)];
        [itemViewArray addObject:itemView];
    }
    
    hFlowView = [[PagedFlowView alloc] initWithFrame:CGRectMake(Number_Zero, Number_Zero, KGSCREEN.size.width, self.contentView.height)];
    hFlowView.backgroundColor = [UIColor clearColor];
    hFlowView.delegate = self;
    hFlowView.dataSource = self;
    hFlowView.minimumPageAlpha = 0.95; //非主页的透明度
    hFlowView.minimumPageScale = 0.96;
    [self.contentView addSubview:hFlowView];
}


//滑动手势
//- (void)addPanSwipeGesture {
//    UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanSwipe:)];
//    //    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
//    [[self view] addGestureRecognizer:recognizer];
//}

- (void)loadRecipesInfoView:(RecipesDomain *)recipes {
    if(recipesInfoView) {
        [recipesInfoView removeFromSuperview];
    }
    recipesInfoView = [[RecipesInfoView alloc] initWithFrame:CGRectMake(Number_Zero, Number_Zero, KGSCREEN.size.width, KGSCREEN.size.height)];
    [self.contentView addSubview:recipesInfoView];
    
    [recipesInfoView loadRecipesData:recipes];
    
    [recipesInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
}

//加载食谱数据
- (void)loadRecipesInfoByData {
    [[KGHUD sharedHud] show:self.contentView];
    
    [[KGHttpService sharedService] getRecipesList:lastDateStr endDate:nil success:^(NSArray *recipesArray) {
        
        [[KGHUD sharedHud] hide:self.contentView];
        
        RecipesDomain * tempDomain = [[RecipesDomain alloc] init];
        tempDomain.plandate = lastDateStr;
        if(recipesArray && [recipesArray count]>Number_Zero) {
            tempDomain = [recipesArray objectAtIndex:Number_Zero];
        }
        
//        [self loadRecipesInfoView:tempDomain];
        
    } faild:^(NSString *errorMsg) {
        [[KGHUD sharedHud] show:self.contentView onlyMsg:errorMsg];
    }];
}


#pragma mark PagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
//    return CGSizeMake(KGSCREEN.size.width, self.contentView.height);
    return CGSizeMake(230, 375);
}

//flow滑动结束之后回调
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(PagedFlowView *)flowView {
    if (pageNumber >= Number_Zero) {
        
    }
}

#pragma mark -
#pragma mark PagedFlowView Datasource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    return [itemViewArray count];
}

//返回给某列使用的View
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    RecipesInfoView * itemView = (RecipesInfoView *)[flowView dequeueReusableCell];
    if (!itemView) {
        itemView = [[RecipesInfoView alloc] initWithFrame:CGRectMake(Number_Zero, Number_Zero, KGSCREEN.size.width, KGSCREEN.size.height)];
    }
//    [itemView resetSpecialOffersItemValue:[communitys objectAtIndex:index]];
    return itemView;
    
}

//- (void)getQueryDate {
//    if(!isFirstReq) {
//        if(index != lastRow) {
//            lastDateStr = [KGDateUtil nextOrPreyDay:lastDateStr date:lastRow-index];
//        }
//    } else {
//        lastDateStr = [KGDateUtil getDate:Number_Two];
//    }
//    
//    lastRow = index;
//    NSLog(@"lastDate:%@, lastRow:%ld", lastDateStr, (long)lastRow);
//    
//    if(index == Number_Zero) {
//        [dataSource insertObject:[[RecipesDomain alloc] init] atIndex:Number_Zero];
//        [recipesCollectionView reloadData];
//    }
//}

//- (void)handlePanSwipe:(UIPanGestureRecognizer *)gesture {
//    UIView * piece = [gesture view];
//    
//    [self adjustAnchorPointForGestureRecognizer:gesture];
//    
//    if ([gesture state] == UIGestureRecognizerStateBegan || [gesture state] == UIGestureRecognizerStateChanged) {
//        CGPoint translation = [gesture translationInView:[piece superview]];
//        
//        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
//        [gesture setTranslation:CGPointZero inView:[piece superview]];
//    }
//}
//
//
//- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
//    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        UIView *piece = gestureRecognizer.view;
//        CGPoint locationInView = [gestureRecognizer locationInView:piece];
//        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
//        
//        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
//        piece.center = locationInSuperview;
//    }
//}
//
//
////水平手势x值发生改变
//- (void)didChangeViewX:(CGFloat)x gesture:(UIPanGestureRecognizer*)gesture {
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        recipesInfoView.x += x;
//    }];
//}


@end
