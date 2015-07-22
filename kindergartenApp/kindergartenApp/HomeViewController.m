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
#import "KGIntroductionViewController.h"
#import "UIView+Extension.h"

@interface HomeViewController () <ImageCollectionViewDelegate> {
    
    IBOutlet UIScrollView * scrollView;
    IBOutlet UIView * photosView;
    IBOutlet UIView * funiView;
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.contentSize = CGSizeMake(self.view.width, funiView.y + funiView.height + Number_Ten);
    [self loadPhotoView];
//    [self funBtnParam];
    
    
//    [MFBHomeData setupObjectClassInArray:^NSDictionary* {
//        return @{ @"ListItems" : @"MFBFloor" };
//    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self funBtnParam];
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


- (void)funBtnParam {
    UIButton * btn = nil;
    for(NSInteger i=Number_Ten; i<Number_Twenty; i++) {
        btn = (UIButton *)[self.view viewWithTag:i];
        
        CGPoint center = btn.imageView.center;
        center.x = btn.width/2;
        center.y = btn.imageView.height/2;
        btn.imageView.center = center;
        
        CGRect newFrame = [btn titleLabel].frame;
//        newFrame.origin.x =0;
//        newFrame.origin.y = btn.imageView.height + 5;
//        newFrame.size.width = btn.frame.size.width;
//        
//        btn.titleLabel.frame = newFrame;
//        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
//        UIEdgeInsetsMake(top, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//        CGFloat x = (btn.width - newFrame.size.width) / 2;
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.y + btn.imageView.height + 15, 1, 1, x)];
        center.y += 40;
        btn.titleLabel.center = center;
    }
}


#pragma ImageCollectionViewDelegate

//单击回调
-(void)singleTapEvent:(NSString *)pType {
    
}



- (IBAction)funBtnClicked:(UIButton *)sender {
    BaseViewController * baseVC = nil;
    switch (sender.tag) {
        case 10:
            baseVC = [[KGIntroductionViewController alloc] init];
            break;
        case 19:
            baseVC = [[KGIntroductionViewController alloc] init];
            break;
        default:
            break;
    }
    
    if(baseVC) {
        [self.navigationController pushViewController:baseVC animated:YES];
    }
}


@end
