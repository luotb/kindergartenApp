//
//  FuniPhotoScrollView.h
//  funiApp
//
//  Created by You on 13-7-24.
//  Copyright (c) 2013年 you. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FuniAttachment.h"

@protocol FuniPhotoScrollViewDelegate;

@interface FuniPhotoScrollView : UIScrollView<UIScrollViewDelegate, UIGestureRecognizerDelegate>{
    id<FuniPhotoScrollViewDelegate>  photoScrollViewDelegate;
    UIImageView    * photoImageView;
    NSString       * photoPath;
    NSString       * downPhotoSize;
    FuniAttachment * attachment;
    NSString       * defImgName;
    BOOL             isSingle;      //是否显示单张图片
    UIImage        * singleImage;   //单张图片
}

@property(retain, nonatomic) id<FuniPhotoScrollViewDelegate>  photoScrollViewDelegate;
@property(retain, nonatomic) UIImageView    * photoImageView;
@property(retain, nonatomic) FuniAttachment * attachment;

-(FuniPhotoScrollView *)initWithPath:(CGRect)frame attach:(FuniAttachment *)attach size:(NSString *)size;
-(FuniPhotoScrollView *)initWithPath:(CGRect)frame attach:(FuniAttachment *)attach size:(NSString *)size defImg:(NSString *)defImg;
-(FuniPhotoScrollView *)initWithSingleImage:(CGRect)frame image:(UIImage *)image defImg:(NSString *)defImg;
@end


@protocol FuniPhotoScrollViewDelegate <NSObject>

//图片单击
-(void)singleTapEvent:(FuniPhotoScrollView *)photoScrollView;

//图片双击
-(void)doubleTapEvent:(FuniPhotoScrollView *)photoScrollView;

@end
