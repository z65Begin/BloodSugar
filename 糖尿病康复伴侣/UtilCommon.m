//
//  UtilCommon.m
//  HalsmaForIos
//
//  Created by User on 14/10/28.
//  Copyright (c) 2014年 hbis. All rights reserved.
//  工具类

//**************** 宏信息*****************//
//日期格式化
#define DATE_FORMAT @"yyyy/MM/dd"

#define MMDD_FORMAT @"MM/dd"

//时间格式化
#define TIME_FORMAT @"HH:mm:ss"

//时间格式化
#define DATE_TIME_FORMAT @"yyyy-MM-dd HH:mm:ss"

#define DATE_TIME_mm_ss @"HH:mm"

#define YYYY_MM_DD_FORMAT @"yyyy年MM月dd日"

#define YYYYMMDD @"YYYYMMdd"

#import "UtilCommon.h"

@implementation UtilCommon
//日期字符串格式化（yyyy/MM/dd 转化为 MM/dd） 返回字符串
+(NSString *)dateStrFormateStr:(NSString *)dateStr{
    NSDate *date = [self strFormateDate:dateStr];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:MMDD_FORMAT];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
/**
 *
 * 改变时间格式 将 @"YYYY-MM-dd" 时间格式改为 YYYYMMDD
 *
 ***/

+ (NSString*)strDateFromDateStr:(NSString*)dateStr{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate * newDate = [dateFormatter dateFromString:dateStr];
    [dateFormatter setDateFormat:YYYYMMDD];
 return   [dateFormatter stringFromDate:newDate];
}

+ (NSString*)dateForTitleFormatStr:(NSString*)dateStr{
NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
    NSDate * date = [dateFormatter dateFromString:dateStr];
    [dateFormatter setDateFormat:YYYY_MM_DD_FORMAT];
    NSString * dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
+ (NSDate *)dateFormaterYYYY_MM_DDFromDateStr:(NSString*)dateStr{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
    
    return [dateFormatter dateFromString:dateStr];

}

+ (NSString *)stringData_mm_ssFromStr:(NSString*)dateStr{
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:DATE_TIME_FORMAT];
    dateFormater.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
    NSDate * date = [dateFormater dateFromString:dateStr];
    [dateFormater setDateFormat:DATE_TIME_mm_ss];
    NSString * dateString = [dateFormater stringFromDate:date];
    return dateString;

}
+(NSString *)dateStrFormStr:(NSString *)dateStr
{
    NSDate *date = [self strFormateDate:dateStr];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
/**
 *日期格式化 返回字符串
 */
+(NSString *)dateFormateStr:(NSDate *)date{
    //格式化日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/**
 *字符串格式化 返回日期
 */
+(NSDate *)strFormateDate:(NSString *)dateStr{
    NSDateFormatter *fromat = [[NSDateFormatter alloc] init];
    [fromat setDateFormat:DATE_TIME_FORMAT];
    return [fromat dateFromString:dateStr];
}

/**
 *时间格式化 返回字符串
 */
+(NSString *)timeFormate:(NSDate *)date{
    //格式化时间
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:TIME_FORMAT];
    NSString *timeString = [timeFormatter stringFromDate:date];
    return timeString;
    
}

//判断是否联网
+(BOOL )isConnected:(Reachability *)reachability
{
    BOOL isConnected = NO;
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
            isConnected = NO;
            break;
        case ReachableViaWWAN:
            isConnected = YES;
            break;
        case ReachableViaWiFi:
            isConnected = YES;
            break;
        default:
            break;
    }
    return isConnected;
}

/**
 *字符串转化为date
 */
+(NSDate *)strDate:(NSString *)dateStr{
    NSDateFormatter *fromat = [[NSDateFormatter alloc] init];
    [fromat setDateFormat:DATE_TIME_FORMAT];
    
    return [fromat dateFromString:dateStr];
}
/**date转化为字符串(yy-mm-dd hh:mm:ss)**/
+(NSString *)dateStr:(NSDate *)date{
    //格式化时间
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:DATE_TIME_FORMAT];
    NSString *timeString = [timeFormatter stringFromDate:date];
    return timeString;
}
//密码进行md5，base64加密
+(NSString *)encrytoMd5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    NSData *base64 = [[NSData alloc] initWithBytes:result length:CC_MD5_DIGEST_LENGTH];
    
    base64 = [GTMBase64 encodeData:base64];
    NSString *base64Str = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    
    NSString *strUpper = @"";
    for(int i = 0; i<base64Str.length; i++){
        //转化为ASCII转码
        NSString *str = [[NSString alloc] initWithFormat:@"%1x",[base64Str characterAtIndex:i]];
        //大小写转化，拼接字符串
        strUpper = [strUpper stringByAppendingString: [str uppercaseString] ];
    }
    return strUpper;
}

/**
 *验证本地登录
 *uid：用户名 pwd：密码 info：用户信息
 */
+(BOOL)verifyLocalLogin:(NSString *)uid andPwd:(NSString *)pwd andInfo:(UserInfoModel *)info{
    if ([@"" isEqual:info.Password ]) {
        return NO;
    }
    pwd = [UtilCommon encrytoMd5:pwd];
    return [pwd isEqual:info.Password];
}

//字符转化为bool
+(BOOL)parseBoolean:(NSString *)value{
    if ([@"true" isEqual:value]) {
        return YES;
    }else{
        return  NO;
    }
}
/**
 *日期比较 ,返回较早的日期
 */
+(NSDate *)getTimeSpan:(NSString *)str1 andStr2:(NSString *)str2{
    NSDate *date1 = [UtilCommon strFormateDate:str1];
    NSDate *date2 = [UtilCommon strFormateDate:str2];
    //返回较早的日期
    NSDate *data3 = [date1 earlierDate: date2];
    return data3;
}
/**
 *获取日期时间差[yyyy-MM-dd HH:mm:ss]
 * str1：现在时间 str2：开始时间
 */
+(int) getTimeSpanInt2:(NSString *)str1 andStr2:(NSString *)str2{

    NSTimeInterval time = [[UtilCommon strDate:str1] timeIntervalSinceDate: [UtilCommon strDate:str2]];

    return (int)time;
}

/**
 *获取日期时间差
 * str1：现在时间 str2：开始时间
 */
+(int) getTimeSpanInt:(NSString *)str1 andStr2:(NSString *)str2{
    
    NSTimeInterval time = [[UtilCommon strFormateDate:str1] timeIntervalSinceDate: [UtilCommon strFormateDate:str2]];
    
    int days = ((int)time)/(3600*24) + 1;
    
    return days;
}

/**
 *bool转化为str
 */
+(NSString *)boolValueOfStr:(BOOL)flag{
    return flag?@"true":@"false";
}

/**
 *小数验证
 */
+(BOOL)isFloatInput:(NSString *)str{
    NSString *pattern = @"^\\d{0,3}\\.?\\d{0,2}$";
    NSPredicate *isFloat = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pattern];
    return [isFloat evaluateWithObject:str];
}

/**
 *整型验证
 */
+(BOOL)isIntInput:(NSString *)str{
    NSString *pattern = @"^\\d*$";
    NSPredicate *isFloat = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pattern];
    return [isFloat evaluateWithObject:str];
}
/**
 *返回早一天数据
 */
+(NSString *)beforeDay:(NSString *)nowDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"YYYY-MM-dd"];
    NSDate * newDate = [dateFormater dateFromString:nowDate];
    
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:newDate];
//    [UtilCommon strFormateDate:nowDate] [UtilCommon dateFormateStr:selectDate]
    [comps setHour:-24];
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *selectDate = [calendar dateByAddingComponents:comps toDate:newDate options:0];
    return [dateFormater stringFromDate:selectDate];
}
/**
 *返回后一天数据
 */
+(NSString *)afterDay:(NSString *)nowDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"YYYY-MM-dd"];
    NSDate * newDate = [dateFormater dateFromString:nowDate];
    NSDateComponents *comps = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:newDate];
//    [UtilCommon strFormateDate:nowDate] [UtilCommon dateFormateStr:selectDate]
    [comps setHour:+24];
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *selectDate = [calendar dateByAddingComponents:comps toDate:newDate options:0];
    return [dateFormater stringFromDate:selectDate];
}
//弹出框
+(void)alertView:(NSString *)title andMessage:(NSString *)message{
    UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

/**
 *日期格式化 任意格式日期 返回字符串
 */
+(NSString *)dateFormateStr:(NSDate *)date DATEFORMAT:(NSString *)DataFormat{
    //格式化日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DataFormat];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

//获取文件扩展名
+(NSString *)GetFilenameExtension:(NSString *)soucesStr{
    NSString * str =   [soucesStr pathExtension];
    NSArray  * strarray = [str componentsSeparatedByString:@"?"];
    
    return strarray[0];
}
//获取uuid
+ (NSString *)uuidString{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}
//获得1970年以来的毫秒数
+(NSString *)GetsTheNumberOfMilliseconds{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    double i=time;      //NSTimeInterval返回的是double类型
    NSString * str = [NSString stringWithFormat:@"%ld",(long)i];
    return str;
}
//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++){
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}
@end
