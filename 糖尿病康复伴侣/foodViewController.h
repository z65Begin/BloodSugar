//
//  foodViewController.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/10.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface foodViewController : UITableViewController
@property(nonatomic) NSMutableArray * dataArray;//数据源数组
@property(nonatomic) NSString * eatFoodTime;
@property(nonatomic)NSString * foodCateName;//食物分类的名字

@property(nonatomic)NSString * stateOfPage;//页面确定  1不为空确定是食物能量计算页面

@property (nonatomic, strong) NSString * date;

@end
