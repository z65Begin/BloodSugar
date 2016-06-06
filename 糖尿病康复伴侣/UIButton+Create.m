//
//  UIButton+Create.m
//  NT
//
//  Created by Kohn on 14-5-27.
//  Copyright (c) 2014年 Pem. All rights reserved.
//

#import "UIButton+Create.h"

@implementation UIButton (Create)

+ (UIButton*) createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    

    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imagePressed] forState:UIControlStateSelected];

    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton*) createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed Title:(NSString * )title
{
    UIButton * button = [UIButton new];
    [button setFrame:frame];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
//    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:imagePressed] forState:UIControlStateSelected];


    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (UIButton *) createButtonWithFrame:(CGRect)frame Title:(NSString *)title Target:(id)target Selector:(SEL)selector
{
    UIButton * button = [UIButton new];
    [button setFrame:frame];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}




@end

