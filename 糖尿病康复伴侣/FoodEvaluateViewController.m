//
//  FoodEvaluateViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/10.
//  Copyright © 2016年 ly. All rights reserved.
//




#import "FoodEvaluateViewController.h"

#import "FoodEvaluateHeadView.h"

#import "LXMPieView.h"
#import "FoodEvaluateCell.h"

#import "ShareChooseView.h"
// 食物模型 饮食记录模型
#import "foodmodel.h"
#import "FoodRecordModel.h"

#import "WXApi.h"

@implementation StatisticsModel

@end


@interface FoodEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource,WXApiDelegate,MBProgressHUDDelegate>

@property (nonatomic, weak) IBOutlet UITableView * tableView;

@property (nonatomic, strong) FoodEvaluateHeadView * headView;

@property (nonatomic, assign) float energy;
@property (nonatomic, assign) float protein;
@property (nonatomic, assign) float fat;
@property (nonatomic, assign) float carbs;
@property (nonatomic, strong) LXMPieView * pieView;

@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, strong) MBProgressHUD * HUD;


@property (nonatomic, assign) int scene;

@end

@implementation FoodEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"饮食评价";    
    NSArray * foodRecordArray = [FileUtils readFoodRecordWithUserID:self.userId andDate:self.date];
    NSMutableArray * breakfastArr = [NSMutableArray array];
    NSMutableArray * breakfastAddArr = [NSMutableArray array];
    NSMutableArray * lunchArr = [NSMutableArray array];
    NSMutableArray * lunchAddArr = [NSMutableArray array];
    NSMutableArray * dinnerArr = [NSMutableArray array];
    NSMutableArray * dinnerAddArr = [NSMutableArray array];
    NSMutableArray * otherArr = [NSMutableArray array];
    //    extern NSString * const DIET_TIMEPER_BRFFAST;
    //    extern NSString * const DIET_TIMEPER_EXTRA1;
    //    extern NSString * const DIET_TIMEPER_LUNCH;
    //    extern NSString * const DIET_TIMEPER_EXTRA2;
    //    extern NSString * const DIET_TIMEPER_DINNER;
    //    extern NSString * const DIET_TIMEPER_NTSAKE;
    //    extern NSString * const DIET_TIMEPER_NOTFOOD;
    float protein = 0;
    float carbs = 0;
    float fat = 0;
    float energy1 = 0;
    
    for (FoodRecordModel * model in foodRecordArray) {
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_BRFFAST]) {
            [breakfastArr addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_EXTRA1]) {
            [breakfastAddArr addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_LUNCH]) {
            [lunchArr addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_EXTRA2]) {
            [lunchAddArr addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_DINNER]) {
            [dinnerArr addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_NTSAKE]) {
            [dinnerAddArr addObject:model];
        }
        if ([model.timeperiod isEqualToString:DIET_TIMEPER_NOTFOOD]) {
            [otherArr addObject:model];
        }
        foodmodel* food1 = [FileUtils readFoodWithFoodID:model.foodId];
        protein += food1.UnitProtein.floatValue * model.intake.floatValue/food1.UnitValue.floatValue;
        fat +=food1.UnitFat.floatValue * model.intake.floatValue/food1.UnitValue.floatValue;
        carbs +=food1.UnitCarbs.floatValue * model.intake.floatValue/food1.UnitValue.floatValue;
        energy1 += food1.UnitEnergy.floatValue*model.intake.floatValue/food1.UnitValue.floatValue;
        //        NSLog(@"%@=%@= intake==%@==%@",food1.FoodName,food1.foodID,food1.UnitCarbs,model.intake);
        //        food1.UnitCarbs
    }
    self.energy = energy1;
    self.protein = protein;
    self.carbs = carbs;
    self.fat = fat;
    [self creatHeadViewForTB];
    
    NSMutableArray * dataArray = [NSMutableArray array];
    StatisticsModel * breakFM = [self statisticFromArray:breakfastArr];
    if (breakFM) {
        [dataArray addObject:breakFM];
    }
    StatisticsModel * breakAddM = [self statisticFromArray:breakfastAddArr];
    if (breakAddM) {
        [dataArray addObject:breakAddM];
    }
    StatisticsModel * lunchM = [self statisticFromArray:lunchArr];
    if (lunchM) {
        [dataArray addObject:lunchM];
    }
    StatisticsModel * lunchAM = [self statisticFromArray:lunchAddArr];
    if (lunchAM) {
        [dataArray addObject:lunchAM];
    }
    StatisticsModel * dinnerM =[self statisticFromArray:dinnerArr];
    if (dinnerM) {
        [dataArray addObject:dinnerM];
    }
    StatisticsModel * dinnerAM =[self statisticFromArray:dinnerAddArr];
    if (dinnerAM) {
        [dataArray addObject:dinnerAM];
    }
    self.dataSource = [dataArray copy];
    [self.tableView reloadData];
}

- (void)creatHeadViewForTB{
    FoodEvaluateHeadView * headView = [FoodEvaluateHeadView viewWithXIB];
    self.headView = headView;
    headView.frame = CGRectMake(0, 0, W, 250);
    self.headView.timeLabel.text = [UtilCommon dateForTitleFormatStr:self.date];
    self.headView.standIntakeLabel.text = [NSString stringWithFormat:@"%d",(int)self.baseIntake];
    self.headView.realityLabel.text = [NSString stringWithFormat:@"%d",(int)self.energy];
    self.pieView.frame = self.headView.bigView.bounds;
    if (self.energy > self.baseIntake) {
        self.headView.bigView.backgroundColor = [UIColor redColor];
        [self.headView.bigView bringSubviewToFront:self.headView.littleView];
    }else if (self.energy == 0){
        self.headView.bigView.backgroundColor = [UIColor whiteColor];
        [self.headView.bigView bringSubviewToFront:self.headView.littleView];
    }else{
        LXMPieModel * model = [[LXMPieModel alloc]initWithColor:[UIColor greenColor] value:self.energy text:nil];
        LXMPieModel * model1 = [[LXMPieModel alloc]initWithColor:[UIColor whiteColor] value:(self.baseIntake - self.energy)text:nil];
        self.pieView.valueArray = [NSArray arrayWithObjects:model,model1, nil];
        [self.headView.bigView addSubview:self.pieView];
        [self.pieView reloadData];
        [self.headView.bigView bringSubviewToFront:self.headView.littleView];
    }
    self.headView.proteinIntakeLabel.text = [NSString stringWithFormat:@"%.1f千卡",self.protein * 4];
    self.headView.proteinScaleLabel.text = [NSString stringWithFormat:@"%.1f%%",self.protein*4/self.baseIntake*100];
    //    NSString * protein = nil;
    float heightProtein = [[FileUtils getValueUsingcode:@"002"] floatValue]/100;
    float lowProtein = [[FileUtils getValueUsingcode:@"003"] floatValue]/100;
    CGRect frame = self.headView.proteinView.bounds;
    float widthView = W - 100;
    if (self.energy* self.headView.proteinView.bounds.size.width) {
        frame.size.width =self.protein*4/self.energy* widthView;
    }else{
        frame.size.width = 0;
    }
    
    self.headView.protein.frame =frame;
    NSLog(@"%@",[NSValue valueWithCGRect:frame]);
    
    if (self.protein*4 < self.baseIntake*lowProtein) {
        self.headView.proteinNeedLabel.text = [NSString stringWithFormat:@"最少还需摄入%.1f克",(self.baseIntake*lowProtein/4- self.protein)];
        self.headView.protein.backgroundColor = blueColorWithRGB(61, 172, 225).CGColor;
    }else if(self.protein*4 > self.baseIntake*heightProtein){
        self.headView.proteinNeedLabel.text = @"已过量";
        self.headView.proteinNeedLabel.textColor = [UIColor redColor];
        self.headView.protein.backgroundColor = [UIColor redColor].CGColor;
    }else{
        self.headView.proteinNeedLabel.text = @"正常";
        self.headView.proteinNeedLabel.textColor = [UIColor blackColor];
        self.headView.protein.backgroundColor = [UIColor greenColor].CGColor;
    }
    
    self.headView.fatIntakeLabel.text = [NSString stringWithFormat:@"%.1f千卡",self.fat*9];
    self.headView.fatScaleLaebl.text = [NSString stringWithFormat:@"%.1f%%",self.fat*9/self.baseIntake*100];
    float highFat = [[FileUtils getValueUsingcode:@"004"] floatValue]/100;
    float lowFat = [[FileUtils getValueUsingcode:@"005"] floatValue]/100;
    if (self.energy) {
        frame.size.width = widthView *self.fat*9/self.energy;
    }else{
        frame.size.width = 0;
    }
    self.headView.fat.frame = frame;
    if (self.fat*9 < self.baseIntake*lowFat) {
        self.headView.fatNeedLabel.text = [NSString stringWithFormat:@"最少还需摄入%.1f克",(self.baseIntake*lowFat/9- self.fat)];
        self.headView.fatNeedLabel.textColor = blueColorWithRGB(61, 172, 225);
        self.headView.fat.backgroundColor = blueColorWithRGB(61, 172, 225).CGColor;
    }else if(self.fat*9 > self.baseIntake*highFat){
        self.headView.fatNeedLabel.text = @"已过量";
        self.headView.fatNeedLabel.textColor = [UIColor redColor];
        self.headView.fat.backgroundColor = [UIColor redColor].CGColor;
    }else{
        self.headView.fatNeedLabel.text = @"正常";
        self.headView.fatNeedLabel.textColor = [UIColor blackColor];
        self.headView.fat.backgroundColor = [UIColor greenColor].CGColor;
    }
    
    self.headView.carbohydrateIntakeLabel.text = [NSString stringWithFormat:@"%.1f千卡",self.carbs*4];
    self.headView.carbohydrateScaleLabel.text = [NSString stringWithFormat:@"%.1f%%",self.carbs*4/self.baseIntake*100];
    float highCarbohydrate = [[FileUtils getValueUsingcode:@"006"] floatValue]/100;
    float lowCarbohydrate = [[FileUtils getValueUsingcode:@"007"] floatValue]/100;
    if (self.energy) {
        frame.size.width = widthView * self.carbs*4/self.energy;
    }else{
        frame.size.width = 0;
    }
    self.headView.carbs.frame = frame;
    if (self.carbs*4 < self.baseIntake*lowCarbohydrate) {
        self.headView.carbohydrateNeedLabel.text = [NSString stringWithFormat:@"最少还需摄入%.1f克",(self.baseIntake*lowCarbohydrate/4- self.carbs)];
        self.headView.carbohydrateNeedLabel.textColor = blueColorWithRGB(61, 172, 225);
        self.headView.carbs.backgroundColor = blueColorWithRGB(61, 172, 225).CGColor;
        
    }else if(self.carbs*4 > self.baseIntake*highCarbohydrate){
        self.headView.carbohydrateNeedLabel.text = @"已过量";
        self.headView.carbohydrateNeedLabel.textColor = [UIColor redColor];
        self.headView.carbs.backgroundColor= [UIColor redColor].CGColor;
        
    }else{
        self.headView.carbohydrateNeedLabel.text = @"正常";
        self.headView.carbohydrateNeedLabel.textColor = [UIColor blackColor];
        self.headView.carbs.backgroundColor = [UIColor greenColor].CGColor;
    }
    [self.headView.shareBtn addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
   headView.frame = CGRectMake(0, 0, W, 250);
    self.tableView.tableHeaderView = self.headView;
    
}
#pragma mark 分享按钮点击事件
- (void)shareButtonClick:(UIButton*)sender{
    ShareChooseView * view = [ShareChooseView viewWithXIB];
    view.shareChoice = ^(NSInteger scene){
        if (scene!=1 && scene!=0) {
            return ;
        }
        self.scene = (int)scene;
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        _HUD.delegate = self;
        _HUD.mode = MBProgressHUDModeIndeterminate;
        _HUD.labelText = @"正在上传文件";
        [_HUD showWhileExecuting:@selector(upDataToSever)  onTarget:self withObject:nil animated:YES];
    };
    [self.view addSubview:view];
    //sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
 }
// 上传信息
- (void)upDataToSever{
    if (![WXApi isWXAppInstalled]) {
        _HUD.labelText = @"您未安装微信";
        return;
    }
    //   截屏
    CGRect rect =self.view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    float originX = 0 ;
    float originY = 0;
    float width = W;
    float height  = 250;
    //你需要的区域起点,宽,高;
    CGRect rect1 = CGRectMake(originX , originY , width , height);
    UIImage * image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([img CGImage], rect1)];
    
    NSString * time = [UtilCommon GetsTheNumberOfMilliseconds];
    //            NSLog(@"%@fsdfsdfsd",Extensionstr);
    NSString * uuidstr =   [UtilCommon uuidString];
    NSString * filename = [NSString stringWithFormat:@"%@-%@-PNG",self.userId,time];
    NSString *   str16 = [UtilCommon hexStringFromString:filename];
    
    BOOL flag = [WebUtilsCommon imageUpload:image filename:[str16 uppercaseString] UUID:uuidstr picExtersion:@"PNG"];
        if (flag) {
        _HUD.labelText = @"文件上传成功，正在上传数据";
        NSString * sidStr = [WebUtilsCommon upToSeverOfWeixinWithUID:self.userId andFoodArray:[FileUtils readFoodRecordWithUserID:self.userId andDate:self.date] ImageName:[str16 uppercaseString] andDate:self.date];
        NSString *kLinkURL = [NSString stringWithFormat:@"%@wxshare.showDiet.action?sid=%@",WEB_SERVER_URL,sidStr];
        static NSString *kLinkTitle = @"我的饮食分享，快来围观";
        static NSString *kLinkDescription = @"这里有我的详细饮食，小伙伴们来围观吧";
        //创建发送对象实例
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;  //不使用文本信息
        sendReq.scene = self.scene;
        //        sendReq.text = @"dadadadad";
        WXMediaMessage *urlMessage = [WXMediaMessage message];
        urlMessage.title = kLinkTitle;//分享标题
        urlMessage.description = kLinkDescription;//分享描述
        [urlMessage setThumbImage:[UIImage imageNamed:@"logo.png"]];
        //创建多媒体对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = kLinkURL;//分享链接
        //完成发送对象实例
        urlMessage.mediaObject = webObj;
        sendReq.message = urlMessage;
        [WXApi sendReq:sendReq];
    }
}
//数组分类的封装
- (StatisticsModel*)statisticFromArray:(NSArray*)array{
    float protein = 0;
    float fat = 0;
    float carbs = 0;
    if (array.count) {
        StatisticsModel * model = [[StatisticsModel alloc]init];
        for (FoodRecordModel * recordModel in array) {
            if ([recordModel.timeperiod isEqualToString:DIET_TIMEPER_BRFFAST]) {
                model.timepierod = @"早餐";
            }else if ([recordModel.timeperiod isEqualToString:DIET_TIMEPER_EXTRA1]) {
                model.timepierod = @"上午加餐";
            }else if ([recordModel.timeperiod isEqualToString:DIET_TIMEPER_LUNCH]) {
                model.timepierod = @"午餐";
            }else if ([recordModel.timeperiod isEqualToString:DIET_TIMEPER_EXTRA2]) {
                model.timepierod = @"下午加餐";
            }else if ([recordModel.timeperiod isEqualToString:DIET_TIMEPER_DINNER]) {
                model.timepierod = @"晚餐";
            }else if ([recordModel.timeperiod isEqualToString:DIET_TIMEPER_NTSAKE]) {
                model.timepierod = @"夜宵";
            }else {
                return nil;
            }
            foodmodel* food1 = [FileUtils readFoodWithFoodID:recordModel.foodId];
            protein += food1.UnitProtein.floatValue/food1.UnitValue.floatValue*recordModel.intake.floatValue;
            fat += food1.UnitFat.floatValue/food1.UnitValue.floatValue*recordModel.intake.floatValue;
            carbs += food1.UnitCarbs.floatValue/food1.UnitValue.floatValue*recordModel.intake.floatValue;
        }
        float energytotal = protein*4 + fat*9+ carbs*4;
        model.protein = [NSString stringWithFormat:@"%.1f",protein*4];
        model.fat = [NSString stringWithFormat:@"%.1f",fat*9];
        model.carbs = [NSString stringWithFormat:@"%.1f",carbs*4];
        model.energy = [NSString stringWithFormat:@"%d千卡/%.1f",(int)energytotal,energytotal/self.energy*100];
        return model;
    }else{
        return nil;
    }
}

#pragma mark tableView delegate && dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodEvaluateCell * cell = [FoodEvaluateCell cellWithXIBForTableView:tableView];
    StatisticsModel* model = [self.dataSource objectAtIndex:indexPath.row];
    [cell cellWithModel:model];
    self.headView.frame = CGRectMake(0, 0, W, 250);
    return cell;
}


- (LXMPieView *)pieView{
    if (!_pieView) {
        _pieView = [[LXMPieView alloc]initWithFrame:self.headView.bigView.bounds values:nil];
    }
    return _pieView;
}
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSArray alloc]init];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
