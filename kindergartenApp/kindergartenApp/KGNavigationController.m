//
//  UIColor+MFColor.m
//  maifangbao
//
//  Created by whb on 15/5/24.
//  Copyright (c) 2015年 whb. All rights reserved.
//


#import "KGNavigationController.h"
#import "BaseViewController.h"
#import "LoginViewController.h"
#import "UIColor+Extension.h"

@interface KGNavigationController()
@end

@implementation KGNavigationController


//+ (void)initialize
//{
//    // 设置整个项目所有item的主题样式
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    
//    // 设置普通状态
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    
//    
//    // 设置不可用状态
////    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
////    disableTextAttrs[NSForegroundColorAttributeName] = RGBA(225, 225, 225, 0.9);
////    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
////    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
//}


/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(BaseViewController *)viewController animated:(BOOL)animated
{
    //登陆页面排除
    if (((BaseViewController *)self.topViewController).animating&&![self.topViewController isKindOfClass:[LoginViewController class]]) {
        return;
    }
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"fjiantou" highImage:@"fjiantou"];
    }
    ((BaseViewController *)self.topViewController).animating = YES;
    viewController.animating = YES;
    [super pushViewController:viewController animated:animated];
    //开启iOS7的滑动返回效果
    
}


- (void)back
{
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}


@end
