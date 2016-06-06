//
//  UtilCommon.h
//  HalsmaForIos
//
//  Created by User on 14/10/28.
//  Copyright (c) 2014年 hbis. All rights reserved.
//  工具类

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Const.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"
#import "UserInfoModel.h"

@interface UtilCommon : NSObject

/** 日期字符串格式化（yyyy/MM/dd 转化为 MM/dd） 返回字符串 */
+(NSString *)dateStrFormateStr:(NSDate *)date;

/**
 *
 * 改变时间格式 将 @"YYYY-MM-dd" 时间格式改为 YYYYMMDD
 *
 ***/

+ (NSString*)strDateFromDateStr:(NSString*)dateStr;
+ (NSString*)dateForTitleFormatStr:(NSString*)dateStr;

+(NSString *)dateStrFormStr:(NSString *)dateStr;
/**日期格式化 返回字符串(yyyy/MM/dd)*/
+(NSString *)dateFormateStr:(NSDate *)date;
/**返回date -> YYYY-MM-dd   */
+ (NSDate *)dateFormaterYYYY_MM_DDFromDateStr:(NSString*)dateStr;

//转换时间格式 yyyy-MM-dd HH:mm:ss ->  HH:mm:ss
+ (NSString *)stringData_mm_ssFromStr:(NSString*)dateStr;

//字符串格式化 返回日期
+(NSDate *)strFormateDate:(NSString *)dateStr;

//时间格式化 返回字符串
+(NSString *)timeFormate:(NSDate *)date;


/**
 *日期格式化 任意格式日期 返回字符串
 */
+(NSString *)dateFormateStr:(NSDate *)date DATEFORMAT:(NSString *)DataFormat;

//判断是否联网
+(BOOL )isConnected:(Reachability *)reachability;


/**字符串转化为date(yy-mm-dd hh-mm-ss)**/
+(NSDate *)strDate:(NSString *)dateStr;
/**date转化为字符串(yy-mm-dd hh:mm:ss)**/
+(NSString *)dateStr:(NSDate *)date;
//密码进行md5加密
+(NSString *)encrytoMd5:(NSString *)str;

/**
 *验证本地登录
 *uid：用户名 pwd：密码 info：用户信息
 */
+(BOOL)verifyLocalLogin:(NSString *)uid andPwd:(NSString *)pwd andInfo:(UserInfoModel *)info;

//字符转化为bool
+(BOOL)parseBoolean:(NSString *)value;

/**
 *日期比较,返回较早的日期
 */
+(NSDate *)getTimeSpan:(NSString *)str1 andStr2:(NSString *)str2;

/**
 *获取日期时间差
 * str1：现在时间 str2：开始时间
 */
+(int) getTimeSpanInt2:(NSString *)str1 andStr2:(NSString *)str2;
+(int) getTimeSpanInt:(NSString *)str1 andStr2:(NSString *)str2;

//bool转化为str
+(NSString *)boolValueOfStr:(BOOL)flag;
/**
 *小数验证
 */
+(BOOL)isFloatInput:(NSString *)str;
/**
 *整型验证
 */
+(BOOL)isIntInput:(NSString *)str;
/**
 *返回前一天数据
 */
+(NSString *)beforeDay:(NSString *)nowDate;
/**
 *返回后一天数据
 */
+(NSString *)afterDay:(NSString *)nowDate;
/**
 *获取目标热量
 */
//+(int)getTargetEnergy:(UserInfoModel *)userInfo;

//弹出框
+(void)alertView:(NSString *)title andMessage:(NSString *)message;

//获取文件扩展名
+(NSString *)GetFilenameExtension:(NSString *)soucesStr;

//获取uuid
+ (NSString *)uuidString;


//获得1970年以来的毫秒数
+(NSString *)GetsTheNumberOfMilliseconds;

//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;
@end
