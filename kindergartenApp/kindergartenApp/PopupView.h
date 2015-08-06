//
//  FuniPopupWindowBaseView.h
//  funiiPhoneApp
//
//  Created by You on 14-8-26.
//  Copyright (c) 2014年 LQ. All rights reserved.
//

#import "BaseView.h"

@interface PopupView : BaseView <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView * popupContentView;

@end
