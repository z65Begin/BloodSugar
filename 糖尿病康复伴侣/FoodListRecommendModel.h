//
//  FoodListRecommendModel.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/24.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodListRecommendModel : NSObject

@property(nonatomic,copy) NSString * DataTime;//食谱的日期
@property(nonatomic,copy) NSString * MenuId;//食谱ID
@property(nonatomic,copy) NSString * EnergyLv;//适用热量等级
@property(nonatomic,copy) NSString * FoodId;//食物ID
@property(nonatomic,copy) NSString * TimePeriod;//时段区分
@property(nonatomic,copy) NSString * FoodIntake;//推荐量

@end
