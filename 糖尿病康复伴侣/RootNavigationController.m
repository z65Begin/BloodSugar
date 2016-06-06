//
//  RootNavigationController.m
//  HalsmaForIos
//
//  Created by liuyang on 16/1/11.
//  Copyright © 2016年 hbis. All rights reserved.
//

#import "RootNavigationController.h"

@implementation RootNavigationController
/**
 *   第一次使用这个类的时候会调用（一个类只会调用一次）
 */
+(void)initialize
{
    //1.设置导航栏主题
    //取出qppearance对象
    UINavigationBar * navBar = [UINavigationBar appearance];
    
     navBar.barTintColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.3];
    //    [navBar setBackgroundImage:[[UIImage imageNamed:@"main_bg_top"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forBarMetrics:UIBarMetricsDefault];
    //    [navBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg_top"]]];
    //设置标题属性
    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    [navBar setTitleTextAttributes:textAttrs];
    
    //2.设置导航按钮主题
    [self setupBarButtonItemTheme];
}

+(void)setupBarButtonItemTheme
{
    UIBarButtonItem * item = [[UIBarButtonItem alloc]init];
    
    //设置文字属性
    NSMutableDictionary * textsAttrs = [NSMutableDictionary dictionary];
    textsAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textsAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    
    textsAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textsAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textsAttrs forState:UIControlStateHighlighted];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];
}

@end
