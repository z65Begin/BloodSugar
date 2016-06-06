//
//  SportFileUtils.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/6.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportFileUtils.h"

#import "GDataXMLNode.h"

#import "sportCataModel.h"

#import "SportRecordModel.h"

@implementation SportFileUtils

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
/**
 * 读取运动模型
 * type：运动编号
 */

+ (sportCataModel *)readSportCataWith:(NSString*)type{
NSString *fileName = SPORT_TYPE_FILE;
    NSData * fileData = [self readFileData:fileName];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
    NSString * xpath = [NSString stringWithFormat:@"./Type[@id='%@']",type];
    NSArray * typeArray = [rootEle nodesForXPath:xpath error:nil];
    GDataXMLElement * typeEle = [typeArray firstObject];
    sportCataModel * model = [[sportCataModel alloc]init];
    model.sid = type;
    model.Name = [[[typeEle elementsForName:NAME]firstObject] stringValue];
    model.Energy = [[[typeEle elementsForName:ENERGY]firstObject]stringValue];
    return model;
}
/**
 *   保存一条 新的 运动记录 到本地
 *   userId：用户id
 *   model：运动记录模型
 */

+ (BOOL)saveSportRecordWithUID:(NSString*)userId andRecordModel:(SportRecordModel*)model{
    NSString * fileName = [userId stringByAppendingString:SPORT_RECORD_FILE];
    NSData * fileData = [self findFileWithUserId:userId andSubfix:SPORT_RECORD_FILE];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootEle = [fileDoc rootElement];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",model.date];
    NSArray * array = [rootEle nodesForXPath:xpath error:nil];
    GDataXMLElement * recordEle = [array firstObject];
    if (recordEle == nil) {
        GDataXMLElement * newRecord = [GDataXMLElement elementWithName:Record];
        GDataXMLElement * newDate = [GDataXMLElement attributeWithName:FOODDATE stringValue:model.date];
        GDataXMLElement * newSport = [GDataXMLElement elementWithName:SPORT_Record_Sport];
        GDataXMLElement * newTime = [GDataXMLElement attributeWithName:SPORT_Record_time stringValue:model.time];
        GDataXMLElement  * newTimeLength = [GDataXMLElement elementWithName:SPORT_Record_TimeLength stringValue:model.TimeLength];
        GDataXMLElement * newType = [GDataXMLElement elementWithName:TYPE stringValue:model.Type];
        GDataXMLElement * newResult = [GDataXMLElement elementWithName:SPORT_RECORD_Result stringValue:model.Result];
        GDataXMLElement * newUpdtime = [GDataXMLElement elementWithName:upDataTime stringValue:model.UpdTime];
        
        [newSport addAttribute:newTime];
        [newSport addChild:newTimeLength];
        [newSport addChild:newType];
        [newSport addChild:newResult];
        [newRecord addAttribute:newDate];
        [newRecord addChild:newSport];
        [newRecord addChild:newUpdtime];
        [rootEle addChild:newRecord];
    }else{
        GDataXMLElement * updtime = [[recordEle elementsForName:upDataTime]firstObject];
        [updtime setStringValue:model.UpdTime];
        GDataXMLElement * newSport = [GDataXMLElement elementWithName:SPORT_Record_Sport];
        GDataXMLElement * newTime = [GDataXMLElement attributeWithName:SPORT_Record_time stringValue:model.time];
        GDataXMLElement  * newTimeLength = [GDataXMLElement elementWithName:SPORT_Record_TimeLength stringValue:model.TimeLength];
        GDataXMLElement * newType = [GDataXMLElement elementWithName:TYPE stringValue:model.Type];
        GDataXMLElement * newResult = [GDataXMLElement elementWithName:SPORT_RECORD_Result stringValue:model.Result];
        [newSport addAttribute:newTime];
        [newSport addChild:newTimeLength];
        [newSport addChild:newType];
        [newSport addChild:newResult];
        [recordEle addChild:newSport];
    }
    NSString * content = [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
    return  [self isCreateFile:fileName andContent:content];
}
/**
 * 修改数据
 * userId:用户id
 * recordArray：修改的数组
 */
+ (BOOL)saveSportRecordWitnUID:(NSString*)userId andRecordArray:(NSArray*)recordArray{
    
    NSString * fileName = [userId stringByAppendingString:SPORT_RECORD_FILE];
    NSData * fileData = [self findFileWithUserId:userId andSubfix:SPORT_RECORD_FILE];
    GDataXMLDocument * fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    SportRecordModel * model = [recordArray firstObject];
    GDataXMLElement * rootEle = [fileDoc rootElement];
    NSString * xpath = [NSString stringWithFormat:@"./Record[@date='%@']",model.date];
    NSArray * recordArr = [rootEle nodesForXPath:xpath error:nil];
    if (recordArray.count) {
        for (GDataXMLElement * recordEle in recordArr) {
            [rootEle removeChild:recordEle];
        }
    }
    [self isCreateFile:fileName andContent:[[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding]];
    BOOL flag = NO;
    for (SportRecordModel * recordModel in recordArray) {
      flag  = [self saveSportRecordWithUID:userId andRecordModel:recordModel];
    }
//    NSString * content = [[NSString alloc]initWithData:fileDoc.XMLData encoding:NSUTF8StringEncoding];
    return flag;

}
@end
