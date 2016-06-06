//
//  foodmodel.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/9.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface foodmodel : NSObject

@property(nonatomic,copy)NSString * CateName;//分类名字
@property(nonatomic,copy)NSString * CateID;//分类ID
@property(nonatomic,copy)NSString * foodID;//食物ID
@property(nonatomic,copy)NSString * FoodCateID;//食物分类id
@property(nonatomic,copy)NSString * FoodName;//食物名字
@property(nonatomic,copy)NSString * UnitValue;//单位值
@property(nonatomic,copy)NSString * UnitName;//单位名
@property(nonatomic,copy)NSString * UnitEnergy;//每单位的热量
@property(nonatomic,copy)NSString * UnitGI;//每单位GI
@property(nonatomic,copy)NSString * UnitH2O;//每单位水分
@property(nonatomic,copy)NSString * UnitProtein;//每单位蛋白质
@property(nonatomic,copy)NSString * UnitFat;//每单位脂肪
@property(nonatomic,copy)NSString * UnitDieFiber;//每单位膳食纤维
@property(nonatomic,copy)NSString * UnitCarbs;// 每单位碳水化合物
@property(nonatomic,copy)NSString * UnitVA;//每单位维生素A
@property(nonatomic,copy)NSString * UnitVB1;//每单位维生素B1
@property(nonatomic,copy)NSString * UnitVB2;//每单位维生素B2
@property(nonatomic,copy)NSString * UnitVC;//每单位维生素C
@property(nonatomic,copy)NSString * UnitVE;//每单位维生素E
@property(nonatomic,copy)NSString * UnitNiacin;//每单位烟酸
@property(nonatomic,copy)NSString * UnitNa;//每单位钠
@property(nonatomic,copy)NSString * UnitCa;//每单位钙
@property(nonatomic,copy)NSString * UnitFe;//每单位铁
@property(nonatomic,copy)NSString * UnitChol;//每单位胆固醇
@property(nonatomic,copy)NSString * DelFlag;//删除标记

@end
