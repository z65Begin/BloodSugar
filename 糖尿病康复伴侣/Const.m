//
//  Const.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "Const.h"

@implementation Const

//用户名
NSString * const USER_ID = @"com.hbis.app.uid";
//密码
NSString * const USER_PWD = @"com.hbis.app.pwd";

// 设置
NSString * const SETTING_DICTIONARY = @"healthdiab_configure_";
NSString * const SETTING_Sync = @"AutoSync";
NSString * const SETTING_ONLYWIFI = @"WifiOnly";
NSString * const SETTING_WARNING = @"NotifySet";
NSString * const SETTING_DIETHIDDEN = @"dietHidden";
NSString * const SETTING_SPORTHIDDEN = @"sportHidden";
NSString * const SETTING_BODYSIGNHIDDEN = @"bodySignHidden";
NSString * const SETTING_MEDICINEHIDDEN = @"medicineHidden";
NSString * const SETTING_SYNCHISTIME = @"SyncHisTime";


//服务器ip
//NSString *const WEN_SERVER_IP =@"192.168.19.144";
NSString *const WEN_SERVER_IP =@"http://www.halsma.com";
//服务器地址
NSString *const WEB_SERVER_URL = @"http://www.halsma.com/healthdiabetes/client/";


////测试服务器
//NSString *const WEN_SERVER_IP =@"192.168.2.222";
//
//NSString *const WEB_SERVER_URL = @"http://192.168.2.222:8080/healthdiabetes/client/";

//用户信息文件
NSString *const USER_INFO_FILE = @"_info.xml";

NSString *const CLIENT_SERVER_GETINFO = @"getUserInfo";
/******用户*****/
//用户信息-密码
NSString *const U_id = @"UID";
NSString *const U_Password = @"Password";
NSString *const U_Name = @"Name";
NSString *const U_Pinyin = @"Pinyin";
NSString *const U_NickName = @"NickName";
NSString *const U_Org = @"Org";
NSString *const U_Type = @"Type";
NSString *const U_Email = @"Email";
NSString *const U_Tel = @"Tel";
NSString *const U_Sex = @"Sex";
NSString *const U_Birthday = @"Birthday";
NSString *const U_Height = @"Height";
NSString *const U_Weight = @"Weight";
NSString *const U_ExIntensity = @"ExIntensity";
NSString *const U_DiabetesType = @"DiabetesType";
NSString *const U_Complication = @"Complication";
NSString *const U_RestHr = @"RestHr";
NSString *const U_FamilyHis = @"FamilyHis";
NSString *const U_CliDiagnosis = @"CliDiagnosis";
NSString *const U_InfoSet = @"InfoSet";
NSString *const U_SecureSet = @"SecureSet";
//下载的用户信息-密码
NSString *const Uid = @"UID";//用户ID
NSString *const UOrg= @"UOrg";//机构ID
NSString *const UPassword = @"Password";

NSString *const UName= @"UName";//姓名
NSString *const UPinyin= @"UPinyin";//拼音
NSString *const UNickName= @"UNickName";//昵称

NSString *const UType= @"UType";//用户类型
NSString *const UEmail= @"UEmail";//邮箱地址
NSString *const UTel= @"UTel";//联系电话
NSString *const USex= @"USex";//用户性别
NSString *const UBirthday= @"UBirthday";//生日
NSString *const UHeight= @"UHeight";//身高
NSString *const UWeight= @"UWeight";//体重
NSString *const UExIntensity= @"UExInten";//活动强度
NSString *const UDiabetesType= @"UDiabType";//糖尿病类型
NSString *const UComplication= @"UComplication";//并发症
NSString *const URestHr= @"RestHr";//静止心率
NSString *const UFamilyHis= @"UFamilyHis";//家族病史
NSString *const UCliDiagnosis= @"UCliDiag";//临床诊断
NSString *const UInfoSet= @"UInfoSet";//个人信息设置标记
NSString *const USecureSet= @"USecSet";//安全信息设置标记
/*********验证登录用节点************/
NSString *const VERIFY_LOGIN = @"verifyLogin";
NSString *const U_ID_LOGIN = @"LoginId";
NSString *const U_TYPE_LOGIN = @"Type";
NSString *const U_PWD_LOGIN = @"LoginPwd";
NSString *const U_VERSION_LOGIN = @"Version";
//客户端请求模式-登录
NSString *const CLIENT_MODE_LOGIN = @"reqLogin";
NSString *const REQ_TYPE = @"ReqType";


NSString *const CLIENT_MODE_GETINFO = @"getInfo";

NSString *const CLIENT_MODE_UPINFO  = @"upInfo";
NSString *const CLIENT_MODE_GETUSERINFO = @"getUserInfo";
//服务器返回code
NSString *const RETURN_CODE = @"ReturnCode";

//注册
NSString *const USER_REGIST = @"userRegist";
NSString *const UID = @"UID";
NSString *const PASSWORD = @"Password";
NSString *const UNAME = @"UName";
NSString *const USEX = @"USex";
//更改密码
NSString *const OLDPASSWORD = @"OldPwd";
NSString *const NEWPASSWORD = @"NewPwd";
NSString *const CHANGEPASSWORD =@"alterPassword";

//饮食记录
NSString *const FOOD_RECORD_FILE = @"_food_record.xml";
NSString *const INTAKE = @"Intake";
//食物
NSString *const UPDATAFOODINFO = @"updateFoodInfo";
NSString *const FOOD_DATA_FILE = @"food_data.xml";
NSString * const CateListELE = @"CateList";
NSString * const FoodListELE = @"FoodList";
NSString * const CategoryELE = @"Category";
NSString * const FoodELE =@"Food";
NSString * const CateName = @"CateName";

NSString * const FoodCateID = @"cate";
NSString * const FoodID = @"id";
NSString * const UnitValue = @"UnitValue";
NSString * const UnitName = @"UnitName";
NSString * const UnitEnergy = @"UnitEnergy";
NSString * const UnitGI = @"UnitGI";
NSString * const UnitH2O = @"UnitH2O";
NSString * const UnitProtein = @"UnitProtein";
NSString * const UnitFat = @"UnitFat";
NSString * const UnitDieFiber = @"UnitDieFiber";
NSString * const UnitCarbs = @"UnitCarbs";
NSString * const UnitVA = @"UnitVA";
NSString * const UnitVB1 = @"UnitVB1";
NSString * const UnitVB2 = @"UnitVB2";
NSString * const UnitVC = @"UnitVC";
NSString * const UnitVE = @"UnitVE";
NSString * const UnitNiacin = @"UnitNiacin";
NSString * const UnitNa = @"UnitNa";
NSString * const UnitCa = @"UnitCa";
NSString * const UnitFe = @"UnitFe";
NSString * const UnitChol = @"UnitChol";
NSString * const DelFlag = @"DelFlag";

//饮食时间段
NSString * const DIET_TIMEPER_BRFFAST = @"10"; //早餐
NSString * const DIET_TIMEPER_EXTRA1 = @"11";  //早餐加餐
NSString * const DIET_TIMEPER_LUNCH = @"20";   //午餐
NSString * const DIET_TIMEPER_EXTRA2 = @"21";  //午餐加餐
NSString * const DIET_TIMEPER_DINNER = @"30";  //晚餐
NSString * const DIET_TIMEPER_NTSAKE = @"31";  //夜宵
NSString * const DIET_TIMEPER_NOTFOOD = @"00"; //非饮食

/******************** 运动 ********************/
//运动
NSString *const TYPELIST = @"TypeList";
NSString *const TYPE = @"Type";

NSString *const NAME = @"Name";
NSString *const ENERGY = @"Energy";
NSString *const GETSPORTTYPE = @"getSportType";
NSString *const SPORT_TYPE_FILE = @"sport_type.xml";

NSString * const SPORT_Record = @"syncSportRecord"; //运动记录

NSString * const SPORT_RECORD_FILE = @"_sport_record.xml";
NSString * const SPORT_Record_Sport = @"Sport";
NSString * const SPORT_Record_time = @"time";
NSString * const SPORT_Record_TimeLength = @"TimeLength";
NSString * const SPORT_RECORD_Result = @"Result";
//运动效果 Result
NSString * const SPORT_Result_00 = @"00";//正常呼吸没有不适
NSString * const SPORT_Result_01 = @"01";//呼吸加快但可以与人正常交谈
NSString * const SPORT_Result_02 = @"02";//呼吸急促 还可以交谈 但有困难
NSString * const SPORT_Result_03 = @"03";//气喘 甚至伴有胸闷等其他不适


//血糖
NSString *const SUGAR_RECORD_FILE = @"_sugar_record.xml";
NSString *const SUGAR_BloodSugar = @"BloodSugar";
NSString *const SUGAR_timeper = @"timeper";
NSString *const SUGAR_timespan = @"timespan";
NSString *const SUGAR_Send_syncSugarRecord = @"syncSugarRecord"; //2.1 获取血糖记录请求
//血糖时段
NSString *const SUGAR_timeper_breakfast = @"11";
NSString *const SUGAR_timeper_breakfast_after = @"12";
NSString *const SUGAR_timeper_lunch = @"21";
NSString *const SUGAR_timeper_lunch_after = @"22";
NSString *const SUGAR_timeper_dinner = @"31";
NSString *const SUGAR_timeper_dinner_after = @"32";
NSString *const SUGAR_timeper_bedtime = @"41";
//体征
NSString *const BODYSIGN_syncBodySignRecord = @"syncBodySignRecord";// 2.1 获取体征记录请求
NSString *const BODYSIGN_RECORD_FILE = @"_bodysign_record.xml";

NSString *const BODYSIGN_RECORD_Weight = @"Weight";//体重
NSString *const BODYSIGN_RECORD_DBP = @"DBP";//舒张压
NSString *const BODYSIGN_RECORD_SBP = @"SBP";//收缩压
NSString *const BODYSIGN_RECORD_Temperature = @"Temperature";//体温
NSString *const BODYSIGN_RECORD_BlipidChol = @"BlipidChol";//血脂总胆固醇
NSString *const BODYSIGN_RECORD_BlipidTG = @"BlipidTG";//血脂甘油三酯
NSString *const BODYSIGN_RECORD_BlipidHDLIP = @"BlipidHDLIP";//血脂高密度脂蛋白
NSString *const BODYSIGN_RECORD_BlipidLDLIP = @"BlipidLDLIP";//血脂低密度脂蛋白
NSString *const BODYSIGN_RECORD_GlyHemoglobin = @"GlyHemoglobin";//糖化血红蛋白
NSString *const BODYSIGN_RECORD_TotalBilirubin = @"TotalBilirubin";//总胆红素
NSString *const BODYSIGN_RECORD_DirectBilirubin = @"DirectBilirubin";//直接胆红素
NSString *const BODYSIGN_RECORD_SerumCreatinine = @"SerumCreatinine";//血清肌酐
NSString *const BODYSIGN_RECORD_UricAcid = @"UricAcid";//尿酸
NSString *const BODYSIGN_RECORD_MiAlbuminuria = @"MiAlbuminuria";//微蛋白尿检
NSString *const BODYSIGN_RECORD_Fundus = @"Fundus";//眼底
NSString *const BODYSIGN_RECORD_Plantar = @"Plantar";//足底

//用药
NSString *const GETMEDICINETYPE = @"updateMedicineInfo";
NSString *const MEDICINE_TYPE_FILE = @"medicine_data.xml";

NSString *const MEDICINE_RECORD_FILE = @"_medication_record.xml";
NSString *const MEDICINE_RECID = @"recid";
NSString *const MEDICINE_RECORD_MEDNAME = @"MedName";
NSString *const MEDICINE_RECORD_AmountTimes = @"AmountTimes";
NSString *const MEDICINE_RECORD_AMountUnit = @"AMountUnit";
NSString *const MEDICINE_RECORD_UnitName = @"UnitName";
NSString *const MEDICINE_RECORD_Notes = @"Notes";
NSString * const MEDICINE_RECORD_Medication = @"Medication";


NSString *const Medicine = @"Medicine";
NSString *const Alias = @"Alias";
NSString *const MedicList = @"MedicList";
NSString *const amountTime = @"amountTimes";
//用药记录
NSString * const syncMedicationRecord = @"syncMedicationRecord";
//药物记录写入
NSString * const medicineWriteRecord =@"medicineWriteRecord.xml";
NSString * const Record = @"Record";
NSString * const upMedicationRecord = @"upMedicationRecord";
NSString * const upDataTime = @"UpdTime";
NSString * const Medication = @"Medication";
/********************通用节点********************/
//跟节点
NSString *const ROOT = @"Root";
NSString *const DATA = @"Data";
NSString *const DATATIME = @"DataTime";
NSString *const SID = @"id";
//客户端请求模式-获取数据
NSString *const CLIENT_MODE_GET = @"get";
//客户端请求模式-获取数据
NSString *const CLIENT_MODE_POST = @"POST";

/********************站内信文件节点********************/

//最后更新时间
NSString *const  UPDATE_TIME = @"UpdateTime";
//list
NSString *const MAIL_LIST = @"MailList";
NSString *const NOTIFY_LIST = @"NotifyList";
//邮件
NSString *const MAIL = @"Mail";
//公告
NSString *const NOTIFY = @"Notify";

NSString *const IGNORE = @"Ignore";
/**公告*/
NSString *const USER_INNER_NOTICE_FILE = @"_innerNotify.xml";

//邮件id
NSString *const M_ID = @"mid";
//已读/未读
NSString *const OPENED = @"Opened";
//标题
NSString *const TITLE = @"Title";
//正文
NSString *const CONTENT = @"Content";
//发送时间
NSString *const SEND_TIME = @"SendTime";
//附件
NSString *const ADJUNCT = @"Adjunct";
//发送ID
NSString *const SENDER_ID = @"SenderId";
//发送者姓名
NSString *const SENDER_NAME = @"SenderName";
/*********站内信************/
NSString *const CLIENT_SERVER_INNERMAIL = @"getUserInnerMail";
//NSString *const DATATIME = @"DataTime";

/*********站内信************/
NSString *const CLIENT_SERVER_INNERNOTICE = @"GetUserInnerNotify";
/**站内信*/
NSString *const USER_INNER_MAIL_FILE = @"_innerMail.xml";
NSString *const MID = @"mid";

/*****************基准数据*********************/
NSString *const BaselineFileName =@"baseline.xml";
NSString *const Baseline = @"Baseline";
NSString *const value = @"Value";
NSString *const Backup = @"Backup";
NSString *const Code = @"Code";

/*****************食物推荐***************************/
NSString *const FOODLISTRECOMMENDFILE = @"food_menu.xml";
NSString *const MENUADVICE=@"MenuAdvice";
NSString *const ADVICE = @"Advice";
NSString *const MENUID = @"MenuId";
NSString *const ENERGYLV = @"EnergyLv";

NSString *const MENU = @"Menu";
NSString *const MENULIST = @"MenuList";
NSString *const FOODINFO =@"FoodInfo";
NSString *const TIMEPERIOD = @"TimePeriod";
NSString *const FOODINTAKE = @"FoodIntake";
NSString * const FoodRecommendID = @"FoodId";
NSString * const FOODDATE =  @"date";//食谱日期
NSString * const FOOD = @"Food";
NSString * const  FID= @"fid";
NSString * const  FoodRequestId = @"FoodId";
NSString * const  timeperiodFile =  @"timeperiod";
NSString *const FOODRECOMMENDINTAKE = @"intake";
NSString *const FOODRECOMMENDENERGYLV = @"energylv";

/*****************食物推荐食谱***************************/
NSString *const FOODFILEMENU = @"_menu_favorite.xml";
NSString *const FAVORITE = @"Favorite";
NSString *const COMMENT = @"Comment";
NSString *const CRTTIME = @"CrtTime";

/*************************运动目标**********/
NSString *const USERTARGET_FIELDNAME  = @"_target.xml";
NSString *const USERTARGET_SPORTSTEP = @"SportStep";
NSString *const USERTARGET_ITEM = @"Item";
NSString *const USERTARGET_INDEX = @"index";
NSString *const USERTARGET_DATE = @"date";
NSString *const USERTARGET_VALUE = @"Value";

/********************咨询上传*****************/
NSString *const  ASVISORY = @"Advisory";
NSString *const  TEXT = @"Text";


/****************用户咨询文件*******************/
NSString *const  ASVISORYFILENAME = @"_advisory.xml";
NSString * const ASVISORYREPLYFILENAME = @"_advisory_reply.xml";
NSString *const REPLYLIST =   @"ReplyList";
NSString *const REPLY = @"Reply";
NSString *const REPLY_RID = @"rid";
NSString *const REPLY_USERID = @"UsrId";
NSString *const REPLY_USERNAME = @"UsrName";
NSString *const REPLY_ISNEW = @"IsNew";
/************用户咨询数据***************************/
NSString *const USERDOWNDOCTORADVISORY = @"downDoctorAdvisory";//获取用户咨询请求
NSString *const USERUPDOCADVISORY = @"upDocAdvisory";//咨询上传
NSString *const USERUPADVISORYREPLY = @"upAdvisoryReply";//咨询回复
///＊咨询回复上传＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊*/
NSString *const RECID = @"RecId";
NSString *const MAXID = @"MaxId";

/*医师建议数据文件************************/
NSString *const DOCTORINSTRUCTFILENAME = @"_docinstruct.xml";
NSString *const INSTRUCT = @"Instruct";
NSString *const DOCID = @"DocID";
NSString *const DOCNAME  = @"DocName";
NSString *const DOCTORINSTRUCTREPLYFILENAME = @"_docinstruct_reply.xml";
NSString *const RPLTIME = @"RplTime";


/**获取医师的建议和请求*********************/
NSString *const DOCTORDOWNDOCTORINSTRUCT = @"downDoctorInstruct";//医生的请求
NSString *const DOCTORUPINSTRUCTREPLY = @"upInstructReply";//医师回复
@end
