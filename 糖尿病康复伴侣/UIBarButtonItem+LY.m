//
//  UIBarButtonItem+LY.m
//  SinaBlog
//
//  Created by liuyang on 15/7/10.
//  Copyright (c) 2015年 YoungLiu. All rights reserved.
//

#import "UIBarButtonItem+LY.h"
#import "UIImage+LY.h"
@implementation UIBarButtonItem (LY)

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target highIcon:(NSString *)highIcon action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (icon) {
        [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    }
    if (highIcon) {
        [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    }
//    if (button.currentImage) {
         button.frame = (CGRect){CGPointZero,button.currentBackgroundImage.size.width/2.6,button.currentBackgroundImage.size.height/2.6};
//    }else{
//        button.bounds = CGRectZero;
//    }
   
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

-(UIBarButtonItem *)itemWithIcon:(NSString *)icon
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    button.bounds = (CGRect){CGPointZero,button.currentBackgroundImage.size.width/2.6,button.currentBackgroundImage.size.height/2.6};
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
