//
//  Const.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Const : NSObject

//用户名
extern NSString * const USER_ID;
//密码
extern NSString * const USER_PWD;

// 设置
extern NSString * const SETTING_DICTIONARY;
extern NSString * const SETTING_Sync;
extern NSString * const SETTING_ONLYWIFI;
extern NSString * const SETTING_WARNING;
extern NSString * const SETTING_DIETHIDDEN;
extern NSString * const SETTING_SPORTHIDDEN;
extern NSString * const SETTING_BODYSIGNHIDDEN;
extern NSString * const SETTING_MEDICINEHIDDEN;
extern NSString * const SETTING_SYNCHISTIME;


//服务器ip
extern NSString * const WEN_SERVER_IP;
//服务器地址
extern NSString * const WEB_SERVER_URL;

/**用户信息文件*/
extern NSString * const USER_INFO_FILE;

extern NSString * const CLIENT_SERVER_GETINFO;

//用户信息-密码
extern NSString * const U_id;
extern NSString * const U_Password;
extern NSString * const U_Name;
extern NSString * const U_Pinyin;
extern NSString * const U_NickName;
extern NSString * const U_Org;
extern NSString * const U_Type;
extern NSString * const U_Email;
extern NSString * const U_Tel;
extern NSString * const U_Sex;
extern NSString * const U_Birthday;
extern NSString * const U_Height;
extern NSString * const U_Weight;
extern NSString * const U_ExIntensity;
extern NSString * const U_DiabetesType;
extern NSString * const U_Complication;
extern NSString * const U_RestHr;
extern NSString * const U_FamilyHis;
extern NSString * const U_CliDiagnosis;
extern NSString * const U_InfoSet;
extern NSString * const U_SecureSet;
//下载的用户信息-密码
extern NSString * const Uid;
extern NSString * const UPassword;
extern NSString * const UName;
extern NSString * const UPinyin;
extern NSString * const UNickName;
extern NSString * const UOrg;
extern NSString * const UType;
extern NSString * const UEmail;
extern NSString * const UTel;
extern NSString * const USex;
extern NSString * const UBirthday;
extern NSString * const UHeight;
extern NSString * const UWeight;
extern NSString * const UExIntensity;
extern NSString * const UDiabetesType;
extern NSString * const UComplication;
extern NSString * const URestHr;
extern NSString * const UFamilyHis;
extern NSString * const UCliDiagnosis;
extern NSString * const UInfoSet;
extern NSString * const USecureSet;
/*********验证登录用节点************/
extern NSString * const VERIFY_LOGIN;
extern NSString * const U_ID_LOGIN;
extern NSString * const U_PWD_LOGIN;
extern NSString * const U_TYPE_LOGIN;
extern NSString * const U_VERSION_LOGIN;
//客户端请求模式-登录
extern NSString * const CLIENT_MODE_LOGIN;
extern NSString * const REQ_TYPE;

//服务器返回code
extern NSString * const RETURN_CODE;

//注册
extern NSString * const USER_REGIST;
extern NSString * const UID;
extern NSString * const PASSWORD;
extern NSString * const UNAME;
extern NSString * const USEX;
//更改密码
extern NSString *const OLDPASSWORD;
extern NSString *const NEWPASSWORD;
extern NSString *const CHANGEPASSWORD;
/**客户端请求模式-获取数据*/
extern NSString *const CLIENT_MODE_GETINFO;
/**客户端请求模式-上传数据*/
extern NSString *const CLIENT_MODE_UPINFO;
/**客户端请求模式-获取用户数据*/
extern NSString *const CLIENT_MODE_GETUSERINFO;
//食物
extern NSString * const UPDATAFOODINFO;
extern NSString * const FOOD_DATA_FILE;
extern NSString * const CateListELE;
extern NSString * const CategoryELE;
extern NSString * const FoodELE;
extern NSString * const FoodListELE;

extern NSString * const FoodCateID;
extern NSString * const FoodID;
extern NSString * const CateName;
extern NSString * const UnitValue;
extern NSString * const UnitName;
extern NSString * const UnitEnergy;
extern NSString * const UnitGI;
extern NSString * const UnitH2O;
extern NSString * const UnitProtein;
extern NSString * const UnitFat;
extern NSString * const UnitDieFiber;
extern NSString * const UnitCarbs;
extern NSString * const UnitVA;
extern NSString * const UnitVB1;
extern NSString * const UnitVB2;
extern NSString * const UnitVC;
extern NSString * const UnitVE;
extern NSString * const UnitNiacin;
extern NSString * const UnitNa;
extern NSString * const UnitCa;
extern NSString * const UnitFe;
extern NSString * const UnitChol;
extern NSString * const DelFlag;
//饮食记录

extern NSString *const FOOD_RECORD_FILE;
extern NSString *const INTAKE;

//饮食时间段
extern NSString * const DIET_TIMEPER_BRFFAST;
extern NSString * const DIET_TIMEPER_EXTRA1;
extern NSString * const DIET_TIMEPER_LUNCH;
extern NSString * const DIET_TIMEPER_EXTRA2;
extern NSString * const DIET_TIMEPER_DINNER;
extern NSString * const DIET_TIMEPER_NTSAKE;
extern NSString * const DIET_TIMEPER_NOTFOOD;

//运动
#pragma  mark 运动
extern NSString * const TYPELIST;
extern NSString * const TYPE;
extern NSString * const SID;
extern NSString * const NAME;
extern NSString * const ENERGY;
extern NSString * const GETSPORTTYPE;
extern NSString * const SPORT_TYPE_FILE;
extern NSString * const SPORT_Record; //运动记录
extern NSString * const SPORT_RECORD_FILE;
extern NSString * const SPORT_Record_Sport;
extern NSString * const SPORT_Record_time;
extern NSString * const SPORT_Record_TimeLength;
extern NSString * const SPORT_RECORD_Result;
//运动效果
extern NSString * const SPORT_Result_00;//正常呼吸没有不适
extern NSString * const SPORT_Result_01;//呼吸加快但可以与人正常交谈
extern NSString * const SPORT_Result_02;//呼吸急促 还可以交谈 但有困难
extern NSString * const SPORT_Result_03;//气喘 甚至伴有胸闷等其他不适

// 血糖
extern NSString *const SUGAR_Send_syncSugarRecord;//网络

extern NSString *const SUGAR_RECORD_FILE;
extern NSString *const SUGAR_BloodSugar;
extern NSString *const SUGAR_timeper ;
extern NSString *const SUGAR_timespan ;

extern NSString *const SUGAR_timeper_breakfast;      //血糖时段参数 timeper
extern NSString *const SUGAR_timeper_breakfast_after;
extern NSString *const SUGAR_timeper_lunch ;
extern NSString *const SUGAR_timeper_lunch_after ;
extern NSString *const SUGAR_timeper_dinner ;
extern NSString *const SUGAR_timeper_dinner_after;
extern NSString *const SUGAR_timeper_bedtime ;
//体征
extern NSString *const BODYSIGN_syncBodySignRecord; //网络
extern NSString *const BODYSIGN_RECORD_FILE;

extern NSString *const BODYSIGN_RECORD_Weight;//体重
extern NSString *const BODYSIGN_RECORD_DBP;//舒张压
extern NSString *const BODYSIGN_RECORD_SBP;//收缩压
extern NSString *const BODYSIGN_RECORD_Temperature;//体温
extern NSString *const BODYSIGN_RECORD_BlipidChol;//血脂总胆固醇
extern NSString *const BODYSIGN_RECORD_BlipidTG;//血脂甘油三酯
extern NSString *const BODYSIGN_RECORD_BlipidHDLIP;//血脂高密度脂蛋白
extern NSString *const BODYSIGN_RECORD_BlipidLDLIP;//血脂低密度脂蛋白
extern NSString *const BODYSIGN_RECORD_GlyHemoglobin;//糖化血红蛋白
extern NSString *const BODYSIGN_RECORD_TotalBilirubin;//总胆红素
extern NSString *const BODYSIGN_RECORD_DirectBilirubin;//直接胆红素
extern NSString *const BODYSIGN_RECORD_SerumCreatinine;//血清肌酐
extern NSString *const BODYSIGN_RECORD_UricAcid;//尿酸
extern NSString *const BODYSIGN_RECORD_MiAlbuminuria;//微蛋白尿检
extern NSString *const BODYSIGN_RECORD_Fundus;//眼底
extern NSString *const BODYSIGN_RECORD_Plantar;//足底
//用药
extern NSString * const GETMEDICINETYPE;
extern NSString * const MEDICINE_TYPE_FILE;
extern NSString * const Medicine;
extern NSString * const Alias;
extern NSString * const Item;
extern NSString * const MedicList;

extern NSString * const MEDICINE_RECORD_FILE;
extern NSString * const MEDICINE_RECID;
extern NSString * const MEDICINE_RECORD_MEDNAME;
extern NSString * const MEDICINE_RECORD_AmountTimes;
extern NSString * const MEDICINE_RECORD_AMountUnit;
extern NSString * const MEDICINE_RECORD_UnitName;
extern NSString * const MEDICINE_RECORD_Notes;
extern NSString * const MEDICINE_RECORD_Medication ;

//用药记录上传
extern NSString * const syncMedicationRecord;
//药物记录写入
extern NSString * const medicineWriteRecord;
extern NSString * const Record;
extern NSString * const upMedicationRecord;
extern NSString * const amountTime;
extern NSString * const upDataTime;
extern NSString * const Medication;
/********************通用节点********************/
//根节点
extern NSString * const ROOT;
extern NSString * const DATA;
extern NSString * const DATATIME;
//客户端请求模式-获取数据
extern NSString * const CLIENT_MODE_GET;
extern NSString * const CLIENT_MODE_POST;

/********************站内信文件节点********************/

//最后更新时间
extern NSString *const  UPDATE_TIME;
//list
extern NSString *const MAIL_LIST;
extern NSString *const NOTIFY_LIST;
//邮件
extern NSString *const MAIL;
//公告
extern NSString *const NOTIFY;
extern NSString *const IGNORE;
//邮件id
extern NSString *const M_ID;
//已读/未读
extern NSString *const OPENED;
//标题
extern NSString *const TITLE;
//正文
extern NSString *const CONTENT;
//发送时间
extern NSString *const SEND_TIME;
//附件
extern NSString *const ADJUNCT;

//发送ID
extern NSString *const SENDER_ID;
//发送者姓名
extern NSString *const SENDER_NAME;
/*********站内信************/
extern NSString *const CLIENT_SERVER_INNERMAIL;
//extern NSString *const DATATIME;

/*********站内信************/
extern NSString *const CLIENT_SERVER_INNERNOTICE;
/**站内信*/
extern NSString *const USER_INNER_MAIL_FILE;

//对应指导菜单id
extern NSString *const MID;
//公告
 extern NSString *const USER_INNER_NOTICE_FILE;

/*****************基准数据*********************/
extern NSString *const BaselineFileName;
extern NSString *const Baseline;
extern NSString *const value;
extern NSString *const Backup;
extern NSString *const Code;


/*****************食物推荐***************************/
extern NSString *const FOODLISTRECOMMENDFILE;
extern NSString *const MENUADVICE;
extern NSString *const ADVICE;
extern NSString *const MENUID;
extern NSString *const ENERGYLV;
extern NSString *const MENU;
extern NSString * const  FID;
extern NSString * const  timeperiodFile;
extern NSString * const  FoodRequestId;
extern NSString *const MENULIST;
extern NSString *const FOODINFO;
extern NSString *const TIMEPERIOD;
extern NSString *const FOODINTAKE;
extern NSString * const FoodRecommendID;
extern NSString * const FOODDATE;
extern NSString * const FOOD;
extern NSString *const FOODRECOMMENDINTAKE;
extern NSString *const FOODRECOMMENDENERGYLV;
/*****************食物推荐食谱***************************/
extern NSString *const FOODFILEMENU;
extern NSString *const FAVORITE;
extern NSString *const COMMENT;
extern NSString *const CRTTIME;
/*************************运动目标**********/
extern NSString *const USERTARGET_FIELDNAME;

extern NSString *const USERTARGET_SPORTSTEP;

extern NSString *const USERTARGET_ITEM;
extern NSString *const USERTARGET_INDEX;
extern NSString *const USERTARGET_DATE;
extern NSString *const USERTARGET_VALUE;

/********************咨询上传*****************/
extern NSString *const  ASVISORY;
extern NSString *const  TEXT;
/****************用户咨询文件*******************/
extern NSString *const  ASVISORYFILENAME;
extern NSString * const ASVISORYREPLYFILENAME;
extern NSString *const REPLYLIST;
extern NSString *const REPLY;
extern NSString *const REPLY_RID ;
extern NSString *const REPLY_USERID;
extern NSString *const REPLY_USERNAME;
extern NSString *const REPLY_ISNEW ;

///＊咨询回复上传＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊*/
extern NSString *const RECID;
extern NSString *const MAXID;

/*医师建议数据文件************************/
extern NSString *const DOCTORINSTRUCTFILENAME;
extern NSString *const INSTRUCT;
extern NSString *const DOCID;
extern NSString *const DOCNAME;
extern NSString *const DOCTORINSTRUCTREPLYFILENAME;

extern NSString *const RPLTIME;
/*******用户咨询上传数据**************/
extern NSString *const USERDOWNDOCTORADVISORY;
extern NSString *const USERUPDOCADVISORY;
extern NSString *const USERUPADVISORYREPLY;
/*******获取医生的指导和请求**************/
extern NSString *const DOCTORDOWNDOCTORINSTRUCT;
extern NSString *const DOCTORUPINSTRUCTREPLY;
@end
