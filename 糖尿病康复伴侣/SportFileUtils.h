//
//  SportFileUtils.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/6.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "FileUtils.h"

@class SportRecordModel;
@interface SportFileUtils : FileUtils

/**
 * 读取运动模型
 * type：运动编号
 */

+ (sportCataModel *)readSportCataWith:(NSString*)type;

/**
 *   保存一条 新的 运动记录 到本地
 *   userId：用户id
 *   model：运动记录模型
 */

+ (BOOL)saveSportRecordWithUID:(NSString*)userId andRecordModel:(SportRecordModel*)model;

/**
 * 修改数据
 * userId:用户id
 * recordArray：修改的数组
 */
+ (BOOL)saveSportRecordWitnUID:(NSString*)userId andRecordArray:(NSArray*)recordArray;

@end
