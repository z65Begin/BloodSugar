//
//  medicineListModel.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface medicineListModel : NSObject
@property(nonatomic,copy)NSString * sid;//药物ID
@property(nonatomic,copy)NSString * Name;//种类名称
@property(nonatomic,copy)NSString * type;//药物类型
@property(nonatomic,copy)NSString * Alias;//药物别名列表
@property(nonatomic,copy)NSString * Item;//药物别名
@property(nonatomic,copy)NSString * time;//更新时间
@end
