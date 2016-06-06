//
//  WebUtilsCommon.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "InnerMailModel.h"

@class FoodRecordModel;

@interface WebUtilsCommon : NSObject

/**判断获取服务器信息是否成功*/
+(BOOL)getServerBool:(NSData *)fileData;

/**
 *服务器验证
 *uid 用户吗 pwd 密码
 */
+(NSString *)verifyServer:(NSString *)uid andPwd:(NSString *)pwd andType:(NSString *)type andVersion:(NSString *)version;

/**
 *服务器验证(注册)
 *uid 用户吗 pwd 密码
 */
+(NSString *)userServer:(NSString *)uid andPwd:(NSString *)pwd andName:(NSString *)name andSex:(NSString *)sex;

/**
 *创建用户登录用请求
 *uid 用户吗 pwd 密码
 */
+(NSString *)createContentLogin:(NSString *)uid andPwd:(NSString *)pwd andType:(NSString *)type andVersion:(NSString *)version;

/**
 *创建用户注册用请求
 *uid 用户吗 pwd 密码
 */
+(NSString *)createContentRegist:(NSString *)uid andPwd:(NSString *)pwd andName:(NSString *)name andSex:(NSString *)sex;


/**
 *创建修改密码用请求
 */
+(BOOL)modifyPwd:(NSString *)uid andOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)newPwd;


/**
 *向服务器发送请求
 *mode 请求模式
 *请求内容
 */
+(NSData *)sendRequest:(NSString *)mode andContent:(NSString *)content;
/**
 *向服务器发送请求(注册)
 *mode 请求模式
 *请求内容
 */
+(NSData *)sendRequestRegist:(NSString *)mode andContent:(NSString *)content;
///**
// *向服务器发送请求(用药数据上传)
// *mode 请求模式
// *请求内容
// */
//+(NSData *)sendMedicineRecordRequest:(NSString *)medicineRecord andContent:(NSString *)content;

/***************************从服务器获取数据************************************/
/**
 *从服务器获取用户数据
 *uid 用户id
 *return 用户信息
 */
+(UserInfoModel *)getUserInfoFromServer:(NSString *)uid;

/**
 请求推荐食谱数据                         健康日记-饮食 1 2
 返回食谱数据
 uid：用户id
 energyLevel：每日摄入标准热量
 */
+(NSData *)getfoodListRecommendFromServerUID:(NSString *)uid EnergyLevel:(NSString *)energyLevel;

/**
 *从服务器获取食物数据；                    健康日记-饮食 5 6 ———1———
 *uid：用户Id；
 */
+(NSData *)getfoodMonsin:(NSString *)uid andDatatime:(NSString *)dataTime;

/**
 饮食记录获取请求                          健康日记-饮食8.1- 8.2 ———1———
 userID:用户id
 updtime：同步时间
 */
+ (NSData*)getDietRecordWithUsrID:(NSString*)userID;
/**
 提交 饮食记录                             健康日记-饮食 9 - 9.1 ———1———
 userID: 用户id
 model：饮食记录模型
 */
+ (BOOL)sendDietRecordWithUID:(NSString*)userID andModel:(FoodRecordModel*)model NS_DEPRECATED_IOS(2_0, 7_0, "sendFoodRecordToSeverWithUID:") __TVOS_PROHIBITED;

+ (BOOL)sendFoodRecordToSeverWithUID:(NSString *)userId;
/******************** 运动 *******************************/
/***
 *  获取运动记录信息
 * userId:用户id
 * dataTime:更新时间
 */
+ (NSData*)getSportRecordWithUID:(NSString*)userId;
/***
 * 上传运动记录
 ***/
+ (BOOL)sendSportRecordWithUID:(NSString*)userId;
/********************健康日记 - 血糖*******************************/
/** 获取血糖信息
 *userId：用户id
 *dataTime：更新时间
 */
+ (NSData*)getBloodSugarWithUID:(NSString*)userId;

+ (BOOL)sendBloodSugarRecordWithUID:(NSString*)userId;
/********************健康日记 - 体征*******************************/
/**  获取体征记录
 * userId: 用户id
 *dataTime：更新时间
 */
+ (NSData*)getBodySignRecordWitnUID:(NSString*)userId;
+ (BOOL)sendBodySignRecordWithUID:(NSString*)userId;

/**
 *从服务器获取运动种类数据；
 *uid：用户Id；
 */
+(NSData *)getSportMonsin:(NSString *)uid andDatatime:(NSString *)dataTime;

/**
 *从服务器获取药物数据；
 *uid：用户Id；
 */
+(NSData *)getyaoMonsin:(NSString *)uid andDatatime:(NSString *)dataTime;

/**
 *从服务器获取同步药物数据；
 *uid：用户Id；
 */
+(NSData *)getsyncMedicationRecord:(NSString * )uid;
+ (BOOL)sendMedicineRecordWithUID:(NSString*)userId;
/**
 *服务器获取站内信；
 *dateTime：上次更新时间；
 *uid：用户id；
 */
+(NSData *)getInnerMailFromServer:(NSString *)dataTime andUid:(NSString *)uid;

+(NSString *)getTimeFromServer:(NSString *)dataTime andUid:(NSString *)uid;
//新建站内信请求
+(NSString *)createContentInnerMail:(NSString *)dataTime andUid:(NSString *)uid;
/**
 请求数据下载数据(未测试)
 获取站内信公告附件
 */
+(void)getNoticeAdjFromServerUID:(NSString *)uid Uorg:(NSString *)Uorg FileName:(NSString * )fileName FileType:(NSString * )FileType and:(void(^)(UIImage* image, NSString* nameStr))handle;






//获取基准数据(生成请求体并请求数据)
//返回值：服务器返回的基准数据
+(NSData *)getBaselineDataUID:(NSString *)uid BaseLineCode:(NSString *)baseLineCode beforeUpDataTime:(NSString *)updataTime;
//服务器返回的基准数据
//返回值：基准数据数组
+(NSMutableArray * )BaseLineUID:(NSString *)uid BaseLineCode:(NSString *)baseLineCode beforeUpDataTime:(NSString *)time;


//获取用户目标数据
+(NSData *)getUserTargetUseUID:(NSString *)UID;



//向服务器上传个人信息
+(BOOL)upUserInfoUseModel:(UserInfoModel *)model;

/**
 *   上传 目标步数到服务器
 *
 *  @param uid           用户id
 *  @param footstepvalue 目标步数值
 *  @param index         设定序号
 *  @param date          日期
 *
 *  @return 是否成功
 */
+(BOOL)upUserTargetFootUseUID:(NSString *)uid footStepValue:(NSString *)footstepvalue Index:(NSString *)index Date:(NSString *)date;

//向服务器发送咨询信息
+(BOOL)upDocAdvisoryUseUID:(NSString *)uid andUOrg:(NSString *)uorg andTitle:(NSString *)title TEXT:(NSString * )text andAdjunt:(NSString *)adjunt;

//上传图片方法
+ (BOOL) imageUpload:(UIImage *) image filename:(NSString *)filename UUID:(NSString * )Uuid picExtersion:(NSString *)extersion;
/**
 *  获取用户咨询请求
 *
 *  @param uid      用户id
 *  @param datatime 获取时间
 *
 *  @return 返回获取到的数据
 */

+(NSData *)downDoctorAdvisoryUseUID:(NSString *)uid dataTime:(NSString *)datatime;

//咨询回复上传（4.1）
+(NSData *)upAdvisoryReplyUseUID:(NSString *)uid AndUOrg:(NSString *)uorg AndRecId:(NSString *)RecId AndMaxId:(NSString *)MaxId AndUsrId:(NSString *)UsrId AndText:(NSString *)Text andAdjunct:(NSString *)Adjunct;

//
/**
 *  2.1获取医师建议请求
 *
 *  @param uid      用户id
 *  @param dataTime 更新时间
 *
 *  @return 获取到的数据
 */
+(NSData *)downDoctorInstructUseUID:(NSString *)uid andDataTime:(NSString *)dataTime;
//上传医生回复
+(NSData *)upDoctorInstructReplyUseUID:(NSString *)uid AndUOrg:(NSString *)uorg AndRecId:(NSString *)RecId AndMaxId:(NSString *)MaxId AndUsrId:(NSString *)UsrId AndText:(NSString *)Text andAdjunct:(NSString *)Adjunct;

#pragma mark 微信
/**
 *  食物分享到微信
 *
 *  @param userId    用户id
 *  @param foodArray 食物数组
 *  @param imageName 图片名称
 *  @param date      日期
 *
 *  @return 返回SID串，这是分享网址的拼接串
 */
+ (NSString *)upToSeverOfWeixinWithUID:(NSString*)userId andFoodArray:(NSArray*)foodArray ImageName:(NSString*)imageName andDate:(NSString*)date;
//运动
+ (NSString *)upToSeverOfWeixinWithUID:(NSString*)userId andSportArray:(NSArray*)sportArray ImageName:(NSString*)imageName andDate:(NSString*)date;

@end
