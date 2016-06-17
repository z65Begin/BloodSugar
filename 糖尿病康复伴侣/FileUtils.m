//
//  FileUtils.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "FileUtils.h"
#import "GDataXMLNode.h"
#import "InnerMailModel.h"
#import "InnerNoticeModel.h"
#import "baseLineModel.h"
#import "FoodListRecommendModel.h"
#import "collectionModel.h"

#import "FoodRecordModel.h"

#import "MedicineRecordModel.h"

#import "BloodSugarModel.h"
#import "SportRecordModel.h"//运动模型
#import "BodySignModel.h"//用户体征模型

#import "cx_Advisory.h"//用户咨询数据
#import "Message.h"   //咨询记录

@implementation FileUtils
//获取本地时间YYYY-MM-dd格式
+(NSString *)getLocalDate{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}
+ (NSString *)getNowUpdTime{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}


//获取字符串首字母
+(NSString *)firstCharactor:(NSString *)aString{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}
/**
 *写入用户信息
 *
 *fileName：文件名称 info 用户信息
 */
+(BOOL)writeUserInfo:(NSString *)uid andInfo:(UserInfoModel *)info{
    NSString *fileName = [uid stringByAppendingString:USER_INFO_FILE];
    //文档根节点
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    //用户id
    GDataXMLElement *uidEle = [GDataXMLElement elementWithName:UID stringValue:info.UID];
    [root addChild:uidEle];
    //密码
    GDataXMLElement *pwdEle = [GDataXMLElement elementWithName:U_Password stringValue:info.Password];
    [root addChild:pwdEle];
    //姓名
    GDataXMLElement *nameEle = [GDataXMLElement elementWithName:U_Name stringValue:info.Name];
    [root addChild:nameEle];
    //拼音
    GDataXMLElement *pinyinEle = [GDataXMLElement elementWithName:U_Pinyin stringValue:info.Pinyin];
    [root addChild:pinyinEle];
    //    昵称
    GDataXMLElement * nickname = [GDataXMLElement elementWithName:U_NickName stringValue:info.NickName];
    [root addChild:nickname];
    //机构id org
    GDataXMLElement *kikanIdEle = [GDataXMLElement elementWithName:U_Org stringValue:info.Org];
    [root addChild:kikanIdEle];
    
    //用户类型
    GDataXMLElement *uTypeEle = [GDataXMLElement elementWithName:U_Type stringValue:info.Type];
    [root addChild:uTypeEle];
    //邮箱地址
    GDataXMLElement *emailEle = [GDataXMLElement elementWithName:U_Email stringValue:info.Email];
    [root addChild:emailEle];
    //电话
    GDataXMLElement *telEle = [GDataXMLElement elementWithName:U_Tel stringValue:info.Tel];
    [root addChild:telEle];
    //性别
    GDataXMLElement *sexEle = [GDataXMLElement elementWithName:U_Sex stringValue:info.Sex];
    [root addChild:sexEle];
    //生日
    GDataXMLElement *birthdayEle = [GDataXMLElement elementWithName:U_Birthday stringValue:info.Birthday];
    [root addChild:birthdayEle];
    //身高
    GDataXMLElement *heightEle = [GDataXMLElement elementWithName:U_Height stringValue:info.Height];
    [root addChild:heightEle];
    //体重
    GDataXMLElement *WeightEle = [GDataXMLElement elementWithName:U_Weight stringValue:info.Weight];
    [root addChild:WeightEle];
    
    //    活动强度
    GDataXMLElement * ExIntensityEle = [GDataXMLElement elementWithName:U_ExIntensity stringValue:info.ExIntensity];
    [root addChild:ExIntensityEle];
    //    糖尿病类型
    GDataXMLElement * DiabetesTypeEle = [GDataXMLElement elementWithName:U_DiabetesType stringValue:info.DiabetesType];
    [root addChild:DiabetesTypeEle];
    //    并发症
    GDataXMLElement * ComplicationEle = [GDataXMLElement elementWithName:U_Complication stringValue:info.Complication];
    [root addChild:ComplicationEle];
    //    静止心率
    GDataXMLElement * RestHrEle = [GDataXMLElement elementWithName:U_RestHr stringValue:info.RestHr];
    [root addChild:RestHrEle];
    //    家族病史
    GDataXMLElement * FamilyHisEle = [GDataXMLElement elementWithName:U_FamilyHis stringValue:info.FamilyHis];
    [root addChild:FamilyHisEle];
    //    临床诊断
    GDataXMLElement * CliDiagnosisEle = [GDataXMLElement elementWithName:U_CliDiagnosis stringValue:info.CliDiagnosis];
    [root addChild:CliDiagnosisEle];
    //    个人信息设置标志
    GDataXMLElement * InfoSetEle = [GDataXMLElement elementWithName:U_InfoSet stringValue:info.InfoSet];
    [root addChild:InfoSetEle];
    //    安全信息设置标志
    GDataXMLElement * SecureSetEle = [GDataXMLElement elementWithName:U_SecureSet stringValue:info.SecureSet];
    [root addChild:SecureSetEle];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"utf-8"];
    //创建文件
    return [FileUtils isCreateFile:fileName andContent:[[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding]];
}

/**
 *文件是否存在
 */
+(BOOL)hasFile:(NSString *)fileName{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取document路径
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    return [fileManager fileExistsAtPath:filePath];
}
/**
 *从数据文件读取用户个人基本信息
 *uid  用户id
 *返回 用户信息
 */
+(UserInfoModel *)readUserInfo:(NSString *)uid{
    //用户数据
    UserInfoModel * userInfo = [[UserInfoModel alloc] init];
    //取得文件数据
    NSData * data = [FileUtils readFileData:[uid stringByAppendingString:USER_INFO_FILE]];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement * rootEle = [doc rootElement];
    //用户id
    userInfo.UID = uid;
    userInfo.Password = [[[rootEle elementsForName:U_Password] objectAtIndex:0] stringValue];
    userInfo.Name= [[[rootEle elementsForName:U_Name] objectAtIndex:0] stringValue];
    userInfo.Pinyin = [[[rootEle elementsForName:U_Pinyin] objectAtIndex:0] stringValue];
    userInfo.NickName = [[[rootEle elementsForName:U_NickName] objectAtIndex:0] stringValue];
    userInfo.Org = [[[rootEle elementsForName:U_Org] objectAtIndex:0] stringValue];
    userInfo.Type = [[[rootEle elementsForName:U_Type] objectAtIndex:0] stringValue];
    userInfo.Email= [[[rootEle elementsForName:U_Email] objectAtIndex:0] stringValue];
    userInfo.Tel = [[[rootEle elementsForName:U_Tel] objectAtIndex:0] stringValue];
    userInfo.Sex = [[[rootEle elementsForName:U_Sex] objectAtIndex:0] stringValue];
    userInfo.Birthday = [[[rootEle elementsForName:U_Birthday] objectAtIndex:0] stringValue];
    userInfo.Height = [[[rootEle elementsForName:U_Height] objectAtIndex:0] stringValue];
    userInfo.Weight = [[[rootEle elementsForName:U_Weight] objectAtIndex:0] stringValue];
    userInfo.ExIntensity = [[[rootEle elementsForName:U_ExIntensity] objectAtIndex:0] stringValue] ;
    userInfo.DiabetesType = [[[rootEle elementsForName:U_DiabetesType] objectAtIndex:0] stringValue];
    userInfo.Complication = [[[rootEle elementsForName:U_Complication] objectAtIndex:0] stringValue];
    userInfo.RestHr = [[[rootEle elementsForName:U_RestHr] objectAtIndex:0] stringValue] ;
    userInfo.FamilyHis = [[[rootEle elementsForName:U_FamilyHis] objectAtIndex:0] stringValue];
    userInfo.CliDiagnosis = [[[rootEle elementsForName:U_CliDiagnosis] objectAtIndex:0] stringValue];
    userInfo.InfoSet = [[[rootEle elementsForName:U_InfoSet] objectAtIndex:0] stringValue] ;
    userInfo.SecureSet = [[[rootEle elementsForName:U_SecureSet] objectAtIndex:0] stringValue] ;
    return userInfo;
}

/**
 *保存食物数据；
 *dataServer：用户行动确认；
 */
+(BOOL)writefoodMonsin:(NSData *)dataServer{
    NSString *fileName = FOOD_DATA_FILE;
  
    [self findFileWithUserId:nil andSubfix:FOOD_DATA_FILE];
    // 切割doc 然后生成两个root根节点的数据
    //    生成字符串（二进制）
    NSString *str1 = [[NSString alloc] initWithData:dataServer encoding:NSUTF8StringEncoding];
    //    切割字符串用DocSplit
    NSArray * array=[str1 componentsSeparatedByString:@"DocSplit"];
    
    NSString *dataStr = array[1] ;
    NSData * finalData = [NSData dataWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding]];

    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:finalData encoding:NSUTF8StringEncoding]];
}

/**
 *保存运动种类数据；
 *dataServer：用户行动确认；
 */
+(BOOL)writeSportMonsin:(NSData *)dataServer{
    NSString *fileName = SPORT_TYPE_FILE;
    NSData *fileData = [self findFileWithUserId:nil andSubfix:fileName];
//   客户端
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
//    服务端
    GDataXMLDocument *serverDoc = [[GDataXMLDocument alloc] initWithData:dataServer options:0 error:nil];
    GDataXMLElement *serverRoot = [serverDoc rootElement];
    GDataXMLElement *serverDataEle = [[serverRoot elementsForName:DATA] objectAtIndex:0];

    GDataXMLElement * dataTimeEle = [[rootEle elementsForName:DATATIME]firstObject];
    if (dataTimeEle) {
        [dataTimeEle setStringValue:[[[serverDataEle elementsForName:DATATIME] firstObject] stringValue]];
        NSArray * typeArray = [serverDataEle elementsForName:TYPE];
        for (GDataXMLElement * typeEle in typeArray) {
            NSString * xpath = [NSString stringWithFormat:@"./Type[@id='%@']",[[typeEle attributeForName:FoodID]stringValue]];
           GDataXMLElement * typeFile = [[rootEle nodesForXPath:xpath error:nil]firstObject];
            if (typeFile) {
                [rootEle removeChild:typeFile];
            }
            [rootEle addChild:typeEle];
        }
    }else{
        rootEle = serverDataEle;
    }
    GDataXMLDocument * newDoc = [[GDataXMLDocument alloc]initWithRootElement:rootEle];
    [newDoc setVersion:@"1.0"];
    [newDoc setCharacterEncoding:@"UTF-8"];
    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:newDoc.XMLData encoding:NSUTF8StringEncoding]];
}
/**
 *  读取文件最新更新时间
 *
 *  @param fileName 文件名称
 *
 *  @return 返回更新时间
 */
+ (NSString *)readDataTimeFromFile:(NSString *)fileName{
    if (![self hasFile:fileName]) {
        return nil;
    }
    NSData * fileData = [self readFileData:fileName];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [doc rootElement];
    NSString * dataTime = [[[rootEle elementsForName:DATATIME]firstObject]stringValue];
    return dataTime;
}

/**
 *保存药品种类数据；
 *dataServer：用户行动确认；
 */

+(BOOL)writeyaoMonsin:(NSData *)dataServer{
    NSString *fileName = MEDICINE_TYPE_FILE;
//    客户端
    NSData *fileData = [self findFileWithUserId:nil andSubfix:MEDICINE_TYPE_FILE];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
//    服务端
    GDataXMLDocument *serverDoc = [[GDataXMLDocument alloc] initWithData:dataServer options:0 error:nil];
    GDataXMLElement *serverRoot = [serverDoc rootElement];
    GDataXMLElement *serverDataEle = [[serverRoot elementsForName:DATA] objectAtIndex:0];
    rootEle = serverDataEle;
    GDataXMLDocument * newDoc = [[GDataXMLDocument alloc]initWithRootElement:rootEle];
    [newDoc setVersion:@"1.0"];
    [newDoc setCharacterEncoding:@"UTF-8"];
    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:newDoc.XMLData encoding:NSUTF8StringEncoding]];
}

/**
 *创建文件
 * fileName 文件名; fileConten 文件内容
 * 返回bool yes表示创建成功
 */
+(BOOL)isCreateFile:(NSString *)fileName andContent:(NSString *)fileContent{
    BOOL isCreateFile = NO;
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取document路径
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    //xml文件内容
    NSString *content = fileContent;
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    isCreateFile = [fileManager createFileAtPath:filePath contents:contentData attributes:nil];
    return isCreateFile;
}
/**
 *读取数据
 *fileName 文件名称
 *返回 文件内容
 */
+(NSData *)readFileData:(NSString *)fileName{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取document路径
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //文化路径
    NSString *filePath = [directoryPaths objectAtIndex:0];
    //文件数据
    NSData *data = [fileManager contentsAtPath:[filePath stringByAppendingPathComponent:fileName]];
    return data;
}
///**
// *读取个人信息；
// *sid：id；
// */
//
//+(UserInfoModel *)username:(NSString *)uid
//{
//    NSString *fileName = USER_INFO_FILE;
//
//    NSData *fileData = [self readFileData:fileName];
//
//    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
//    GDataXMLElement *rootEle = [doc rootElement];
//    UserInfoModel * model = [[UserInfoModel alloc]init];
//
//    model.UID = [[[rootEle elementsForName:UID]objectAtIndex:0]stringValue];
//
//    return model;
//
//}

//查找文件
+ (NSData*)findFileWithUserId:(NSString *)userId andSubfix:(NSString *)subfix{
    NSString *fileName = nil;
    if (userId == nil) {
        fileName = subfix;
    }else{
        fileName = [userId stringByAppendingString:subfix];
    }
    if (![self hasFile:fileName]) {
        GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
        //设置文档信息
        GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
        [rootDoc setVersion:@"1.0"];
        [rootDoc setCharacterEncoding:@"UTF-8"];
        [FileUtils isCreateFile:fileName andContent:[[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding]];
    }
    NSData *fileData = [self readFileData:fileName];
    
    return fileData;
}

/**
 *读取药物种类；
 *sid：id；
 */
+(NSMutableArray *)readYid{
    NSString *fileName = MEDICINE_TYPE_FILE;
    
    NSData *fileData = [self readFileData:fileName];
    
    NSMutableArray *yaoListArr = [[NSMutableArray alloc] init];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    
    GDataXMLElement *rootEle = [doc rootElement];
    GDataXMLElement *MedicList1 = [[rootEle elementsForName:MedicList]objectAtIndex:0];
    NSArray * MedicineArr = [MedicList1 elementsForName:Medicine];
    for (GDataXMLElement *typeEle in MedicineArr) {
        
        medicineListModel * medicineModel = [[medicineListModel alloc] init];
        medicineModel.sid = [[typeEle attributeForName:SID] stringValue];
        medicineModel.type = [[typeEle attributeForName:TYPE] stringValue];
        medicineModel.Name = [[[typeEle elementsForName:NAME] objectAtIndex:0] stringValue];
        medicineModel.Alias = [[[typeEle elementsForName:Alias]objectAtIndex:0]stringValue];
        [yaoListArr addObject:medicineModel];
    }
    
    return yaoListArr;
}
/*******************************   健康日记 - 饮食    ***********************************************/
/**
 *读取食物分类；
 *sid：id；
 */
+(NSMutableArray *)readFCid{
    NSString *fileName = FOOD_DATA_FILE;
    NSData *fileData = [self readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    GDataXMLElement *CateListEle = [[rootEle elementsForName:CateListELE]objectAtIndex:0];
    NSMutableArray *CategoryArray = [[NSMutableArray alloc] init];
    for (GDataXMLElement * ele in CateListEle.children) {
        foodmodel * model  = [[foodmodel alloc]init];
        model.CateName = [[[ele elementsForName:NAME] objectAtIndex:0] stringValue];
        [CategoryArray addObject:model];
    }
    return CategoryArray;
}
/**
 *读取食物；
 *sid：id；
 */
+(NSMutableArray *)readFid{
    NSString *fileName = FOOD_DATA_FILE;
    NSData *fileData = [self readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    GDataXMLElement *FoodListEle = [[rootEle elementsForName:FoodListELE]objectAtIndex:0];
    NSMutableArray *FoodListArray = [[NSMutableArray alloc] init];
    for (GDataXMLElement * ele in FoodListEle.children) {
        foodmodel * model  = [[foodmodel alloc]init];
        model.FoodCateID = [[ele attributeForName:FoodCateID]stringValue];
        model.foodID = [[ele attributeForName:FoodID]stringValue];
        model.FoodName = [[[ele elementsForName:NAME] objectAtIndex:0] stringValue];
        model.UnitValue = [[[ele elementsForName:UnitValue]objectAtIndex:0]stringValue];
        model.UnitName = [[[ele elementsForName:UnitName]objectAtIndex:0]stringValue];
        model.UnitEnergy = [[[ele elementsForName:UnitEnergy]objectAtIndex:0]stringValue];
        model.UnitGI = [[[ele elementsForName:UnitGI]objectAtIndex:0]stringValue];
        model.UnitH2O = [[[ele elementsForName:UnitH2O]objectAtIndex:0]stringValue];
        model.UnitProtein = [[[ele elementsForName:UnitProtein]objectAtIndex:0]stringValue];
        model.UnitFat = [[[ele elementsForName:UnitFat]objectAtIndex:0]stringValue];
        model.UnitDieFiber = [[[ele elementsForName:UnitDieFiber]objectAtIndex:0]stringValue];
        model.UnitCarbs = [[[ele elementsForName:UnitCarbs]objectAtIndex:0]stringValue];
        model.UnitVA = [[[ele elementsForName:UnitVA]objectAtIndex:0]stringValue];
        model.UnitVB1 = [[[ele elementsForName:UnitVB1]objectAtIndex:0]stringValue];
        model.UnitVB2 = [[[ele elementsForName:UnitVB2]objectAtIndex:0]stringValue];
        model.UnitVC = [[[ele elementsForName:UnitVC]objectAtIndex:0]stringValue];
        model.UnitVE = [[[ele elementsForName:UnitVE]objectAtIndex:0]stringValue];
        model.UnitNiacin = [[[ele elementsForName:UnitNiacin]objectAtIndex:0]stringValue];
        model.UnitNa = [[[ele elementsForName:UnitNa]objectAtIndex:0]stringValue];
        model.UnitCa = [[[ele elementsForName:UnitCa]objectAtIndex:0]stringValue];
        model.UnitFe = [[[ele elementsForName:UnitFe]objectAtIndex:0]stringValue];
        model.UnitChol = [[[ele elementsForName:UnitChol]objectAtIndex:0]stringValue];
        model.DelFlag = [[[ele elementsForName:DelFlag]objectAtIndex:0]stringValue];
        [FoodListArray addObject:model];
        //        NSLog(@"%@model",model);
    }
    return FoodListArray;
}
+ (foodmodel*)readFoodWithFoodID:(NSString*)foodID{
    NSString *fileName = FOOD_DATA_FILE;
    NSData *fileData = [self readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    NSString * xpath = [NSString stringWithFormat:@"./FoodList/Food[@id='%@']",foodID];
    GDataXMLElement * foodEle = [[rootEle nodesForXPath:xpath error:nil]firstObject];
    foodmodel * model  = [[foodmodel alloc]init];
    model.FoodCateID = [[foodEle attributeForName:FoodCateID]stringValue];
    model.foodID = [[foodEle attributeForName:FoodID]stringValue];
    model.FoodName = [[[foodEle elementsForName:NAME] objectAtIndex:0] stringValue];
    model.UnitValue = [[[foodEle elementsForName:UnitValue]objectAtIndex:0]stringValue];
    model.UnitName = [[[foodEle elementsForName:UnitName]objectAtIndex:0]stringValue];
    model.UnitEnergy = [[[foodEle elementsForName:UnitEnergy]objectAtIndex:0]stringValue];
    model.UnitGI = [[[foodEle elementsForName:UnitGI]objectAtIndex:0]stringValue];
    model.UnitH2O = [[[foodEle elementsForName:UnitH2O]objectAtIndex:0]stringValue];
    model.UnitProtein = [[[foodEle elementsForName:UnitProtein]objectAtIndex:0]stringValue];
    model.UnitFat = [[[foodEle elementsForName:UnitFat]objectAtIndex:0]stringValue];
    model.UnitDieFiber = [[[foodEle elementsForName:UnitDieFiber]objectAtIndex:0]stringValue];
    model.UnitCarbs = [[[foodEle elementsForName:UnitCarbs]objectAtIndex:0]stringValue];
    model.UnitVA = [[[foodEle elementsForName:UnitVA]objectAtIndex:0]stringValue];
    model.UnitVB1 = [[[foodEle elementsForName:UnitVB1]objectAtIndex:0]stringValue];
    model.UnitVB2 = [[[foodEle elementsForName:UnitVB2]objectAtIndex:0]stringValue];
    model.UnitVC = [[[foodEle elementsForName:UnitVC]objectAtIndex:0]stringValue];
    model.UnitVE = [[[foodEle elementsForName:UnitVE]objectAtIndex:0]stringValue];
    model.UnitNiacin = [[[foodEle elementsForName:UnitNiacin]objectAtIndex:0]stringValue];
    model.UnitNa = [[[foodEle elementsForName:UnitNa]objectAtIndex:0]stringValue];
    model.UnitCa = [[[foodEle elementsForName:UnitCa]objectAtIndex:0]stringValue];
    model.UnitFe = [[[foodEle elementsForName:UnitFe]objectAtIndex:0]stringValue];
    model.UnitChol = [[[foodEle elementsForName:UnitChol]objectAtIndex:0]stringValue];
    model.DelFlag = [[[foodEle elementsForName:DelFlag]objectAtIndex:0]stringValue];
    return model;
}
#pragma mark  写入系统文件的 统一方法 比较 更新时间
+ (NSString*)writeWithUID:(NSString*)userId andData:(NSData*)systemData andFileChildName:(NSString*)subfix{
    NSData * fileData = [self findFileWithUserId:userId andSubfix:subfix];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * file_root = [fileDoc rootElement];
    
    GDataXMLDocument * sysDoc = [[GDataXMLDocument alloc]initWithData:systemData options:0 error:nil];
    GDataXMLElement * sys_root = [sysDoc rootElement];
    GDataXMLElement * sys_data = [[sys_root elementsForName:DATA] firstObject];
    for (GDataXMLElement * recordEle in sys_data.children) {
        NSString* dateStr = [[recordEle attributeForName:FOODDATE]stringValue];
        NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",dateStr];
        GDataXMLElement * fileRecordEle = [[file_root nodesForXPath:xpath error:nil]firstObject];
        if (fileRecordEle != nil) {
            NSString * fileUpd = [[[fileRecordEle elementsForName:upDataTime]firstObject]stringValue];
            NSString * sysUpd = [[[recordEle elementsForName:upDataTime]firstObject]stringValue];
            NSDate * fileDate = [UtilCommon strFormateDate:fileUpd];
            NSDate * sysDate = [UtilCommon strFormateDate:sysUpd];
            if ([fileDate compare:sysDate] == NSOrderedAscending) {
                [file_root removeChild:fileRecordEle];
                [file_root addChild:recordEle];
            }
        }else{
            [file_root addChild:recordEle];
        }
    }
    return [[NSString alloc] initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
}

/**饮食记录 写入本地文件  baba_food_record.dat
 uid 用户id
 */
+ (BOOL)writeDietRecordLocalWithUID:(NSString*)uid andData:(NSData*)systemData{
    NSString * fileName = [uid stringByAppendingString:FOOD_RECORD_FILE];
//    NSData * fileData = [self findFileWithUserId:uid andSubfix:FOOD_RECORD_FILE];
//    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
//    GDataXMLElement * file_root = [fileDoc rootElement];
// 
//    GDataXMLDocument * sysDoc = [[GDataXMLDocument alloc]initWithData:systemData options:0 error:nil];
//    GDataXMLElement * sys_root = [sysDoc rootElement];
//    GDataXMLElement * sys_data = [[sys_root elementsForName:DATA] firstObject];
//    for (GDataXMLElement * recordEle in sys_data.children) {
//       NSString* dateStr = [[recordEle attributeForName:FOODDATE]stringValue];
//        NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",dateStr];
//        GDataXMLElement * fileRecordEle = [[file_root nodesForXPath:xpath error:nil]firstObject];
//        if (fileRecordEle != nil) {
//            NSString * fileUpd = [[[fileRecordEle elementsForName:upDataTime]firstObject]stringValue];
//            NSString * sysUpd = [[[recordEle elementsForName:upDataTime]firstObject]stringValue];
//            NSDate * fileDate = [UtilCommon strFormateDate:fileUpd];
//            NSDate * sysDate = [UtilCommon strFormateDate:sysUpd];
//            if ([fileDate compare:sysDate] == NSOrderedAscending) {
//                [file_root removeChild:fileRecordEle];
//                [file_root addChild:recordEle];
//            }
//        }else{
//            [file_root addChild:recordEle];
//        }
//    }
//  return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding]];
  NSString * content = [self writeWithUID:uid andData:systemData andFileChildName:FOOD_RECORD_FILE];
    return [self isCreateFile:fileName andContent:content];
    
}

/**
 *写入食物记录；
 *data：数据；
 */
+(BOOL)writefoodRecordUserID:(NSString *)userId FoodID:(NSString *)foodID Intake:(NSString *)intake timeperiod:(NSString *)timeperiod time:(NSString *)time UpdTime:(NSString *)UpdTime RecordDay:(NSString *)RecordDay{
    
    NSString *fileName = [userId stringByAppendingString:FOOD_RECORD_FILE];
    NSData * fileData = [self findFileWithUserId:userId andSubfix:FOOD_RECORD_FILE];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [doc rootElement];
//    NSArray * recordArr  = [rootEle elementsForName:Record];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",RecordDay];
    GDataXMLElement * recordEle = [[rootEle nodesForXPath:xpath error:nil] firstObject];
    if (recordEle == nil) {
        GDataXMLElement * recordEle1 = [GDataXMLElement elementWithName:Record];
        GDataXMLElement * dataAttr = [GDataXMLElement attributeWithName:@"date" stringValue:RecordDay];
        GDataXMLElement * updtimeEle = [GDataXMLElement elementWithName:upDataTime stringValue:UpdTime];
        GDataXMLElement * intakeEle = [GDataXMLElement elementWithName:INTAKE stringValue:intake];
        GDataXMLElement * foodidAttribute = [GDataXMLElement attributeWithName:@"foodid" stringValue:foodID];
        GDataXMLElement * timeperiodAttribute = [GDataXMLElement attributeWithName:@"timeperiod" stringValue:timeperiod];
        GDataXMLElement *timeattribute = [GDataXMLElement attributeWithName:@"time" stringValue:time];
        [intakeEle addAttribute:foodidAttribute];
        [intakeEle addAttribute:timeperiodAttribute];
        [intakeEle addAttribute:timeattribute];
        [recordEle1 addChild:intakeEle];
        [recordEle1 addChild:updtimeEle];
        [recordEle1 addAttribute:dataAttr];
        [rootEle addChild:recordEle1];
    }else{
        NSString * xpath2 = [NSString stringWithFormat:@"./Intake[@foodid='%@'][@timeperiod='%@']",foodID,timeperiod];
        GDataXMLElement * intakeEle = [[recordEle nodesForXPath:xpath2 error:nil]firstObject];
        if (!intakeEle) {
            GDataXMLElement * updtimeEle = [[recordEle elementsForName:upDataTime] firstObject];
            if (!updtimeEle) {
                GDataXMLElement * newupdtimeEle = [GDataXMLElement elementWithName:upDataTime stringValue:UpdTime];
                [recordEle addChild:newupdtimeEle];
            }else{
                [updtimeEle setStringValue:UpdTime];
            }
            GDataXMLElement * intakeEle1 = [GDataXMLElement elementWithName:INTAKE stringValue:intake];
            GDataXMLElement * foodidAttribute = [GDataXMLElement attributeWithName:@"foodid" stringValue:foodID];
            GDataXMLElement * timeperiodAttribute = [GDataXMLElement attributeWithName:@"timeperiod" stringValue:timeperiod];
            GDataXMLElement *timeattribute = [GDataXMLElement attributeWithName:@"time" stringValue:time];
            [intakeEle1 addAttribute:foodidAttribute];
            [intakeEle1 addAttribute:timeperiodAttribute];
            [intakeEle1 addAttribute:timeattribute];
            [recordEle addChild:intakeEle1];
            
        }else{
            [intakeEle setStringValue:intake];
            GDataXMLNode * timeEle = [intakeEle attributeForName:@"time"];
            [timeEle setStringValue:time];
            GDataXMLElement * updELe = [[recordEle elementsForName:upDataTime]firstObject];
            [updELe setStringValue:UpdTime];
        }
    }
    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:doc.XMLData encoding:NSUTF8StringEncoding]];
    
}
//修改食物数据
+ (BOOL)writefoodRecordWithUID:(NSString*)userId andFoodRecordArray:(NSArray*)foodRecordArr andDate:(NSString *)dateTime{
    NSString * fileName = [userId stringByAppendingString:FOOD_RECORD_FILE];
    
    NSData* fileData = [self findFileWithUserId:userId andSubfix:FOOD_RECORD_FILE];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement* rootEle = [fileDoc rootElement];
    FoodRecordModel* model = [foodRecordArr firstObject];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",dateTime];
    GDataXMLElement * recordEle = [[rootEle nodesForXPath:xpath error:nil]firstObject];
    NSString * xpath1 = [NSString stringWithFormat:@"./Intake[@timeperiod='%@']",model.timeperiod];
    NSArray * intakeArr = [recordEle nodesForXPath:xpath1 error:nil];
    for (GDataXMLElement* intakeEle in intakeArr) {
        [recordEle removeChild:intakeEle];
    }
    BOOL flag = NO;
    NSString * content = [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
    [self isCreateFile:fileName andContent:content];
    
    for (FoodRecordModel * childModel in foodRecordArr) {
      flag = [self writefoodRecordUserID:userId FoodID:childModel.foodId Intake:childModel.intake timeperiod:childModel.timeperiod time:childModel.time UpdTime:childModel.updtime RecordDay:childModel.date];
    }
    if (!foodRecordArr.count) {
        return YES;
    }
    
    return flag;
}
/**
    读取食物记录        [userId]_food_record.xml
    userId : 用户id
 */
+(NSArray *)readFoodRecordWithUserID:(NSString *)userId andDate:(NSString*)dateString{
    NSString * fileName = [userId stringByAppendingString:FOOD_RECORD_FILE];
    NSData * data = [self readFileData:fileName];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    GDataXMLElement * rootEle = [doc rootElement];
//    NSArray * recordArray = [rootEle elementsForName:Record];
    NSMutableArray * array = [NSMutableArray array];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",dateString];
    NSArray * recordArray = [rootEle nodesForXPath:xpath error:nil];
    for (GDataXMLElement * ele_record in recordArray) {
        NSString * date = [[ele_record attributeForName:@"date"] stringValue];
        NSString * updtime = [[[ele_record elementsForName:upDataTime]firstObject]stringValue];
        NSArray * intakeArray = [ele_record elementsForName:INTAKE];
        for (GDataXMLElement * intakeEle in intakeArray) {
            FoodRecordModel * model = [[FoodRecordModel alloc]init];
            model.foodId = [[intakeEle attributeForName:@"foodid"]stringValue];
            model.date = date;
            model.timeperiod = [[intakeEle attributeForName:timeperiodFile] stringValue];
            model.intake = [intakeEle stringValue];
            model.time = [[intakeEle attributeForName:@"time"]stringValue];
            model.updtime = updtime;
            [array addObject:model];
        }
    }
    return array;
}
/**
 删除 食物记录  [userId]_food_record.xml
  userId : 用户id
 model : 食物记录模型
 */
+ (BOOL)deleteFoodRecordWitnUserID:(NSString *)userID andModel:(FoodRecordModel *)model{
    NSString * fileName = [userID stringByAppendingString:FOOD_RECORD_FILE];
    NSData * data = [self readFileData:fileName];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    GDataXMLElement * rootEle = [doc rootElement];
    
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']/Intake[@foodid='%@']",model.date,model.foodId];
    NSArray * array = [rootEle nodesForXPath:xpath error:nil];
    NSArray * recordArr = [rootEle elementsForName:Record];
    for (GDataXMLElement * recordEle in recordArr) {
        if ( [[[recordEle attributeForName:@"date"]stringValue] isEqualToString:model.date]) {
            [recordEle removeChild:array.firstObject];
        }
    }
    return [self isCreateFile:fileName andContent:[[NSString alloc]initWithData:doc.XMLData encoding:NSUTF8StringEncoding]];
}
/**********************************健康日记 - 运动********************************/
#pragma mark 健康日记 - 运动
/**
 *读取运动种类；
 *sid：id；
 */
+(NSMutableArray *)readSid{
    NSString *fileName = SPORT_TYPE_FILE;
    NSData *fileData = [self readFileData:fileName];
    NSMutableArray *sportCatalArr = [[NSMutableArray alloc] init];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    NSArray * typeArr = [rootEle elementsForName:TYPE];
    for (GDataXMLElement *typeEle in typeArr) {
        sportCataModel *sportModel = [[sportCataModel alloc] init];
        sportModel.sid = [[typeEle attributeForName:SID] stringValue];
        sportModel.Name = [[[typeEle elementsForName:NAME] objectAtIndex:0] stringValue];
        sportModel.Energy = [[[typeEle elementsForName:ENERGY] objectAtIndex:0] stringValue];
        [sportCatalArr addObject:sportModel];
    }
    return sportCatalArr;
}
/**       将请求来的血糖记录数据写入本地   _sport_record.xml
 *userId： 用户id
 *systemData：请求获取到的数据
 */
+(BOOL)writeSportRecodWithUID:(NSString*)userId SystemData:(NSData*)systemData{
    NSString * fileName = [userId stringByAppendingString:SPORT_RECORD_FILE];
    NSString * content = [self writeWithUID:userId andData:systemData andFileChildName:SPORT_RECORD_FILE];
    return [self isCreateFile:fileName andContent:content];
}

+ (NSArray *)readSportRecordWithUID:(NSString*)userId andDate:(NSString*)date{
    NSString * fileName = [userId stringByAppendingString:SPORT_RECORD_FILE];
    NSData * fileData = [self readFileData:fileName];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",date];
    NSArray * recordArray = [rootEle nodesForXPath:xpath error:nil];
    GDataXMLElement * recordEle = [recordArray firstObject];
    NSMutableArray * array = [NSMutableArray array];
    NSString * updtime = [[[recordEle elementsForName:upDataTime] firstObject] stringValue];
    NSArray * sportArray = [recordEle elementsForName:SPORT_Record_Sport];
    for (GDataXMLElement * sportEle in sportArray) {
        SportRecordModel * model = [[SportRecordModel alloc]init];
        model.time = [[sportEle attributeForName:SPORT_Record_time] stringValue];
        model.TimeLength = [[[sportEle elementsForName:SPORT_Record_TimeLength]firstObject]stringValue];
        model.Type = [[[sportEle elementsForName:TYPE]firstObject]stringValue];
        model.Result = [[[sportEle elementsForName:SPORT_RECORD_Result]firstObject]stringValue];
        model.UpdTime = updtime;
        model.date = date;
        [array addObject:model];
    }
    return [array copy];
}

/**********************************健康日记 - 血糖********************************/
#pragma mark 健康日记 - 血糖
/**       将请求来的血糖记录数据写入本地   _sugar_record.xml
 *userId： 用户id
 *systemData：请求获取到的数据
 */
+ (BOOL)writeBloodSugarWithUID:(NSString*)userId SystemData:(NSData*)systemData{
    NSString * fileName = [userId stringByAppendingString:SUGAR_RECORD_FILE];
//    NSData * fileData = [self findFileWithUserId:userId andSubfix:SUGAR_RECORD_FILE];
//    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
//    GDataXMLElement * rootEle = [fileDoc rootElement];  //文件
//    GDataXMLDocument * sysDoc = [[GDataXMLDocument alloc]initWithData:systemData options:0 error:nil];
//    GDataXMLElement * sys_root = [sysDoc rootElement];
//    GDataXMLElement * sys_data = [[sys_root elementsForName:DATA] firstObject];
//    for (GDataXMLElement * recordEle in sys_data.children) {
//        NSString * dateStr = [[recordEle attributeForName:FOODDATE] stringValue];
//        NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",dateStr];
//        NSArray * recordArray_file = [rootEle nodesForXPath:xpath error:nil];
//        if (recordArray_file.count) {
//            NSArray * sys_bloodsugar = [recordEle elementsForName:SUGAR_BloodSugar];
//            GDataXMLElement * file_recordArray = [recordArray_file firstObject];
//            NSString * newUpdTime = [[[recordEle elementsForName:upDataTime] firstObject] stringValue];
//          GDataXMLElement* updTimeELe = [[file_recordArray elementsForName:upDataTime]firstObject];
//            [updTimeELe setStringValue:newUpdTime];
//            for (GDataXMLElement * bloodSugarEle in sys_bloodsugar) {
//                NSString * sys_blood_timeper = [[bloodSugarEle attributeForName:SUGAR_timeper]stringValue];
//                NSArray * file_bloodSugar = [file_recordArray elementsForName:SUGAR_BloodSugar];
//                for (GDataXMLElement * fileBloodSugar in file_bloodSugar) {
//                    if ([[[fileBloodSugar attributeForName:SUGAR_timeper]stringValue] isEqualToString:sys_blood_timeper]) {
//                        [file_recordArray removeChild:fileBloodSugar];
//                    }
//                }
//                [file_recordArray addChild:bloodSugarEle];
//            }
//        }else{
//            [rootEle addChild:recordEle];
//        }
//    }
    NSString * content = [self writeWithUID:userId andData:systemData andFileChildName:SUGAR_RECORD_FILE];
    return [self isCreateFile:fileName andContent:content];
}
/**
 * 读取 血糖记录并返回
 * userId：用户id
 */
+ (NSArray*)readBloodSugarWithUID:(NSString*)userId andDate:(NSString*)date {
    NSString * fileName = [userId stringByAppendingString:SUGAR_RECORD_FILE];
    NSData * fileData = [self readFileData:fileName];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",date];
    NSArray * recordArray = [rootEle nodesForXPath:xpath error:nil];
    
    NSMutableArray * array = [NSMutableArray array];
    for (GDataXMLElement * recordEle  in recordArray) {
        NSString * dateStr = [[recordEle attributeForName:FOODDATE] stringValue];
        NSString  * updTimeStr = [[[recordEle elementsForName:upDataTime]firstObject] stringValue];
        NSArray * bloodSugarArray = [recordEle elementsForName:SUGAR_BloodSugar];
        for (GDataXMLElement * bloodSugarEle in bloodSugarArray) {
            BloodSugarModel * model = [[BloodSugarModel alloc]init];
            model.UpdTime = updTimeStr;
            model.date = dateStr;
            NSString * timeperStr = [[bloodSugarEle attributeForName:SUGAR_timeper] stringValue];
            NSString * timespanStr = [[bloodSugarEle attributeForName:SUGAR_timespan] stringValue];
            model.timeper = timeperStr;
            model.timespan = timespanStr;
            NSString * valuesStr = [[[bloodSugarEle elementsForName:value]firstObject] stringValue];
            model.Value = valuesStr;
            [array addObject:model];
        }
    }
    return array;
}
/**
 * 保存血糖数据到本地
 * userId：用户id
 * model：血糖记录模型
 */
+ (BOOL)saveBloodSugarWithUID:(NSString*)userId andModel:(BloodSugarModel*)model{
    NSString * fileName = [userId stringByAppendingString:SUGAR_RECORD_FILE];
    NSData * fileData = [self findFileWithUserId:userId andSubfix:SUGAR_RECORD_FILE];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",model.date];
    GDataXMLElement * recordEle = [[rootEle nodesForXPath:xpath error:nil]firstObject];
    if (recordEle != nil) {
//        NSArray * bloodSugarArray = [recordEle elementsForName:SUGAR_BloodSugar];
//        GDataXMLElement * updtimeEle = [[recordEle elementsForName:upDataTime]firstObject];
//        [updtimeEle setStringValue:model.UpdTime];
//        for (GDataXMLElement * bloodSugarEle in bloodSugarArray) {
//            NSString * timeperStr = [[bloodSugarEle attributeForName:SUGAR_timeper] stringValue];
//            if ([model.timeper isEqualToString:timeperStr]) {
//                GDataXMLNode * timespan = [bloodSugarEle attributeForName:SUGAR_timespan] ;
//                [timespan setStringValue:model.timespan];
//                GDataXMLElement * valueEle = [[bloodSugarEle elementsForName:value]firstObject];
//                [valueEle setStringValue:model.Value];
//                NSString * content = [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
//                return [self isCreateFile:fileName andContent:content];
//            }
//        }
//        GDataXMLElement * newBloodSugarEle = [GDataXMLElement elementWithName:SUGAR_BloodSugar];
//        GDataXMLElement * newTimePerEle = [GDataXMLElement attributeWithName:SUGAR_timeper stringValue:model.timeper];
//        GDataXMLElement * newTimespanEle = [GDataXMLElement attributeWithName:SUGAR_timespan stringValue:model.timespan];
//        GDataXMLElement * newValueEle = [GDataXMLElement elementWithName:value stringValue:model.Value];
//        [newBloodSugarEle addAttribute:newTimePerEle];
//        [newBloodSugarEle addAttribute:newTimespanEle];
//        [newBloodSugarEle addChild:newValueEle];
//        [recordEle addChild:newBloodSugarEle];
        NSString * xpath1 = [NSString stringWithFormat:@"./BloodSugar[@timeper='%@']",model.timeper];
      GDataXMLElement* bloodSaugarEle = [[recordEle nodesForXPath:xpath1 error:nil]firstObject];
        if (bloodSaugarEle) {
          GDataXMLElement * valueEle = [[bloodSaugarEle elementsForName:value]firstObject];
            [valueEle setStringValue:model.Value];
        }else{
            GDataXMLElement * newBloodSugarEle = [GDataXMLElement elementWithName:SUGAR_BloodSugar];
            GDataXMLElement * newTimePerEle = [GDataXMLElement attributeWithName:SUGAR_timeper stringValue:model.timeper];
            GDataXMLElement * newTimespanEle = [GDataXMLElement attributeWithName:SUGAR_timespan stringValue:model.timespan];
            GDataXMLElement * newValueEle = [GDataXMLElement elementWithName:value stringValue:model.Value];
            [newBloodSugarEle addAttribute:newTimePerEle];
            [newBloodSugarEle addAttribute:newTimespanEle];
            [newBloodSugarEle addChild:newValueEle];
            [recordEle addChild:newBloodSugarEle];
        }
    }else{
        GDataXMLElement * newRecordEle = [GDataXMLElement elementWithName:Record];
        GDataXMLElement * newDateEle = [GDataXMLElement attributeWithName:FOODDATE stringValue:model.date];
        GDataXMLElement * newBloodSugarEle = [GDataXMLElement elementWithName:SUGAR_BloodSugar];
        GDataXMLElement * newTimePerEle = [GDataXMLElement attributeWithName:SUGAR_timeper stringValue:model.timeper];
        GDataXMLElement * newTimespanEle = [GDataXMLElement attributeWithName:SUGAR_timespan stringValue:model.timespan];
        GDataXMLElement * newValueEle = [GDataXMLElement elementWithName:value stringValue:model.Value];
        GDataXMLElement * newUpdtimeEle = [GDataXMLElement elementWithName:upDataTime stringValue:model.UpdTime];
        
        [newBloodSugarEle addAttribute:newTimePerEle];
        [newBloodSugarEle addAttribute:newTimespanEle];
        [newBloodSugarEle addChild:newValueEle];
        [newRecordEle addChild:newBloodSugarEle];
        [newRecordEle addAttribute:newDateEle];
        [newRecordEle addChild:newUpdtimeEle];
        [rootEle addChild:newRecordEle];
    }
    NSString * content = [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
    return [self isCreateFile:fileName andContent:content];
}
+ (void)saveBloodSugarWithUID:(NSString *)userId withModelArray:(NSArray*)modelArray andDate:(NSString*)dateTime{
    NSString * fileName = [userId stringByAppendingString:SUGAR_RECORD_FILE];
    NSData * fileData = [self findFileWithUserId:userId andSubfix:SUGAR_RECORD_FILE];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
//    BloodSugarModel * model = [modelArray firstObject];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",dateTime];
    GDataXMLElement * recordEle = [[rootEle nodesForXPath:xpath error:nil]firstObject];
    [rootEle removeChild:recordEle];
    NSString * content = [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
    [self isCreateFile:fileName andContent:content];    
    for (BloodSugarModel * modelBlood in modelArray) {
        [self saveBloodSugarWithUID:userId andModel:modelBlood];
    }
   }

/**********************************健康日记 - 体征*******************************/
#pragma mark 健康日记 - 体征
/**
 * 将 获取的 体征数据写入本地  _bodysign_record.xml
 * userId： 用户id
 * systemData：请求获取到的数据
*/
+ (BOOL)writeBodySignWithUID:(NSString*)userId SystemData:(NSData*)systemData{
    NSString * fileName = [userId stringByAppendingString:BODYSIGN_RECORD_FILE];
//    NSData * fileData = [self findFileWithUserId:userId andSubfix:BODYSIGN_RECORD_FILE];
//    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
//    GDataXMLElement * file_root = [fileDoc rootElement];
//    GDataXMLDocument * sys_Doc = [[GDataXMLDocument alloc]initWithData:systemData options:8 error:nil];
//    GDataXMLElement * sys_root = [sys_Doc rootElement];
//    GDataXMLElement * sys_data = [[sys_root elementsForName:DATA]firstObject];
//    NSArray * sys_recordArray = [sys_data elementsForName:Record];
//    for (GDataXMLElement * sys_recordEle in sys_recordArray) {
//        NSString * date = [[sys_recordEle attributeForName:FOODDATE] stringValue];
//        NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",date];
//        NSArray *  file_recordArray = [file_root nodesForXPath:xpath error:nil] ;
//        if (file_recordArray.count) {
//            GDataXMLElement * file_recordEle = [file_recordArray firstObject];
//            [file_root removeChild:file_recordEle];
//            [file_root addChild:sys_recordEle];
//            
//        }else{
//            [file_root addChild:sys_recordEle];
//        }
//    }
    NSString * content = [self writeWithUID:userId andData:systemData andFileChildName:BODYSIGN_RECORD_FILE];
    return [self isCreateFile:fileName andContent: content];
}
/**
 * 将 编辑的体征数据保存到本地
 *userId：用户id
 *model： 体征模型
 */
+ (BOOL)saveBodySignWithUID:(NSString*)userId AndModel:(BodySignModel*)model{
    NSString * fileName = [userId stringByAppendingString:BODYSIGN_RECORD_FILE];
    NSData * fileData = [self findFileWithUserId:userId andSubfix:BODYSIGN_RECORD_FILE];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",model.date];
    GDataXMLElement * recordEle = [[rootEle nodesForXPath:xpath error:nil] firstObject];
    NSString * weightStr = [[[recordEle elementsForName:BODYSIGN_RECORD_DBP] firstObject]stringValue];
    NSString * dbpStr = [[[recordEle elementsForName:BODYSIGN_RECORD_Weight] firstObject]stringValue];
    NSString * sbpStr = [[[recordEle elementsForName:BODYSIGN_RECORD_SBP] firstObject]stringValue];
    [rootEle removeChild:recordEle];
    
    
    
    GDataXMLElement * newRecordEle = [GDataXMLElement elementWithName:Record];
    GDataXMLElement * dateAttrebute = [GDataXMLElement attributeWithName:FOODDATE stringValue:model.date];
    [newRecordEle addAttribute:dateAttrebute];
    GDataXMLElement * updtimeEle = [GDataXMLElement elementWithName:upDataTime stringValue:model.UpdTime];
    GDataXMLElement * weightEle = nil;
    if (model.Weight) {
         weightEle  = [GDataXMLElement elementWithName:BODYSIGN_RECORD_Weight stringValue:model.Weight];
    }else{
     weightEle  = [GDataXMLElement elementWithName:BODYSIGN_RECORD_Weight stringValue:weightStr];
    }
    
    GDataXMLElement * dbpEle = nil;
    if (model.DBP) {
        dbpEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_DBP stringValue:model.DBP];
    }else{
        dbpEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_DBP stringValue:dbpStr];
    }
    
    GDataXMLElement * sbpEle = nil;
    if (model.SBP) {
         sbpEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_SBP stringValue:model.SBP];
    }else{
    sbpEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_SBP stringValue:sbpStr];
    }
    GDataXMLElement * temperatureEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_Temperature stringValue:model.Temperature];
    GDataXMLElement * cholEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_BlipidChol stringValue:model.BlipidChol];
    GDataXMLElement * pidtgEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_BlipidTG stringValue:model.BlipidTG];
    GDataXMLElement * pidHDEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_BlipidHDLIP stringValue:model.BlipidHDLIP];
    GDataXMLElement * pidLDEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_BlipidLDLIP stringValue:model.BlipidLDLIP];
    GDataXMLElement * glyEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_GlyHemoglobin stringValue:model.GlyHemoglobin];
    GDataXMLElement * totalEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_TotalBilirubin stringValue:model.TotalBilirubin];
    GDataXMLElement * directEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_DirectBilirubin stringValue:model.DirectBilirubin];
    GDataXMLElement * serEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_SerumCreatinine stringValue:model.SerumCreatinine];
    GDataXMLElement * uricELe = [GDataXMLElement elementWithName:BODYSIGN_RECORD_UricAcid stringValue:model.UricAcid];
    GDataXMLElement * mialbumEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_MiAlbuminuria stringValue:model.MiAlbuminuria];
    GDataXMLElement * fundusEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_Fundus stringValue:model.Fundus];
    GDataXMLElement * planEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_Plantar stringValue:model.Plantar];
    [newRecordEle addChild:updtimeEle];
    [newRecordEle addChild:weightEle];
    [newRecordEle addChild:dbpEle];
    [newRecordEle addChild:sbpEle];
    [newRecordEle addChild:temperatureEle];
    [newRecordEle addChild:cholEle];
    [newRecordEle addChild:pidtgEle];
    [newRecordEle addChild:pidHDEle];
    [newRecordEle addChild:pidLDEle];
    [newRecordEle addChild:glyEle];
    [newRecordEle addChild:totalEle];
    [newRecordEle addChild:directEle];
    [newRecordEle addChild:serEle];
    [newRecordEle addChild:uricELe];
    [newRecordEle addChild:mialbumEle];
    [newRecordEle addChild:fundusEle];
    [newRecordEle addChild:planEle];
    [rootEle addChild:newRecordEle];
  return  [self isCreateFile:fileName andContent: [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding]];
//    return YES;
}
/**
 * 修改用户 体重 和 血压
 * userId：用户id
 * dbp：舒张压
 * sbp:收缩压
 * date:日期
 */
+ (BOOL)saveBodySignWith:(NSString*)userId andWeight:(NSString*)weight DBP:(NSString*)dbp SBP:(NSString*)sbp andDate:(NSString*)date{
    NSString * fileName = [userId stringByAppendingString:BODYSIGN_RECORD_FILE];
    NSData * fileData = [self findFileWithUserId:userId andSubfix:BODYSIGN_RECORD_FILE];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",date];
    NSArray * recordArray = [rootEle nodesForXPath:xpath error:nil];
    NSString * updTime = [self getNowUpdTime];
    if (recordArray.count) {
        GDataXMLElement * recordEle = [recordArray firstObject];
       GDataXMLElement * weightEle = [[recordEle elementsForName:BODYSIGN_RECORD_Weight]firstObject];
        if (weightEle != nil) {
            [weightEle setStringValue:weight];
        }else{
            GDataXMLElement * newWeightEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_Weight stringValue:weight];
            [recordEle addChild:newWeightEle];
        }
        GDataXMLElement * dbpEle = [[recordEle elementsForName:BODYSIGN_RECORD_DBP]firstObject];
        if (dbpEle != nil) {
            [dbpEle setStringValue:dbp];
        }else{
            GDataXMLElement * newDbpEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_DBP stringValue:dbp];
            [recordEle addChild:newDbpEle];
        }
        GDataXMLElement * sbpEle = [[recordEle elementsForName:BODYSIGN_RECORD_SBP]firstObject];
        if (sbpEle != nil) {
            [sbpEle setStringValue:sbp];
        }else{
            GDataXMLElement * newSbpEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_SBP stringValue:sbp];
            [recordEle addChild:newSbpEle];
        }
        GDataXMLElement * updtimeEle = [[recordEle elementsForName:upDataTime]firstObject];
        [updtimeEle setStringValue:updTime];
    }else{
        GDataXMLElement * newRecordEle = [GDataXMLElement elementWithName:Record];
        GDataXMLElement * newDate = [GDataXMLElement attributeWithName:FOODDATE stringValue:date];
        GDataXMLElement * newWeightEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_Weight stringValue:weight];
        GDataXMLElement * newDbpEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_DBP stringValue:dbp];
        GDataXMLElement * newSbpEle = [GDataXMLElement elementWithName:BODYSIGN_RECORD_SBP stringValue:sbp];
        GDataXMLElement * newUpdtime = [GDataXMLElement elementWithName:upDataTime stringValue:updTime];
        [newRecordEle addChild:newUpdtime];
        [newRecordEle addAttribute:newDate];
        [newRecordEle addChild:newWeightEle];
        [newRecordEle addChild:newDbpEle];
        [newRecordEle addChild:newSbpEle];
        [rootEle addChild:newRecordEle];
    }
    NSString * content = [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
    return  [self isCreateFile:fileName andContent:content];
}

/**
 * 读取 用户体征数据
 *userId：用户id
 */
+ (BodySignModel*)readBodySignWithUID:(NSString*)userId withDate:(NSString*)dateString{
    NSString * filename = [userId stringByAppendingString:BODYSIGN_RECORD_FILE];
    NSData * fileData = [self readFileData:filename];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
    
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",dateString];
    
    GDataXMLElement * recordEle = [[rootEle nodesForXPath:xpath error:nil]firstObject];
    if (recordEle) {
        BodySignModel * model = [[BodySignModel alloc]init];
        model.date  = [[recordEle attributeForName:FOODDATE]stringValue];
        model.Weight = [[[recordEle elementsForName:BODYSIGN_RECORD_Weight]firstObject]stringValue];
        model.DBP = [[[recordEle elementsForName:BODYSIGN_RECORD_DBP]firstObject]stringValue];
        model.SBP = [[[recordEle elementsForName:BODYSIGN_RECORD_SBP]firstObject]stringValue];
        model.Temperature = [[[recordEle elementsForName:BODYSIGN_RECORD_Temperature]firstObject]stringValue];
        model.BlipidChol = [[[recordEle elementsForName:BODYSIGN_RECORD_BlipidChol]firstObject]stringValue];
        model.BlipidTG = [[[recordEle elementsForName:BODYSIGN_RECORD_BlipidTG]firstObject]stringValue];
        model.BlipidHDLIP = [[[recordEle elementsForName:BODYSIGN_RECORD_BlipidHDLIP]firstObject]stringValue];
        model.BlipidLDLIP = [[[recordEle elementsForName:BODYSIGN_RECORD_BlipidLDLIP]firstObject]stringValue];
        model.GlyHemoglobin = [[[recordEle elementsForName:BODYSIGN_RECORD_GlyHemoglobin]firstObject]stringValue];
        model.TotalBilirubin = [[[recordEle elementsForName:BODYSIGN_RECORD_TotalBilirubin]firstObject]stringValue];
        model.DirectBilirubin = [[[recordEle elementsForName:BODYSIGN_RECORD_DirectBilirubin]firstObject]stringValue];
        model.UricAcid = [[[recordEle elementsForName:BODYSIGN_RECORD_UricAcid]firstObject]stringValue];
        model.MiAlbuminuria = [[[recordEle elementsForName:BODYSIGN_RECORD_MiAlbuminuria]firstObject]stringValue];
        model.Fundus = [[[recordEle elementsForName:BODYSIGN_RECORD_Fundus]firstObject]stringValue];
        model.Plantar = [[[recordEle elementsForName:BODYSIGN_RECORD_Plantar]firstObject]stringValue];
        return model;
    }
    return nil;
}

/**********************************健康日记 - 用药*******************************/
#pragma mark 用药 记录
/**
 写入网络请求的 用药记录放入本地    [userId]_medication_record.xml
 userId: 用户id
 systemData：网络获取的数据
 */
+ (BOOL)writeMedicineWithUID:(NSString*)userId SystmeData:(NSData*)systemData{
    NSString * fileName = [userId stringByAppendingString:MEDICINE_RECORD_FILE];
//    NSData * fileData = [self findFileWithUserId:userId andSubfix:MEDICINE_RECORD_FILE];
//    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
//    GDataXMLElement * rootEle = [fileDoc rootElement];
//    GDataXMLDocument * sysDoc = [[GDataXMLDocument alloc]initWithData:systemData options:0 error:nil];
//    GDataXMLElement * sys_root = [sysDoc rootElement];
//    GDataXMLElement * sys_data = [[sys_root elementsForName:DATA] firstObject];
//    for (GDataXMLElement * recordEle in sys_data.children) {
//        NSString * sys_date = [[recordEle attributeForName:FOODDATE]stringValue];
//        NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",sys_date];
//        GDataXMLElement* recordArrFile = [[rootEle nodesForXPath:xpath error:nil] firstObject];
//        if (recordArrFile != nil) {
//            [rootEle removeChild:recordArrFile];
//        }
//        [rootEle addChild:recordEle];
//    }
    NSString * content = [self writeWithUID:userId andData:systemData andFileChildName:MEDICINE_RECORD_FILE];
    
  return [self isCreateFile:fileName andContent:content];
}
/**
 读取用户 用药记录             [userId]_medication_record.xml
 返回用药记录模型
 */
+ (NSArray*)readMedicineRecordWithUID:(NSString *)userId AndDate:(NSString*)date{
    NSString * fileName = [userId stringByAppendingString:MEDICINE_RECORD_FILE];
    NSData * fileData = [self readFileData:fileName];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:9 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",date];
    
    NSArray * recordArr = [rootEle nodesForXPath:xpath error:nil];
    
    NSMutableArray * array = [NSMutableArray array];
    for (GDataXMLElement * recordEle in recordArr) {
        NSString * date = [[recordEle attributeForName:FOODDATE] stringValue];
        NSString * updtime = [[[recordEle elementsForName:upDataTime] firstObject] stringValue];
     NSArray * MedicationArray = [recordEle elementsForName:MEDICINE_RECORD_Medication];
        for (GDataXMLElement * childEle in MedicationArray) {
            MedicineRecordModel * model = [[MedicineRecordModel alloc]init];
            model.date = date;
            model.recid = [[childEle attributeForName:MEDICINE_RECID] stringValue];
            model.updtime = updtime;
            model.MedName = [[[childEle elementsForName:MEDICINE_RECORD_MEDNAME]firstObject]stringValue];
            model.AmountTimes = [[[childEle elementsForName:MEDICINE_RECORD_AmountTimes]firstObject]stringValue];
            model.AMountUnit = [[[childEle elementsForName:MEDICINE_RECORD_AMountUnit]firstObject]stringValue];
            model.UnitName = [[[childEle elementsForName:MEDICINE_RECORD_UnitName]firstObject]stringValue];
            model.Notes = [[[childEle elementsForName:MEDICINE_RECORD_Notes]firstObject]stringValue];
            [array addObject:model];
        }
    }
    return array;
}

/**
 *写入用药记录；
 *data：数据；
 */
+(BOOL)writeyaoRecordMedicineID:(NSString *)medicineID MedName:(NSString *)MedName AmountTimes:(NSString *)AmountTimes AMountUnit:(NSString *)AMountUnit UnitName:(NSString *)UnitName Notes:(NSString *)Notes UpdTime:(NSString *)UpdTime{
    //    NSLog(@"%@",NSHomeDirectory());
    NSString *fileName = medicineWriteRecord;
    
    NSData * fileData = [self findFileWithUserId:nil andSubfix:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    
    GDataXMLElement * rootEle = [doc rootElement];
    GDataXMLElement * record= [GDataXMLElement elementWithName:Record];
    
    [rootEle addChild:record];
    NSArray *recordArray = [rootEle elementsForName:Record];
    for (GDataXMLElement * record in recordArray) {
        GDataXMLElement * updatatime = [GDataXMLElement elementWithName:upDataTime stringValue:UpdTime];
        [record addChild:updatatime];
        GDataXMLElement * medication = [GDataXMLElement elementWithName:Medication ];
        [record addChild:medication];
        GDataXMLElement * amountTimes = [GDataXMLElement elementWithName:amountTime stringValue:AmountTimes];
        [record addChild:amountTimes];
    }
    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:doc.XMLData encoding:NSUTF8StringEncoding]];
}
/**
 * 保存 用药数据
 * userId：用户id
 * model：用药模型
 */
+ (BOOL)writeMedicineRecordWithUID:(NSString *)userId AndModel:(MedicineRecordModel*)model {
    NSString * fileName = [userId stringByAppendingString:MEDICINE_RECORD_FILE];
    NSData * fileData = [self findFileWithUserId:userId andSubfix:MEDICINE_RECORD_FILE];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
    NSArray * recordArray = [rootEle elementsForName:Record];
    for (GDataXMLElement * recordEle in recordArray) {
        if ([[[recordEle attributeForName:USERTARGET_DATE]stringValue] isEqualToString:model.date]) {
       NSArray * medicationArray = [recordEle elementsForName:MEDICINE_RECORD_Medication];
            for (GDataXMLElement * medicationEle in medicationArray) {
              NSString * medicineName = [[[medicationEle elementsForName:MEDICINE_RECORD_MEDNAME]firstObject]stringValue];
                if ([medicineName isEqualToString:model.MedName]) {
                    model.recid = [[medicationEle attributeForName:MEDICINE_RECID] stringValue];
                    [recordEle removeChild:medicationEle];
                    GDataXMLNode * medicineAttribute = [GDataXMLElement attributeWithName:MEDICINE_RECID stringValue:model.recid];
                    GDataXMLElement *  medicineMedicatior = [GDataXMLElement elementWithName:MEDICINE_RECORD_Medication];
                    [medicineMedicatior addAttribute:medicineAttribute];
                    GDataXMLElement * medicineMedname = [GDataXMLElement elementWithName:MEDICINE_RECORD_MEDNAME stringValue:model.MedName];
                    GDataXMLElement * medicineAmountTimes = [GDataXMLElement elementWithName:MEDICINE_RECORD_AmountTimes stringValue:model.AmountTimes];
                    GDataXMLElement * medicineAmountUnit = [GDataXMLElement elementWithName:MEDICINE_RECORD_AMountUnit stringValue:model.AMountUnit];
                    GDataXMLElement * medicineUnitName = [GDataXMLElement elementWithName:MEDICINE_RECORD_UnitName stringValue:model.UnitName];
                    GDataXMLElement * medicineNotes = [GDataXMLElement elementWithName:MEDICINE_RECORD_Notes stringValue:model.Notes];
                    [medicineMedicatior addChild:medicineMedname];
                    [medicineMedicatior addChild:medicineAmountTimes];
                    [medicineMedicatior addChild:medicineAmountUnit];
                    [medicineMedicatior addChild:medicineUnitName];
                    [medicineMedicatior addChild:medicineNotes];
                    [recordEle addChild:medicineMedicatior];
                    GDataXMLElement * updtimeEle = [[recordEle elementsForName:upDataTime]firstObject];
                    [updtimeEle setStringValue:model.updtime];
                    NSString * fileStr = [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
                    return [self isCreateFile:fileName andContent:fileStr];
                }
            }
//            没有
            NSString * recid = nil;
            if (medicationArray.count < 10) {
                recid = [NSString stringWithFormat:@"%02ld",(medicationArray.count +1)];
            }else{
                recid  = [NSString stringWithFormat:@"%ld",(medicationArray.count +1)];
            }
            model.recid = recid;
            GDataXMLNode * medicineAttribute = [GDataXMLElement attributeWithName:MEDICINE_RECID stringValue:model.recid];
            GDataXMLElement *  medicineMedicatior = [GDataXMLElement elementWithName:MEDICINE_RECORD_Medication];
            [medicineMedicatior addAttribute:medicineAttribute];
            GDataXMLElement * medicineMedname = [GDataXMLElement elementWithName:MEDICINE_RECORD_MEDNAME stringValue:model.MedName];
            GDataXMLElement * medicineAmountTimes = [GDataXMLElement elementWithName:MEDICINE_RECORD_AmountTimes stringValue:model.AmountTimes];
            GDataXMLElement * medicineAmountUnit = [GDataXMLElement elementWithName:MEDICINE_RECORD_AMountUnit stringValue:model.AMountUnit];
            GDataXMLElement * medicineUnitName = [GDataXMLElement elementWithName:MEDICINE_RECORD_UnitName stringValue:model.UnitName];
            GDataXMLElement * medicineNotes = [GDataXMLElement elementWithName:MEDICINE_RECORD_Notes stringValue:model.Notes];
            [medicineMedicatior addChild:medicineMedname];
            [medicineMedicatior addChild:medicineAmountTimes];
            [medicineMedicatior addChild:medicineAmountUnit];
            [medicineMedicatior addChild:medicineUnitName];
            [medicineMedicatior addChild:medicineNotes];
            [recordEle addChild:medicineMedicatior];
            GDataXMLElement * updtimeEle = [[recordEle elementsForName:upDataTime]firstObject];
            [updtimeEle setStringValue:model.updtime];

            NSString * fileStr = [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
            return [self isCreateFile:fileName andContent:fileStr];
        }
    }
//    未找到相同日期
    GDataXMLElement * recordEle = [GDataXMLElement elementWithName:Record];
    GDataXMLNode * dateAttribute = [GDataXMLElement attributeWithName:USERTARGET_DATE stringValue:model.date];
    [recordEle addAttribute:dateAttribute];
    GDataXMLElement * updtimeEle = [GDataXMLElement elementWithName:upDataTime stringValue:model.updtime];
    [recordEle addChild:updtimeEle];
    model.recid = @"01";
    GDataXMLNode * medicineAttribute = [GDataXMLElement attributeWithName:MEDICINE_RECID stringValue:model.recid];
    GDataXMLElement *  medicineMedicatior = [GDataXMLElement elementWithName:MEDICINE_RECORD_Medication];
    [medicineMedicatior addAttribute:medicineAttribute];
    GDataXMLElement * medicineMedname = [GDataXMLElement elementWithName:MEDICINE_RECORD_MEDNAME stringValue:model.MedName];
    GDataXMLElement * medicineAmountTimes = [GDataXMLElement elementWithName:MEDICINE_RECORD_AmountTimes stringValue:model.AmountTimes];
    GDataXMLElement * medicineAmountUnit = [GDataXMLElement elementWithName:MEDICINE_RECORD_AMountUnit stringValue:model.AMountUnit];
    GDataXMLElement * medicineUnitName = [GDataXMLElement elementWithName:MEDICINE_RECORD_UnitName stringValue:model.UnitName];
    GDataXMLElement * medicineNotes = [GDataXMLElement elementWithName:MEDICINE_RECORD_Notes stringValue:model.Notes];
    [medicineMedicatior addChild:medicineMedname];
    [medicineMedicatior addChild:medicineAmountTimes];
    [medicineMedicatior addChild:medicineAmountUnit];
    [medicineMedicatior addChild:medicineUnitName];
    [medicineMedicatior addChild:medicineNotes];
    [recordEle addChild:medicineMedicatior];
    [rootEle addChild:recordEle];
    NSString * fileStr = [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
    return [self isCreateFile:fileName andContent:fileStr];
}
+ (BOOL)writeMedicineRecordWithUID:(NSString *)userId AndModelArray:(NSArray*)medicineArray andDate:(NSString *)dateTime{
    NSString * fileName = [userId stringByAppendingString:MEDICINE_RECORD_FILE];
    NSData * fileData = [self findFileWithUserId:userId andSubfix:MEDICINE_RECORD_FILE];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
//    MedicineRecordModel * model = [medicineArray firstObject];
    
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",dateTime];
    GDataXMLElement * recordEle = [[rootEle nodesForXPath:xpath error:nil]firstObject];
    if (recordEle != nil) {
        [rootEle removeChild:recordEle];
    }
    
    NSString* content = [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
    [self isCreateFile:fileName andContent:content];
    
    BOOL flag = NO;
    for (MedicineRecordModel* childModel in medicineArray) {
      flag = [self writeMedicineRecordWithUID:userId AndModel:childModel];
    }
    return flag;
}
/**
 *  将 邮件数据写入本地
 *
 *  @param userID     用户id
 *  @param serverData 网络获取到的数据
 *
 *  @return 文件存储是否成功
 */
+ (BOOL)writeInnerMailWithUID:(NSString*)userID andServerData:(NSData*)serverData{
    if (serverData == nil) {
        return NO;
    }
    NSString * fileName = [userID stringByAppendingString:USER_INNER_MAIL_FILE];
    NSData * fileData = [self findFileWithUserId:userID andSubfix:USER_INNER_MAIL_FILE];
//    客户端
    GDataXMLDocument * docFile = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [docFile rootElement];
//    服务端
    GDataXMLDocument * docServer = [[GDataXMLDocument alloc]initWithData:serverData options:0 error:nil];
    GDataXMLElement * rootServer = [docServer rootElement];
    GDataXMLElement * dataServer = [[rootServer elementsForName:DATA]firstObject];
    
    GDataXMLElement * updTimeEle = [[rootEle elementsForName:UPDATE_TIME]firstObject];
    if (updTimeEle) {
        [updTimeEle setStringValue:[[[dataServer elementsForName:UPDATE_TIME] firstObject] stringValue]];
        GDataXMLElement * maillistFile = [[rootEle elementsForName:MAIL_LIST]firstObject];
       NSArray * maillistEle = [dataServer elementsForName:MAIL];
        if (!maillistFile) {
            maillistFile = [GDataXMLElement elementWithName:MAIL_LIST];
            [rootEle addChild:maillistFile];
        }
        for (GDataXMLElement * mailEle in maillistEle) {
            NSString * xpath = [NSString stringWithFormat:@"./Mail[@mid='%@']",[[mailEle attributeForName:FoodID] stringValue]];
            GDataXMLElement * nameArray = [[maillistFile nodesForXPath:xpath error:nil] firstObject];
            //            NSLog(@"----%@----",nameArray);
            if (nameArray) {
                [maillistFile removeChild:nameArray];
            }
            GDataXMLElement * openEle = [GDataXMLElement elementWithName:OPENED stringValue:@"false"];
            [mailEle addChild:openEle];
            [maillistFile addChild:mailEle];
        }
    }else{
         NSArray * maillistEle = [dataServer elementsForName:MAIL];
        GDataXMLElement * mailListFile = [GDataXMLElement elementWithName:MAIL_LIST];
        
        [rootEle addChild:[[dataServer elementsForName:UPDATE_TIME] firstObject]];
        
        for (GDataXMLElement * mailEle in maillistEle) {
            GDataXMLElement * openEle = [GDataXMLElement elementWithName:OPENED stringValue:@"false"];
            [mailEle addChild:openEle];
            [mailListFile addChild:mailEle];
        }
        [rootEle addChild:mailListFile];
    }
    GDataXMLDocument * newDoc = [[GDataXMLDocument alloc]initWithRootElement:rootEle];
    [newDoc setVersion:@"1.0"];
    [newDoc setCharacterEncoding:@"UTF-8"];
    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:newDoc.XMLData encoding:NSUTF8StringEncoding]];
}

/**
 *经站内信保存到本地
 *innerMail 站内信
 */
+(BOOL)writeInnerMail:(NSArray *)innerMailArr andUid:(NSString *)uid andNewUpdateTime:(NSString *)newUpdateTime{
    NSString *fileName = [uid stringByAppendingString:USER_INNER_MAIL_FILE];
    NSData * fileData = [self findFileWithUserId:uid andSubfix:USER_INNER_MAIL_FILE];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    
    
    GDataXMLElement *mailListEle = [[rootEle elementsForName:MAIL_LIST] objectAtIndex:0];
    if (!mailListEle) {
         mailListEle = [GDataXMLElement elementWithName:MAIL_LIST];
        [rootEle addChild:mailListEle];
    }
    GDataXMLElement *updateTimeEle = [[rootEle elementsForName:UPDATE_TIME] objectAtIndex:0];
    if (!updateTimeEle) {
        updateTimeEle = [GDataXMLElement elementWithName:UPDATE_TIME stringValue:newUpdateTime];
    }else{
        [updateTimeEle setStringValue:newUpdateTime];
    }
    for (InnerMailModel *innerMail in innerMailArr) {
        
        NSString *pathDataStr = [[NSString alloc] initWithFormat:@"//*[@%@=\"%@\"]",MID,innerMail.mid];
        NSArray *nodeEleArr = [doc nodesForXPath:pathDataStr error:nil];
        if (nodeEleArr.count > 0) {
            [mailListEle removeChild:nodeEleArr[0]];
        }
        GDataXMLElement *mainEle = [GDataXMLElement elementWithName:MAIL];
        //记录id
        GDataXMLElement *midAtt = [GDataXMLElement attributeWithName:MID stringValue:innerMail.mid];
        [mainEle addAttribute:midAtt];
        //已读／未读
        GDataXMLElement *openEle = [GDataXMLElement elementWithName:OPENED stringValue:innerMail.opened];
        [mainEle addChild:openEle];
        //标题
        GDataXMLElement *titleEle = [GDataXMLElement elementWithName:TITLE stringValue:innerMail.title];
        [mainEle addChild:titleEle];
        //正文
        GDataXMLElement *contentEle = [GDataXMLElement elementWithName:CONTENT stringValue:innerMail.content];
        [mainEle addChild:contentEle];
        //发送时间
        GDataXMLElement *sendTimeEle = [GDataXMLElement elementWithName:SEND_TIME stringValue:innerMail.sendTime];
        [mainEle addChild:sendTimeEle];
        //        附件
        GDataXMLElement * AdjunctEle = [GDataXMLElement elementWithName:ADJUNCT stringValue:innerMail.Adjunct];
        
        [mainEle addChild:AdjunctEle];
        //发送者id
        GDataXMLElement *senderIdEle = [GDataXMLElement elementWithName:SENDER_ID stringValue:innerMail.senderId];
        [mainEle addChild:senderIdEle];
        //发送者姓名
        GDataXMLElement *senderNameEle = [GDataXMLElement elementWithName:SENDER_NAME stringValue:innerMail.senderName];
        [mainEle addChild:senderNameEle];
        [mailListEle addChild:mainEle];
    }
    
    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:doc.XMLData encoding:NSUTF8StringEncoding]];
}
+(BOOL)writeInnerMail:(NSArray *)innerMailArr andUid:(NSString *)uid{
    NSString *fileName = [uid stringByAppendingString:USER_INNER_MAIL_FILE];
    
    NSData * fileData = [self findFileWithUserId:uid andSubfix:USER_INNER_MAIL_FILE];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    
    GDataXMLElement *mailListEle = [[rootEle elementsForName:MAIL_LIST] objectAtIndex:0];
    for (InnerMailModel *innerMail in innerMailArr) {
        NSString *pathDataStr = [[NSString alloc] initWithFormat:@"//*[@%@=\"%@\"]",MID,innerMail.mid];
        NSArray *nodeEleArr = [doc nodesForXPath:pathDataStr error:nil];
        if (nodeEleArr.count > 0) {
            [mailListEle removeChild:nodeEleArr[0]];
        }
        GDataXMLElement *mainEle = [GDataXMLElement elementWithName:MAIL];
        //记录id
        GDataXMLElement *midAtt = [GDataXMLElement attributeWithName:MID stringValue:innerMail.mid];
        [mainEle addAttribute:midAtt];
        //已读／未读
        GDataXMLElement *openEle = [GDataXMLElement elementWithName:OPENED stringValue:[UtilCommon boolValueOfStr:innerMail.opened]];
        [mainEle addChild:openEle];
        //标题
        GDataXMLElement *titleEle = [GDataXMLElement elementWithName:TITLE stringValue:innerMail.title];
        [mainEle addChild:titleEle];
        //正文
        GDataXMLElement *contentEle = [GDataXMLElement elementWithName:CONTENT stringValue:innerMail.content];
        [mainEle addChild:contentEle];
        //发送时间
        GDataXMLElement *sendTimeEle = [GDataXMLElement elementWithName:SEND_TIME stringValue:innerMail.sendTime];
        [mainEle addChild:sendTimeEle];
        //        附件
        GDataXMLElement * AdjunctEle = [GDataXMLElement elementWithName:ADJUNCT stringValue:innerMail.Adjunct];
        [mainEle addChild:AdjunctEle];
        //发送者id
        GDataXMLElement *senderIdEle = [GDataXMLElement elementWithName:SENDER_ID stringValue:innerMail.senderId];
        [mainEle addChild:senderIdEle];
        //发送者姓名
        GDataXMLElement *senderNameEle = [GDataXMLElement elementWithName:SENDER_NAME stringValue:innerMail.senderName];
        [mainEle addChild:senderNameEle];
        [mailListEle addChild:mainEle];
    }
    
    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:doc.XMLData encoding:NSUTF8StringEncoding]];
}

/**
 *经站内信保存到本地
 *innerNotice 站内信
 */
+(BOOL)writeInnerNotice:(NSArray *)innerNoticeArr andUid:(NSString *)uid andNewUpdateTime:(NSString *)newUpdateTime{
    NSString *fileName = [uid stringByAppendingString:USER_INNER_MAIL_FILE];
    
    NSData * fileData = [self findFileWithUserId:uid andSubfix:USER_INNER_MAIL_FILE];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    
    GDataXMLElement *notifyListEle = [[rootEle elementsForName:NOTIFY_LIST] objectAtIndex:0];
    
    NSArray * noticeArray = [notifyListEle elementsForName:NOTIFY];
    
    NSMutableArray * localNotArray = [NSMutableArray array];
    for (GDataXMLElement *ele in noticeArray) {
        InnerNoticeModel *innerNotice = [[InnerNoticeModel alloc] init];
        
        innerNotice.mid = [[ele attributeForName:MID] stringValue];
        innerNotice.title = [[[ele elementsForName:TITLE] objectAtIndex:0] stringValue];
        innerNotice.content = [[[ele elementsForName:CONTENT] objectAtIndex:0] stringValue];
        innerNotice.sendTime = [[[ele elementsForName:SEND_TIME] objectAtIndex:0] stringValue];
        
        [localNotArray addObject:innerNotice];
    }
    
    for (InnerNoticeModel *innerNotice in localNotArray) {
        NSString *pathDataStr = [[NSString alloc] initWithFormat:@"//*[@%@=\"%@\"]",MID,innerNotice.mid];
        NSArray *nodeEleArr = [doc nodesForXPath:pathDataStr error:nil];
        if (nodeEleArr.count>0) {
            [notifyListEle removeChild:nodeEleArr[0]];
        }
    }
    
    for (InnerNoticeModel *innerNotice in innerNoticeArr) {
        NSString *pathDataStr = [[NSString alloc] initWithFormat:@"//*[@%@=\"%@\"]",MID,innerNotice.mid];
        NSArray *nodeEleArr = [doc nodesForXPath:pathDataStr error:nil];
        if (nodeEleArr.count > 0) {
            [notifyListEle removeChild:nodeEleArr[0]];
        }
        GDataXMLElement *mainEle = [GDataXMLElement elementWithName:NOTIFY];
        //记录id
        GDataXMLElement *midAtt = [GDataXMLElement attributeWithName:MID stringValue:innerNotice.mid];
        [mainEle addAttribute:midAtt];
        //标题
        GDataXMLElement *titleEle = [GDataXMLElement elementWithName:TITLE stringValue:innerNotice.title];
        [mainEle addChild:titleEle];
        //正文
        GDataXMLElement *contentEle = [GDataXMLElement elementWithName:CONTENT stringValue:innerNotice.content];
        [mainEle addChild:contentEle];
        //发送时间
        GDataXMLElement *sendTimeEle = [GDataXMLElement elementWithName:SEND_TIME stringValue:innerNotice.sendTime];
        [mainEle addChild:sendTimeEle];
        [notifyListEle addChild:mainEle];
    }
    
    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:doc.XMLData encoding:NSUTF8StringEncoding]];
}


+(BOOL)writeInnerNoticeUid:(NSString *)uid andNewUpdateTime:(NSString *)newUpdateTime{
    NSString *fileName = [uid stringByAppendingString:USER_INNER_NOTICE_FILE];
    NSData * fileData = [self findFileWithUserId:uid andSubfix:USER_INNER_NOTICE_FILE];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    GDataXMLElement *updateTimeEle = [[rootEle elementsForName:UPDATE_TIME] objectAtIndex:0];
    [updateTimeEle setStringValue:newUpdateTime];
    GDataXMLElement *ignoreEle = [[rootEle elementsForName:IGNORE] objectAtIndex:0];
    [ignoreEle setStringValue:@"0"];
    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:doc.XMLData encoding:NSUTF8StringEncoding]];
}

+(NSString *)requestIgnoreWithUid:(NSString *)uid{
    NSString *fileName = [uid stringByAppendingString:USER_INNER_NOTICE_FILE];
    NSData *fileData = [self readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    
    //GDataXMLElement *ignoreEle = [[rootEle elementsForName:IGNORE] objectAtIndex:0];
    NSString * ignore =[[[rootEle elementsForName:IGNORE] objectAtIndex:0] stringValue];
    return ignore;
}

+(NSArray *)getlocalNocticByUid:(NSString *)uid{
    NSString *fileName = [uid stringByAppendingString:USER_INNER_NOTICE_FILE];
    NSData *fileData = [self readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    GDataXMLElement *notifyListEle = [[rootEle elementsForName:NOTIFY_LIST] objectAtIndex:0];
    NSArray * noticeArray = [notifyListEle elementsForName:NOTIFY];
    
    NSMutableArray * localNotArray = [NSMutableArray array];
    
    for (GDataXMLElement *ele in noticeArray) {
        InnerNoticeModel *innerNotice = [[InnerNoticeModel alloc] init];
        innerNotice.mid = [[ele attributeForName:MID] stringValue];
        innerNotice.title = [[[ele elementsForName:TITLE] objectAtIndex:0] stringValue];
        innerNotice.content = [[[ele elementsForName:CONTENT] objectAtIndex:0] stringValue];
        innerNotice.sendTime = [[[ele elementsForName:SEND_TIME] objectAtIndex:0] stringValue];
        
        [localNotArray addObject:innerNotice];
    }
    
    
    return localNotArray;
}
/**
 *读取本地站内信
 *uid 用户id
 *返回会站内信数组
 */
+(NSMutableArray *)readInnerMail:(NSString *)uid andPageNumber:(int)pageNumber{
    NSString *fileName = [uid stringByAppendingString:USER_INNER_MAIL_FILE];
    if (![self hasFile:fileName]) {
        return nil;
    }
    NSData *fileData = [self readFileData:fileName];
    if (fileData == nil) {
        return nil;
    }
    NSMutableArray *innerMailArr = [[NSMutableArray alloc] init];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    GDataXMLElement *mailListEle = [[rootEle elementsForName:MAIL_LIST] objectAtIndex:0];
    NSArray *mailArr = [mailListEle elementsForName:MAIL];
    
    NSArray *sortedArray = [NSArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // NSString *type = @"time";
    sortedArray = [mailArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSComparisonResult result = [[NSNumber numberWithInteger:[[dateFormatter dateFromString:[[[obj2 elementsForName:SEND_TIME] objectAtIndex:0] stringValue]] timeIntervalSinceNow]] compare:[NSNumber numberWithInteger:[[dateFormatter dateFromString:[[[obj1 elementsForName:SEND_TIME] objectAtIndex:0] stringValue]] timeIntervalSinceNow]]];
        return result;
    }];
    
    NSMutableArray * remailArray = [NSMutableArray array];
    for (int i=0; i<sortedArray.count; i++) {
        if (i>=(pageNumber-1)*10 && i<(pageNumber-1)*10+10) {
            [remailArray addObject:[sortedArray objectAtIndex:i]];
        }
    }
    for (GDataXMLElement *mailEle in remailArray) {
        InnerMailModel *innerMail = [[InnerMailModel alloc] init];
        innerMail.mid = [[mailEle attributeForName:MID] stringValue];
        innerMail.opened =[[[mailEle elementsForName:OPENED] objectAtIndex:0] stringValue];
        innerMail.title = [[[mailEle elementsForName:TITLE] objectAtIndex:0] stringValue];
        innerMail.content = [[[mailEle elementsForName:CONTENT] objectAtIndex:0] stringValue];
        innerMail.sendTime = [[[mailEle elementsForName:SEND_TIME] objectAtIndex:0] stringValue];
        innerMail.senderId = [[[mailEle elementsForName:SENDER_ID] objectAtIndex:0] stringValue];
        innerMail.senderName = [[[mailEle elementsForName:SENDER_NAME] objectAtIndex:0] stringValue];
        innerMail.Adjunct = [[[mailEle elementsForName:ADJUNCT]objectAtIndex:0]stringValue];
        
        [innerMailArr addObject:innerMail];
    }
    
    return innerMailArr;
}

/**
 *读取本地站内信
 *uid 用户id
 *返回会站内信数组
 */
+(NSArray *)readInnerMail:(NSString *)uid{
    NSString *fileName = [uid stringByAppendingString:USER_INNER_MAIL_FILE];
    if (![self hasFile:fileName]) {
        return nil;
    }
    NSData *fileData = [self readFileData:fileName];
    if (fileData == nil) {
        return nil;
    }
    NSMutableArray *innerMailArr = [[NSMutableArray alloc] init];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    GDataXMLElement *mailListEle = [[rootEle elementsForName:MAIL_LIST] objectAtIndex:0];
    NSArray *mailArr = [mailListEle elementsForName:MAIL];
    
    for (GDataXMLElement *mailEle in mailArr) {
        InnerMailModel *innerMail = [[InnerMailModel alloc] init];
        
        innerMail.mid = [[mailEle attributeForName:MID] stringValue];
        innerMail.opened =[[[mailEle elementsForName:OPENED] objectAtIndex:0] stringValue];
        innerMail.title = [[[mailEle elementsForName:TITLE] objectAtIndex:0] stringValue];
        innerMail.content = [[[mailEle elementsForName:CONTENT] objectAtIndex:0] stringValue];
        innerMail.sendTime = [[[mailEle elementsForName:SEND_TIME] objectAtIndex:0] stringValue];
        innerMail.senderId = [[[mailEle elementsForName:SENDER_ID] objectAtIndex:0] stringValue];
        innerMail.senderName = [[[mailEle elementsForName:SENDER_NAME] objectAtIndex:0] stringValue];
        [innerMailArr addObject:innerMail];
    }
    return innerMailArr;
}
/**
 *读取本地站内信最后更新时间
 *uid 用户id
 */
+(NSString *)readInnerMailUpdateTime:(NSString *)uid{
    NSString *fileName = [uid stringByAppendingString:USER_INNER_MAIL_FILE];
    if (![self hasFile:fileName]) {
        return nil;
    }
    NSData *fileData = [self readFileData:fileName];
    if (fileData == nil) {
        return nil;
    }
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    
    return [[[rootEle elementsForName:UPDATE_TIME] objectAtIndex:0] stringValue];
}

//将获取到的站内信或者公告的附件写入到本地
+(BOOL)writeNoticeAdjtoLocal:(NSData *)data UID:(NSString *)uid{
    
    NSString *fileName = [uid stringByAppendingString:@"_NoticeAdj"];
    if (![self hasFile:fileName]) {
        return NO;
    }
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取document路径
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    BOOL  isCreateFile = [fileManager createFileAtPath:filePath contents:data attributes:nil];
    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    return isCreateFile;
}
//将获取到基准数据写入到本地
+(BOOL)writegetBaselineData:(NSMutableArray *)dataArray dataTime:(NSString *)dataTime{
    NSString *fileName = BaselineFileName;
    NSData * fileData = [self findFileWithUserId:nil andSubfix:BaselineFileName];
    
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [doc rootElement];
    //移除所有元素
    for (GDataXMLElement *ele in rootEle.children) {
        [rootEle removeChild:ele];
    }
    
    GDataXMLElement *dataTimeEle = [GDataXMLElement elementWithName:DATATIME stringValue:dataTime];
    [rootEle addChild:dataTimeEle];
    
    for (int i = 0; i < dataArray.count;  i ++) {
        GDataXMLElement * BaselineEle = [GDataXMLElement elementWithName:Baseline];
        baseLineModel * model  = dataArray[i];
        GDataXMLElement *  nameEle = [GDataXMLElement elementWithName:NAME stringValue:model.Name];
        [BaselineEle addChild:nameEle];
        GDataXMLElement * valueEle = [GDataXMLElement elementWithName:value stringValue:model.Value];
        [BaselineEle addChild:valueEle];
        GDataXMLElement * BackupEle = [GDataXMLElement elementWithName:Backup stringValue:model.Backup];
        [BaselineEle addChild:BackupEle];
        GDataXMLElement * codeAtr = [GDataXMLElement attributeWithName:@"code" stringValue:model.code];
        [BaselineEle addAttribute:codeAtr];
        [rootEle addChild:BaselineEle];
    }
    
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:rootEle];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"utf-8"];
    //创建文件
    return [FileUtils isCreateFile:fileName andContent:[[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding]];
}
/*
 从本地取出基准数据
 返回值：model的数组
 */
+(NSMutableArray *)ReadBaseLineData{
    NSData *data = [FileUtils readFileData:BaselineFileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    NSArray * baseLineEleArray = [rootEle elementsForName:Baseline];
    NSMutableArray * marray = [[NSMutableArray alloc]init];
    for (int i = 0; i < baseLineEleArray.count; i ++) {
        GDataXMLElement * ele = baseLineEleArray[i];
        baseLineModel * model = [[baseLineModel alloc]init];
        model.Name = [[[ele elementsForName:NAME]firstObject]stringValue];
        model.Value = [[[ele elementsForName:value]firstObject]stringValue];
        model.code = [[ele attributeForName:@"code"]stringValue];
        model.Backup = [[[ele elementsForName:Backup]firstObject]stringValue];
        [marray addObject:model];
    }
    return marray;
}
/*
 利用属性取基准数据节点的模型的数组
 //
 */
+(baseLineModel *)getNodeDataUseCodeAttribute:(NSString *)attribute{
    NSData *data = [FileUtils readFileData:BaselineFileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    //    NSArray * baseLineEleArray = [rootEle elementsForName:Baseline];
    NSString * str = [NSString stringWithFormat:@"./Baseline[@code='%@']",attribute];
    NSArray *aryNode=[rootEle nodesForXPath:str error:nil];
    
    baseLineModel * model = [[baseLineModel alloc]init];
    model.Name = [[[aryNode[0] elementsForName:NAME]firstObject]stringValue];
    model.Backup = [[[aryNode[0]elementsForName:Backup]firstObject]stringValue];
    model.Value = [[[aryNode[0]elementsForName:value]firstObject]stringValue];
    model.code = [[aryNode[0] attributeForName:@"code"]stringValue];
    return model;
}
/*
 将食物推荐列表写入本地
 返回值  是否成功写入数据
 */
+(BOOL)writeFoodListRecommend:(NSData *)data{
    
    NSString *fileName =FOODLISTRECOMMENDFILE;
    NSData * fileData = [self findFileWithUserId:nil andSubfix:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    for (GDataXMLElement * ele in rootEle.children) {
        [rootEle removeChild:ele];
    }
    GDataXMLElement * MenuAdviceEle = [GDataXMLElement elementWithName:MENUADVICE];
    GDataXMLDocument *serverDoc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *serverRoot = [serverDoc rootElement];
    GDataXMLElement *serverDataEle = [[serverRoot elementsForName:DATA] objectAtIndex:0];
    NSString * datatimestr = [[[serverDataEle elementsForName:DATATIME]objectAtIndex:0]stringValue];
    GDataXMLElement * dateEle = [GDataXMLElement elementWithName:FOODDATE stringValue:datatimestr];
    NSString * advicestr = [[[serverDataEle elementsForName:MENUID]objectAtIndex:0]stringValue];
    GDataXMLElement * AdvicEle = [GDataXMLElement elementWithName:ADVICE stringValue:advicestr];
    [AdvicEle addAttribute:dateEle];
    NSString * energylvStr = [[[serverDataEle elementsForName:ENERGYLV]objectAtIndex:0]stringValue];
    GDataXMLElement * energylvEle = [GDataXMLElement elementWithName:FOODRECOMMENDENERGYLV stringValue:energylvStr];
    [AdvicEle addAttribute:energylvEle];
    [MenuAdviceEle addChild:AdvicEle];
    [rootEle addChild:MenuAdviceEle];
    GDataXMLElement * MenuListEle = [GDataXMLElement elementWithName:MENULIST];
    GDataXMLElement * MenuEle = [GDataXMLElement elementWithName:MENU];
    NSString * MenuIdStr = [[[serverDataEle elementsForName:MENUID]objectAtIndex:0]stringValue];
    GDataXMLElement * midAttr = [GDataXMLElement elementWithName:MID stringValue:MenuIdStr];
    [MenuEle addAttribute:midAttr];
    //食物信息节点数组
    NSArray * FoodInfoEleArray = [serverDataEle elementsForName:FOODINFO];
    for (int i = 0; i < FoodInfoEleArray.count; i ++) {
        GDataXMLElement * ele  = FoodInfoEleArray[i];
        NSString * FoodIdstr = [[[ele elementsForName:FoodRequestId]objectAtIndex:0]stringValue];
        NSString * TimePeriodStr = [[[ele elementsForName:TIMEPERIOD]objectAtIndex:0]stringValue];
        NSString * FoodIntakeStr = [[[ele elementsForName:FOODINTAKE]objectAtIndex:0]stringValue];
        GDataXMLElement * foodEle = [GDataXMLElement elementWithName:FOOD];
        GDataXMLElement * fidAttr = [GDataXMLElement elementWithName:FID stringValue:FoodIdstr];
        GDataXMLElement * timeperiodAttr = [GDataXMLElement elementWithName:timeperiodFile stringValue:TimePeriodStr];
        GDataXMLElement * intakeAttr = [GDataXMLElement elementWithName:FOODRECOMMENDINTAKE stringValue:FoodIntakeStr];
        [foodEle addAttribute:fidAttr];
        [foodEle addAttribute: timeperiodAttr];
        [foodEle addAttribute:intakeAttr];
        [MenuEle addChild:foodEle];
        //        [dataELe addChild:ele];
    }
    [MenuListEle addChild:MenuEle];
    [rootEle addChild:MenuListEle];
    return    [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:doc.XMLData encoding:NSUTF8StringEncoding]];
}
/*   通过backup获得value值*/
+(NSString *)getValueUsingcode:(NSString * )code{
    
    NSData *data = [FileUtils readFileData:BaselineFileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    //    NSArray * baseLineEleArray = [rootEle elementsForName:Baseline];
    NSString * str = [NSString stringWithFormat:@"./Baseline[@code='%@']",code];
    NSArray *aryNode=[rootEle nodesForXPath:str error:nil];
    
    
    baseLineModel * model = [[baseLineModel alloc]init];
    //    model.Name = [[[aryNode[0] elementsForName:NAME]firstObject]stringValue];
    //    model.Backup = [[[aryNode[0]elementsForName:Backup]firstObject]stringValue];
    model.Value = [[[aryNode[0]elementsForName:value]firstObject]stringValue];
    //    model.code = [[aryNode[0] attributeForName:@"code"]stringValue];
    return model.Value;
}

/*根据日期和热量等级去取食物推荐列表*/
+(NSMutableArray *)getFoodListRecommendUseDate:(NSString *)date andenergylv:(NSString *)energylv{
    NSData *data = [FileUtils readFileData:FOODLISTRECOMMENDFILE];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    //    两个条件查询  and energylv='%@' energylv
    NSString * str = [NSString stringWithFormat:@"./MenuAdvice/Advice[@date='%@' and @energylv='%@']",date,energylv];
    NSArray *aryNode=[rootEle nodesForXPath:str error:nil];
    
    NSString * advicestr = [[aryNode firstObject] stringValue];
    //取得推荐食谱id
    NSString * foodmenuStr = [NSString stringWithFormat:@"./MenuList/Menu[@mid='%@']",advicestr];
    NSArray *aryNodefoodMenu=[rootEle nodesForXPath:foodmenuStr error:nil];
    
    GDataXMLElement * menuELe = [aryNodefoodMenu firstObject];
    
    NSArray * foodELe = [menuELe elementsForName:FOOD];
    
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < foodELe.count; i ++) {
        
        FoodListRecommendModel * model = [[FoodListRecommendModel alloc]init];
        GDataXMLElement * food = foodELe[i];
        
        model.FoodId = [[food attributeForName:FID]stringValue];
        model.TimePeriod = [[food attributeForName:timeperiodFile]stringValue];
        model.FoodIntake = [[food attributeForName:FOODRECOMMENDINTAKE]stringValue];
        model.MenuId = [[menuELe attributeForName:MID]stringValue];
        [dataArray addObject:model];
    }
    //    NSLog(@"%@dataArray",dataArray);
    return dataArray;
}
/*通过食物的id取得食物的名字*/
+(NSString *)getFoodNameUseFoodID:(NSString *)foodId{
    NSString * fileName = FOOD_DATA_FILE;
    NSData * data = [FileUtils readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    NSString * str = [NSString stringWithFormat:@"./FoodList/Food[@id='%@']",foodId];
    NSArray *aryNode=[rootEle nodesForXPath:str error:nil];
    NSString * foodName = [[[[aryNode firstObject] elementsForName:NAME]firstObject]stringValue];
    return foodName;
}
/**
 获取食物模型  通过 食物foodId
 foodId ： 食物id
 
 */
+ (foodmodel*)getFoodModelWithFoodId:(NSString *)foodId{
    NSString * fileName = FOOD_DATA_FILE;
    NSData * data = [FileUtils readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    NSString * str = [NSString stringWithFormat:@"./FoodList/Food[@id='%@']",foodId];
    NSArray *aryNode=[rootEle nodesForXPath:str error:nil];
    GDataXMLElement * ele = aryNode.firstObject;
    foodmodel * model  = [[foodmodel alloc]init];
    model.FoodCateID = [[ele attributeForName:FoodCateID]stringValue];
    model.foodID = [[ele attributeForName:FoodID]stringValue];
    model.FoodName = [[[ele elementsForName:NAME] objectAtIndex:0] stringValue];
    model.UnitValue = [[[ele elementsForName:UnitValue]objectAtIndex:0]stringValue];
    model.UnitName = [[[ele elementsForName:UnitName]objectAtIndex:0]stringValue];
    model.UnitEnergy = [[[ele elementsForName:UnitEnergy]objectAtIndex:0]stringValue];
    model.UnitGI = [[[ele elementsForName:UnitGI]objectAtIndex:0]stringValue];
    model.UnitH2O = [[[ele elementsForName:UnitH2O]objectAtIndex:0]stringValue];
    model.UnitProtein = [[[ele elementsForName:UnitProtein]objectAtIndex:0]stringValue];
    model.UnitFat = [[[ele elementsForName:UnitFat]objectAtIndex:0]stringValue];
    model.UnitDieFiber = [[[ele elementsForName:UnitDieFiber]objectAtIndex:0]stringValue];
    model.UnitCarbs = [[[ele elementsForName:UnitCarbs]objectAtIndex:0]stringValue];
    model.UnitVA = [[[ele elementsForName:UnitVA]objectAtIndex:0]stringValue];
    model.UnitVB1 = [[[ele elementsForName:UnitVB1]objectAtIndex:0]stringValue];
    model.UnitVB2 = [[[ele elementsForName:UnitVB2]objectAtIndex:0]stringValue];
    model.UnitVC = [[[ele elementsForName:UnitVC]objectAtIndex:0]stringValue];
    model.UnitVE = [[[ele elementsForName:UnitVE]objectAtIndex:0]stringValue];
    model.UnitNiacin = [[[ele elementsForName:UnitNiacin]objectAtIndex:0]stringValue];
    model.UnitNa = [[[ele elementsForName:UnitNa]objectAtIndex:0]stringValue];
    model.UnitCa = [[[ele elementsForName:UnitCa]objectAtIndex:0]stringValue];
    model.UnitFe = [[[ele elementsForName:UnitFe]objectAtIndex:0]stringValue];
    model.UnitChol = [[[ele elementsForName:UnitChol]objectAtIndex:0]stringValue];
    model.DelFlag = [[[ele elementsForName:DelFlag]objectAtIndex:0]stringValue];
    return model;
}

/*将推荐的食谱写入本地
 mid收藏菜单的ID
 收藏时间CrtTime
 备注名Comment
 UserID用户id
 */
+(BOOL)writeFoodMenuToLocalFoodMenuID:(NSString *)mid Comment:(NSString * )comment CrtTime:(NSString *)time UserID:(NSString *)userid{
    NSString *fileName =[NSString stringWithFormat:@"%@%@",userid,FOODFILEMENU];
    NSData * fileData = [self findFileWithUserId:userid andSubfix:FOODFILEMENU];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    
    GDataXMLElement *rootEle = [doc rootElement];
    
    GDataXMLElement * FavoriteELe = [GDataXMLElement elementWithName:FAVORITE];
    
    GDataXMLElement * MIDATTR  = [GDataXMLElement attributeWithName:MID stringValue:mid];
    [FavoriteELe addAttribute:MIDATTR];
    GDataXMLElement * CommentEle = [GDataXMLElement elementWithName:COMMENT stringValue:comment];
    [FavoriteELe addChild:CommentEle];
    GDataXMLElement * CrtTimeEle = [GDataXMLElement elementWithName:CRTTIME stringValue:time];
    [FavoriteELe addChild:CrtTimeEle];
    
    [rootEle addChild:FavoriteELe];
    return    [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:doc.XMLData encoding:NSUTF8StringEncoding]];
}

/*
 将推荐的食谱列表从本地取出
 */
+(NSMutableArray *)getFoodMenuOfFavoriteUserID:(NSString *)userid{
    
    //    NSString *fileName =[NSString stringWithFormat:@"%@%@",userid,FOODFILEMENU];
    NSData * data = [self findFileWithUserId:userid andSubfix:FOODFILEMENU];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    
    NSMutableArray * marray = [[NSMutableArray alloc]init];
    NSArray * FavoriteEleArray = [rootEle elementsForName:FAVORITE];
    for (int i = 0; i < FavoriteEleArray.count; i ++) {
        collectionModel * model = [[collectionModel alloc]init];
        GDataXMLElement * ele =FavoriteEleArray[i];
        
        model.Comment = [[[ele elementsForName:COMMENT]objectAtIndex:0]stringValue];
        model.CrtTime = [[[ele elementsForName:CRTTIME]objectAtIndex:0]stringValue];
        model.mid = [[ele attributeForName:MID]stringValue];
        [marray addObject:model];
    }
    return marray;
}


/*删除某一个节点
 传入节点的食谱名字 xpath查询节点  删除
 返回值：bool值 成功与否
 */
+(BOOL)deleteNodeUseMID:(NSString * )mid andUID:(NSString *)uid{
    NSString *fileName =[NSString stringWithFormat:@"%@%@",uid,FOODFILEMENU];
    
    NSData *fileData = [self readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    
    NSString * str = [NSString stringWithFormat:@"./Favorite[@mid='%@']",mid];
    NSArray *aryNode=[rootEle nodesForXPath:str error:nil];
    [rootEle removeChild:aryNode[0]];
    
    NSLog(@"%@rootele",rootEle);
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:rootEle];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    
    return  [FileUtils isCreateFile:fileName andContent:[[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding]];
}
/*判断是否保存过推荐的食谱*/
+(BOOL)saveRecommendFoodListUsingUID:(NSString *)UID AndMID:(NSString *)mid{
    NSString *fileName =[NSString stringWithFormat:@"%@%@",UID,FOODFILEMENU];
    
    NSData *fileData = [self readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    
    NSString * str = [NSString stringWithFormat:@"./Favorite[@mid='%@']",mid];
    NSArray *aryNode=[rootEle nodesForXPath:str error:nil];
    if (aryNode.count == 0) {
        return YES;
    }else{
        
        return NO;
    }
}

/*根据menuid去取食物推荐列表*/
+(NSMutableArray *)getFoodListRecommendUseMID:(NSString *)mid{
    
    NSData *data = [FileUtils readFileData:FOODLISTRECOMMENDFILE];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    
    //取得推荐食谱id
    NSString * foodmenuStr = [NSString stringWithFormat:@"./MenuList/Menu[@mid='%@']",mid];
    NSArray *aryNodefoodMenu=[rootEle nodesForXPath:foodmenuStr error:nil];
    
    GDataXMLElement * menuELe = aryNodefoodMenu[0];
    
    NSArray * foodELe = [menuELe elementsForName:FOOD];
    NSMutableArray * dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < foodELe.count; i ++) {
        
        FoodListRecommendModel * model = [[FoodListRecommendModel alloc]init];
        GDataXMLElement * food = foodELe[i];
        
        model.FoodId = [[food attributeForName:FID]stringValue];
        model.TimePeriod = [[food attributeForName:timeperiodFile]stringValue];
        model.FoodIntake = [[food attributeForName:FOODRECOMMENDINTAKE]stringValue];
        [dataArray addObject:model];
        
    }
    return dataArray;
}
//输入id 和站内信的id和状态   返回更改状态的成功与失败
+(BOOL)writeInnerMailReadStateUid:(NSString *)uid mailId:(NSString *)mailId state:(NSString *)state{
    NSString *fileName = [uid stringByAppendingString:USER_INNER_MAIL_FILE];
    
    NSData *fileData = [self readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    
    NSString *Str = [[NSString alloc] initWithFormat:@"./MailList/Mail[@mid='%@']",mailId];
    //    NSString *Str = [[NSString alloc] initWithFormat:@"./Root/MailList/Mail mid=\"%@\"",mailId];
    
    NSArray *nodeEleArr = [rootEle nodesForXPath:Str error:nil];
    
    //    NSLog(@"______%@_______________%@___________",Str,nodeEleArr);
    GDataXMLElement * mailELe = [nodeEleArr lastObject];
    GDataXMLElement * openedEle = [[mailELe elementsForName:OPENED]objectAtIndex:0];
    [openedEle setStringValue:state];
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:rootEle];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    
    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:doc.XMLData encoding:NSUTF8StringEncoding]];
    
}
//将用户目标文件写入本地 写入id和从网络下载的数据
+(BOOL)writeUserTargetWithUID:(NSString *)uid andData:(NSData *)data{
    NSString *fileName = [uid stringByAppendingString:USERTARGET_FIELDNAME];
   
    NSData *fileData = [self findFileWithUserId:uid andSubfix:USERTARGET_FIELDNAME];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    
    GDataXMLElement *rootEle = [doc rootElement];
    
    for (GDataXMLElement *ele in rootEle.children) {
        [rootEle removeChild:ele];
    }
    GDataXMLElement * SportStepEle = [GDataXMLElement elementWithName:USERTARGET_SPORTSTEP];
    GDataXMLDocument *serverDoc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *serverRoot = [serverDoc rootElement];
    
    GDataXMLElement *serverDataEle = [[serverRoot elementsForName:DATA] objectAtIndex:0];
    GDataXMLElement * serverSportStepEle= [[serverDataEle elementsForName:USERTARGET_SPORTSTEP]objectAtIndex:0];
    
    NSArray * serverItemEle = [serverSportStepEle elementsForName:USERTARGET_ITEM];
    
    for (GDataXMLElement * ELE in serverItemEle) {
        NSString * serverIndexAtrr = [[ELE attributeForName:USERTARGET_INDEX]stringValue];
        NSString * serverDateAtrr = [[ELE attributeForName:USERTARGET_DATE]stringValue];
        NSString * serverValueEle = [[[ELE elementsForName:USERTARGET_VALUE]objectAtIndex:0]stringValue];
        
        GDataXMLElement * itemEle = [GDataXMLElement elementWithName:USERTARGET_ITEM];
        GDataXMLElement * IndexAtrr = [GDataXMLElement attributeWithName:USERTARGET_INDEX stringValue:serverIndexAtrr];
        GDataXMLElement * DateAtrr = [GDataXMLElement attributeWithName:USERTARGET_DATE stringValue:serverDateAtrr];
        GDataXMLElement * ValueEle = [GDataXMLElement elementWithName:USERTARGET_VALUE stringValue:serverValueEle];
        [itemEle addAttribute:IndexAtrr];
        
        [itemEle addAttribute:DateAtrr];
        [itemEle addChild:ValueEle];
        
        [SportStepEle addChild:itemEle];
    }
    [rootEle addChild:SportStepEle];
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:rootEle];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    
    return  [FileUtils isCreateFile:fileName andContent:[[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding]];
}
//更改用户信息设置状态
+(BOOL)writeUserinfoSetStateUseUID:(NSString *)uid andState:(NSString *)state{
    NSString * fileName =[uid stringByAppendingString:USER_INFO_FILE];
    //取得文件数据
    NSData *data = [FileUtils readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    
    GDataXMLElement * infosetELe = [[rootEle elementsForName:U_InfoSet]objectAtIndex:0];
    [infosetELe setStringValue:state];
    
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:rootEle];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    
    return [self isCreateFile:fileName andContent:[[NSString alloc] initWithData:doc.XMLData encoding:NSUTF8StringEncoding]];
}
//取出目标步数
//输入用户id和当前的日期（格式20160409）
//返回值 当天的步数（如果没有当天的目标步数 返回向前最近的天数）和 步数的id
+(NSMutableArray *)getTargetFootStepUseUID:(NSString *)uid andDate:(NSString *)date{
    NSString * fileName =[uid stringByAppendingString:USERTARGET_FIELDNAME];
    //取得文件数据
    NSData *data = [FileUtils readFileData:fileName];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    NSString * Str = [NSString stringWithFormat:@"./SportStep/Item[@date='%@']",date];
    NSArray *aryNode=[rootEle nodesForXPath:Str error:nil];
    NSString * beforeDay = date;
    while (aryNode.count == 0) {
        //        beforeDay = @"";
        long int day = beforeDay.intValue;
        day--;
        //        NSLog(@"%ld",day);
        beforeDay = [NSString stringWithFormat:@"%ld",day];
        NSString * Strday = [NSString stringWithFormat:@"./SportStep/Item[@date='%@']",beforeDay];
        aryNode=[rootEle nodesForXPath:Strday error:nil];
        while (day == 20151000) {
            NSMutableArray * marray = [NSMutableArray array];
            [marray addObject:@""];
            [marray addObject:@"000"];
            
            return  marray;
        }
    }
    GDataXMLElement * Ele = aryNode[0];
    NSString * returnstr = [[[Ele elementsForName:USERTARGET_VALUE]objectAtIndex:0]stringValue];
    NSString * num = [[Ele attributeForName:USERTARGET_INDEX]stringValue];
    //        NSLog(@"%@",aryNodeday);
    NSMutableArray * marray = [NSMutableArray array];
    [marray addObject:returnstr];
    [marray addObject:num];
    return marray;
}
//解析存储（用户咨询2.2）数据 存储成1.1和1。2   两个xml文件
+(BOOL)analysisDoctorAdvisoryUseData:(NSData *)serverData andUID:(NSString *)userid{
    //    文件名
    NSString *fileName_advisory =[NSString stringWithFormat:@"%@%@",userid,ASVISORYFILENAME];
    NSData * data_advisory = [self findFileWithUserId:userid andSubfix:ASVISORYFILENAME];
    GDataXMLDocument *doc_advisory = [[GDataXMLDocument alloc] initWithData:data_advisory options:0 error:nil];
    GDataXMLElement *rootEle_advisory = [doc_advisory rootElement];
    
    GDataXMLDocument *serverDoc = [[GDataXMLDocument alloc] initWithData:serverData options:0 error:nil];
    GDataXMLElement *serverRoot = [serverDoc rootElement];
    GDataXMLElement * serverDataEle = [[serverRoot elementsForName:DATA]objectAtIndex:0];
    GDataXMLElement * serverDataTimeEle = [[serverDataEle elementsForName:DATATIME]objectAtIndex:0] ;
    
    GDataXMLElement * datatimeEle = [[rootEle_advisory elementsForName:DATATIME]firstObject];
    if (datatimeEle) {
        [datatimeEle setStringValue:serverDataTimeEle.stringValue];
    }else{
        [rootEle_advisory addChild:serverDataTimeEle];
    }
      NSArray * serverAdvisoryEleArray = [serverDataEle elementsForName:ASVISORY];
    
    GDataXMLElement * RecordEle_advisory = [[rootEle_advisory elementsForName:Record]firstObject];
    if (!RecordEle_advisory) {
        RecordEle_advisory = [GDataXMLElement elementWithName:Record];
        for (GDataXMLElement * ELE in serverAdvisoryEleArray){
            GDataXMLElement * isNewEle = [GDataXMLElement elementWithName:REPLY_ISNEW stringValue:@"true"];
            NSString * Id = [[ELE attributeForName:FoodID]stringValue];
        //  根据ID查找  查找最后更新时间
            NSString * xpath = [NSString stringWithFormat:@"./ReplyList[@id='%@']",Id];
            NSArray * nameArray = [serverDataEle nodesForXPath:xpath error:nil];
            GDataXMLElement * reply = [nameArray firstObject];
            NSArray * SERVERReplyEleArray  = [reply elementsForName:REPLY];
            GDataXMLElement * ele = [SERVERReplyEleArray lastObject];
            NSString * reltime = nil;
            if (ele) {
                reltime  = [[[ele elementsForName:upDataTime]objectAtIndex:0]stringValue];
            }else{
                reltime = @"";
            }
            GDataXMLElement * RplTime_advisoryEle = [GDataXMLElement elementWithName:RPLTIME stringValue:reltime];
            [ELE addChild:RplTime_advisoryEle];
            
            [ELE addChild:isNewEle];
            [RecordEle_advisory addChild:ELE];
        }
        [rootEle_advisory addChild:RecordEle_advisory];
    }else{
        for (GDataXMLElement * ELE in serverAdvisoryEleArray){
            NSString * string = [[ELE attributeForName:@"id"]stringValue];
            NSString * xpathForAdvisory = [NSString stringWithFormat:@"./Advisory[@id='%@']",string];
            GDataXMLElement * advisoryEle = [[RecordEle_advisory nodesForXPath:xpathForAdvisory error:nil]firstObject];
            if (advisoryEle) {
                [RecordEle_advisory removeChild:advisoryEle];
            }
            GDataXMLElement * isNewEle = [GDataXMLElement elementWithName:REPLY_ISNEW stringValue:@"true"];
         
            NSString * Id = [[ELE attributeForName:FoodID]stringValue];
//            //  根据ID查找  查找最后更新时间
            NSString * xpath = [NSString stringWithFormat:@"./ReplyList[@id='%@']",Id];
            NSArray * nameArray = [serverDataEle nodesForXPath:xpath error:nil];
            GDataXMLElement * reply = [nameArray firstObject];
            NSArray * SERVERReplyEleArray  = [reply elementsForName:REPLY];
          
            GDataXMLElement * ele = [SERVERReplyEleArray lastObject];
            NSString * reltime = nil;
            
            if (ele) {
                 reltime  = [[[ele elementsForName:upDataTime]objectAtIndex:0]stringValue];
            }else{
                reltime = @"";
            }
            GDataXMLElement * RplTime_advisoryEle = [GDataXMLElement elementWithName:RPLTIME stringValue:reltime];
            [ELE addChild:RplTime_advisoryEle];
            
            [ELE addChild:isNewEle];
            [RecordEle_advisory addChild:ELE];
        }
    }
    
    NSString * fileName_advisory_reply=[NSString stringWithFormat:@"%@%@",userid,ASVISORYREPLYFILENAME];
    NSData * data_advisory_reply = [self findFileWithUserId:userid andSubfix:ASVISORYREPLYFILENAME];
    GDataXMLDocument *doc_advisory_reply = [[GDataXMLDocument alloc] initWithData:data_advisory_reply options:0 error:nil];
    
    GDataXMLElement *root_advisory_replyEle = [doc_advisory_reply rootElement];
    
    NSArray * serverReplyListEleArray = [serverDataEle elementsForName:REPLYLIST];
    GDataXMLElement  * Record_advisory_replyEle = [[root_advisory_replyEle elementsForName:Record]firstObject];
    if (!Record_advisory_replyEle) {
        Record_advisory_replyEle = [GDataXMLElement elementWithName:Record];
        for (GDataXMLElement * ELE in serverReplyListEleArray) {
            [Record_advisory_replyEle addChild:ELE];
        }
        [root_advisory_replyEle addChild:Record_advisory_replyEle];
    }else{
        for (GDataXMLElement * ELE in serverReplyListEleArray) {
            NSString * Id = [[ELE attributeForName:FoodID]stringValue];
            NSString * xpath3 = [NSString stringWithFormat:@"./ReplyList[@id='%@']",Id];
            GDataXMLElement* replyListEle = [[Record_advisory_replyEle nodesForXPath:xpath3 error:nil]firstObject];
            if (replyListEle) {
                for (GDataXMLElement*replyEle in replyListEle.children) {
                    NSString * ridStr = [[replyEle attributeForName:REPLY_RID]stringValue];
                    NSString * xpath4 = [NSString stringWithFormat:@"./Reply[@rid='%@']",ridStr];
                    GDataXMLElement * replyFile = [[replyListEle nodesForXPath:xpath4 error:nil]firstObject];
                    if (replyFile) {
                        [replyListEle removeChild:replyFile];
                    }
                    [replyListEle addChild:replyEle];
                }
            }else{
                [Record_advisory_replyEle addChild:ELE];
            }
        }
    }
    
    
    return  [FileUtils isCreateFile:fileName_advisory andContent:[[NSString alloc] initWithData:doc_advisory.XMLData encoding:NSUTF8StringEncoding]]&&[FileUtils isCreateFile:fileName_advisory_reply andContent:[[NSString alloc] initWithData:doc_advisory_reply.XMLData encoding:NSUTF8StringEncoding]];
}

//利用uid取出上次咨询时的时间
+(NSString *)getLastTimeOfConsultUseUID:(NSString *)uid{
    NSData * data =    [self readFileData:[NSString stringWithFormat:@"%@%@",uid,ASVISORYFILENAME]];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    NSString * dataTime = [[[rootEle elementsForName:DATATIME]objectAtIndex:0]stringValue];
    return dataTime;
}
//利用uid去取出上次医师建议回复的时间
+(NSString *)getLastTimeOfDocinstructUseUID:(NSString *)uid{
    
    NSData * data =    [self readFileData:[NSString stringWithFormat:@"%@%@",uid,DOCTORINSTRUCTFILENAME]];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    NSString * dataTime = [[[rootEle elementsForName:DATATIME]objectAtIndex:0]stringValue];
    
    return dataTime;
}
//2.2返回的医师建议存储到本地存成1.1和1.2两个文件
+(BOOL)analysisDoctorInstructUseData:(NSData *)serverData andUID:(NSString *)userid{
    
    NSString *fileName_docinstruc =[NSString stringWithFormat:@"%@%@",userid,DOCTORINSTRUCTFILENAME];
    NSData * data_docinstruc = [self findFileWithUserId:userid andSubfix:DOCTORINSTRUCTFILENAME];
    
    GDataXMLDocument *doc_docinstruc = [[GDataXMLDocument alloc] initWithData:data_docinstruc options:0 error:nil];
    GDataXMLElement *rootEle_docinstruc = [doc_docinstruc rootElement];
    
    GDataXMLDocument *serverDoc = [[GDataXMLDocument alloc] initWithData:serverData options:0 error:nil];
    GDataXMLElement *serverRoot = [serverDoc rootElement];
    GDataXMLElement * serverDataEle = [[serverRoot elementsForName:DATA]objectAtIndex:0];
    GDataXMLElement * serverDataTimeEle = [[serverDataEle elementsForName:DATATIME]objectAtIndex:0];
    
    GDataXMLElement * datatimeEle = [[rootEle_docinstruc elementsForName:DATATIME]firstObject];
    //    添加时间
    if (datatimeEle) {
        [datatimeEle setStringValue:serverDataTimeEle.stringValue];
    }else{
        [rootEle_docinstruc addChild:serverDataTimeEle];
    }
    
    NSArray * serverInstructEleArray = [serverDataEle elementsForName:INSTRUCT];
    GDataXMLElement * recordELe_docinstruc = [[rootEle_docinstruc elementsForName:Record]firstObject];
    if (recordELe_docinstruc) {
        for (GDataXMLElement * ele in serverInstructEleArray) {
            NSString * idStr = [[ele attributeForName:FoodID]stringValue];
            NSString * xpath1 = [NSString stringWithFormat:@"./Instruct[@id='%@']",idStr];
            GDataXMLElement * instructEle = [[serverDataEle nodesForXPath:xpath1 error:nil]firstObject];
            if (instructEle) {
                [recordELe_docinstruc removeChild:instructEle];
            }
            //  根据ID查找  查找最后更新时间
            NSString * xpath = [NSString stringWithFormat:@"./ReplyList[@id='%@']",idStr];
            NSArray * nameArray = [serverDataEle nodesForXPath:xpath error:nil];
            GDataXMLElement * reply = [nameArray firstObject];
            NSArray * SERVERReplyEleArray  = [reply elementsForName:REPLY];
            GDataXMLElement * ele = [SERVERReplyEleArray lastObject];
            NSString * reltime = [[[ele elementsForName:upDataTime]objectAtIndex:0]stringValue];
            GDataXMLElement * RplTime_advisoryEle = [GDataXMLElement elementWithName:RPLTIME stringValue:reltime];
            GDataXMLElement  * IsNewEle = [GDataXMLElement attributeWithName:REPLY_ISNEW stringValue:@"true"];
            [ele addChild:IsNewEle];
            [ele addChild:RplTime_advisoryEle];
            [recordELe_docinstruc addChild:ele];
        }
        
        
    }else{
        recordELe_docinstruc = [GDataXMLElement elementWithName:Record];
        for (GDataXMLElement * ele in serverInstructEleArray) {
            NSString * idStr = [[ele attributeForName:FoodID]stringValue];
            //  根据ID查找  查找最后更新时间
            NSString * xpath = [NSString stringWithFormat:@"./ReplyList[@id='%@']",idStr];
            GDataXMLElement * reply = [[serverDataEle nodesForXPath:xpath error:nil] firstObject];
            NSArray * SERVERReplyEleArray  = [reply elementsForName:REPLY];
            GDataXMLElement * ele1 = [SERVERReplyEleArray lastObject];
            NSString * reltime = [[[ele1 elementsForName:upDataTime]objectAtIndex:0]stringValue];
            GDataXMLElement * RplTime_advisoryEle = [GDataXMLElement elementWithName:RPLTIME stringValue:reltime];
            GDataXMLElement  * IsNewEle = [GDataXMLElement attributeWithName:REPLY_ISNEW stringValue:@"true"];
            [ele addChild:IsNewEle];
            [ele addChild:RplTime_advisoryEle];
            [recordELe_docinstruc addChild:ele];
        }
        [rootEle_docinstruc addChild:recordELe_docinstruc];
    }
    
    NSString *fileName_docinstruc_reply =[NSString stringWithFormat:@"%@%@",userid,DOCTORINSTRUCTREPLYFILENAME];
    
    NSData * data_docinstruc_reply = [self findFileWithUserId:userid andSubfix:DOCTORINSTRUCTREPLYFILENAME];
    
    GDataXMLDocument *doc_docinstruc_reply = [[GDataXMLDocument alloc] initWithData:data_docinstruc_reply options:0 error:nil];
    GDataXMLElement *rootEle_docinstruc_reply = [doc_docinstruc_reply rootElement];
    GDataXMLElement * RecordEle_docinstruc_reply = [[rootEle_docinstruc_reply elementsForName:Record]firstObject];
    //    [GDataXMLElement elementWithName:Record];
    NSArray * ReplyListArry = [serverDataEle elementsForName:REPLYLIST];
    if (RecordEle_docinstruc_reply) {
        for (GDataXMLElement * replyEle in ReplyListArry) {
            NSString * Id = [[replyEle attributeForName:FoodID]stringValue];
            NSString * xpath3 = [NSString stringWithFormat:@"./ReplyList[@id='%@']",Id];
            GDataXMLElement* replyListEle = [[RecordEle_docinstruc_reply nodesForXPath:xpath3 error:nil]firstObject];
            if (replyListEle) {
                for (GDataXMLElement*replyEle in replyListEle.children) {
                    NSString * ridStr = [[replyEle attributeForName:REPLY_RID]stringValue];
                    NSString * xpath4 = [NSString stringWithFormat:@"./Reply[@rid='%@']",ridStr];
                    GDataXMLElement * replyFile = [[replyListEle nodesForXPath:xpath4 error:nil]firstObject];
                    if (replyFile) {
                        [replyListEle removeChild:replyFile];
                    }
                    [replyListEle addChild:replyEle];
                }
            }else{
                [RecordEle_docinstruc_reply addChild:replyEle];
            }
        }
    }else{
        RecordEle_docinstruc_reply = [GDataXMLElement elementWithName:Record];
        for (GDataXMLElement* replylistEle  in ReplyListArry) {
            [RecordEle_docinstruc_reply addChild:replylistEle];
        }
        [rootEle_docinstruc_reply addChild:RecordEle_docinstruc_reply];
    }
    
    return  [FileUtils isCreateFile:fileName_docinstruc andContent:[[NSString alloc] initWithData:doc_docinstruc.XMLData encoding:NSUTF8StringEncoding]]&& [FileUtils isCreateFile:fileName_docinstruc_reply andContent:[[NSString alloc] initWithData:doc_docinstruc_reply.XMLData encoding:NSUTF8StringEncoding]];
}
/**
 *  修改用户读取状态
 *
 *  @param model  数据模型
 *  @param userId 用户id
 *
 *  @return 更改是否成功
 */
+ (BOOL)changeStatus:(cx_Advisory *) model andUserId:(NSString *)userId{
    if ((model.docID.length && ![model.docID isEqualToString:@""] ) ||( model.docName.length &&![model.docName isEqualToString:@""] )) {
//        保存到医生建议
        NSString * fileName = [userId stringByAppendingString:DOCTORINSTRUCTFILENAME];
        NSData * fileData = [self findFileWithUserId:userId andSubfix:DOCTORINSTRUCTFILENAME];
        GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
        GDataXMLElement * rootEle = [document rootElement];
        GDataXMLElement * recordEle = [[rootEle elementsForName:Record]firstObject];
        
        NSString * xpath = [NSString stringWithFormat:@"./Instruct[@id='%@']",model.idAddress];
        GDataXMLElement * advisory = [[recordEle nodesForXPath:xpath error:nil]firstObject];
        if (advisory) {
            GDataXMLElement * isNewEle = [[advisory elementsForName:@"IsNew"] firstObject];
            [isNewEle setStringValue:model.isNew];
            
            NSString * content = [[NSString alloc]initWithData:document.XMLData encoding:NSUTF8StringEncoding];
            return  [self isCreateFile:fileName andContent:content];
        }
    }
//    保存到咨询数据
    NSString * fileName = [userId stringByAppendingString:ASVISORYFILENAME];
    NSData * fileData = [self findFileWithUserId:userId andSubfix:ASVISORYFILENAME];
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [document rootElement];
    GDataXMLElement * recordEle = [[rootEle elementsForName:Record]firstObject];
    
   
    NSString * xpath = [NSString stringWithFormat:@"./Advisory[@id='%@']",model.idAddress];
    GDataXMLElement * advisory = [[recordEle nodesForXPath:xpath error:nil]firstObject];
    if (advisory) {
        GDataXMLElement * isNewEle = [[advisory elementsForName:@"IsNew"] firstObject];
        [isNewEle setStringValue:model.isNew];
        
        NSString * content = [[NSString alloc]initWithData:document.XMLData encoding:NSUTF8StringEncoding];
        return  [self isCreateFile:fileName andContent:content];
    }
    
    
    
    return YES;
}

//用户咨询数据
+ (NSArray*)readAdvisoryDataWithUID:(NSString *)uid{
    NSMutableArray * array = [NSMutableArray array];
    //    1. 先读取 用户咨询
    NSString * fileNameUser = [NSString stringWithFormat:@"%@%@",uid,ASVISORYFILENAME];
    NSData * dataUser = [self readFileData:fileNameUser];
    GDataXMLDocument * docUser = [[GDataXMLDocument alloc]initWithData:dataUser options:0 error:nil];
    GDataXMLElement * rootUser = [docUser rootElement];
    
    GDataXMLElement * recordEle = [[rootUser elementsForName:Record]lastObject];
    NSArray * advisoryArray = [recordEle elementsForName:ASVISORY];
    
    for (GDataXMLElement * ele_user in advisoryArray) {
        if (!ele_user.children) {
            continue;
        }
        cx_Advisory * advisory = [[cx_Advisory alloc]init];
        advisory.idAddress = [[ele_user attributeForName:FoodID]stringValue];
        advisory.isNew = [[[ele_user elementsForName:REPLY_ISNEW] lastObject] stringValue];
        advisory.title = [[[ele_user elementsForName:TITLE]objectAtIndex:0] stringValue];
        advisory.text = [[[ele_user elementsForName:TEXT]objectAtIndex:0] stringValue];
        advisory.adjunct = [[[ele_user elementsForName:ADJUNCT]objectAtIndex:0] stringValue];
        advisory.updtime = [[[ele_user elementsForName:upDataTime]objectAtIndex:0] stringValue];
        advisory.rpltime = [[[ele_user elementsForName:RPLTIME]objectAtIndex:0] stringValue];
        [array addObject:advisory];
    }
    //    2.读取 医生建议
    NSString * fileNameDoctor = [NSString stringWithFormat:@"%@%@",uid,DOCTORINSTRUCTFILENAME];
    NSData * dataDoctor = [self readFileData:fileNameDoctor];
    
    GDataXMLDocument * docDoctor = [[GDataXMLDocument alloc]initWithData:dataDoctor options:0 error:nil];
    GDataXMLElement * rootDoctor = [docDoctor rootElement];
    NSArray * instructArray = [rootDoctor elementsForName:Record];
    
    for (GDataXMLElement * ele_doctor in instructArray) {
        if (!ele_doctor.children) {
            continue;
        }
        cx_Advisory * advisory = [[cx_Advisory alloc]init];
        advisory.idAddress = [[ele_doctor attributeForName:INSTRUCT]stringValue];
        advisory.isNew = [[[ele_doctor elementsForName:REPLY_ISNEW]objectAtIndex:0]stringValue];
        advisory.docID = [[[ele_doctor elementsForName:DOCID]objectAtIndex:0]stringValue];
        advisory.docName = [[[ele_doctor elementsForName:DOCNAME]objectAtIndex:0]stringValue];
        advisory.title = [[[ele_doctor elementsForName:TITLE]objectAtIndex:0] stringValue];
        advisory.text = [[[ele_doctor elementsForName:TEXT]objectAtIndex:0]stringValue];
        advisory.adjunct = [[[ele_doctor elementsForName:ADJUNCT]objectAtIndex:0]stringValue];
        advisory.updtime = [[[ele_doctor elementsForName:UPDATE_TIME]objectAtIndex:0]stringValue];
        advisory.rpltime = [[[ele_doctor elementsForName:RPLTIME]objectAtIndex:0]stringValue];
        [array addObject:advisory];
    }
    NSMutableArray * sortArray = [array mutableCopy];
    for (int i = 0; i < array.count; i++) {
        for (int j = 0; j< i+1; j++) {
            cx_Advisory * data1 = sortArray [i];
            cx_Advisory * data2 = sortArray[j];
            NSString * data1Str;
            NSString * data2Str;
            if (data1.rpltime.length) {
                data1Str = data1.rpltime;
            }else{
                data1Str = data1.updtime;
            }
            if (data2.rpltime.length) {
                data2Str = data2.rpltime;
            }else{
                data2Str = data2.updtime;
            }
            NSDate * date1 = [UtilCommon strFormateDate:data1Str];
            NSDate * date2 = [UtilCommon strFormateDate:data2Str];
            if ([date1 laterDate:date2]) {
                cx_Advisory * tmp;
                tmp = data2;
                data2 = data1;
                data1 = tmp;
            }
        }
    }
    return sortArray;
}
//获取用户聊天记录 uid  用户id  chatid  message id
+ (NSArray *)chatHistoryWithUid:(NSString *)uid And:(NSString *)chatId type:(BOOL)isDoctor{
    //    1.查询用户咨询数据
    NSString *fileName_docinstruc =[NSString stringWithFormat:@"%@%@",uid,ASVISORYREPLYFILENAME];
 
    NSData *data_docinstruc = [FileUtils readFileData:fileName_docinstruc];
    GDataXMLDocument *doc_docinstruc = [[GDataXMLDocument alloc] initWithData:data_docinstruc options:0 error:nil];
    GDataXMLElement *rootEle_docinstruc = [doc_docinstruc rootElement];
    NSString * xpath = [NSString stringWithFormat:@"./ReplyList[@id='%@']",chatId];
    NSArray * array = [rootEle_docinstruc nodesForXPath:xpath error:nil];
    GDataXMLElement * element = [array lastObject];
    NSMutableArray * messageArray = [NSMutableArray array];
    for (GDataXMLElement * ele in element.children) {
        Message * message = [[Message alloc]init];
        message.rid = [[ele attributeForName:REPLY_RID] stringValue];
        message.usrid = [[[ele elementsForName:REPLY_USERID] objectAtIndex:0] stringValue];
        message.username = [[[ele elementsForName:REPLY_USERNAME] objectAtIndex:0]stringValue];
        message.text = [[[ele elementsForName:TEXT]objectAtIndex:0]stringValue];
        message.adjunct = [[[ele elementsForName:ADJUNCT]objectAtIndex:0]stringValue];
        message.updtime = [[[ele elementsForName:upDataTime]objectAtIndex:0]stringValue];
        if (isDoctor) {
            message.type = MessageTypeOther;
        }else{
            message.type = MessageTypeMe;
        }
        [messageArray addObject:message];
    }
    //    2. 查询 医生建议数据
    NSString * fliename_doctorReply = [NSString stringWithFormat:@"%@%@",uid,DOCTORINSTRUCTREPLYFILENAME];
    
    if (![self hasFile:fliename_doctorReply]) {
        return messageArray;
    }
    NSData * doc_reply = [FileUtils readFileData:fliename_doctorReply];
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:doc_reply options:0 error:nil];
    GDataXMLElement * rootEle = [document rootElement];
    NSString * xpath_doc = [NSString stringWithFormat:@"./Record/ReplyList[@id='%@']",chatId];
    NSArray * doctorReplyArr = [rootEle nodesForXPath:xpath_doc error:nil];
    GDataXMLElement * xmlElement = [doctorReplyArr lastObject];
    for (GDataXMLElement * docEle in xmlElement.children) {
        Message * message = [[Message alloc]init];
        message.rid = [[docEle attributeForName:REPLY_RID] stringValue];
        message.usrid = [[[docEle elementsForName:REPLY_USERID]objectAtIndex:0]stringValue];
        message.username = [[[docEle elementsForName:REPLY_USERNAME] objectAtIndex:0]stringValue];
        message.text = [[[docEle elementsForName:TEXT]objectAtIndex:0]stringValue];
        message.adjunct = [[[docEle elementsForName:ADJUNCT]objectAtIndex:0]stringValue];
        message.updtime = [[[docEle elementsForName:upDataTime]objectAtIndex:0]stringValue];
        
        if (isDoctor) {
            message.type = MessageTypeMe;
        }else{
            message.type = MessageTypeOther;
        }
        [messageArray addObject:message];
    }
    
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"updtime" ascending:YES];
    [messageArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    return messageArray;
}

//排序
+ (NSArray*)busListSortArrayWithArray:(NSArray*)array key:(NSString *) key isAsc:(BOOL)isAsc{
    NSSortDescriptor * sortKey = [NSSortDescriptor sortDescriptorWithKey:key ascending:isAsc];
    NSArray * sortArray = [NSArray arrayWithObjects:sortKey, nil];
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:array];
    NSArray * resultArr = [tempArr sortedArrayUsingDescriptors:sortArray];
    return resultArr;
}
@end