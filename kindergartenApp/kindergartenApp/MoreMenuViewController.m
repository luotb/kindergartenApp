//
//  MoreMenuViewController.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/8/6.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "MoreMenuViewController.h"
#import "DynamicMenuDomain.h"
#import "UIImageView+WebCache.h"
#import "UIButton+Extension.m"

@interface MoreMenuViewController () {
    UIView * headView;
    UIView * moreFunView;
    UIView * cancelView;
}

@end

@implementation MoreMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:Number_ViewAlpha_Five];
    
    [self loadHeadView];
    [self loadMoreFunView:_menuArray];
    [self loadCancelView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//加载头部部分
- (void)loadHeadView {
    NSInteger totalRow = ([_menuArray count] + Number_Four - Number_One) / Number_Four;
    CGFloat moreViewH = (totalRow * 77) + 64;
    CGFloat moreViewY = KGSCREEN.size.height - moreViewH;
    
    headView = [[UIView alloc] initWithFrame:CGRectMake(Number_Zero, moreViewY, KGSCREEN.size.width, 32)];
    [self.view addSubview:headView];
    
    headView.backgroundColor = [UIColor brownColor];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(Number_Zero, Number_Zero, CGRectGetWidth(headView.frame), CGRectGetHeight(headView.frame))];
    label.text = @"更多";
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:label];
}

//加载更多功能按钮部分
- (void)loadMoreFunView:(NSArray *)menuArray {
    
    CGFloat itemViewW = KGSCREEN.size.width / Number_Four;
    CGFloat itemViewH = 77;
//    CGFloat itemViewX = Number_Zero;
    CGFloat itemViewY = Number_Zero;
    CGFloat itemImgWH = 45;
    CGFloat itemImgX  = (itemViewW - itemImgWH) / Number_Two;
    CGFloat itemLabelY = itemImgWH + Number_Seven;
    CGFloat itemLabelH = Number_Ten;
    NSInteger col  = Number_Zero;
    NSInteger row  = Number_Zero;
    
    NSInteger totalRow = ([menuArray count] + Number_Four - Number_One) / Number_Four;
    moreFunView = [[UIView alloc] initWithFrame:CGRectMake(Number_Zero, CGRectGetMaxY(headView.frame), KGSCREEN.size.width, totalRow * itemViewH)];
    [self.view addSubview:moreFunView];
    
    for(NSInteger i=Number_Zero; i<[menuArray count]; i++) {
        
        DynamicMenuDomain * domain = [menuArray objectAtIndex:i];
        
        if(col == Number_Four) {
            col = Number_Zero;
            row++;
        }
        
        UIView * itemView = [[UIView alloc] initWithFrame:CGRectMake(col * itemViewW, itemViewY * row, itemViewW, itemViewH)];
        itemView.backgroundColor = [UIColor clearColor];
        [moreFunView addSubview:itemView];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(itemImgX, Number_Zero, itemImgWH, itemImgWH)];
        [itemView addSubview:imageView];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:domain.iconUrl] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        
        
        UILabel * itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(Number_Zero, itemLabelY, itemViewW, itemLabelH)];
        itemLabel.text = domain.name;
        itemLabel.font = [UIFont systemFontOfSize:Number_Ten];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        [itemView addSubview:itemLabel];
        
        col++;
    }
}

//加载取消部分
- (void)loadCancelView {
    cancelView = [[UIView alloc] initWithFrame:CGRectMake(Number_Zero, CGRectGetMaxY(moreFunView.frame), KGSCREEN.size.width, 32)];
    [self.view addSubview:cancelView];
    cancelView.backgroundColor = [UIColor brownColor];
    
    UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(Number_Zero, Number_Zero, CGRectGetWidth(cancelView.frame), CGRectGetHeight(cancelView.frame))];
    [cancelBtn setText:@"收起"];
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cancelView addSubview:cancelBtn];
}

- (void)cancelBtnClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
