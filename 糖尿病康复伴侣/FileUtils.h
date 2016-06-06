//
//  FileUtils.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "sportCataModel.h"
#import "medicineListModel.h"
#import "foodmodel.h"
#import "baseLineModel.h"

@class MedicineRecordModel; //用药模型

@class BloodSugarModel;    //血糖模型
@class BodySignModel;      //体征模型

@interface FileUtils : NSObject
//获取本地时间YYYY-MM-dd格式
+(NSString *)getLocalDate;
//获取现在更新时间 YYYY-MM-dd HH:mm:ss
+ (NSString *)getNowUpdTime;

//排序类
+(NSString *)firstCharactor:(NSString *)aString;

/**
 *写入用户信息
 *
 *fileName：文件名称 info 用户信息
 */
+(BOOL)writeUserInfo:(NSString *)uid andInfo:(UserInfoModel *)info;

/**
 *  读取文件最新更新时间
 *
 *  @param fileName 文件名称
 *
 *  @return 返回更新时间
 */
+ (NSString *)readDataTimeFromFile:(NSString *)fileName;

/**
 *创建文件
 *fileName 文件名
 */
+(BOOL) isCreateFile:(NSString *)fileName andContent:(NSString *)fileContent;
//查找文件
+ (NSData*)findFileWithUserId:(NSString *)userId andSubfix:(NSString *)subfix;
/**
 *读取用户个人信息
 *uid  用户id
 *返回 用户信息
 */
+(UserInfoModel *)readUserInfo:(NSString *)uid;

/**
 *读取用户数据
 *fileName 文件名称
 *返回 文件内容
 */
+(NSData *)readFileData:(NSString *)fileName;

/**
 *文件是否存在
 */
+(BOOL)hasFile:(NSString *)fileName;

/**************************写入数据到本地*************************************/

/**
 *保存食物数据；
 *dataServer：用户行动确认；
 */
+(BOOL)writefoodMonsin:(NSData *)dataServer;

/**
 *保存运动种类数据；
 *dataServer：用户行动确认；
 */
+(BOOL)writeSportMonsin:(NSData *)dataServer;

/**
 *保存药物数据；
 *dataServer：用户行动确认；
 */

+(BOOL)writeyaoMonsin:(NSData *)dataServer;


/**************************从本地读取数据*************************************/
/**
 *读取运动种类；
 *sid：id；
 */

+(NSMutableArray *)readSid;

/**
 *读取药物；
 *sid：id；
 */
+(NSMutableArray *)readYid;
/**
 *读取食物；
 *sid：id；
 */
+(NSMutableArray *)readFid;

/**
 *读取食物分类；
 *sid：id；
 */
+(NSMutableArray *)readFCid;
/******************************** 健康日记 - 饮食 ***************************************************/
/**
 *写入  饮食记录；上传 将 饮食记录存入本地
 *data：数据；
 */
+(BOOL)writefoodRecordUserID:(NSString *)userId FoodID:(NSString *)foodID  Intake:(NSString *)intake timeperiod:(NSString *)timeperiod time:(NSString *)time UpdTime:(NSString *)UpdTime RecordDay:(NSString * )RecordDay;

+ (BOOL)writefoodRecordWithUID:(NSString*)userId andFoodRecordArray:(NSArray*)foodRecordArr andDate:(NSString *)dateTime;
/**饮食记录 写入本地文件  baba_food_record.dat 将网络获取的饮食记录写入本地
 uid 用户id
 */
+ (BOOL)writeDietRecordLocalWithUID:(NSString*)uid andData:(NSData*)systemData;

/**
 读取食物记录        [userId]_food_record.xml
 userId : 用户id
 dateString:食物记录时间
 */
+(NSArray *)readFoodRecordWithUserID:(NSString *)userId andDate:(NSString*)dateString;

+ (foodmodel*)readFoodWithFoodID:(NSString*)foodID;
/**
 删除 食物记录  [userId]_food_record.xml
 userId : 用户id
 model : 食物记录模型
 */
+ (BOOL)deleteFoodRecordWitnUserID:(NSString *)userID andModel:(FoodRecordModel *)model;
/********************************** 运动 ************************************************/
#pragma mark 运动
/**       将请求来的血糖记录数据写入本地   _sport_record.xml
 *userId： 用户id
 *systemData：请求获取到的数据
 */
+ (BOOL)writeSportRecodWithUID:(NSString*)userId SystemData:(NSData*)systemData;
/**       将请求来的血糖记录数据写入本地   _sport_record.xml
 *userId： 用户id
 *systemData：请求获取到的数据
 */

+ (NSArray *)readSportRecordWithUID:(NSString*)userId andDate:(NSString*)date;

/********************************** 健康日记 - 血糖 ************************************************/
#pragma mark 血糖
/**       将请求来的血糖记录数据写入本地   _sugar_record.xml
 *userId： 用户id
 *systemData：请求获取到的数据
 */
+ (BOOL)writeBloodSugarWithUID:(NSString*)userId SystemData:(NSData*)systemData;
/**
 * 读取 血糖记录并返回
 * userId：用户id
 * date:读取日期
 */
//+ (NSArray*)readBloodSugarWithUID:(NSString*)userId;
+ (NSArray*)readBloodSugarWithUID:(NSString*)userId andDate:(NSString*)date;
/**
 * 保存血糖数据到本地
 * userId：用户id
 * model：血糖记录模型
 */
+ (BOOL)saveBloodSugarWithUID:(NSString*)userId andModel:(BloodSugarModel*)model;
+ (void)saveBloodSugarWithUID:(NSString *)userId withModelArray:(NSArray*)modelArray andDate:(NSString*)dateTime;

/********************************* 健康日记 - 体征 *************************************************/
#pragma mark 体征
/** 将 获取的 体征数据写入本地  _bodysign_record.xml
 *userId： 用户id
 *systemData：请求获取到的数据
 */
+ (BOOL)writeBodySignWithUID:(NSString*)userId SystemData:(NSData*)systemData;
/**
 * 读取 用户体征数据
 *userId：用户id
 */
+ (BodySignModel*)readBodySignWithUID:(NSString*)userId withDate:(NSString*)dateString;
/**
 * 将 编辑的体征数据保存到本地
 *userId：用户id
 *model： 体征模型
 */

+ (BOOL)saveBodySignWithUID:(NSString*)userId AndModel:(BodySignModel*)model;
/**
 * 修改用户 体重 和 血压
 * userId：用户id
 * dbp：舒张压
 * sbp:收缩压
 * date:日期
 */
+ (BOOL)saveBodySignWith:(NSString*)userId andWeight:(NSString*)weight DBP:(NSString*)dbp SBP:(NSString*)sbp andDate:(NSString*)date;

/******************************* 健康日记 - 用药  ***************************************************/

#pragma mark 用药
/**
 写入网络请求的 用药记录放入本地
 userId: 用户id
 systemData：网络获取的数据
 */
+ (BOOL)writeMedicineWithUID:(NSString*)userId SystmeData:(NSData*)systemData;

/**
 读取用户 用药记录             [userId]_medication_record.xml
 返回用药记录模型
 */
+ (NSArray*)readMedicineRecordWithUID:(NSString *)userId AndDate:(NSString*)date;
//+ (NSArray*)readMedicineRecordWithUID:(NSString *)userId;

/**
 * 保存 用药数据
 * userId：用户id
 * model：用药模型
 */

+ (BOOL)writeMedicineRecordWithUID:(NSString *)userId AndModel:(MedicineRecordModel*)model;
+ (BOOL)writeMedicineRecordWithUID:(NSString *)userId AndModelArray:(NSArray*)medicineArray andDate:(NSString *)dateTime;

/****************************************  站内信 ***************************************************/
/**
 *站内信保存到本地
 *innerMail 站内信
 */
+(BOOL)writeInnerMail:(NSArray *)innerMailArr andUid:(NSString *)uid andNewUpdateTime:(NSString *)newUpdateTime;

+(BOOL)writeInnerMail:(NSArray *)innerMailArr andUid:(NSString *)uid;

/**
 *  将 邮件数据写入本地
 *
 *  @param userID     用户id
 *  @param serverData 网络获取到的数据
 *
 *  @return 文件存储是否成功
 */
+ (BOOL)writeInnerMailWithUID:(NSString*)userID andServerData:(NSData*)serverData;

/**
 *读取本地站内信
 *uid 用户id
 */
+(NSMutableArray *)readInnerMail:(NSString *)uid andPageNumber:(int)pageNumber;

+(NSArray *)readInnerMail:(NSString *)uid;



/**
 *读取本地站内信最后更新时间
 *uid 用户id
 */
+(NSString *)readInnerMailUpdateTime:(NSString *)uid;



//将获取到的站内信或者公告的附件写入到本地
+(BOOL)writeNoticeAdjtoLocal:(NSData *)data UID:(NSString *)uid;



//将获取到基准数据写入到本地
+(BOOL)writegetBaselineData:(NSMutableArray *)dataArray dataTime:(NSString *)dataTime;


/*
 从本地取出基准数据
 返回值：model的数组
 */
+(NSMutableArray *)ReadBaseLineData;



/*
 将食物推荐写入本地
 返回值  是否成功写入数据
 */
+(BOOL)writeFoodListRecommend:(NSData *)data;



/*
 利用属性取出节点的数组
 //
 */
+(baseLineModel *)getNodeDataUseCodeAttribute:(NSString *)attribute;



/*   通过backup获得value值*/
+(NSString *)getValueUsingcode:(NSString * )code;


/*根据日期去取食物推荐列表*/
+(NSMutableArray *)getFoodListRecommendUseDate:(NSString *)date andenergylv:(NSString *)energylv;

/*通过食物的id取得食物的名字*/
+(NSString *)getFoodNameUseFoodID:(NSString *)foodId;
/**
 获取食物模型  通过 食物foodId
 foodId ： 食物id
 
 */
+ (foodmodel*)getFoodModelWithFoodId:(NSString *)foodId;


/*将推荐的食谱写入本地
 mid收藏菜单的ID
 收藏时间CrtTime
 备注名Comment
 UserID用户id
 */
+(BOOL)writeFoodMenuToLocalFoodMenuID:(NSString *)mid Comment:(NSString * )comment CrtTime:(NSString *)time UserID:(NSString *)userid;
/*
 将推荐的食谱列表从本地取出
 */
+(NSMutableArray *)getFoodMenuOfFavoriteUserID:(NSString *)userid;

/*删除某一个节点
 传入节点的食谱名字 xpath查询节点  删除
 返回值：bool值 成功与否
 */
+(BOOL)deleteNodeUseMID:(NSString * )mid andUID:(NSString *)uid;

/*判断是否保存过推荐的食谱*/
+(BOOL)saveRecommendFoodListUsingUID:(NSString *)UID AndMID:(NSString *)mid;
/*根据menuid去取食物推荐列表*/
+(NSMutableArray *)getFoodListRecommendUseMID:(NSString *)mid;

//输入id 和站内信的id和状态   返回更改状态的成功与失败
+(BOOL)writeInnerMailReadStateUid:(NSString *)uid mailId:(NSString *)mailId state:(NSString *)state;

//将用户目标文件写入本地 写入id和从网络下载的数据
+(BOOL)writeUserTargetWithUID:(NSString *)uid andData:(NSData *)data;


//更改用户信息设置状态
+(BOOL)writeUserinfoSetStateUseUID:(NSString *)uid andState:(NSString *)state;


//取出目标步数
//输入用户id和当前的日期（格式20160409）
//返回值 当天的步数（如果没有当天的目标步数 返回向前最近的天数）
+(NSMutableArray *)getTargetFootStepUseUID:(NSString *)uid andDate:(NSString *)date;


//解析存储（用户咨询2.2）数据
+(BOOL)analysisDoctorAdvisoryUseData:(NSData *)data andUID:(NSString *)userid;




//利用uid取出上次咨询时的时间
+(NSString *)getLastTimeOfConsultUseUID:(NSString *)uid;



//利用uid去取出上次医师建议回复的时间
+(NSString *)getLastTimeOfDocinstructUseUID:(NSString *)uid;



//2.2返回的医师建议存储到本地存成1.1和1.2两个文件
+(BOOL)analysisDoctorInstructUseData:(NSData *)serverData andUID:(NSString *)userid;

//读取 用户咨询 和 医师建议 数据
+ (NSArray*)readAdvisoryDataWithUID:(NSString *)uid;
// 获取用户聊天数据 uid 用户id  chatid 数据id  isDoctor 是否是医生
+ (NSArray *)chatHistoryWithUid:(NSString *)uid And:(NSString *)chatId type:(BOOL)isDoctor;

@end
