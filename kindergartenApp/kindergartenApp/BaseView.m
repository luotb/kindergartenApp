//
//  FuniCustomView.m
//  AKTabBar Example
//
//  Created by You on 15-8-6.
//  Copyright (c) 2015年 Ali Karagoz. All rights reserved.
//

#import "BaseView.h"
#import "SystemResource.h"

@implementation BaseView

+ (BaseView *)instanceView:(NSString *)className{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil];
    return [nibView objectAtIndex:Number_Zero];
}


- (void)resetView:(KGBaseDomain *)baseDomain{
    
}

@end
