//
//  personInfoView.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/16.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personInfoView : UIView
+(id)PersonInfoView;
//无用标签
@property (weak, nonatomic) IBOutlet UILabel *nameLable;//姓名

@property (weak, nonatomic) IBOutlet UILabel *nameStar;//姓名星星

@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UILabel *pinyinLable;
@property (weak, nonatomic) IBOutlet UILabel *emailLable;
@property (weak, nonatomic) IBOutlet UILabel *telLable;

@property (weak, nonatomic) IBOutlet UILabel *sexLable;


@property (weak, nonatomic) IBOutlet UILabel *sexStar;

@property (weak, nonatomic) IBOutlet UILabel *birthdayNameLable;

@property (weak, nonatomic) IBOutlet UILabel *birthdayStar;

@property (weak, nonatomic) IBOutlet UILabel *heightLable;

@property (weak, nonatomic) IBOutlet UILabel *heightStar;

@property (weak, nonatomic) IBOutlet UILabel *weightLable;

@property (weak, nonatomic) IBOutlet UILabel *weightStar;

@property (weak, nonatomic) IBOutlet UILabel *heartRateLable;
@property (weak, nonatomic) IBOutlet UILabel *jingZhi;

@property (weak, nonatomic) IBOutlet UILabel *heartRateStar;

@property (weak, nonatomic) IBOutlet UILabel *ActivityStrengthLable;

@property (weak, nonatomic) IBOutlet UILabel *diabetesTypeLable;


@property (weak, nonatomic) IBOutlet UILabel *familyHisLable;
@property (weak, nonatomic) IBOutlet UILabel *bothDiseaseLable;
@property (weak, nonatomic) IBOutlet UILabel *bothDiseaseStar;


@property (weak, nonatomic) IBOutlet UILabel *birthdayLable;//生日

@property (weak, nonatomic) IBOutlet UITextField *nameTF;//姓名
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;//昵称
@property (weak, nonatomic) IBOutlet UITextField *pinyinTF;//拼音
@property (weak, nonatomic) IBOutlet UITextField *emailTF;//邮箱


@property (weak, nonatomic) IBOutlet UITextField *telrphoneTF;//电话

@property (weak, nonatomic) IBOutlet UIButton *SexManBtn;//性别男

@property (weak, nonatomic) IBOutlet UIButton *SexWomanBtn;//性别女
@property (weak, nonatomic) IBOutlet UIButton *timeChooseBtn;//生日选择

@property (weak, nonatomic) IBOutlet UITextField *heightTF;//高度

@property (weak, nonatomic) IBOutlet UITextField *weightTF;//体重
@property (weak, nonatomic) IBOutlet UITextField *RestHrTF;//心率

/*活动强度*/
@property (weak, nonatomic) IBOutlet UIButton *bedridden;//卧床

@property (weak, nonatomic) IBOutlet UIButton *smallWork;//轻体力劳动
@property (weak, nonatomic) IBOutlet UIButton *middleWork;//中体力劳动

@property (weak, nonatomic) IBOutlet UIButton *bigWork;//重体力劳动
/*糖尿病类型*/
@property (weak, nonatomic) IBOutlet UIButton *highSugarPeople;//高糖人群
@property (weak, nonatomic) IBOutlet UIButton *diabetesOne;//糖尿病I型

@property (weak, nonatomic) IBOutlet UIButton *diabetesTwo;//糖尿病II型
/*家族病史*/
@property (weak, nonatomic) IBOutlet UIButton *diabetes;//糖尿病

@property (weak, nonatomic) IBOutlet UIButton *hypertension;//高血压

@property (weak, nonatomic) IBOutlet UIButton *Obesity;//肥胖

@property (weak, nonatomic) IBOutlet UIButton *coronary_heart_disease;//冠心病

@property (weak, nonatomic) IBOutlet UIButton *tumour;//肿瘤
@property (weak, nonatomic) IBOutlet UIButton *Cerebral_vascular_disease;//脑血管疾病

@property (weak, nonatomic) IBOutlet UILabel *bothdisease;//并发症


@property (weak, nonatomic) IBOutlet UIButton *noBothDisease;//无并发症

@property (weak, nonatomic) IBOutlet UIButton *bothDiseaseHypertension;//并发症高血压

@property (weak, nonatomic) IBOutlet UIButton *bothDiseaseHypertensionSlight;//并发症高血压轻微
@property (weak, nonatomic) IBOutlet UIButton *bothDiseaseHypertensionM;//并发症高血压中度

@property (weak, nonatomic) IBOutlet UIButton *bothDiseaseHypertensionHeavy;//并发症高血压重度

@property (weak, nonatomic) IBOutlet UIButton *heartBrain;//心脑血管病变

@property (weak, nonatomic) IBOutlet UIButton *heartBrainSlight;//心脑血管病变轻微

@property (weak, nonatomic) IBOutlet UIButton *heartBrainM;//心脑血管病变中度


@property (weak, nonatomic) IBOutlet UIButton *heartBrainHeavy;//心脑血管病变中毒

@property (weak, nonatomic) IBOutlet UIButton *Eye;//眼部病变
@property (weak, nonatomic) IBOutlet UIButton *eyeSlight;//眼部病变轻微

@property (weak, nonatomic) IBOutlet UIButton *eyeM;//眼部病变中度

@property (weak, nonatomic) IBOutlet UIButton *eyeHeavy;//眼部病变重度

@property (weak, nonatomic) IBOutlet UIButton *nervousSystem;//神经系统病变
@property (weak, nonatomic) IBOutlet UIButton *nervousSystemSlight;//神经系统病变轻微


@property (weak, nonatomic) IBOutlet UIButton *nervousSystemM;//神经系统病变中度


@property (weak, nonatomic) IBOutlet UIButton *nervousSystemHeavy;//神经系统病变重度

@property (weak, nonatomic) IBOutlet UIButton *diabeticNephropathy;//糖尿病肾病

@property (weak, nonatomic) IBOutlet UIButton *diabeticNephropathySlight;//糖尿病肾病轻度


@property (weak, nonatomic) IBOutlet UIButton *diabeticNephropathyM;//糖尿病肾病中度


@property (weak, nonatomic) IBOutlet UIButton *diabeticNephropathyHeavy;//糖尿病肾病重度


@property (weak, nonatomic) IBOutlet UIButton *DiabeticFoot;//糖尿病足

@property (weak, nonatomic) IBOutlet UIButton *DiabeticFootSlight;//糖尿病足轻微
@property (weak, nonatomic) IBOutlet UIButton *DiabeticFootM;//糖尿病足中度

@property (weak, nonatomic) IBOutlet UIButton *DiabeticFootHeavy;//糖尿病足重度

@property (weak, nonatomic) IBOutlet UIButton *other;//其他


@property (weak, nonatomic) IBOutlet UITextField *otherTF;//其他textfield




@property (weak, nonatomic) IBOutlet UITextView *clinicalDiagnosisTV;//临床诊断





@end
