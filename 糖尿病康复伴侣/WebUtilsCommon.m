//
//  WebUtilsCommon.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "WebUtilsCommon.h"
#import "GDataXMLNode.h"
#import "baseLineModel.h"
//#import "FoodListRecommendModel.h"

#import "FoodRecordModel.h"

#import "SportRecordModel.h"
#import "sportCataModel.h"

@implementation WebUtilsCommon

/**判断获取服务器信息是否成功*/
+(BOOL)getServerBool:(NSData *)fileData
{
    //判断是否获取成功
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
//    NSLog(@"doc%@",doc);
    GDataXMLElement *rootElement = [doc rootElement];
    NSString *returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
       NSLog(@"returncode====%@",returnCode);
    if ([returnCode isEqualToString:@"error"]) {
        return NO;
    }
    return YES;
}

/**
 *服务器验证
 *uid 用户吗 pwd 密码
 */
+(NSString *)verifyServer:(NSString *)uid andPwd:(NSString *)pwd andType:(NSString *)type andVersion:(NSString *)version{
    //登录请求用字符串
    NSString *content = [WebUtilsCommon createContentLogin:uid andPwd:pwd andType:type andVersion:version];
    NSData *data = [WebUtilsCommon sendRequest:VERIFY_LOGIN andContent:content];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    NSString *returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    return returnCode;
}

/**
 *服务器验证(注册)
 *uid 用户吗 pwd 密码
 */
+(NSString *)userServer:(NSString *)uid andPwd:(NSString *)pwd andName:(NSString *)name andSex:(NSString *)sex
{
    //登录请求用自负串
    NSString *content = [WebUtilsCommon createContentRegist:uid andPwd:pwd andName:name andSex:sex];
    NSData *data = [WebUtilsCommon sendRequest:USER_REGIST andContent:content];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    NSString *returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    return returnCode;
}
/**
 *创建用户登录用请求
 *uid 用户吗 pwd 密码
 */
+(NSString *)createContentLogin:(NSString *)uid andPwd:(NSString *)pwd andType:(NSString *)type andVersion:(NSString *)version{
    
    //文档根节点
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement *reqType = [GDataXMLNode elementWithName:REQ_TYPE stringValue:CLIENT_MODE_LOGIN];
    [root addChild:reqType];
    
    GDataXMLElement *data = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement *uId = [GDataXMLNode elementWithName:U_ID_LOGIN stringValue:uid];
    GDataXMLElement *password = [GDataXMLNode elementWithName:U_PWD_LOGIN stringValue:pwd];
    GDataXMLElement *Type = [GDataXMLNode elementWithName:U_TYPE_LOGIN stringValue:type];
    GDataXMLElement *Version = [GDataXMLNode elementWithName:U_VERSION_LOGIN stringValue:version];
    
    [data addChild:uId];
    [data addChild:password];
    [data addChild:Type];
    [data addChild:Version];
    [root addChild:data];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    //返回用户请求内容
    return [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
}

/**
 *创建用户注册用请求
 *uid 用户吗 pwd 密码
 */
+(NSString *)createContentRegist:(NSString *)uid andPwd:(NSString *)pwd andName:(NSString *)name andSex:(NSString *)sex
{
    //文档根节点
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement *reqType = [GDataXMLNode elementWithName:REQ_TYPE stringValue:CLIENT_MODE_UPINFO];
    [root addChild:reqType];
    
    GDataXMLElement *data = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement *uId = [GDataXMLNode elementWithName:UID stringValue:uid];
    GDataXMLElement *password = [GDataXMLNode elementWithName:PASSWORD stringValue:pwd];
    GDataXMLElement *Name = [GDataXMLNode elementWithName:UNAME stringValue:name];
    GDataXMLElement *Sex = [GDataXMLNode elementWithName:USEX stringValue:sex];
    
    [data addChild:uId];
    [data addChild:password];
    [data addChild:Name];
    [data addChild:Sex];
    [root addChild:data];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    //返回用户请求内容
    return [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];

}

/**
 *创建修改密码用请求
 */
+(BOOL)modifyPwd:(NSString *)uid andOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)newPwd{
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement *reqType = [GDataXMLNode elementWithName:REQ_TYPE stringValue:CLIENT_MODE_UPINFO];
    [root addChild:reqType];
    
    GDataXMLElement *data = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement *uidEle = [GDataXMLNode elementWithName:UID stringValue:uid];
    [data addChild:uidEle];
    //用户信息节点
    GDataXMLElement *oldPwdEle = [GDataXMLElement elementWithName:OLDPASSWORD stringValue:oldPwd];
    GDataXMLElement *newPwdEle = [GDataXMLElement elementWithName:NEWPASSWORD stringValue:newPwd];
    [data addChild:oldPwdEle];
    [data addChild:newPwdEle];
    [root addChild:data];
    
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    //用户请求内容
    NSString *requestStr = [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    NSData *fileData = [self sendRequest:CHANGEPASSWORD andContent:requestStr];
    if(fileData == nil){
        return NO;
    }
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:fileData options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    NSString *returnCode = [[[rootEle elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    if ([returnCode isEqualToString:@"ok"]) {
        return YES;
    }else{
        return NO;
    }
}

/**
 *向服务器发送请求
 *mode 请求模式
 *请求内容
 */


+(NSData *)sendRequest:(NSString *)mode andContent:(NSString *)content {
    NSData *data1 = nil;
    NSURL *url = [NSURL URLWithString: [WEB_SERVER_URL stringByAppendingString:mode]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = CLIENT_MODE_POST;
    NSString *str = [NSString stringWithFormat:@"dataStr=%@",[self URLencode:content stringEncoding:NSUTF8StringEncoding]];
    request.timeoutInterval = 30.0;
//    NSError *error = nil;
    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    
//    data1 = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    __block typeof (data1)weakData = data1;
  dispatch_semaphore_t semaphore =  dispatch_semaphore_create(0);
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        weakData = data;
        dispatch_semaphore_signal(semaphore);
    }] resume];
     dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSString *returnStr = [[NSString alloc] initWithData:weakData encoding:NSUTF8StringEncoding];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString *strUtf8 = [returnStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    data1 = [strUtf8 dataUsingEncoding:NSUTF8StringEncoding];
    return data1;
}

+ (NSString*)URLencode:(NSString *)originalString
        stringEncoding:(NSStringEncoding)stringEncoding {
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
    int len = (int)[escapeChars count];
    NSMutableString *temp = [[originalString
                              stringByAddingPercentEscapesUsingEncoding:stringEncoding]
                             mutableCopy];
    int i;
    for (i = 0; i < len; i++) {
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    NSString *outStr = [NSString stringWithString: temp];
    return outStr;
}
//CFSTR("!*'();:@&=+$,/?%#[]")
+(NSData *)sendRequestRegist:(NSString *)mode andContent:(NSString *)content{
    NSData *data = nil;
    NSURL *url = [NSURL URLWithString: [WEB_SERVER_URL stringByAppendingString:mode]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = CLIENT_MODE_POST;
    NSString *str = [NSString stringWithFormat:@"dataStr=%@",[content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    request.timeoutInterval = 30.0;
//    NSError *error = nil;
    //返回数据
//    data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    __block typeof (data)weakData = data;
    dispatch_semaphore_t semaphore =  dispatch_semaphore_create(0);
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        weakData = data;
        dispatch_semaphore_signal(semaphore);
    }] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSString *returnStr = [[NSString alloc] initWithData:weakData encoding:NSUTF8StringEncoding];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString *strUtf8 = [returnStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    data = [strUtf8 dataUsingEncoding:NSUTF8StringEncoding];
    return data;

}

/**
 *从服务器获取用户数据
 *uid 用户id
 *return 用户信息
 */
+(UserInfoModel *)getUserInfoFromServer:(NSString *)uid{
    //初始化用户信息分配内存
    UserInfoModel *info = [[UserInfoModel alloc] init];
    info.UID = uid;
    //发送请求用参数
    NSString *content =  [WebUtilsCommon createContentUsetInfo:uid];
    //返回结果
    NSData *data = [WebUtilsCommon sendRequest:CLIENT_SERVER_GETINFO andContent:content];
    if(data == nil){
        return nil;
    }
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement * rootElement = [doc rootElement];
    NSString * returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    if ([returnCode isEqualToString:@"error"]) {
        return nil;
    }
    GDataXMLElement *dataEle = [[rootElement elementsForName:DATA] objectAtIndex:0];
    //用户id
    info.UID = [[[dataEle elementsForName:Uid] objectAtIndex:0] stringValue];
    info.Password = [[[dataEle elementsForName:UPassword] objectAtIndex:0]stringValue];
    info.Name = [[[dataEle elementsForName:UName] objectAtIndex:0]stringValue];
    info.Pinyin = [[[dataEle elementsForName:UPinyin] objectAtIndex:0]stringValue];
    info.NickName = [[[dataEle elementsForName:UNickName] objectAtIndex:0]stringValue];
    info.Org = [[[dataEle elementsForName:UOrg] objectAtIndex:0]stringValue];
    info.Type = [[[dataEle elementsForName:UType] objectAtIndex:0]stringValue];
    info.Email = [[[dataEle elementsForName:UEmail] objectAtIndex:0]stringValue];
    info.Tel = [[[dataEle elementsForName:UTel] objectAtIndex:0]stringValue];
    info.Sex = [[[dataEle elementsForName:USex] objectAtIndex:0]stringValue];
    info.Birthday = [[[dataEle elementsForName:UBirthday] objectAtIndex:0]stringValue];
    info.Height = [[[dataEle elementsForName:UHeight] objectAtIndex:0]stringValue];
    info.Weight = [[[dataEle elementsForName:UWeight] objectAtIndex:0]stringValue];
    info.ExIntensity = [[[dataEle elementsForName:UExIntensity] objectAtIndex:0]stringValue] ;
    info.DiabetesType = [[[dataEle elementsForName:UDiabetesType] objectAtIndex:0]stringValue] ;
    info.Complication = [[[dataEle elementsForName:UComplication] objectAtIndex:0]stringValue];
    info.RestHr = [[[dataEle elementsForName:URestHr] objectAtIndex:0]stringValue];
    info.FamilyHis = [[[dataEle elementsForName:UFamilyHis] objectAtIndex:0]stringValue];
    info.CliDiagnosis = [[[dataEle elementsForName:UCliDiagnosis] objectAtIndex:0]stringValue];
    info.InfoSet = [[[dataEle elementsForName:UInfoSet] objectAtIndex:0]stringValue];
    info.SecureSet = [[[dataEle elementsForName:USecureSet] objectAtIndex:0]stringValue];
    return info;
}

/**
 *创建获取用户信息用请求
 *uid 用户id
 */
+(NSString *)createContentUsetInfo:(NSString *)uid{
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement *reqType = [GDataXMLNode elementWithName:REQ_TYPE stringValue:CLIENT_MODE_GETINFO];
    [root addChild:reqType];
    
    GDataXMLElement *data = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement *uId = [GDataXMLElement elementWithName:UID stringValue:uid];
    [data addChild:uId];
    [root addChild:data];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    //返回用户请求内容
    return [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
}

/**
 *从服务器获取食物数据；       健康日记-饮食 5 6            —————————1———————————
 *uid：用户Id；
 */
+(NSData *)getfoodMonsin:(NSString *)uid andDatatime:(NSString *)dataTime{
    GDataXMLElement * root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_GETINFO];
    [root addChild:reqType];
    
    GDataXMLElement * dataEle = [GDataXMLElement elementWithName:DATA];
    //食物请求节点
    GDataXMLElement * uidEle = [GDataXMLElement elementWithName:UID stringValue:uid];
    [dataEle addChild:uidEle];
    GDataXMLElement * dataTimeEle = [GDataXMLElement elementWithName:DATATIME stringValue:nil];
    [dataEle addChild:dataTimeEle];
    [root addChild:dataEle];
    
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    //返回用户请求内容
    NSString *content =[[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    NSData *serverData = [WebUtilsCommon sendRequest:UPDATAFOODINFO andContent:content];
    return serverData;
}

/**
 *从服务器获取运动种类数据；
 *uid：用户Id；
 */
+(NSData *)getSportMonsin:(NSString *)uid andDatatime:(NSString *)dataTime{
    GDataXMLElement * root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_GETINFO];
    [root addChild:reqType];
    
    GDataXMLElement * dataEle = [GDataXMLElement elementWithName:DATA];
    //食物请求节点
    GDataXMLElement * uidEle = [GDataXMLElement elementWithName:UID stringValue:uid];
    [dataEle addChild:uidEle];
    GDataXMLElement * dataTimeEle = [GDataXMLElement elementWithName:DATATIME stringValue:dataTime];
    [dataEle addChild:dataTimeEle];
    [root addChild:dataEle];
    
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    //返回用户请求内容
    NSString *content =[[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    NSData *serverData = [WebUtilsCommon sendRequest:GETSPORTTYPE andContent:content];
    
    return serverData;
}


// 发送请求 的XML
/**
 * 创建发送请求的XML
 *userId：用户id
 *dataTime：更新时间
 */
+ (NSString*)getInformationWithUID:(NSString*)userId {
    GDataXMLElement * root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_GETINFO];
    [root addChild:reqType];
    
    GDataXMLElement * dataEle = [GDataXMLElement elementWithName:DATA];
    GDataXMLElement * uidEle = [GDataXMLElement elementWithName:UID stringValue:userId];
    [dataEle addChild:uidEle];
    NSDictionary * newDic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
    NSString * dataTime = [newDic objectForKey:SETTING_SYNCHISTIME];
    GDataXMLElement * dataTimeEle = [GDataXMLElement elementWithName:DATATIME stringValue:dataTime];
    [dataEle addChild:dataTimeEle];
    [root addChild:dataEle];
    
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    NSString *content =[[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    return content;
}
#pragma  mark  发送 用户记录 的 基础方法
+ (BOOL)sendRecordToSeverWithUID:(NSString *)userId andAddress:(NSString*)addressString andFileSubfix:(NSString*)subfix{
    GDataXMLElement * rootEle = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement * dataEle = [GDataXMLElement elementWithName:DATA];
    GDataXMLElement * uidEle = [GDataXMLElement elementWithName:UID stringValue:userId];
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_UPINFO];
    [rootEle addChild:reqType];
    [dataEle addChild:uidEle];
    NSString * fileName = [userId stringByAppendingString:subfix];
    NSData * fileData = [FileUtils readFileData:fileName];
    GDataXMLDocument *fileDoc = [[GDataXMLDocument alloc]initWithData:fileData options:0 error:nil];
    GDataXMLElement * rootFile = [fileDoc rootElement];
    //   获取同步时间
    NSDictionary * newDic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
    NSString * syncStr = [newDic objectForKey:SETTING_SYNCHISTIME];
    NSDate * syncDate = [UtilCommon strFormateDate:syncStr];
    for (GDataXMLElement * recordEle in rootFile.children) {
        if (!syncDate) {
            [dataEle addChild:recordEle];
        }else{
            NSString * updStr = [[[recordEle elementsForName:upDataTime]firstObject] stringValue];
            NSDate * updDate = [UtilCommon strFormateDate:updStr];
            if ([updDate compare:syncDate] == NSOrderedDescending) {
                [dataEle addChild:recordEle];
            };
        }
    }
    [rootEle addChild:dataEle];
    GDataXMLDocument * sendDoc = [[GDataXMLDocument alloc]initWithRootElement:rootEle];
    [sendDoc setVersion:@"1.0"];
    [sendDoc setCharacterEncoding:@"UTF-8"];
    NSString * content = [[NSString alloc]initWithData:sendDoc.XMLData encoding:NSUTF8StringEncoding];
    NSData * getData = [WebUtilsCommon sendRequest:addressString andContent:content];
    
    GDataXMLDocument * systemDoc = [[GDataXMLDocument alloc]initWithData:getData options:0 error:nil];
    GDataXMLElement * root = [systemDoc rootElement];
    NSString * returnCode = [[[root elementsForName:RETURN_CODE] objectAtIndex:0]stringValue];
    if ([returnCode isEqualToString:@"error"] ) {
        return NO;
    }
    return YES;
}

#pragma mark 运动记录
/***
 *  获取运动记录信息
 * userId:用户id
 * dataTime:更新时间
 */
+ (NSData*)getSportRecordWithUID:(NSString*)userId {
    NSString * content = [self getInformationWithUID:userId ];
    NSData * serverData = [WebUtilsCommon sendRequest:SPORT_Record andContent:content];
    GDataXMLDocument * systemDoc = [[GDataXMLDocument alloc]initWithData:serverData options:0 error:nil];
    GDataXMLElement * rootEle = [systemDoc rootElement];
    NSString * returnCode = [[[rootEle elementsForName:RETURN_CODE] objectAtIndex:0]stringValue];
    if ([returnCode isEqualToString:@"error"] ) {
        return nil;
    }

    return serverData;
}

+ (BOOL)sendSportRecordWithUID:(NSString*)userId{
    return [self sendRecordToSeverWithUID:userId andAddress:@"upSportRecord" andFileSubfix:SPORT_RECORD_FILE];
}

/** 获取血糖信息
 *userId：用户id
 *dataTime：更新时间
 */
+ (NSData*)getBloodSugarWithUID:(NSString*)userId{
    NSString * content = [self getInformationWithUID:userId ];
    NSData * serverData = [WebUtilsCommon sendRequest:SUGAR_Send_syncSugarRecord andContent:content];
    return serverData;
}
/***
 *  发送血糖请求
 */
+ (BOOL)sendBloodSugarRecordWithUID:(NSString*)userId{
    return [self sendRecordToSeverWithUID:userId andAddress:@"upSugarRecord" andFileSubfix:SUGAR_RECORD_FILE];
}

/**  获取体征记录
 * userId: 用户id
 *dataTime：更新时间
 */
+ (NSData*)getBodySignRecordWitnUID:(NSString*)userId{

    NSString * content = [self getInformationWithUID:userId ];
    
    NSData * serverData = [WebUtilsCommon sendRequest:BODYSIGN_syncBodySignRecord andContent:content];
    
    return serverData;
}
+ (BOOL)sendBodySignRecordWithUID:(NSString*)userId{
    return [self sendRecordToSeverWithUID:userId andAddress:@"upBodySignRecord" andFileSubfix:BODYSIGN_RECORD_FILE];
}
/**
 *从服务器获取药物数据；  健康日记-用药   5.1  5.2  ————————1————————
 *uid：用户Id；
 */
+(NSData *)getyaoMonsin:(NSString *)uid andDatatime:(NSString *)dataTime{

    GDataXMLElement * root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_GETINFO];
    [root addChild:reqType];
    
    GDataXMLElement * dataEle = [GDataXMLElement elementWithName:DATA];
    //药物请求节点
    GDataXMLElement * uidEle = [GDataXMLElement elementWithName:UID stringValue:uid];
    [dataEle addChild:uidEle];
    GDataXMLElement * dataTimeEle = [GDataXMLElement elementWithName:DATATIME stringValue:dataTime];
    [dataEle addChild:dataTimeEle];
    [root addChild:dataEle];
    
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    //返回用户请求内容
    NSString *content =[[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    NSData *serverData = [WebUtilsCommon sendRequest:GETMEDICINETYPE andContent:content];

    return serverData;
}
/**
 *从服务器获取同步药物记录数据；
 *uid：用户Id；
 */
+(NSData *)getsyncMedicationRecord:(NSString * )uid{

    NSString * content = [self getInformationWithUID:uid];
    NSData *serverData = [WebUtilsCommon sendRequest:syncMedicationRecord andContent:content];
//    NSLog(@"用药记录获取%@用药记录获取",serverData);
    return serverData;
}
+ (BOOL)sendMedicineRecordWithUID:(NSString*)userId{

    return  [self sendRecordToSeverWithUID:userId andAddress:upMedicationRecord andFileSubfix:MEDICINE_RECORD_FILE];
}

/**
 *服务器获取更新的站内信；
 *dateTime：上次更新时间；
 *uid：用户id；
 */
+(NSData *)getInnerMailFromServer:(NSString *)dataTime andUid:(NSString *)uid{
    NSString *content = [self createContentInnerMail:dataTime andUid:uid];
    //返回结果
    NSData * data = [WebUtilsCommon sendRequest:CLIENT_SERVER_INNERMAIL andContent:content];
    if(data == nil){
        return nil;
    }
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
//    NSLog(@"%@",doc);
    GDataXMLElement *rootEle = [doc rootElement];
    NSString *returnCode = [[[rootEle elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    if ([returnCode isEqualToString:@"error"]) {
        return nil;
    }
    return data;
    NSMutableArray *innerMailArr = [[NSMutableArray alloc] init];
    
    GDataXMLElement *dataEle = [[rootEle elementsForName:DATA] objectAtIndex:0];
    
    NSArray *mailArr = [dataEle elementsForName:MAIL];
//    NSLog(@"mailArr%@mailArr",mailArr);
    for (GDataXMLElement *ele in mailArr) {
        InnerMailModel *innerMail = [[InnerMailModel alloc] init];
                innerMail.mid = [[ele attributeForName:MID] stringValue];
        innerMail.title = [[[ele elementsForName:TITLE] objectAtIndex:0] stringValue];
        innerMail.opened = [[[ele elementsForName:@"Opened"]objectAtIndex:0]stringValue];
        
        innerMail.content = [[[ele elementsForName:CONTENT] objectAtIndex:0] stringValue];
        innerMail.sendTime = [[[ele elementsForName:SEND_TIME] objectAtIndex:0] stringValue];
        innerMail.senderId = [[[ele elementsForName:SENDER_ID] objectAtIndex:0] stringValue];
        innerMail.senderName = [[[ele elementsForName:SENDER_NAME] objectAtIndex:0] stringValue];
        innerMail.Adjunct = [[[ele elementsForName:ADJUNCT]objectAtIndex:0]stringValue];
        [innerMailArr addObject:innerMail];
    }
    
    return innerMailArr;
}


+(NSString *)createContentInnerMail:(NSString *)dataTime andUid:(NSString *)uid{
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement *reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_GETINFO];
    [root addChild:reqType];
    
    GDataXMLElement *data = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement *uidEle = [GDataXMLNode elementWithName:UID stringValue:uid];
    [data addChild:uidEle];
    GDataXMLElement *dataTimeEle = [GDataXMLNode elementWithName:DATATIME stringValue:dataTime];
    [data addChild:dataTimeEle];
    [root addChild:data];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    //返回用户请求内容
    return [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
}

//返回站内信最新更新时间
+(NSString *)getTimeFromServer:(NSString *)dataTime andUid:(NSString *)uid{
    NSString *content = [self createContentInnerMail:dataTime andUid:uid];
    //返回结果
    NSData *data = [WebUtilsCommon sendRequest:CLIENT_SERVER_INNERMAIL andContent:content];
    if(data == nil){
        return nil;
    }
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    GDataXMLElement *rootEle = [doc rootElement];
    GDataXMLElement *dataEle = [[rootEle elementsForName:DATA] objectAtIndex:0];
    NSString *updateTime = [[[dataEle elementsForName:UPDATE_TIME] objectAtIndex:0] stringValue];
    
    return updateTime;
}

/**
 *  下载  附件
 *
 *  @param uid      用户id
 *  @param Uorg     用户Org
 *  @param fileName 文件名称
 *  @param FileType 文件类型
 *  @return 返回网络获取的数据
 */
+(void)getNoticeAdjFromServerUID:(NSString *)uid Uorg:(NSString *)Uorg FileName:(NSString * )fileName FileType:(NSString * )FileType and:(void(^)(UIImage* image, NSString* nameStr))handle {

    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement *data = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement *uidEle = [GDataXMLNode elementWithName:UID stringValue:uid];
    [data addChild:uidEle];
    GDataXMLElement * uorgEle = [GDataXMLElement elementWithName:UOrg stringValue:Uorg];
    [data addChild:uorgEle];
    GDataXMLElement * fileTypeEle = [GDataXMLElement elementWithName:@"FileType" stringValue:FileType];
    [data addChild:fileTypeEle];
    
    GDataXMLElement * fileNameEle = [GDataXMLElement elementWithName:@"FileName" stringValue:fileName];
    [data addChild:fileNameEle];

    [root addChild:data];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
  NSString * content =   [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    
//    NSData * getedData = [WebUtilsCommon sendRequest:@"downloadFile" andContent:content];

//    NSData *getdata = nil;
    NSURL *url = [NSURL URLWithString: [WEB_SERVER_URL stringByAppendingString:@"downloadFile"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = CLIENT_MODE_POST;
    NSString *str = [NSString stringWithFormat:@"dataStr=%@",[self URLencode:content stringEncoding:NSUTF8StringEncoding]];
    
    //    [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
    request.timeoutInterval = 30.0;
//    NSError *error = nil;
    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    //返回数据e
//    getdata = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
//    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
   [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       UIImage * image  = [[UIImage alloc]initWithData:data scale:1.0f];
       if ([[response.suggestedFilename substringFromIndex:response.suggestedFilename.length -3]isEqualToString:@"JPG"]||[[response.suggestedFilename substringFromIndex:response.suggestedFilename.length -3]isEqualToString:@"PNG"]) {
           
           handle(image,response.suggestedFilename);
       }
   }] resume];
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        UIImage * image  = [[UIImage alloc]initWithData:data scale:1.0f];
//        if ([[response.suggestedFilename substringFromIndex:response.suggestedFilename.length -3]isEqualToString:@"JPG"]||[[response.suggestedFilename substringFromIndex:response.suggestedFilename.length -3]isEqualToString:@"PNG"]) {
//            handle(image,response.suggestedFilename);
//        }
//    }];
//    int char1 = 0 ,char2 =0 ; //必须这样初始化
//    [getdata getBytes:&char1 range:NSMakeRange(0, 1)];
//    [getdata getBytes:&char2 range:NSMakeRange(1, 1)];
//    NSLog(@"%d%d",char1,char2);
//    NSString * nameStr = [[NSString alloc]initWithData:getedData encoding:NSUTF8StringEncoding];
//    NSLog(@"nameStr==%@",nameStr);
}

//获取基准数据(生成请求体并请求数据)
//返回值：服务器返回的基准数据
+(NSData *)getBaselineDataUID:(NSString *)uid BaseLineCode:(NSString *)baseLineCode beforeUpDataTime:(NSString *)updataTime{
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_GETINFO];
    [root addChild:reqType];
    GDataXMLElement *dataEle = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement * updataTimeEle = [GDataXMLElement elementWithName:DATATIME stringValue:updataTime];
    [dataEle addChild:updataTimeEle];
    
    GDataXMLElement *uidEle = [GDataXMLNode elementWithName:UID stringValue:uid];
    [dataEle addChild:uidEle];
    
    GDataXMLElement * baseLineCodeEle = [GDataXMLElement elementWithName:@"Code" stringValue:baseLineCode];
    [dataEle addChild:baseLineCodeEle];

    
    [root addChild:dataEle];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    NSString * content =   [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    
    NSData * getedData = [WebUtilsCommon sendRequest:@"getBaselineData" andContent:content];
//    NSString *result  =[[ NSString alloc] initWithData:getedData encoding:NSUTF8StringEncoding];
    return getedData;

}
//服务器返回的基准数据
//返回值：基准数据数组
+(NSMutableArray * )BaseLineUID:(NSString *)uid BaseLineCode:(NSString *)baseLineCode beforeUpDataTime:(NSString *)time{
//服务器返回的数据
   NSData * data =  [WebUtilsCommon getBaselineDataUID:uid BaseLineCode:baseLineCode beforeUpDataTime:time];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
//    
    GDataXMLElement * rootElement = [doc rootElement];
//    
    NSString * returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    
    if ([returnCode isEqualToString:@"error"]) {
        return nil;
    }
    GDataXMLElement * dataEle = [[rootElement elementsForName:DATA]objectAtIndex:0];
//
    
//
    NSArray * baseLineEleArray = [dataEle elementsForName:Baseline];
    NSMutableArray * marray = [[NSMutableArray alloc]init];
   
    for (int i = 0; i < baseLineEleArray.count; i ++) {
        GDataXMLElement * ele = baseLineEleArray[i];
         baseLineModel * model = [[baseLineModel alloc]init];
        model.Name = [[[ele elementsForName:NAME]firstObject]stringValue];
        model.Value = [[[ele elementsForName:value]firstObject]stringValue];
        model.Backup = [[[ele elementsForName:Backup]firstObject]stringValue];
        model.code = [[ele attributeForName:@"code"]stringValue];
        [marray addObject:model];
    }
        return marray;
}

/**
 请求推荐食谱数据     健康日记 1 2           —————————————1———————————————
 返回食谱数据  
 uid：用户id
 energyLevel：每日摄入标准热量
 */
+(NSData *)getfoodListRecommendFromServerUID:(NSString *)uid EnergyLevel:(NSString *)energyLevel{
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_GETINFO];
    [root addChild:reqType];
     GDataXMLElement *dataEle = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement *uidEle = [GDataXMLElement elementWithName:UID stringValue:uid];
    [dataEle addChild:uidEle];
    GDataXMLElement * EnergyEle = [GDataXMLElement elementWithName:@"Energy" stringValue:energyLevel];
    [dataEle addChild:EnergyEle];
    [root addChild:dataEle];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    NSString * content =   [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    NSData * getedData = [WebUtilsCommon sendRequest:@"getAdviceFood" andContent:content];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:getedData options:0 error:nil];
    GDataXMLElement * rootElement = [doc rootElement];
    NSString * returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    if ([returnCode isEqualToString:@"error"]) {
        return nil;
    }
    return getedData;
}
/**
  饮食记录获取请求   健康日记-饮食 8.1 - 8.2  ————————————1——————————————
  userID:用户id
  */
+ (NSData*)getDietRecordWithUsrID:(NSString*)userID {

    NSString * content = [self getInformationWithUID:userID];
//    [[NSString alloc]initWithData:document.XMLData encoding:NSUTF8StringEncoding];
    NSData * getData = [WebUtilsCommon sendRequest:@"syncFoodRecord" andContent:content];
    GDataXMLDocument * systemDoc = [[GDataXMLDocument alloc]initWithData:getData options:0 error:nil];
    GDataXMLElement * rootEle = [systemDoc rootElement];
    NSString * returnCode = [[[rootEle elementsForName:RETURN_CODE] objectAtIndex:0]stringValue];
    if ([returnCode isEqualToString:@"error"] ) {
        return nil;
    }
    return getData;
}
/**
 提交 饮食记录  健康日记-饮食 9 - 9.1  ——————————1——————————
 userID: 用户id
 model：饮食记录模型
 */
+ (BOOL)sendDietRecordWithUID:(NSString*)userID andModel:(FoodRecordModel*)model{
    GDataXMLElement * root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_UPINFO];
    GDataXMLElement * data = [GDataXMLElement elementWithName:DATA];
    GDataXMLElement * uid = [GDataXMLElement elementWithName:UID stringValue:userID];
    GDataXMLElement * record = [GDataXMLElement elementWithName:Record];
    GDataXMLElement * date = [GDataXMLElement attributeWithName:USERTARGET_DATE stringValue:model.date];
    GDataXMLElement * updtime = [GDataXMLElement elementWithName:upDataTime stringValue:model.updtime];
    GDataXMLElement * intake = [GDataXMLElement elementWithName:INTAKE stringValue:model.intake];
    GDataXMLElement * foodId = [GDataXMLElement attributeWithName:@"foodid" stringValue:model.foodId];
    GDataXMLElement * timePeriod = [GDataXMLElement attributeWithName:timeperiodFile stringValue:model.timeperiod];
    GDataXMLElement * time = [GDataXMLElement attributeWithName:@"time" stringValue:model.time];
    [root addChild:reqType];
    [data addChild:uid];
    [record addAttribute:date];
    [record addChild:updtime];
    [intake addAttribute:foodId];
    [intake addAttribute:timePeriod];
    [intake addAttribute:time];
    [record addChild:intake];
    [data addChild:record];
    [root addChild:data];
    
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithRootElement:root];
    [document setVersion:@"1.0"];
    [document setCharacterEncoding:@"UTF-8"];
    NSString * content = [[NSString alloc]initWithData:document.XMLData encoding:NSUTF8StringEncoding];
    NSData * getData = [WebUtilsCommon sendRequest:@"upFoodRecord" andContent:content];
//    NSString * str = [[NSString alloc]initWithData:getData encoding:NSUTF8StringEncoding];
    GDataXMLDocument * systemDoc = [[GDataXMLDocument alloc]initWithData:getData options:0 error:nil];
    GDataXMLElement * rootEle = [systemDoc rootElement];
    NSString * returnCode = [[[rootEle elementsForName:RETURN_CODE] objectAtIndex:0]stringValue];
    
    if ([returnCode isEqualToString:@"error"] ) {
        return NO;
    }
    return YES;
}
//上传 食物记录 到服务器

+ (BOOL)sendFoodRecordToSeverWithUID:(NSString *)userId{
    return [self sendRecordToSeverWithUID:userId andAddress:@"upFoodRecord" andFileSubfix:FOOD_RECORD_FILE];
}

//获取用户目标数据
+(NSData *)getUserTargetUseUID:(NSString *)UID{
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_GETINFO];
    [root addChild:reqType];
    GDataXMLElement *dataEle = [GDataXMLElement elementWithName:DATA];
    GDataXMLElement *uidEle = [GDataXMLNode elementWithName:Uid stringValue:UID];
    [dataEle addChild:uidEle];
    [root addChild:dataEle];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    NSString * content =   [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    NSData * getedData = [WebUtilsCommon sendRequest:@"getUserTarget" andContent:content];
     GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:getedData options:0 error:nil];
    //
    GDataXMLElement * rootElement = [doc rootElement];
    NSString * returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    if ([returnCode isEqualToString:@"error"]) {
        return nil;
    }
    return getedData;
}
//向服务器上传个人信息
+(BOOL)upUserInfoUseModel:(UserInfoModel *)model{
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];

    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_UPINFO];
    [root addChild:reqType];
    GDataXMLElement *dataEle = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement *uidEle = [GDataXMLElement elementWithName:UID stringValue:model.UID];
    [dataEle addChild:uidEle];
    
    GDataXMLElement * nameELe = [GDataXMLElement elementWithName:UNAME stringValue:model.Name];
    [dataEle addChild:nameELe];
    
    GDataXMLElement * UPinyinELe = [GDataXMLElement elementWithName:UPinyin stringValue:model.Pinyin];
    [dataEle addChild:UPinyinELe];
   
    GDataXMLElement * UNickNameEle = [GDataXMLElement elementWithName:UNickName stringValue:model.NickName];
    [dataEle addChild:UNickNameEle];
    
    GDataXMLElement * UEmailEle = [GDataXMLElement elementWithName:UEmail stringValue:model.Email];
    [dataEle addChild:UEmailEle];
    GDataXMLElement * UTelEle = [GDataXMLElement elementWithName:UTel stringValue:model.Tel];
    [dataEle addChild:UTelEle];
    GDataXMLElement * USexEle = [GDataXMLElement elementWithName:USex stringValue:model.Sex];
    [dataEle addChild:USexEle];
    GDataXMLElement * UBirthdayEle = [GDataXMLElement elementWithName:UBirthday stringValue:model.Birthday];
    [dataEle addChild:UBirthdayEle];
    GDataXMLElement * UHeightEle = [GDataXMLElement elementWithName:UHeight stringValue:model.Height];
    [dataEle addChild:UHeightEle];
    GDataXMLElement * UWeightEle = [GDataXMLElement elementWithName:UWeight stringValue:model.Weight];
    [dataEle addChild:UWeightEle];
    GDataXMLElement * UExIntensityEle = [GDataXMLElement elementWithName:UExIntensity stringValue:model.ExIntensity];
    [dataEle addChild:UExIntensityEle];
    GDataXMLElement * UDiabetesTypeEle = [GDataXMLElement elementWithName:UDiabetesType stringValue:model.DiabetesType];
    [dataEle addChild:UDiabetesTypeEle];
    GDataXMLElement * UComplicationEle = [GDataXMLElement elementWithName:UComplication stringValue:model.Complication];
    [dataEle addChild:UComplicationEle];
    
    GDataXMLElement * URestHrEle = [GDataXMLElement elementWithName:URestHr stringValue:model.RestHr];
    [dataEle addChild:URestHrEle];

    GDataXMLElement * UFamilyHisELe = [GDataXMLElement elementWithName:UFamilyHis stringValue:model.FamilyHis];
    [dataEle addChild:UFamilyHisELe];

    GDataXMLElement * UCliDiagnosisEle = [GDataXMLElement elementWithName:UCliDiagnosis stringValue:model.CliDiagnosis];
    [dataEle addChild:UCliDiagnosisEle];
    
    GDataXMLElement * UinfoSet = [GDataXMLElement elementWithName:@"UInfoSet" stringValue:model.InfoSet];
    [dataEle addChild:UinfoSet];
    
    [root addChild:dataEle];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    NSString * content =   [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    
    NSData * getedData = [WebUtilsCommon sendRequest:@"upUserInfo" andContent:content];
    
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:getedData options:0 error:nil];
    //
    GDataXMLElement * rootElement = [doc rootElement];
    //
    NSString * returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    
    if ([returnCode isEqualToString:@"error"]) {
        return NO;
    }else{
        return YES;

    }
   
}
//向服务器上传目标信息 用户4
+(BOOL)upUserTargetFootUseUID:(NSString *)uid footStepValue:(NSString *)footstepvalue Index:(NSString *)index Date:(NSString *)date{

        GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
        
        GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_UPINFO];
        [root addChild:reqType];
        GDataXMLElement *dataEle = [GDataXMLElement elementWithName:DATA];
        //用户信息节点
        GDataXMLElement *uidEle = [GDataXMLElement elementWithName:UID stringValue:uid];
        [dataEle addChild:uidEle];
    GDataXMLElement *SportStepEle = [GDataXMLElement elementWithName:USERTARGET_SPORTSTEP];
    
    GDataXMLElement *itemEle = [GDataXMLElement elementWithName:USERTARGET_ITEM];
    GDataXMLElement * indexAttr = [GDataXMLElement attributeWithName:USERTARGET_INDEX stringValue:index];
    [itemEle addAttribute:indexAttr];
    GDataXMLElement * dateAttr = [GDataXMLElement attributeWithName:USERTARGET_DATE stringValue:date];
    [itemEle addAttribute:dateAttr];
    GDataXMLElement * ValueEle = [GDataXMLElement elementWithName:USERTARGET_VALUE stringValue:footstepvalue];
    [itemEle addChild:ValueEle];
    [SportStepEle addChild:itemEle];
    [dataEle addChild:SportStepEle];
    [root addChild:dataEle];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    NSString * content =   [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    
    NSData * getedData = [WebUtilsCommon sendRequest:@"upUserTarget" andContent:content];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:getedData options:0 error:nil];
    //
    GDataXMLElement * rootElement = [doc rootElement];
    //
    NSString * returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    
    if ([returnCode isEqualToString:@"error"]) {
        return NO;
    }else{
        return YES;
        
    }
}
#pragma mark 用户咨询上传   医生回复
//向服务器发送咨询信息 咨询建议 -用户咨询3
+(BOOL)upDocAdvisoryUseUID:(NSString *)uid andUOrg:(NSString *)uorg andTitle:(NSString *)title TEXT:(NSString * )text andAdjunt:(NSString *)adjunt{
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_UPINFO];
    [root addChild:reqType];
    GDataXMLElement *dataEle = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement *uidEle = [GDataXMLElement elementWithName:UID stringValue:uid];
    [dataEle addChild:uidEle];
    GDataXMLElement * uorgEle = [GDataXMLElement elementWithName:UOrg stringValue:uorg];
    [dataEle addChild:uorgEle];
    GDataXMLElement * AdvisoryEle  = [GDataXMLElement elementWithName:ASVISORY];
    GDataXMLElement * TitleEle = [GDataXMLElement elementWithName:TITLE stringValue:title];
    [AdvisoryEle addChild:TitleEle];
    GDataXMLElement * TextEle = [GDataXMLElement elementWithName:TEXT stringValue:text];
    [AdvisoryEle addChild:TextEle];
    GDataXMLElement * AdjunctEle = [GDataXMLElement elementWithName:ADJUNCT stringValue:adjunt];
    [AdvisoryEle addChild:AdjunctEle];
    
    [dataEle addChild:AdvisoryEle];
    [root addChild:dataEle];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    
    NSString * content =   [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    NSData * getedData = [WebUtilsCommon sendRequest:USERUPDOCADVISORY andContent:content];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:getedData options:0 error:nil];
    GDataXMLElement * rootElement = [doc rootElement];
    NSString * returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    if ([returnCode isEqualToString:@"error"]) {
        return NO;
    }else{
        return YES;
    }
}
//上传图片方法
/**
 *  上传图片的方法
 *
 *  @param image     图片对象
 *  @param filename  文件名 用户名-时间戳（毫秒级）-文件扩展名 转成16进制后然后 再转成大写
 *  @param Uuid      uuid
 *  @param extersion 文件扩展名 png&&jpg
 *
 *  @return 返回是否上传成功
 */
+ (BOOL) imageUpload:(UIImage *) image filename:(NSString *)filename UUID:(NSString * )Uuid picExtersion:(NSString *)extersion{
    NSData *imageData = nil;
    //把图片转换成imageDate格式
    if ([extersion isEqualToString:@"JPG"]||[extersion isEqualToString:@"JPEG"]) {
          imageData = UIImageJPEGRepresentation(image, 1.0);
    }else if([extersion isEqualToString:@"PNG"]){
        imageData = UIImagePNGRepresentation(image);
    }
    //传送路径
    NSString *urlString = [WEB_SERVER_URL stringByAppendingString:@"uploadFile"];
    //建立请求对象
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    //设置请求路径
    [request setURL:[NSURL URLWithString:urlString]];
    //请求方式
    [request setHTTPMethod:@"POST"];
    //一连串上传头标签
    NSString *boundary = [NSString stringWithFormat:@"%@",Uuid];//uuid
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString * content = [NSString stringWithFormat:@"Content-Disposition: form-data;name=\"upload\";filename=\"%@\"\r\n",filename] ;
    [body appendData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    //上传文件开始
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    __block typeof (imageData)weakData = imageData;
    dispatch_semaphore_t semaphore =  dispatch_semaphore_create(0);
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        weakData = data;
        dispatch_semaphore_signal(semaphore);
    }] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //获得返回值
    NSString *returnString = [[NSString alloc] initWithData:weakData encoding:NSUTF8StringEncoding];
    if ([returnString isEqualToString:@"error"]) {
        return NO;
    }else{
        return YES;
    }
}

/**
 *  下载用户咨询 数据  用户咨询请求（2.1）
 *
 *  @param uid      用户id
 *  @param datatime 上次更新时间
 *
 *  @return 返回数据
 */
+(NSData *)downDoctorAdvisoryUseUID:(NSString *)uid dataTime:(NSString *)datatime{
    
    NSString * content = [self XMLOfAdvisoryAndInstructWithUID:uid andDateTime:datatime];
    NSData * getedData = [WebUtilsCommon sendRequest:USERDOWNDOCTORADVISORY andContent:content];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:getedData options:0 error:nil];
    GDataXMLElement * rootElement = [doc rootElement];
    NSString * returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    if ([returnCode isEqualToString:@"error"]) {
         return nil;
    }else{
        return getedData;
    }
}

//用户咨询回复上传（4.1）(未测试)
+(NSData *)upAdvisoryReplyUseUID:(NSString *)uid AndUOrg:(NSString *)uorg AndRecId:(NSString *)RecId AndMaxId:(NSString *)MaxId AndUsrId:(NSString *)UsrId AndText:(NSString *)Text andAdjunct:(NSString *)Adjunct{
  return  [self upAdvisoryReplyUseUID:uid AndUOrg:uorg AndRecId:RecId AndMaxId:MaxId AndUsrId:UsrId AndText:Text andAdjunct:Adjunct AndAddress:USERUPADVISORYREPLY];
}

//
/**
 *  获取医师建议   请求 2.1
 *
 *  @param uid      用户id
 *  @param dataTime 上次更新时间
 *
 *  @return 网络下载的数据
 */
+(NSData *)downDoctorInstructUseUID:(NSString *)uid andDataTime:(NSString *)dataTime{
    NSString * content = [self XMLOfAdvisoryAndInstructWithUID:uid andDateTime:dataTime];
    NSData * getedData = [WebUtilsCommon sendRequest:DOCTORDOWNDOCTORINSTRUCT andContent:content];
  
    return getedData;
}
//上传医生回复 3.1
+(NSData *)upDoctorInstructReplyUseUID:(NSString *)uid AndUOrg:(NSString *)uorg AndRecId:(NSString *)RecId AndMaxId:(NSString *)MaxId AndUsrId:(NSString *)UsrId AndText:(NSString *)Text andAdjunct:(NSString *)Adjunct{
  return [self upAdvisoryReplyUseUID:uid AndUOrg:uorg AndRecId:RecId AndMaxId:MaxId AndUsrId:UsrId AndText:Text andAdjunct:Adjunct AndAddress:DOCTORUPINSTRUCTREPLY];
}
+(NSString *)XMLOfAdvisoryAndInstructWithUID:(NSString*)userId andDateTime:(NSString*)dateTime{
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_GETINFO];
    [root addChild:reqType];
    GDataXMLElement *dataEle = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement *uidEle = [GDataXMLElement elementWithName:UID stringValue:userId];
    [dataEle addChild:uidEle];
    GDataXMLElement * datatimeEle = [GDataXMLElement elementWithName:DATATIME stringValue:dateTime];
    [dataEle addChild:datatimeEle];
    [root addChild:dataEle];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    NSString * content = [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    return content;
    
    
}
//上传 用户咨询 和 医生回复 的咨询建议
+(NSData *)upAdvisoryReplyUseUID:(NSString *)uid AndUOrg:(NSString *)uorg AndRecId:(NSString *)RecId AndMaxId:(NSString *)MaxId AndUsrId:(NSString *)UsrId AndText:(NSString *)Text andAdjunct:(NSString *)Adjunct AndAddress:(NSString*)addresss{
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_UPINFO];
    [root addChild:reqType];
    GDataXMLElement *dataEle = [GDataXMLElement elementWithName:DATA];
    //用户信息节点
    GDataXMLElement *uidEle = [GDataXMLElement elementWithName:UID stringValue:uid];
    [dataEle addChild:uidEle];
    GDataXMLElement * uorgEle = [GDataXMLElement elementWithName:UOrg stringValue:uorg];
    [dataEle addChild:uorgEle];
    GDataXMLElement * RecIdEle = [GDataXMLElement elementWithName:RECID stringValue:RecId];
    [dataEle addChild:RecIdEle];
    GDataXMLElement * MaxIdEle = [GDataXMLElement elementWithName:MAXID stringValue:MaxId];
    [dataEle addChild:MaxIdEle];
    GDataXMLElement * replyEle =[GDataXMLElement elementWithName:REPLY];
    GDataXMLElement * UsrIdEle = [GDataXMLElement elementWithName:REPLY_USERID stringValue:UsrId];
    [replyEle addChild:UsrIdEle];
    GDataXMLElement * TextEle =[GDataXMLElement elementWithName:TEXT stringValue:Text];
    [replyEle addChild:TextEle];
    GDataXMLElement * AdjunctEle = [GDataXMLElement elementWithName:ADJUNCT stringValue:Adjunct];
    [replyEle addChild:AdjunctEle];
    
    [dataEle addChild:replyEle];
    [root addChild:dataEle];
    //设置文档信息
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    
    NSString * content =   [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    NSData * getedData = [WebUtilsCommon sendRequest:addresss andContent:content];
    GDataXMLDocument * doc = [[GDataXMLDocument alloc] initWithData:getedData options:0 error:nil];
    GDataXMLElement * rootElement = [doc rootElement];
    NSString * returnCode = [[[rootElement elementsForName:RETURN_CODE] objectAtIndex:0] stringValue];
    if ([returnCode isEqualToString:@"error"]||returnCode == nil ) {
        return nil;
        NSLog(@"上传 咨询请求信息出现错误");
    }else{
        NSLog(@"上传 咨询请求请求信息成功");
    }
    return getedData;
}
#pragma mark 微信分享 上传的内容
// 上传 分享 食物 数组
+ (NSString *)upToSeverOfWeixinWithUID:(NSString*)userId andFoodArray:(NSArray*)foodArray ImageName:(NSString*)imageName andDate:(NSString*)date{
    GDataXMLElement * rootEle = [GDataXMLElement elementWithName:@"Diet"];
    GDataXMLElement * dateEle = [GDataXMLElement elementWithName:@"Date" stringValue:date];
    GDataXMLElement * foodListELe = [GDataXMLElement elementWithName:@"FoodList"];
    
    if (foodArray.count) {
        for (FoodRecordModel* model in foodArray) {
            GDataXMLElement * periedEle = [GDataXMLElement elementWithName:@"period" stringValue:model.timeperiod];
            foodmodel * cataM = [FileUtils readFoodWithFoodID:model.foodId];
            GDataXMLElement * foodEle = [GDataXMLElement elementWithName:@"Food" stringValue:model.intake];
            GDataXMLElement * nameEle = [GDataXMLElement elementWithName:@"name" stringValue:cataM.FoodName];
            GDataXMLElement * unitEle = [GDataXMLElement elementWithName:@"unit" stringValue:cataM.UnitName];
            [foodEle addAttribute:periedEle];
            [foodEle addAttribute:nameEle];
            [foodEle addAttribute:unitEle];
            [foodListELe addChild:foodEle];
        }
    }
    [rootEle addChild:foodListELe];
    [rootEle addChild:dateEle];
    NSString * descStr = [rootEle XMLString];

    NSString * content = [self shareToWXOfXMLWithUID:userId type:@"02" description:descStr imageName:imageName];
    NSData * getedData = [WebUtilsCommon sendRequest:@"upWxShare" andContent:content];
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:getedData options:0 error:nil];
    GDataXMLElement * getRoot = [document  rootElement];
    GDataXMLElement * dataGet = [[getRoot elementsForName:DATA]firstObject];
    
   NSString * sidStr = [[[dataGet elementsForName:@"SID"]firstObject]stringValue];
//    NSLog(@"%@",sidStr);
    return sidStr;
}
+ (NSString *)upToSeverOfWeixinWithUID:(NSString*)userId andSportArray:(NSArray*)sportArray ImageName:(NSString*)imageName andDate:(NSString*)date{
    GDataXMLElement * sportEle = [GDataXMLElement elementWithName:@"Sport"];
    GDataXMLElement * dateEle = [GDataXMLElement elementWithName:@"Date" stringValue:date];
    GDataXMLElement * timesEle = [GDataXMLElement elementWithName:@"Times" stringValue:[NSString stringWithFormat:@"%d",sportArray.count]];
    int timeLength = 0;
    float hotTotal = 0;
    GDataXMLElement * sportListEle = [GDataXMLElement elementWithName:@"SportList"];
    for (SportRecordModel* model in sportArray) {
      sportCataModel * cataM = [SportFileUtils readSportCataWith:model.Type];
        GDataXMLElement * nameEle = [GDataXMLElement attributeWithName:@"name" stringValue:cataM.Name];
        GDataXMLElement * resultEle = [GDataXMLElement attributeWithName:@"result" stringValue:model.Result];
        GDataXMLElement * itemEle = [GDataXMLElement elementWithName:@"Item" stringValue:model.time];
        [itemEle addAttribute:nameEle];
        [itemEle addAttribute:resultEle];
        [sportListEle addChild:itemEle];
        timeLength += model.TimeLength.intValue;
        hotTotal += (model.TimeLength.intValue/60)*cataM.Energy.floatValue;
    }
    if (timeLength) {
        GDataXMLElement * energyEle = [GDataXMLElement elementWithName:@"Energy" stringValue:[NSString stringWithFormat:@"%d",(int)hotTotal]];
        [sportEle addChild:energyEle];
    }
    if (hotTotal) {
         GDataXMLElement * secondsEle = [GDataXMLElement elementWithName:@"Seconds" stringValue:[NSString stringWithFormat:@"%d",timeLength]];
        [sportEle addChild:secondsEle];
    }
    if (sportArray.count) {
        [sportEle addChild:timesEle];
        [sportEle addChild:sportListEle];
    }
    [sportEle addChild:dateEle];
    NSString * sportStr = [sportEle XMLString];
    NSString * content = [self shareToWXOfXMLWithUID:userId type:@"01" description:sportStr imageName:imageName];
    NSData * getedData = [WebUtilsCommon sendRequest:@"upWxShare" andContent:content];
    
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:getedData options:0 error:nil];
    GDataXMLElement * getRoot = [document  rootElement];
    GDataXMLElement * dataGet = [[getRoot elementsForName:DATA]firstObject];
    
    NSString * sidStr = [[[dataGet elementsForName:@"SID"]firstObject]stringValue];
    NSLog(@"%@",sidStr);
    return sidStr;
}
//分享 基础 xml 拼接
+ (NSString *)shareToWXOfXMLWithUID:(NSString*)userId type:(NSString*)type description:(NSString*)description imageName:(NSString*)imagename {
    GDataXMLElement *root = [GDataXMLElement elementWithName:ROOT];
    GDataXMLElement * reqType = [GDataXMLElement elementWithName:REQ_TYPE stringValue:CLIENT_MODE_UPINFO];
    [root addChild:reqType];
    GDataXMLElement *dataEle = [GDataXMLElement elementWithName:DATA];
    GDataXMLElement *uidEle = [GDataXMLElement elementWithName:UID stringValue:userId];
    [dataEle addChild:uidEle];
    GDataXMLElement * typeEle = [GDataXMLElement elementWithName:@"Type" stringValue:type];
    
    GDataXMLElement * descriptionEle = [GDataXMLElement elementWithName:@"Description" stringValue:description];
    
    GDataXMLElement * imageEle = [GDataXMLElement elementWithName:@"IMG" stringValue:imagename ];
    [dataEle addChild:typeEle];
    [dataEle addChild:descriptionEle];
    [dataEle addChild:imageEle];
    [root addChild:dataEle];
    
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:root];
    [rootDoc setVersion:@"1.0"];
    [rootDoc setCharacterEncoding:@"UTF-8"];
    
    NSString * content =   [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    return content;
}

@end
