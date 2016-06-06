//
//  baseLineModel.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/23.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface baseLineModel : NSObject
@property(nonatomic,copy) NSString * code; //基准code
@property(nonatomic,copy) NSString * Name;//基准名称
@property(nonatomic,copy) NSString * Value;//基准值
@property(nonatomic,copy) NSString * Backup;//备用
@end
