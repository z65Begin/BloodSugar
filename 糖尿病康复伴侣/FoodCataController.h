//
//  FoodCataController.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/25.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodCataController : UIViewController
@property(nonatomic,copy) NSString * eatFoodTime;
@property(nonatomic,copy) NSString * stateOfPage;//页面确定  1不为空确定是食物计算页面
@property (nonatomic,assign) BOOL notDiet;
@property (nonatomic, strong) NSString * date;
@end
