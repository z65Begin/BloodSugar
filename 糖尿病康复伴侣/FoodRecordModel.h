//
//  FoodRecordModel.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/27.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "foodmodel.h"

@interface FoodRecordModel : NSObject

@property (nonatomic, copy) NSString * date; // 时间
@property (nonatomic, copy) NSString * time; // 摄入时间
@property (nonatomic, copy) NSString * updtime;//更新时间
@property (nonatomic, copy) NSString * foodId;//食物id
@property (nonatomic, copy) NSString * timeperiod;//时间区间
@property (nonatomic, copy) NSString * intake;    //摄入量

@end
