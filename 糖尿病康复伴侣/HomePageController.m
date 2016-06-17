//
//  homePageController.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HomePageController.h"
#import "HealthView.h"
#import "PersonController.h"
#import "EmailController.h"
#import "ToolBoxView.h"
#import "DoctorView.h"
#import "SportCataController.h"
#import "FoodCataController.h"
#import "MedicinalWriteController.h"

#import "DateHelper.h"
#import "NSDate+CalculateDay.h"

#import "foodListRecommendController.h"
#import "foodEnergyViewController.h"
#import "baseLineModel.h"

#import "TableViewDoctorCell.h"
#import "cx_Advisory.h"               //模型 咨询的

#import "consultViewController.h"
#import "ChatViewController.h"

#import "FoodRecordModel.h"          // 饮食记录模型
#import "FoodRecordListViewController.h" // 饮食列表

#import "FoodEvaluateViewController.h"   //饮食评价
#import "SportEvaluateViewController.h" //运动评价

#import "SignViewController.h"

#import "BodySignModel.h"

#import "SportListViewController.h"

#import "BloodSugarModel.h"
#import "SportRecordModel.h"
#import "sportCataModel.h"

#import "BodySignModel.h"

#import "MedicineListController.h"

#import "CXChooseDateView.h"

#import "CXChooseDateYYView.h"

#import "MBProgressHUD/MBProgressHUD+MJ.h"

#import <mach/mach.h>

static NSString * cellIdentifier = @"TableViewDoctorCell";

@interface HomePageController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    UILabel *Timelb;
    NSString * time;
    UIViewController *pickerViewController;
    //    int  state;//时间选择器选择状态
    
}
@property(nonatomic,weak)UIButton * healthBtn;//底部每日健康按钮
@property(nonatomic,weak)UIButton * doctorBtn;
@property(nonatomic,weak)UIButton * toolBtn;
@property(nonatomic, strong) UILabel *  titleLabel;

@property(nonatomic,weak)UIScrollView * homeScrollView;
@property(nonatomic,weak)UIView * homeListView;
@property(nonatomic,strong)HealthView * healthView;//健康视图
@property(nonatomic,strong)ToolBoxView * toolBoxView;
@property(nonatomic,strong)DoctorView * doctorView;

@property (nonatomic) Reachability *hostReachability;

@property (nonatomic, strong)NSArray * dataSource;

@property(nonatomic,weak)UIButton * sportCataBtn;//运动种类按钮

@property (nonatomic, copy) NSString * date; //日期

@property (nonatomic, assign) float baseIntake;  //标准摄入

@property (nonatomic, assign) float sportEnergy; //运动消耗 总热量

@property (nonatomic, strong) MBProgressHUD * HUD;

@property (nonatomic, weak) NSArray * foodArray;

@end

@implementation HomePageController
- (void)loadView{
//    [super loadView];
    UIView * view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     NSString * date = [FileUtils getLocalDate];
    self.date = date;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self getBaseLineData];
    dispatch_async(dispatch_get_main_queue(), ^{
        
    
        [self createNav];
        [self createHomeScrollView];
          // 获取基准数据
//        [self createHealView];
        [self createToolBar];
    });
  
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    读取 用户饮食记录 问题
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.navigationController.navigationBarHidden) {
            self.navigationController.navigationBarHidden = NO;
        }
    });
    if (self.homeScrollView.contentOffset.x == 0) {
        if (self.healthView) {
            NSArray * foodRecordArray = [FileUtils readFoodRecordWithUserID:self.UserID andDate:self.date];
            if (![self.foodArray isEqualToArray:foodRecordArray]) {
            [self change];
            }
        }
    }
    
}
//MARK:获取到每日标准摄入量  根据公式
-(void)getBaseLineData{
    //    NSMutableArray * marray = [[NSMutableArray alloc]init];
    NSArray * codeArray = @[@"B01",@"B02",@"B03",@"B04",@"B05",@"B06",@"B07",@"B08"];
    float userHeight = [SingleManager sharedSingleManager].InfoModel.Height.floatValue/100;
    float userWeight = [SingleManager sharedSingleManager].InfoModel.Weight.floatValue;
    float valueBMI = userWeight/(userHeight*userHeight);
    float valueBase = 0;
    
    NSMutableArray * baseLineArray = [FileUtils ReadBaseLineData];
    NSMutableArray * arrayBMI = [NSMutableArray array];
    for (baseLineModel * model in baseLineArray) {
        for (int i = 0; i < codeArray.count; i++) {
            if ([model.code isEqualToString:codeArray[i]]) {
                [arrayBMI addObject:model];
            }
        }
//        UIImage
    }
    for (baseLineModel* model in arrayBMI) {
        NSArray * stringArr = [model.Backup componentsSeparatedByString:@","];
        float lowF = 0;
        float highF = 0;
        if ([stringArr[0] isEqualToString:@""]) {
            lowF = 0;
        }else{
            lowF = [stringArr[0] floatValue];
        }
        if ([stringArr[1]isEqualToString:@""]) {
            highF = 10000;
        }else{
            highF = [stringArr[1] floatValue];
        }
        if ((valueBMI >= lowF )&&(valueBMI < highF)) {
            valueBase = model.Value.floatValue;
            break;
        }
    }
    float baseIntake = userHeight*userHeight*22*valueBase;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.baseIntake = baseIntake;
    });
    
}

-(void)timeSet{
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createChooseTime:)];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createChooseTime:)];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createChooseTime:)];
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createChooseTime:)];
    UITapGestureRecognizer * tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createChooseTime:)];
    UITapGestureRecognizer * tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createChooseTime:)];
    UITapGestureRecognizer * tap7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createChooseTime:)];
    [self.healthView.healthBodyView.breakfastTime addGestureRecognizer:tap1];
    [self.healthView.healthBodyView.morningAddFoodTime addGestureRecognizer:tap2];
    [self.healthView.healthBodyView.lunchTime addGestureRecognizer:tap3];
    [self.healthView.healthBodyView.afternoonAddFoodTime addGestureRecognizer:tap4];
    [self.healthView.healthBodyView.dinnerTime addGestureRecognizer:tap5];
    [self.healthView.healthBodyView.afterDinnerEatFoodTime addGestureRecognizer:tap6];
    [self.healthView.healthBodyView.smokeTime addGestureRecognizer:tap7];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
-(void)createChooseTime:(UITapGestureRecognizer *)sender{
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"HH:mm"];
    UILabel * label = (UILabel*)sender.view;
    NSString * dateStr = nil;
    if ([label.text isEqualToString:@"－:－"]) {
        dateStr = @"00:00:00";
    }else{
    NSDate * date = [dateFormater dateFromString:label.text];
    [dateFormater setDateFormat:@"HH:mm:ss"];
        dateStr = [dateFormater stringFromDate:date];
    }
    NSString * nowStr = [NSString stringWithFormat:@"%@ %@",self.date,dateStr];
    CXChooseDateView * view = [CXChooseDateView viewWithXIBWithDate:nowStr];
    [view viewAddToView:self.view];
    view.timeChoose = ^(NSString* timeStr){
        label.text = [UtilCommon stringData_mm_ssFromStr:timeStr];
    };
}
//创建 左右tabbarItem，中部titleView
- (void)createNav{
    self.navigationController.navigationBar.alpha = 1;
    // 背景颜色设置为系统默认颜色
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem * personItem = [UIBarButtonItem itemWithIcon:@"img_person.png" target:self highIcon:@"img_person.png" action:@selector(personItemClick)];
    self.navigationItem.leftBarButtonItem = personItem;
    //右边按钮po
    UIBarButtonItem * syncItem = [UIBarButtonItem itemWithIcon:@"ico_sync_data" target:self highIcon:@"ico_sync_data" action:@selector(syncItemClick)];
    
    UIBarButtonItem * emailItem = [UIBarButtonItem itemWithIcon:@"img_email" target:self highIcon:@"img_email" action:@selector(emailItemClick)];
    
    NSArray *buttonItemArray = [[NSArray alloc]initWithObjects:emailItem,syncItem, nil];
    self.navigationItem.rightBarButtonItems = buttonItemArray;
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 120, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:14];  //设置文本字体与大小
    titleLabel.textColor = [UIColor blackColor];  //设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [UtilCommon dateForTitleFormatStr:self.date];  //设置标题
    self.navigationItem.titleView = titleLabel;
    
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headLabelClick)];
    [titleLabel addGestureRecognizer:tapGR];
    titleLabel.userInteractionEnabled = YES;
    
    self.titleLabel = titleLabel;
}
- (void)headLabelClick{
//    NSLog(@"time");
    CXChooseDateYYView * view = [CXChooseDateYYView viewWithXIBWithDate:self.date];
    [self.view addSubview:view];
    view.chooseDate = ^(NSString * dateStr){
        self.date = dateStr;
        self.titleLabel.text = [UtilCommon dateForTitleFormatStr:self.date];
        [self change];
    };
}
// 底部三个按钮
-(void)createToolBar{
    UIView * toolView = [[UIView alloc]init];
    toolView.backgroundColor = [UIColor colorWithHexString:@"#cecece"];
    toolView.frame = CGRectMake(0, H-49, W, 49);
    //创建三个button
    UIButton * healthBtn = [self cx_buttonWiithTitle:@"每日健康" action:@selector(healthBtnClick) backgroundColor:[UIColor grayColor]];
    healthBtn.frame = CGRectMake(0, 0, W/3, 49);
    healthBtn.selected = YES;
    self.healthBtn = healthBtn;
    UIButton * doctorBtn = [self cx_buttonWiithTitle:@"联系医生" action:@selector(doctorBtnClick) backgroundColor:nil];
    doctorBtn.frame = CGRectMake(W/3, 0, W/3, 49);
    doctorBtn.selected = NO;
    self.doctorBtn = doctorBtn;
    UIButton * toolBtn = [self cx_buttonWiithTitle:@"工具箱" action:@selector(toolBtnClick) backgroundColor:nil];
    toolBtn.frame = CGRectMake(W/3*2, 0, W/3, 49);
    toolBtn.selected = NO;
    self.toolBtn = toolBtn;
    [toolView addSubview:healthBtn];
    [toolView addSubview:doctorBtn];
    [toolView addSubview:toolBtn];
    [self.view addSubview:toolView];
}

-(void)createHomeScrollView{
    UIScrollView * homeScrollView = [[UIScrollView alloc]init];
    self.homeScrollView = homeScrollView;
//    self.homeScrollView.backgroundColor = [UIColor yellowColor];
    homeScrollView.frame = CGRectMake(0, 64, W, H-64-49);
    homeScrollView.contentSize = CGSizeMake(3*W,0);
    homeScrollView.pagingEnabled = YES;
    
    [self.view addSubview:homeScrollView];
    homeScrollView.delegate = self;
    UIView * homeListView = [[UIView alloc]init];
    homeListView.frame = CGRectMake(0, 0, 3*W, H-64-49);
    homeListView.backgroundColor = [UIColor whiteColor];
    [homeScrollView addSubview:homeListView];
    self.homeListView = homeListView;
    
    [self createHealView];
}
//创建每日健康view
#pragma  mark 创建每日健康view
-(void)createHealView{
    HealthView * healthView = [HealthView healthView];
    self.healthView = healthView;
    self.sportCataBtn = healthView.healthBodyView.sportCataBtn;
    healthView.frame = CGRectMake(0, 0, W, H-64-49);
 
    [healthView.healthHeadView.leftBtn addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventTouchUpInside];
    [healthView.healthHeadView.rightBtn addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventTouchUpInside];
    [healthView.healthBodyView.breakfastBtn addTarget:self action:@selector(foodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [healthView.healthBodyView.addBreakBtn addTarget:self action:@selector(foodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [healthView.healthBodyView.lunchBtn addTarget:self action:@selector(foodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [healthView.healthBodyView.addLunchBtn addTarget:self action:@selector(foodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [healthView.healthBodyView.dinnerBtn addTarget:self action:@selector(foodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [healthView.healthBodyView.addDinnerBtn addTarget:self action:@selector(foodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [healthView.healthBodyView.evaluate addTarget:self action:@selector(evaluateClick) forControlEvents:UIControlEventTouchUpInside];
    [healthView.healthBodyView.sportEvaluate addTarget:self action:@selector(sportEvaluateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    非饮食
    [healthView.healthBodyView.smokeBtn addTarget:self action:@selector(foodBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    时间设置
    [self timeSet];
    //    运动
    [self.sportCataBtn addTarget:self action:@selector(sportCataBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    体征
    [healthView.healthBodyView.signBtn addTarget:self action:@selector(signBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    用药
    [healthView.healthBodyView.medicinalBtn addTarget:self action:@selector(medicinalBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.homeListView addSubview:healthView];
//    MBProgressHUD * progressHUD = [[MBProgressHUD alloc]init];
//    progressHUD.mode = MBProgressHUDModeIndeterminate;
////    self.HUD = progressHUD;
//    progressHUD.labelText = @"数据变更";
//    [progressHUD showWhileExecuting:@selector(change) onTarget:self withObject:nil animated:YES];
    

    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary * setDic = [userDefault objectForKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
    if (!setDic) {
        setDic = [NSMutableDictionary dictionary];
        [setDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_Sync];
        [setDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_ONLYWIFI];
        [setDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_WARNING];
        [setDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_DIETHIDDEN];
        [setDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_SPORTHIDDEN];
        [setDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_BODYSIGNHIDDEN];
        [setDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_MEDICINEHIDDEN];
        [userDefault setObject:setDic forKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
        [userDefault synchronize];
    }
    
    BOOL sync = [[setDic objectForKey:SETTING_Sync] boolValue];
    BOOL wifiOnly = [[setDic objectForKey:SETTING_ONLYWIFI]boolValue];

    [self change];
    //    自动同步打开  仅WiFi 打开
    if (sync) {
        if (wifiOnly) {
            if ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == ReachableViaWiFi) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                     [self sendToNetWork];
                });
            }
        }else{
            if ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus != NotReachable) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [self sendToNetWork];
                });
            }
        }
    }
}
#pragma mark 更换日期 按钮点击事件
- (void)changeDate:(UIButton*)sender{
    //    左侧按钮
    if (sender.tag == 10001) {
        self.date = [UtilCommon beforeDay:self.date];
    }
    //    右侧按钮
    if (sender.tag == 10002) {
        if ([self.date isEqualToString:[FileUtils getLocalDate]]) {
            [UtilCommon alertView:@"提示" andMessage:@"不能指定晚于今天的日期"];
            return;
        }
        self.date = [UtilCommon afterDay:self.date];
    }
    //    日期
    self.titleLabel.text = [UtilCommon dateForTitleFormatStr:self.date];
//    MBProgressHUD * progressHUD = [[MBProgressHUD alloc]init];
//    progressHUD.mode = MBProgressHUDModeIndeterminate;
//    //            self.HUD = progressHUD;
//    progressHUD.labelText = @"数据变更";
//    [progressHUD showWhileExecuting:@selector(change) onTarget:self withObject:nil animated:YES];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self change];
//    });
    [self change];
}

#pragma mark 改变页面的布局
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

- (void)change{
    //    摄入热量 食物摄入
    NSArray * foodRecordArray = [FileUtils readFoodRecordWithUserID:self.UserID andDate:self.date];
    self.foodArray = foodRecordArray;
//    TOCK;
    CGFloat foodHeight = [self.healthView changeWithFoodRecordArray:foodRecordArray];
    
    float intakeEnergy = 0;
    float protein = 0;
    float fat = 0;
    float carbs = 0;
//    TOCK;
    for (FoodRecordModel* model in foodRecordArray) {
        foodmodel * food = [FileUtils readFoodWithFoodID:model.foodId];
        intakeEnergy += food.UnitEnergy.floatValue * model.intake.floatValue;
        protein += food.UnitProtein.floatValue/food.UnitValue.floatValue*model.intake.floatValue;
        fat += food.UnitFat.floatValue/food.UnitValue.floatValue*model.intake.floatValue;
        carbs += food.UnitCarbs.floatValue/food.UnitValue.floatValue*model.intake.floatValue;
    }
//    TOCK;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.healthView.healthHeadView.intakeLabel.text = [NSString stringWithFormat:@"%d/%d千卡",(int)intakeEnergy/100,(int)self.baseIntake];  
    });
    TICK;
    // 运动消耗 1.根据时间确定按钮样式
    if ([self.date isEqualToString:[FileUtils getLocalDate]]) {
        [self.healthView.healthBodyView.sportCataBtn setImage:[UIImage imageNamed:@"ico_timer.png"] forState:UIControlStateNormal];
    }else{
        [self.healthView.healthBodyView.sportCataBtn setImage:[UIImage imageNamed:@"ico_edit.png"] forState:UIControlStateNormal];
    }
    NSArray * sportArray = [FileUtils readSportRecordWithUID:self.UserID andDate:self.date];
    float sportEnergy = 0;
    if (sportArray.count) {
        for (SportRecordModel* model in sportArray) {
            sportCataModel* cataModel = [SportFileUtils readSportCataWith:model.Type];
            sportEnergy += (cataModel.Energy.floatValue * model.TimeLength.floatValue/60);
        }
    }else{
        sportEnergy = 0;
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
       self.healthView.healthHeadView.movementLabel.text = [NSString stringWithFormat:@"%d千卡",(int)sportEnergy];
    });
    self.sportEnergy = sportEnergy;
    CGFloat sportHeight = [self.healthView changeWithSportRecord:sportArray];
    //    血糖
    NSArray * bloodSugarArray = [FileUtils readBloodSugarWithUID:self.UserID andDate:self.date];
    NSString * emprtyLowStr = [FileUtils getValueUsingcode:@"013"];
    NSString * empertyHighStr = [FileUtils getValueUsingcode:@"012"];
    NSString * twoHourHighStr = [FileUtils getValueUsingcode:@"015"];
    NSString * bloodSugarStr = @"--";
    for (BloodSugarModel* bloodSModel in bloodSugarArray) {
        if ([bloodSModel.timespan isEqualToString:@"2"]) {
            bloodSugarStr = (bloodSModel.Value.floatValue >emprtyLowStr.floatValue && bloodSModel.Value.floatValue < twoHourHighStr.floatValue)?@"正常":@"有异常";
            if ([bloodSugarStr isEqualToString:@"有异常"]) {
                break;
            }
        }else{
            bloodSugarStr = (bloodSModel.Value.floatValue >emprtyLowStr.floatValue && bloodSModel.Value.floatValue < empertyHighStr.floatValue)?@"正常":@"有异常";
            if ([bloodSugarStr isEqualToString:@"有异常"]) {
                break;
            }
        }
    }
    BodySignModel * signBodyM = [FileUtils readBodySignWithUID:self.UserID withDate:self.date];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.healthView.healthHeadView.bloodLabel.text= bloodSugarStr;
    });
    
    CGFloat bloodSugarHeight = [self.healthView changeWithBodySignWithBloodSugarArray:bloodSugarArray andBodySignModel:signBodyM];
    //    药物
    NSArray * medicineArray = [FileUtils readMedicineRecordWithUID:self.UserID AndDate:self.date];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (medicineArray.count) {
            self.healthView.healthHeadView.medicineLabel.text = @"有";
        }else{
            self.healthView.healthHeadView.medicineLabel.text = @"无";
        }
    });
    TOCK;
    CGFloat medicineHeight = [self.healthView changeWithMedicineArray:medicineArray];
    CGSize contentSize  = CGSizeMake(W, 106+25 + foodHeight+sportHeight+bloodSugarHeight+medicineHeight);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.healthView.healthBodyView.frame = CGRectMake(0, 0, W, contentSize.height);
        //    scrollview滚动范围
        self.healthView.healthScrollView.contentSize = contentSize;
    });
    __weak typeof(self) weakSelf =self;
    self.healthView.changeFoodRecord = ^(NSInteger integer, NSArray * foodArray){
        weakSelf.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
        FoodRecordListViewController * foodRecord = [[FoodRecordListViewController alloc]init];
        foodRecord.integer = integer;
        foodRecord.userID = weakSelf.UserID;
        foodRecord.date = weakSelf.date;
        [weakSelf.navigationController  pushViewController:foodRecord animated:YES];
    };
    self.healthView.changeSportRecord = ^{
        weakSelf.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
        SportListViewController * sportList = [[SportListViewController alloc]init];
        sportList.date = weakSelf.date;
        sportList.userId = weakSelf.UserID;
        [weakSelf.navigationController pushViewController:sportList animated:YES];
    };
    self.healthView.changeBloodSugarAndBodySign = ^{
        [weakSelf signBtnClick];
    };
    self.healthView.changeMedicineRecord = ^{
     weakSelf.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
        MedicineListController * medicineList = [[MedicineListController alloc]init];
        medicineList.date = weakSelf.date;
        medicineList.userId = weakSelf.UserID;
        [weakSelf.navigationController pushViewController:medicineList animated:YES];
    };
  
    //最后的计算
    //    intakeEnergy sportEnergy self.baseLines
    for (UIView * view in self.healthView.healthBodyView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* btn = (UIButton*)view;
            btn.selected = NO;
            btn.backgroundColor = [UIColor clearColor];
        }
    }
    if (!intakeEnergy) {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.healthView.healthBodyView.proteinIV.image = [UIImage imageNamed:@"img_arrow_down_blue.png"];
        self.healthView.healthBodyView.fatIV.image = [UIImage imageNamed:@"img_arrow_down_blue.png"];
        self.healthView.healthBodyView.carbsIV.image = [UIImage imageNamed:@"img_arrow_down_blue.png"];
        self.healthView.healthBodyView.topLabel.text = @"无记录";
    });
        return;
    }
    int diff = intakeEnergy/100 - sportEnergy - self.baseIntake;
    double value = diff/(double)self.baseIntake;
    
   dispatch_async(dispatch_get_main_queue(), ^{
       NSString * state = nil;
       if (value < -0.05) {
           self.healthView.healthBodyView.topButton1.selected = YES;
           self.healthView.healthBodyView.topButton1.backgroundColor = [UIColor redColor];
           state = @"过严";
       }else if (value >= -0.05 && value < 0.05){
           self.healthView.healthBodyView.topButton2.selected = YES;
           self.healthView.healthBodyView.topButton2.backgroundColor = blueColorWithRGB(61, 172, 225);
           state = @"良好";
       }else if(value > 0.05 && value < 0.15){
           self.healthView.healthBodyView.topButton3.selected = YES;
           self.healthView.healthBodyView.topButton3.backgroundColor = [UIColor greenColor];
           state = @"一般";
       }else if(value >= 0.15 && value < 0.25){
           self.healthView.healthBodyView.topButton4.selected = YES;
           self.healthView.healthBodyView.topButton4.backgroundColor = [UIColor orangeColor];
           state = @"较差";
       }else{
           self.healthView.healthBodyView.topButton5.selected = YES;
           [self.healthView.healthBodyView.topButton5 setBackgroundColor:blueColorWithRGB(210, 0, 0)];
           state = @"很差";
       }
       if (intakeEnergy/100 > self.baseIntake) {
           self.healthView.healthBodyView.topLabel.text = [NSString stringWithFormat:@"%@(已超过%d千卡)",state,(int)(intakeEnergy/100 - self.baseIntake)];
       }else{
           self.healthView.healthBodyView.topLabel.text = [NSString stringWithFormat:@"%@(还可摄入%d千卡)",state,(int)(self.baseIntake - intakeEnergy/100)];
       }
       
      dispatch_async(dispatch_get_main_queue(), ^{
          //    蛋白质
          float lowProtein = [[FileUtils getValueUsingcode:@"003"] floatValue];
          float highProtein = [[FileUtils getValueUsingcode:@"002"] floatValue];
          NSString * imageName = nil;
          if (protein*4 < lowProtein*self.baseIntake/100) {
              imageName = @"img_arrow_down_blue.png";
          }else if(protein*4 > highProtein *self.baseIntake/100){
              imageName = @"img_arrow_up_red.png";
          }else{
              imageName = @"img_circle_green.png";
          }
          self.healthView.healthBodyView.proteinIV.image = [UIImage imageNamed:imageName];
          //    脂肪
          float lowFat = [[FileUtils getValueUsingcode:@"005"] floatValue];
          float highFat = [[FileUtils getValueUsingcode:@"004"] floatValue];
          NSString* imageNameFat = nil;
          if (fat*9 < lowFat*self.baseIntake/100) {
              imageNameFat = @"img_arrow_down_blue.png";
          }else if(fat*9 > highFat *self.baseIntake/100){
              imageNameFat = @"img_arrow_up_red.png";
          }else{
              imageNameFat = @"img_circle_green.png";
          }
          self.healthView.healthBodyView.fatIV.image = [UIImage imageNamed:imageNameFat];
          // 碳水化合物
          float lowCarbs = [[FileUtils getValueUsingcode:@"007"] floatValue];
          float highCarbs = [[FileUtils getValueUsingcode:@"006"] floatValue];
          NSString* imageNameCarbs = nil;
          if (carbs*4 < lowCarbs*self.baseIntake/100) {
              imageNameCarbs = @"img_arrow_down_blue.png";
          }else if(carbs*4 > highCarbs *self.baseIntake/100){
              imageNameCarbs = @"img_arrow_up_red.png";
          }else{
              imageNameCarbs = @"img_circle_green.png";
          }
          self.healthView.healthBodyView.carbsIV.image = [UIImage imageNamed:imageNameCarbs];
      });
   });
    TOCK;
  
}

#pragma mark 饮食 和 运动 分享 评价 界面
- (void)evaluateClick{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    FoodEvaluateViewController * foodEvaluateVC = [[FoodEvaluateViewController alloc]init];
    foodEvaluateVC.date = self.date;
    foodEvaluateVC.userId = self.UserID;
    foodEvaluateVC.baseIntake = self.baseIntake;
    [self.navigationController pushViewController:foodEvaluateVC animated:YES];
}
- (void)sportEvaluateBtnClick:(UIButton*)sender{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    SportEvaluateViewController * sportEvaluateVC = [[SportEvaluateViewController alloc]init];
    sportEvaluateVC.date = self.date;
    sportEvaluateVC.sportEnergy = self.sportEnergy;
    sportEvaluateVC.userId = self.UserID;
    [self.navigationController pushViewController:sportEvaluateVC animated:YES];
}
#pragma mark 底部三个按钮点击事件
-(void)healthBtnClick{
    if (self.healthBtn.selected == NO) {
        self.healthBtn.selected = YES;
        self.doctorBtn.selected = NO;
        self.toolBtn.selected = NO;
        [self.healthBtn setBackgroundColor:[UIColor grayColor]];
        [self.doctorBtn setBackgroundColor:[UIColor colorWithHexString:@"#cecece"]];
        [self.toolBtn setBackgroundColor:[UIColor colorWithHexString:@"#cecece"]];
        self.homeScrollView.contentOffset = CGPointMake(0, 0);
    }
}
-(void)doctorBtnClick{
    if (self.doctorBtn.selected == NO) {
        self.doctorBtn.selected = YES;
        self.toolBtn.selected = NO;
        self.healthBtn.selected = NO;
        
        [self.doctorBtn setBackgroundColor:[UIColor grayColor]];
        [self.healthBtn setBackgroundColor:[UIColor colorWithHexString:@"#cecece"]];
        [self.toolBtn setBackgroundColor:[UIColor colorWithHexString:@"#cecece"]];
        
        self.doctorView.frame = CGRectMake(W, 0, W, H-64-49);
        self.homeScrollView.contentOffset = CGPointMake(W, 0);
    }
}
-(void)toolBtnClick{
    if (self.toolBtn.selected == NO) {
        self.toolBtn.selected = YES;
        self.doctorBtn.selected = NO;
        self.healthBtn.selected = NO;
        
        [self.toolBtn setBackgroundColor:[UIColor grayColor]];
        [self.doctorBtn setBackgroundColor:[UIColor colorWithHexString:@"#cecece"]];
        [self.healthBtn setBackgroundColor:[UIColor colorWithHexString:@"#cecece"]];
        self.toolBoxView.frame = CGRectMake(2*W, 0, W, H-64-49);
        self.homeScrollView.contentOffset = CGPointMake(2*W, 0);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewDoctorCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cx_Advisory * advisory = [self.dataSource objectAtIndex:indexPath.row];
    
    [cell cellWithModel:advisory];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    cx_Advisory * advisory = [self.dataSource objectAtIndex:indexPath.row];
    BOOL isDoctor = NO;
    if ([advisory.docID isEqualToString:@""] && [advisory.docName isEqualToString:@""]) {
        isDoctor = NO;
    }else{
        isDoctor = YES;
    }
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    ChatViewController * chat = [[ChatViewController alloc]init];
    if (isDoctor) {
        chat.navigationItem.title = @"建议";
    }else{
        chat.navigationItem.title = @"咨询";
    }
    chat.advisory = advisory;
    [self.navigationController pushViewController:chat animated:YES];
    advisory.isNew = @"false";
    
    [FileUtils chatHistoryWithUid:self.UserID And:advisory.idAddress type:isDoctor];
    [FileUtils changeStatus:advisory andUserId:self.UserID];
    self.dataSource = [[FileUtils readAdvisoryDataWithUID:self.UserID] copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.doctorView.tableView reloadData];
    });
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

#pragma mark   -1-跳转到食物能量计算页面
-(void)cx_foodEnergy{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    foodEnergyViewController * energy = [[foodEnergyViewController alloc]init];
    [self.navigationController pushViewController:energy animated:YES];
}
#pragma mark   -1-跳转到食谱推荐页面
-(void)cx_foodList{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    foodListRecommendController * listRecommend  = [[foodListRecommendController alloc]init];
    [self.navigationController pushViewController:listRecommend animated:YES];
    listRecommend.userID = self.UserID;
    listRecommend.date = self.date;
}
#pragma mark -2- 清理缓存页面
-(void)cx_cleanCache{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
}
//MARK:个人中心按钮
-(void)personItemClick{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    
    PersonController * personController = [[PersonController alloc]init];
    [self.navigationController pushViewController:personController animated:YES];
    personController.userid = self.UserID;
}
//获取同步按钮点击
-(void)syncItemClick{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        [MBProgressHUD showMessage:@"您没有打开数据连接，无法上传数据。"];
        return;
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"要开始同步您的记录吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"开始同步", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
//        [self sendToNetWork];
        MBProgressHUD * progressHUD = [[MBProgressHUD alloc]init];
        progressHUD.mode = MBProgressHUDModeIndeterminate;
        progressHUD.labelText = @"正在上传数据";
        [progressHUD showWhileExecuting:@selector(sendToNetWork) onTarget:self withObject:nil animated:YES];
        [self.view addSubview:progressHUD]; 
    }
}
#pragma mark  将本地 记录 数据上传 并将网络 个人记录 数据下载到本地
- (void)sendToNetWork{
    //        开始上传数据  先上传 后读取 写入本地
    /******食物记录********/
    BOOL food = [WebUtilsCommon sendFoodRecordToSeverWithUID:self.UserID];  //上传食物请求
    /*******运动记录********/
    BOOL sport = [WebUtilsCommon sendSportRecordWithUID:self.UserID];
    /******* 血糖**********/
    BOOL bloodSugar = [WebUtilsCommon sendBloodSugarRecordWithUID:self.UserID];
    /******* 体征**********/
    BOOL bodySign = [WebUtilsCommon sendBodySignRecordWithUID:self.UserID];
    /******* 用药**********/
    BOOL medicine = [WebUtilsCommon sendMedicineRecordWithUID:self.UserID];
    /********* 记录重新获取 并写入本地**********/
    NSData * foodData = [WebUtilsCommon getDietRecordWithUsrID:self.UserID];//获取食物请求
    [FileUtils writeDietRecordLocalWithUID:self.UserID andData:foodData];
    NSData * sportData = [WebUtilsCommon getSportRecordWithUID:self.UserID];
    [FileUtils writeSportRecodWithUID:self.UserID SystemData:sportData];
    NSData * bloodSugarData = [WebUtilsCommon getBloodSugarWithUID:self.UserID];
    [FileUtils writeBloodSugarWithUID:self.UserID SystemData:bloodSugarData];
    NSData * bodySignData = [WebUtilsCommon getBodySignRecordWitnUID:self.UserID];
    [FileUtils writeBodySignWithUID:self.UserID SystemData:bodySignData];
    NSData * medicineData = [WebUtilsCommon getsyncMedicationRecord:self.UserID];
    [FileUtils writeMedicineWithUID:self.UserID SystmeData:medicineData];
    
    if (food && sport && bloodSugar && bodySign && medicine) {
        NSMutableDictionary * newDic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
        if (!newDic) {
            newDic = [NSMutableDictionary dictionary];
        }
        NSMutableDictionary * twoDic = [newDic mutableCopy];
        [twoDic setObject:[FileUtils getNowUpdTime] forKey:SETTING_SYNCHISTIME];
        
        [[NSUserDefaults standardUserDefaults]setObject:twoDic forKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        if (!food) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"食物数据上传失败"];
            });
        }
        if (!sport) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"运动数据上传失败"];
            });
            
        }
        if (!bloodSugar) {
            dispatch_async(dispatch_get_main_queue(), ^{
                 [MBProgressHUD showError:@"血糖数据上传失败"];
            });
           
        }
        if (!bodySign) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"体征数据上传失败"];
            });
            
        }
        if (!medicine) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"用药数据上传失败"];
            });
            
        }
    }
}
//站内信
-(void)emailItemClick{ self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    EmailController * emailController = [[EmailController alloc]init];
    [self.navigationController pushViewController:emailController animated:YES];
}
#pragma mark ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([[scrollView class] isSubclassOfClass:[UITableView class]]) {
        return;
    }
    if (self.homeScrollView.contentOffset.x == 0) {
        [self healthBtnClick];
    }else if(self.homeScrollView.contentOffset.x == W){
        [self doctorBtnClick];
        //    下载咨询方面的数据  判断时间是否相同
        
        MBProgressHUD * progressHUD = [[MBProgressHUD alloc]init];
        progressHUD.mode = MBProgressHUDModeIndeterminate;
        progressHUD.labelText = @"正在更新数据";
        [progressHUD showWhileExecuting:@selector(downConsultData) onTarget:self withObject:nil animated:YES];
        [self.view addSubview:progressHUD];
//        [self downConsultData];
    }else if(self.homeScrollView.contentOffset.x == 2*W){
        [self toolBtnClick];
    }
    if (self.homeScrollView.contentOffset.x == 0) {
        if (self.healthView) {
            NSArray * foodRecordArray = [FileUtils readFoodRecordWithUserID:self.UserID andDate:self.date];
            if (![self.foodArray isEqualToArray:foodRecordArray]) {
                [self change];
            }
        }
    }

}
#pragma mark  下载咨询方面的数据
-(void)downConsultData{
    NSData * data = nil;
    //    文件不存在 判断取出时间 根据时间 请求网络数据
    if (![FileUtils hasFile:[NSString stringWithFormat:@"%@%@",self.UserID,ASVISORYFILENAME]]) {
        data =  [WebUtilsCommon downDoctorAdvisoryUseUID:self.UserID dataTime:nil];
    }else {
        //    取时间
        NSString * datatime = [FileUtils getLastTimeOfConsultUseUID:self.UserID];
        data =  [WebUtilsCommon downDoctorAdvisoryUseUID:self.UserID dataTime:datatime];
    }
    if (!data) {
        [MBProgressHUD showMessage:@"获取用户咨询数据失败"];
    }
    [FileUtils analysisDoctorAdvisoryUseData:data andUID:self.UserID];
    NSData * docData = nil;
    if (![FileUtils hasFile:[NSString stringWithFormat:@"%@%@",self.UserID,DOCTORINSTRUCTFILENAME]]) {
        docData =  [WebUtilsCommon downDoctorInstructUseUID:self.UserID andDataTime:nil];
    }else {
        //    取时间
        NSString * datatime = [FileUtils getLastTimeOfDocinstructUseUID:self.UserID];
        docData =  [WebUtilsCommon downDoctorInstructUseUID:self.UserID andDataTime:datatime];
    }
    if (!docData) {
        [MBProgressHUD showMessage:@"获取医生建议数据失败"];
    }
    [FileUtils analysisDoctorInstructUseData:docData andUID:self.UserID];
    self.dataSource = [[FileUtils readAdvisoryDataWithUID:self.UserID] copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.doctorView.tableView reloadData];
    });
    
}
//MARK:点击运动种类按钮
-(void)sportCataBtnClick{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    //判断当前日期  是否是今天
    if ([[FileUtils getLocalDate] isEqualToString:self.date]) {
        SportCataController * sportCataController = [[SportCataController alloc]init];
        sportCataController.date = self.date;
        sportCataController.userId = self.UserID;
        [self.navigationController pushViewController:sportCataController animated:YES];
    }else{
        SportListViewController * sportList = [[SportListViewController alloc]init];
        sportList.date = self.date;
        sportList.userId = self.UserID;
        [self.navigationController pushViewController:sportList animated:YES];
    }
}
//点击食物按钮
-(void)foodBtnClick:(UIButton * )btn{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    FoodCataController * foodCataController = [[FoodCataController alloc]init];
    foodCataController.date = self.date;
    [self.navigationController pushViewController:foodCataController animated:YES];
    //    foodCataController.date   日期 添加 饮食记录
    if (btn.tag == 200) {
        foodCataController.eatFoodTime = DIET_TIMEPER_BRFFAST;
    }else if (btn.tag == 201){
        foodCataController.eatFoodTime = DIET_TIMEPER_EXTRA1;
    }else if (btn.tag == 202){
        foodCataController.eatFoodTime = DIET_TIMEPER_LUNCH;
    }else if (btn.tag == 203){
        foodCataController.eatFoodTime = DIET_TIMEPER_EXTRA2;
    }else if (btn.tag == 204){
        foodCataController.eatFoodTime = DIET_TIMEPER_DINNER;
    }else if (btn.tag == 205){
        foodCataController.eatFoodTime = DIET_TIMEPER_NTSAKE;
    }else if (btn.tag == 206){
        foodCataController.eatFoodTime = DIET_TIMEPER_NOTFOOD;
        foodCataController.notDiet = YES;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [SingleManager sharedSingleManager].timeArray = @[self.healthView.healthBodyView.breakfastTime.text,
                                                      self.healthView.healthBodyView.morningAddFoodTime.text,
                                                      self.healthView.healthBodyView.lunchTime.text,
                                                      self.healthView.healthBodyView.afternoonAddFoodTime.text,
                                                      self.healthView.healthBodyView.dinnerTime.text,
                                                      self.healthView.healthBodyView.afterDinnerEatFoodTime.text,self.healthView.healthBodyView.smokeTime.text
                                                      ];
}
//MARK:   体征录入按钮
-(void)signBtnClick{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    SignViewController * sign = [[SignViewController alloc]init];
    sign.date = self.date;
    sign.userId = self.UserID;
    [self.navigationController pushViewController:sign animated:YES];
}
//MARK:用药按钮
-(void)medicinalBtnClick{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    MedicinalWriteController * medicinalWrite = [[MedicinalWriteController alloc]init];
    
    medicinalWrite.userID = self.UserID;
    medicinalWrite.date = self.date;
    
    [self.navigationController pushViewController:medicinalWrite animated:YES];
}
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}
- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus) {
        case NotReachable:
            NSLog(@"====1当前网络状态不可达=======");
            break;
        case ReachableViaWiFi:
            NSLog(@"====1当前网络状态为Wifi=======");
            break;
        case ReachableViaWWAN:
            NSLog(@"====1当前网络状态为3G=======");
            break;
    }
}
#pragma mark 医生咨询---刷新---按钮点击事件 咨询界面tableview datasource && delegate
//咨询界面
-(void)consult:(UIButton *)button{
    consultViewController * consult = [[consultViewController alloc]init];
    consult.uid = self.UserID;
    [self.navigationController pushViewController:consult animated:YES];
}
//刷新按钮点击事件
- (void)refreshDoctorView{
    //检测站点是否可以连接
    NSString *remoteHostName = WEN_SERVER_IP;
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    BOOL isConnected =[UtilCommon isConnected:self.hostReachability];
    if (isConnected == NO) {
        //   本地登录
        [UtilCommon alertView:@"提示" andMessage:@"无网络连接，无法获取数据"];
    }else{
        //   网络登录
//        [self downConsultData];
        MBProgressHUD * progressHUD = [[MBProgressHUD alloc]init];
        progressHUD.mode = MBProgressHUDModeIndeterminate;
        progressHUD.labelText = @"正在更新数据";
        [progressHUD showWhileExecuting:@selector(downConsultData) onTarget:self withObject:nil animated:YES];
        [self.view addSubview:progressHUD];
    }
}

#pragma mark getter
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}
- (ToolBoxView *)toolBoxView{
    if (!_toolBoxView) {
        _toolBoxView = [ToolBoxView toolBoxView];
        [self.homeListView addSubview:_toolBoxView];
        [self.toolBoxView.foodEnergyCalculate addTarget:self action:@selector(cx_foodEnergy) forControlEvents:UIControlEventTouchUpInside];
        [self.toolBoxView.foodListRecommend addTarget:self action:@selector(cx_foodList) forControlEvents:UIControlEventTouchUpInside];
        [self.toolBoxView.cleanCache addTarget:self action:@selector(cx_cleanCache) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toolBoxView;
}
- (DoctorView *)doctorView{
    if (!_doctorView) {
        _doctorView = [DoctorView doctorView];
        _doctorView.tableView.dataSource = self;
        _doctorView.tableView.delegate = self;
        [_doctorView.tableView registerNib:[UINib nibWithNibName:@"TableViewDoctorCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        [_doctorView.consultButton  addTarget:self action:@selector(consult:) forControlEvents:UIControlEventTouchUpInside];
        
        [_doctorView.refreshButton addTarget:self action:@selector(refreshDoctorView) forControlEvents:UIControlEventTouchUpInside];
        [self.homeListView addSubview:_doctorView];
    }
    return _doctorView;
}
//简单按钮的封装
- (UIButton *)cx_buttonWiithTitle:(NSString*)title action:(SEL)action backgroundColor:(UIColor*)color{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (color) {
        [button setBackgroundColor:color];
    }
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}


@end
