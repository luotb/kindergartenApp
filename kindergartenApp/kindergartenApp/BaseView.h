//
//  FuniCustomView.h
//  AKTabBar Example
//
//  Created by You on 15-8-6.
//  Copyright (c) 2015年 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGBaseDomain.h"

@interface BaseView : UIView

+ (BaseView *)instanceView:(NSString *)className;

- (void)resetView:(KGBaseDomain *)baseDomain;

@end
