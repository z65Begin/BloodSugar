//
//  MedicineRecordModel.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicineRecordModel : NSObject

@property (nonatomic, copy) NSString * recid;
//记录时间
@property (nonatomic, copy) NSString * date;
//药品名
@property (nonatomic, copy) NSString * MedName;
//用量-服用次数
@property (nonatomic, copy) NSString * AmountTimes;
//用量-单次服用量
@property (nonatomic, copy) NSString * AMountUnit;
//单位  毫升 
@property (nonatomic, copy) NSString * UnitName;
//说明
@property (nonatomic, copy) NSString * Notes;
//更新时间
@property (nonatomic, copy) NSString * updtime;

@end
