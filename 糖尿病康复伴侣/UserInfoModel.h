//
//  UserInfoModel.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject


@property(nonatomic,copy)NSString * UID;//用户ID
@property(nonatomic,copy)NSString * Password;//密码
@property(nonatomic,copy)NSString * Name;//姓名
@property(nonatomic,copy)NSString * Pinyin;//拼音
@property(nonatomic,copy)NSString * NickName;//昵称
@property(nonatomic,copy)NSString * Org;//机构ID
@property(nonatomic,copy)NSString * Type;//用户类型
@property(nonatomic,copy)NSString * Email;//邮箱地址
@property(nonatomic,copy)NSString * Tel;//联系电话
@property(nonatomic,copy)NSString * Sex;//用户性别
@property(nonatomic,copy)NSString * Birthday;//生日
@property(nonatomic,copy)NSString * Height;//身高
@property(nonatomic,copy)NSString * Weight;//体重
@property(nonatomic,copy)NSString * ExIntensity;//活动强度
@property(nonatomic,copy)NSString * DiabetesType;//糖尿病类型
@property(nonatomic,copy)NSString * Complication;//并发症
@property(nonatomic,copy)NSString * RestHr;//静止心率
@property(nonatomic,copy)NSString * FamilyHis;//家族病史
@property(nonatomic,copy)NSString * CliDiagnosis;//临床诊断
@property(nonatomic,copy)NSString * InfoSet;//个人信息设置标记
@property(nonatomic,copy)NSString * SecureSet;//安全信息设置标记
@end
