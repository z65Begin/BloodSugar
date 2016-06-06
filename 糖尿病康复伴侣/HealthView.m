//
//  HealthView.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "HealthView.h"

#import "FoodRecordModel.h"

#import "MethodView.h"

#import "foodmodel.h"

#import "sportCataModel.h"
#import "SportRecordModel.h"

#import "SportHomeView.h"

#import "BloodSugarHomeView.h"
#import "BloodSugarModel.h"

#import "BodySignModel.h"

#import "MedicineRecordModel.h"

#import "MedicineHomeView.h"

@interface HealthView ()<UIScrollViewDelegate>

@property (nonatomic, assign) CGSize scrollViewContentSize;

@property (nonatomic, assign) float foodHeight;

@property (nonatomic, assign) int numberFood;

@property (nonatomic, strong) NSMutableArray * breakArr;
@property (nonatomic, strong) NSMutableArray * breakAdd;
@property (nonatomic, strong) NSMutableArray * lunchArr;
@property (nonatomic, strong) NSMutableArray * lunchAdd;
@property (nonatomic, strong) NSMutableArray * dinnerArr;
@property (nonatomic, strong) NSMutableArray * dinnerAdd;
@property (nonatomic, strong) NSMutableArray * smokeArr;

@end

@implementation HealthView

+(instancetype)healthView
{
    return [[self alloc] initWithFrame:CGRectMake(0, 0, W, H-64-49)];
}

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //创建健康头视图
        [self createHralthHeadView];
        //创建健康内容视图
        [self createHealthBodyView];
    }
    return self;
}
//顶部 展示数据
-(void)createHralthHeadView{
    UIView * lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    lineView.frame = CGRectMake(0, 0, W, 2);
    lineView.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
    
    HealthHeadView * healthHeadView = [HealthHeadView healthHeadView];
    self.healthHeadView = healthHeadView;
    [self addSubview:healthHeadView];
    healthHeadView.frame = CGRectMake(0, 0, W, 128);
}
- (void)setHealthHeadViewWithDictionary:(NSDictionary*)dictionary{
    self.healthHeadView.intakeLabel.text = nil;
    self.healthHeadView.movementLabel.text = nil;
    self.healthHeadView.bloodLabel.text = nil;
    self.healthHeadView.medicineLabel.text = nil;
}

-(void)createHealthBodyView{
    UIScrollView * healthScrollView = [[UIScrollView alloc]init];
    self.healthScrollView = healthScrollView;
    healthScrollView.frame = CGRectMake(0, 128, W, H-128 - 64 - 49);
    
//    healthScrollView.backgroundColor = [UIColor cyanColor];
    [self addSubview:healthScrollView];
    healthScrollView.contentSize = CGSizeMake(0,680);
    healthScrollView.showsHorizontalScrollIndicator = NO;
    healthScrollView.showsVerticalScrollIndicator = NO;
    healthScrollView.bounces = NO;
    healthScrollView.delegate = self;
    healthScrollView.delaysContentTouches = NO;
    healthScrollView.canCancelContentTouches = NO;
    healthScrollView.userInteractionEnabled = YES;
    HealthBodyView * healthBodyView = [HealthBodyView healthBodyView];
    self.healthBodyView = healthBodyView;
    [healthScrollView addSubview:healthBodyView];
    //    healthBodyView.backgroundColor = [UIColor magentaColor];
    healthBodyView.frame = CGRectMake(0, 0, W, 680);

    self.scrollViewContentSize = healthScrollView.contentSize;
    self.foodHeight = self.healthBodyView.foodHeight.constant;
    
}
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])
//改变foodViewFrame
- (CGFloat)changeWithFoodRecordArray:(NSArray *)foodRecordArray{
//    TICK;
 NSMutableDictionary * newDic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
    BOOL food = [[newDic objectForKey:SETTING_DIETHIDDEN] boolValue];
    
    if (!food) {
        self.healthBodyView.foodHeight.constant = 0;
        self.healthBodyView.foodView.hidden = YES;
        return self.healthBodyView.foodHeight.constant;
    }
    self.healthBodyView.foodView.hidden = NO;
    NSMutableArray * breakArr = [NSMutableArray array];
    NSMutableArray * breakAdd = [NSMutableArray array];
    NSMutableArray * lunchArr = [NSMutableArray array];
    NSMutableArray * lunchAdd = [NSMutableArray array];
    NSMutableArray * dinnerArr = [NSMutableArray array];
    NSMutableArray * dinnerAdd = [NSMutableArray array];
    NSMutableArray * smokeArr = [NSMutableArray array];
    self.numberFood = 0;
    for (FoodRecordModel * model in foodRecordArray) {
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_BRFFAST]) {
            [breakArr addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_EXTRA1]) {
            [breakAdd addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_LUNCH]) {
            [lunchArr addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_EXTRA2]) {
            [lunchAdd addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_DINNER]) {
            [dinnerArr addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_NTSAKE]) {
            [dinnerAdd addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_NOTFOOD]) {
            [smokeArr addObject:model];
        }
    }
    self.breakArr = [breakArr copy];
    self.breakAdd = [breakAdd copy];
    self.lunchAdd = [lunchAdd copy];
    self.lunchArr = [lunchArr copy];
    self.dinnerAdd = [dinnerAdd copy];
    self.dinnerArr = [dinnerArr copy];
    self.smokeArr = [smokeArr copy];
//    TOCK;
    if (breakArr.count) {
        self.numberFood += (int)breakArr.count;
    }else{
        self.numberFood += 1;
    }
    if (breakAdd.count) {
        self.numberFood += (int) breakAdd.count;
    }else{
        self.numberFood += 1;
    }
    if (lunchAdd.count) {
        self.numberFood += (int) lunchAdd.count;
    }else{
        self.numberFood += 1;
    }
    if (lunchArr.count) {
        self.numberFood += (int) lunchArr.count;
    }else{
        self.numberFood += 1;
    }
    if (dinnerAdd.count) {
        self.numberFood += (int) dinnerAdd.count;
    }else{
        self.numberFood += 1;
    }
    if (dinnerArr.count) {
        self.numberFood += (int) dinnerArr.count;
    }else{
        self.numberFood += 1;
    }
    if (smokeArr.count) {
        self.numberFood += (int) smokeArr.count;
    }else{
        self.numberFood += 1;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self cx_creatSubviewWithArray:breakArr SuperView:self.healthBodyView.foodView1 NSLayout:self.healthBodyView.breakHeight];
        [self cx_creatSubviewWithArray:breakAdd SuperView:self.healthBodyView.foodView2 NSLayout:self.healthBodyView.breakAddHeight];
        [self cx_creatSubviewWithArray:lunchArr SuperView:self.healthBodyView.foodView3 NSLayout:self.healthBodyView.lunchHeight];
        [self cx_creatSubviewWithArray:lunchAdd SuperView:self.healthBodyView.foodView4 NSLayout:self.healthBodyView.lunchAddHeight];
        [self cx_creatSubviewWithArray:dinnerArr SuperView:self.healthBodyView.foodView5 NSLayout:self.healthBodyView.dinnerHeight];
        [self cx_creatSubviewWithArray:dinnerAdd SuperView:self.healthBodyView.foodView6 NSLayout:self.healthBodyView.dinnerAddHeight];
        [self cx_creatSubviewWithArray:smokeArr SuperView:self.healthBodyView.foodView7 NSLayout:self.healthBodyView.smokeHeight];
        CGSize content = self.scrollViewContentSize;
        content.height += 24*self.numberFood;
        self.healthScrollView.contentSize = content;
        self.healthBodyView.foodHeight.constant = 261+(24*self.numberFood);
    });
//        TOCK;
//    NSLog(@"foodheight===%lf",self.healthBodyView.foodHeight.constant);
    return (261+(24*self.numberFood));
}
/**
 * 改变 运动 记录
 * sportRecordArray:运动记录数组
*/
- (CGFloat)changeWithSportRecord:(NSArray*)sportRecordArray{
    NSMutableDictionary * newDic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
    BOOL food = [[newDic objectForKey:SETTING_SPORTHIDDEN] boolValue];
    
    if (!food) {
        self.healthBodyView.sportHeight.constant = 0;
        self.healthBodyView.sportView.hidden = YES;
        return self.healthBodyView.sportHeight.constant;
    }
    self.healthBodyView.sportView.hidden = NO;
    
    float height = 24.0f;
    float width = W-10;
   dispatch_async(dispatch_get_main_queue(), ^{
       for (UIView* view in self.healthBodyView.sportView.subviews) {
           if ([view isKindOfClass:[SportHomeView class]]) {
               [view removeFromSuperview];
           }
           if ([view isKindOfClass:[MethodView class]]) {
               [view removeFromSuperview];
           }
       }
   });
    dispatch_async(dispatch_get_main_queue(), ^{
    if (sportRecordArray.count) {
//        self.healthBodyView.sportHeight.constant = 45;
        self.healthBodyView.sportHeight.constant = 45 + 24 * sportRecordArray.count;
        int timeLength = 0;
        float hotCata = 0;
        
        for (int i = 0; i < sportRecordArray.count; i++) {
            SportRecordModel * model = sportRecordArray[i];
            SportHomeView * view = [SportHomeView viewWithXIB];
            view.frame = CGRectMake(0, 45+i*height, width, height);
            [view viweWithSportRecordModel:model];
            [self.healthBodyView.sportView addSubview:view];
            [view.button addTarget:self action:@selector(sportRecordClick) forControlEvents:UIControlEventTouchUpInside];
            //            UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sportRecordClick)];
            //            [view addGestureRecognizer:tapGR];
            view.layer.cornerRadius = 8.0f;
            sportCataModel * cataM = [SportFileUtils readSportCataWith:model.Type];
            timeLength += model.TimeLength.intValue;
            hotCata += (model.TimeLength.intValue/60*cataM.Energy.floatValue);
        }
        int hour = 0;
        int minute = 0;
        int second = 0;
        if (timeLength/60/60) {
            hour = timeLength/60/60;
        }
        if ((timeLength%(60*60))/60) {
            minute = timeLength%(60*60)/60;
        }
        if ((timeLength%(60*60))%60) {
            second = (timeLength%(60*60))%60;
        }
        NSString * timeStr = [[NSString alloc]init];
        if (hour) {
            timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%d时",hour]];
        }
        if (minute) {
            timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%d分",minute]];
        }
        if (second) {
            timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%d秒",second]];
        }
        if (!hour && !minute && !second) {
            timeStr = [timeStr stringByAppendingString:@"0秒"];
        }
        self.healthBodyView.sportTotalLabel.text =[NSString stringWithFormat:@"运动总时间%@，共消耗热量%d千卡。",timeStr,(int)hotCata];
    }else{
        MethodView * view = [MethodView viewWithXib];
        view.frame = CGRectMake(0, 45 , width, height);
        view.nameLabel.text = @"暂无数据";
        view.intakeLael.text = nil;
        view.unitLabel.text = nil;
        [self.healthBodyView.sportView addSubview:view];
        self.healthBodyView.sportHeight.constant = 45 +24;
        view.layer.cornerRadius = 8.0f;
        self.healthBodyView.sportTotalLabel.text = @"运动总时间0秒，共消耗热量0千卡";
    }

});
#pragma mark 未设置 scrollview 的 contentsize
    int num = 0;
    if (sportRecordArray.count) {
        num = (int)sportRecordArray.count;
    }else{
        num = 1;
    }
//    self.healthBodyView.sportHeight.constant = 45 + height * num;
    
    return (45 + height * num);
}
//改变体征
- (CGFloat)changeWithBodySignWithBloodSugarArray:(NSArray*)bloodSugarArray andBodySignModel:(BodySignModel*)bodySignM{
    float height = 24.0f;
    float width = W-10;
    NSMutableDictionary * newDic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
    BOOL food = [[newDic objectForKey:SETTING_BODYSIGNHIDDEN] boolValue];
    
    if (!food) {
          self.healthBodyView.bodySignHeight.constant = 0;
          self.healthBodyView.bodySignView.hidden = YES;
        return 0;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
         self.healthBodyView.bodySignView.hidden = NO;
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView* view in self.healthBodyView.bodySignView.subviews) {
            if ([view isKindOfClass:[BloodSugarHomeView class]]) {
                [view removeFromSuperview];
            }
            if ([view isKindOfClass:[MethodView class]]) {
                [view removeFromSuperview];
            }
            if ([view isKindOfClass:[UIButton class]]) {
                [view removeFromSuperview];
            }
        }
    });
    NSDictionary * bodySignMD = [bodySignM getAllPropertiesAndVaules];
    int num = 0;
//    计算显示多少行
    int b = 0;
    int c = 0;
    for (NSString * keyStr in bodySignMD) {
        NSString * valueOfKey = bodySignMD[keyStr];
        if (valueOfKey && valueOfKey.intValue !=0 &&![keyStr isEqualToString:@"date"]&&![keyStr isEqualToString:@"UpdTime"] ) {
            if ([keyStr isEqualToString:@"Plantar"]) {
                int a = [bodySignMD[keyStr] intValue];
                while (a) {
                    if (a%2) {
                        b++;
                    }
                    a = a >>1;
                }
                num = num + b;
            }else if([keyStr isEqualToString:@"DBP"]||[keyStr isEqualToString:@"SBP"]){
                int dbpStr = [bodySignMD[@"DBP"] intValue];
                int sbpStr = [bodySignMD[@"SBP"]intValue];
                if (c == 1) {
                    continue;
                }
                if (dbpStr > 0 || sbpStr >0) {
                    c = 1;
                    num  = num + c;
                }
            }else{
                num ++;
            }
        }
    }
   
        if (bloodSugarArray.count || num) {
//            改变血糖
            dispatch_async(dispatch_get_main_queue(), ^{
                for (int i = 0; i < bloodSugarArray.count; i++) {
                    BloodSugarModel* model = bloodSugarArray[i];
                    BloodSugarHomeView * view = [BloodSugarHomeView viewCreat];
                    view.frame = CGRectMake(0, 35+height*i, width, height);
                    [view viewWithModel:model];
                    view.layer.cornerRadius = 8.0f;
                    
                    view.userInteractionEnabled = YES;
                    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBodySign)];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(0, 0, W-10, 24);
                    button.backgroundColor = [UIColor clearColor];
                    //                button.showsTouchWhenHighlighted = YES;
                    [view addSubview:button];
                    [button addTarget:self action:@selector(chooseBodySign) forControlEvents:UIControlEventTouchUpInside];
                    
                    [view addGestureRecognizer:tapGR];
                    [self.healthBodyView.bodySignView addSubview:view];
                }
            });
//            改变体征
            dispatch_async(dispatch_get_main_queue(), ^{
                int number = 0;
                BOOL bloodPressure = NO;
                for (int i = 0 ; i < bodySignMD.allKeys.count; i++) {
                    NSString * keyStr = bodySignMD.allKeys[i];
                    NSString * valueOfKey = bodySignMD[keyStr];
                    if (valueOfKey && valueOfKey.intValue !=0 &&![keyStr isEqualToString:@"date"]&&![keyStr isEqualToString:@"UpdTime"]){
                        if ([keyStr isEqualToString:@"DBP"]||[keyStr isEqualToString:@"SBP"]) {
                            int dbpStr = [bodySignMD[@"DBP"] intValue];
                            int sbpStr = [bodySignMD[@"SBP"]intValue];
                            if (bloodPressure) {
                                continue;
                            }
                            if (dbpStr > 0|| sbpStr > 0) {
                                bloodPressure = YES;
                                valueOfKey = [NSString stringWithFormat:@"%d/%d",dbpStr,sbpStr];
                                keyStr = @"DBP";
                            }
                        }
                        BloodSugarHomeView * view = [BloodSugarHomeView viewCreat];
                        view.frame = CGRectMake(0, 35+height*(int)bloodSugarArray.count+number*height, width, height);
                        [view viewForBodySign:keyStr andValue:valueOfKey];
                        
                        UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseBodySign)];
                        [view addGestureRecognizer:tapGR];
                        
                        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                        button.frame = CGRectMake(0, 0, W-10, 24);
                        button.backgroundColor = [UIColor clearColor];
                        [view addSubview:button];
                        [button addTarget:self action:@selector(chooseBodySign) forControlEvents:UIControlEventTouchUpInside];
                        [self.healthBodyView.bodySignView addSubview:view];
                        view.layer.cornerRadius = 8.0f;
                        if ([keyStr isEqualToString:@"Plantar"]) {
                            CGRect frame = view.frame;
                            frame.size.height = height * b;
                            view.frame = frame;
                            number = number +b;
                        }else{
                            number++;
                        }
                    };
                }
                self.healthBodyView.bodySignHeight.constant = 35+height* ((int)bloodSugarArray.count+num);
            });
          
        }else{
          dispatch_async(dispatch_get_main_queue(), ^{
              MethodView * view = [MethodView viewWithXib];
              view.frame = CGRectMake(0, 35 , width, height);
              view.nameLabel.text = @"暂无数据";
              view.intakeLael.text = nil;
              view.unitLabel.text = nil;
              [self.healthBodyView.bodySignView addSubview:view];
              self.healthBodyView.bodySignHeight.constant = 35 +24;
              view.layer.cornerRadius = 8.0f;
          });
        }
    if (num == 0 && bloodSugarArray.count == 0 ){
        num = 1;
    }
    
    return (35+height* ((int)bloodSugarArray.count+num)) ;
}
//改变药品
- (CGFloat)changeWithMedicineArray:(NSArray*)medicineArray{
    NSMutableDictionary * newDic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
    BOOL food = [[newDic objectForKey:SETTING_MEDICINEHIDDEN] boolValue];
    if (!food) {
        self.healthBodyView.medicineHeight.constant = 0;
        self.healthBodyView.medicineView.hidden = YES;
        return self.healthBodyView.medicineHeight.constant;
    }
    self.healthBodyView.medicineView.hidden = NO;

    dispatch_async(dispatch_get_main_queue(), ^{
        if (!food) {
            self.healthBodyView.medicineHeight.constant = 0;
            self.healthBodyView.medicineView.hidden = YES;
//            return self.healthBodyView.medicineHeight.constant;
        }
        
        self.healthBodyView.medicineView.hidden = NO;
  
    });
    if (!food) {
        return 0;
    }
    
   dispatch_async(dispatch_get_main_queue(), ^{
       for (UIView * view in self.healthBodyView.medicineView.subviews) {
           if ([view isKindOfClass:[MethodView class]]) {
               [view removeFromSuperview];
           }
           if ([view isKindOfClass:[MedicineHomeView class]]) {
               [view removeFromSuperview];
           }
       }
   });
    CGFloat height = 24.0f;
    CGFloat width = W - 10;
   dispatch_async(dispatch_get_main_queue(), ^{
       if (medicineArray.count) {
           self.healthBodyView.medicineHeight.constant = 35 + height*medicineArray.count;
           for (int i = 0; i < medicineArray.count; i++ ) {
               MedicineHomeView* view = [MedicineHomeView viewCreat];
               view.frame = CGRectMake(0,35+height*i, width, height);
               view.layer.cornerRadius = 8.0f;
               MedicineRecordModel * model = medicineArray[i];
               [view viewWithMedicineModel:model];
               [self.healthBodyView.medicineView addSubview:view];
               
               UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(medicineClick)];
               [view addGestureRecognizer:tapGR];
               
           }
       }else{
           MethodView * view = [MethodView viewWithXib];
           view.frame = CGRectMake(0, 35 , width, height);
           view.nameLabel.text = @"暂无数据";
           view.intakeLael.text = nil;
           view.unitLabel.text = nil;
           [self.healthBodyView.medicineView addSubview:view];
           self.healthBodyView.medicineHeight.constant = 35 +24;
           view.layer.cornerRadius = 8.0f;
           
       }
   });
    int num = 0;
    if (medicineArray.count) {
        num = (int)medicineArray.count;
    }else{
        num = 1;
    }
    
    return  (35 + height*num);
}

//对食物各时间段内 数值的封装
- (void)cx_creatSubviewWithArray:(NSArray *)array SuperView:(UIView *)superView NSLayout:(NSLayoutConstraint*)layout{
    float height = 24.0f;
    float width = W-61;
    for (UIView * view in superView.subviews) {
        if ([view isKindOfClass:[MethodView class]]) {
            [view removeFromSuperview];
        }
    }
    layout.constant = 32;
    if (array.count) {
//        self.numberFood += (int)array.count;
        layout.constant = 32 + array.count* height;
        for (int i = 0; i < array.count; i++) {
            FoodRecordModel * model = array[i];
            MethodView * view = [MethodView viewWithXib];
            view.layer.cornerRadius = 8.0f;
            view.frame = CGRectMake(0,32 + height * i, width, height);
            foodmodel * food = [FileUtils getFoodModelWithFoodId:model.foodId];
            
            if (superView == self.healthBodyView.foodView1) {
                
                if (model.time) {
                    self.healthBodyView.breakfastTime.text = model.time;
                }else{
                self.healthBodyView.breakfastTime.text = @"07:30";
                }
            }
            if (superView == self.healthBodyView.foodView2) {
//                self.healthBodyView.morningAddFoodTime.text = model.time;
                if (model.time) {
                    self.healthBodyView.morningAddFoodTime.text = model.time;
                }else{
                    self.healthBodyView.morningAddFoodTime.text = @"10:00";
                }
                
            }
            if (superView == self.healthBodyView.foodView3) {
//                self.healthBodyView.lunchTime.text = model.time;
                if (model.time && ![model.time isEqualToString:@""]) {
                    self.healthBodyView.lunchTime.text = model.time;
                }else{
                    self.healthBodyView.lunchTime.text = @"12:00";
                }
            }
            if (superView == self.healthBodyView.foodView4) {
//                self.healthBodyView.afternoonAddFoodTime.text = model.time;
                if (model.time && ![model.time isEqualToString:@""]) {
                    self.healthBodyView.afternoonAddFoodTime.text = model.time;
                }else{
                    self.healthBodyView.afternoonAddFoodTime.text = @"15:30";
                }
            }
            if (superView == self.healthBodyView.foodView5) {
//                self.healthBodyView.dinnerTime.text = model.time;
                if (model.time && ![model.time isEqualToString:@""]) {
                    self.healthBodyView.dinnerTime.text = model.time;
                }else{
                    self.healthBodyView.dinnerTime.text = @"16:00";
                }
            }
            if (superView == self.healthBodyView.foodView6) {
//                self.healthBodyView.afterDinnerEatFoodTime.text = model.time;
                if (model.time && ![model.time isEqualToString:@""]) {
                    self.healthBodyView.afterDinnerEatFoodTime.text = model.time;
                }else{
                    self.healthBodyView.afterDinnerEatFoodTime.text = @"20:30";
                }
            }
            if (superView == self.healthBodyView.foodView7) {
                self.healthBodyView.smokeTime.text = model.time;
                if (model.time && ![model.time isEqualToString:@""]) {
                    self.healthBodyView.smokeTime.text = model.time;
                }else{
                    self.healthBodyView.smokeTime.text = @"－:－";
                }
            }
            view.nameLabel.text = food.FoodName; 
            view.intakeLael.text = model.intake;
            if ([food.UnitName isEqualToString:@"g"]) {
                view.unitLabel.text = @"克";
            }else{
                view.unitLabel.text = food.UnitName;
            }
            superView.height = 32+height*array.count;
            [superView addSubview:view];
            UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGRClick:)];
            [view addGestureRecognizer:tapGR];
            //            view.tag = 10000+ (i+1)*10;
            if (superView == self.healthBodyView.foodView1 ) {
                view.tag = 10010;
            }
            if (superView == self.healthBodyView.foodView2 ) {
                view.tag = 10020;
            }
            if (superView == self.healthBodyView.foodView3 ) {
                view.tag = 10030;
            }
            if (superView == self.healthBodyView.foodView4 ) {
                view.tag = 10040;
            }
            if (superView == self.healthBodyView.foodView5 ) {
                view.tag = 10050;
            }
            if (superView == self.healthBodyView.foodView6 ) {
                view.tag = 10060;
            }
            if (superView == self.healthBodyView.foodView7 ) {
                view.tag = 10070;
            }
        }
    }else{
//        self.numberFood += 1;
        MethodView * view = [MethodView viewWithXib];
        view.frame = CGRectMake(0, 32 , width, height);
        view.layer.cornerRadius = 8.0f;
        view.nameLabel.text = @"暂无数据";
        view.intakeLael.text = nil;
        view.unitLabel.text = nil;
        [superView addSubview:view];
        layout.constant = 32 + height;
    }
}
/**
 *  食物 时间 分类 点击事件
 */
- (void)tapGRClick:(UITapGestureRecognizer * )tapGR{
    NSInteger tag = tapGR.view.tag;
    //    NSLog(@"%ld",tag);
    switch (tag) {
        case 10010:
            self.changeFoodRecord(tag,self.breakArr);
            break;
        case 10020:
            self.changeFoodRecord(tag,self.breakArr);
            break;
        case 10030:
            self.changeFoodRecord(tag,self.breakArr);
            break;
        case 10040:
            self.changeFoodRecord(tag,self.breakArr);
            break;
        case 10050:
            self.changeFoodRecord(tag,self.breakArr);
            break;
        case 10060:
            self.changeFoodRecord(tag,self.breakArr);
            break;
        case 10070:
            self.changeFoodRecord(tag,self.breakArr);
            break;
        default:
            break;
    }
}
/**
 *  运动 记录点击 事件
 */
- (void)sportRecordClick{
    if (self.changeSportRecord) {
        self.changeSportRecord();
    }
}
/**
 *  体征 血糖 记录 点击 事件
 **/
- (void)chooseBodySign{
    if (self.changeBloodSugarAndBodySign) {
        self.changeBloodSugarAndBodySign();
    }
}
- (void)medicineClick{
    if (self.changeMedicineRecord) {
        self.changeMedicineRecord();
    }
//    NSLog(@"药品被点击了");
}
- (void)hiddenFoodView:(BOOL)hidden{
    self.healthBodyView.foodView.hidden = hidden;
    if (hidden) {
        
        self.healthBodyView.foodTop.constant = 0;
        CGSize content = self.scrollViewContentSize;
        content.height -= self.healthBodyView.foodHeight.constant;
        self.healthBodyView.foodHeight.constant = 0;
        self.healthScrollView.contentSize = content;
        
    }else{
        self.healthBodyView.foodHeight.constant = 261+(24*self.numberFood);
        self.healthBodyView.foodTop.constant = 3;
        CGSize content = self.scrollViewContentSize;
        content.height = 261+(24*self.numberFood);
        self.healthScrollView.contentSize = content;
    }
}

@end
