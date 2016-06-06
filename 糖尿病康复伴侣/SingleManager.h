//
//  SingleManager.h
//  糖尿病康复伴侣
//
//  Created by 杨冬冬 on 16/3/22.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "foodmodel.h"
@interface SingleManager : NSObject
///用户信息
@property (nonatomic, retain) UserInfoModel * InfoModel;
///食物模型
@property(nonatomic,retain) foodmodel * foodModel;
///时间数组
@property(nonatomic,retain)NSArray * timeArray;

@property(nonatomic)BOOL localLoginState;
///个人信息单例
+ (SingleManager *)sharedSingleManager;

@end
